# How does it work?

When we at Lonely Planet started writing our engine to convert data in our internal "bundle" format to the ContentXML required by our automated layout system [Typefi](http://www.typefi.com), finding a sensible way to express those rules soon became a major problem.  Here's a typical snippet in pseudocode:

    If this tag is a heading
      immediately following the start of a section
        within the Welcome to X chapter
          within a City guide
            then output "Heading 7"

SAX with deeply-nested if-else statements was clearly a no-go and dealing with this level of branching in XSLT is a nightmare.

Enter our saviour: [RSLT](https://github.com/DanielHeath/rslt).  Hacked up by [Dan](https://github.com/DanielHeath) in a moment of inspiration, it reduced the monster above to this:

    class CityGuide::Stylesheet
      within '.welcome-to-x' do
        within '.section' do
          render '> heading', :with => :heading_7

The basic idea is simple. An RSLT stylesheet consists of an ordered list of CSS matchers, followed by an action.  Call `stylesheet.transform(@xml)` on an XML document, and it walks the XML document tag by tag, testing rules until it finds a match.  When a match is found, it executes the action and moves on to the next tag.  Here's an example:

    require 'rslt'
    
    class MyStylesheet < RSLT::Stylesheet
      def rules
        render('p.red')    { builder.red() }
        render('p.yellow') { }
        render('p.blue')    { builder.purple() }
      end
    end

	MyStylesheet.transform <<-XML
    <html>
      <p class="red"/>
      <p class="yellow"/>
      <p class="blue"/>
    </html>
    XML
    
    
  
