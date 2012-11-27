require_relative 'lib/post'
require_relative 'lib/site'

class Blog < Sinatra::Base
 
  before do
    @site = Site.new
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

  get '/' do
    @posts = Post.all
    haml :index
  end
end
