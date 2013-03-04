# The problem

One of the major tasks in Lonely Planet's switch to producing guidebooks from our shiny new content management system was writing an engine to convert data in our internal "bundle" format to fit templates in the ContentXML format required by our automated layout system [Typefi](http://www.typefi.com).

This seemed like a simple enough XML-to-XML conversion problem, so we initially tackled this with XSLT, but it soon became clear that the mapping was *way* more complicated than one-to-one.  Attempt two was with SAX, which at least allowed us to leverage Ruby fully, but as the rule set grew in complexity, our code turned into untestable if-else spaghetti that looked kind of like this:

    If this tag is a heading
      immediately following the start of a section
        within the Welcome to X chapter
          within a City guide
            then output "Heading 3"
      not immediately following the start of a section
        within the Welcome to X chapter
          within a City guide
            then output "Heading 7"

We soon grew to realize that, given the scope of the problem (we're presently at 1867 rules and counting), this was not going to scale.  What to do?

# The solution: RSLT

Enter our saviour: [RSLT](https://github.com/DanielHeath/rslt).  Hacked up by [Dan Heath](https://github.com/DanielHeath) in a moment of inspiration, it reduced the monster above to this:

    class CityGuide::Stylesheet
      within '.welcome-to-x' do
        within '.section' do
          render('> heading') { heading(3) }
          render('heading')   { heading(7) }

The basic idea is simple. An RSLT stylesheet consists of an ordered list of CSS matchers, followed by an action.  Call `stylesheet.transform(@xml)` on an XML document, and it walks the document tag by tag, testing each tag against each rule until it finds a match.  When a match is found, it executes the action with a handy [Builder](http://builder.rubyforge.org/) hook available for attaching your content, and then moves on to the next tag.  Repeat until the source document ends.

# Example

An example is worth a thousand words:

    require 'rslt'
    
    class MyStylesheet < RSLT::Stylesheet
      def rules
        render('parent > child') { builder.p(:style => "child")  { child_content }  }
        render('parent')         { builder.p(:style => "parent") { child_content }  }
        render('text()')         { add element.to_xml.upcase }
      end
    end

    puts MyStylesheet.transform <<-XML
    <parent>
      <child>Use RSLT</child>
    </parent>
    XML
    -> <p style="parent"><p style="child">USE RSLT</p></p>
    
The `child_content` bit there simply means "keep processing my children".  And since repeating that and `builder.p(...)` bit is not very [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself), we can wring out the moisture by abstracting them out into a `paragraph` method:

    def paragraph(style, &block)
      block ||= lambda { |builder| child_content }
      @builder.p(:style => style, &block)
    end

    class MyStylesheet < RSLT::Stylesheet
      def rules
        render('parent > child') { paragraph('child') }
        render('parent')         { paragraph('parent') }
        render('text()')         { add element.to_xml.upcase }
      end
    end

Pretty elegant, no?  And easily testable, too, since we could write unit tests for the individual methods plus integration tests that checked the end-to-end XML-to-XML processing.  In this way, we quickly built up a library of reusable bits (paragraphs, headings, sections, points of interest etc), so the layout of an entire chapter could be reduced to:

    within '.understand.title-page' do
      render('> section')           { section('title page')}
      render '> section > heading', :with => :intro_main_heading
      render 'heading',             :with => :title_page_heading
      render('p')                   { paragraph("List C") }
    end
    
With the really magical bit being that, *unless explicitly overridden*, the subsequent default rules handle anything else found in the chapter.

# Tricks of the trade

Since RSLT's documentation is [prudent enough not to overwhelm the novice with verbosity](http://www.gnu.org/fun/jokes/ed-msg.html), here are some nifty underdocumented features.

* There are two ways for an action to call a method.

  1. Pass in a block that explicitly calls the method, as in `{ heading(7) }`.  (This requires parens around the match.)
  2. Supply in a hash like `:with => :heading, :level => 7`.  This calls `heading()` and passes in the rest of the hash.  (This does not require parens.)

* You can use `helper ModuleName do ... end` blocks within your stylesheet to load methods from a module.  Just watch out for name conflicts, as having a method of the same name in multiple modules in the same stylesheet can lead to unexpected behaviour.

* `child_content` can be called multiple times, and it can take a CSS matcher of its own.  This lets you reorder children in the output:


    def ploughs_before_hoes
      child_content('plough')
      child_content('hoe')
    end


* Stylesheets can extend other stylesheets, just subclass the parent and call super at the end.


    class CityGuide::Stylesheet < Compilers::Typefi::Stylesheet
      def rules
        ...
        super
      end
    end

