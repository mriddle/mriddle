class RSSBuilder
  require "rss"
  
  def build_feed(site, posts)
    RSS::Maker.make("atom") do |maker|
      maker.channel.author = site["rss_author"]
      maker.channel.updated = Time.now.to_s
      maker.channel.about = site["rss_about"]
      maker.channel.title = site["rss_title"]

      posts.map do |post|
        maker.items.new_item do |item|
          item.link = post.permalink
          item.title = post.title
          item.updated = post.modified ? post.modified_on.strftime("%e %b, %Y") : post.date.strftime("%e %b, %Y")
        end
      end
    end
  end

end