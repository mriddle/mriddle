require_relative 'lib/post'
require_relative 'lib/site'
require_relative 'lib/rss_builder'

class Blog < Sinatra::Base
 
  before do
    @site = Site.new
    @posts = Post.all
    @rss_builder = RSSBuilder.new
  end

  get '/:year/:month/:day/:post' do
    filename = params.values_at("year", "month", "day", "post").join('_') + '.md'
    @post = Post.find_by_filename( filename )
    haml :show_post
  end

  get '/stylesheet.css' do
    content_type 'text/css', charset: 'utf-8'
    sass :stylesheet, :style => :compact
  end

  get '/rss' do
    content_type 'text/xml'
    feed = @rss_builder.build_feed(@site, @posts)
    "#{feed}"
  end

  get '/' do
    haml :index
  end
end
