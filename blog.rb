class Blog < Sinatra::Base
  get '/:year/:month/:day/:post' do
    filename = params.values_at("year", "month", "day", "post").join('_') + '.txt'
    @article = Post.find_by_filename( filename )
    haml :show_article
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

class Post
  def self.all
    posts = []
    Dir.glob('posts/*.txt') do |f|
      posts << find_by_filename( f.split('/').last )
    end
    posts.sort_by(&:date).reverse
  end

  def self.find_by_filename( filename )
    file_hash = filename.gsub('.txt', '').split('_')
    post = OpenStruct.new
    year = file_hash.shift
    month = file_hash.shift
    day = file_hash.shift
    post.date = Date.civil(year.to_i, month.to_i, day.to_i)
    post.permalink = "/" + [ year, month, day, URI.escape(file_hash.join('_'))].join('/')
    post.title = file_hash.join(' ').capitalize
    post.content = File.open("posts/#{filename}").read
    post
  end
end
