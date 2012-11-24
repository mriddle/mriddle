class Blog < Sinatra::Base
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

class Post
  def self.all
    posts = []
    Dir.glob('posts/*.md') do |f|
      posts << find_by_filename( f.split('/').last )
    end
    posts.sort_by(&:date).reverse
  end

  def self.find_by_filename( filename )
    file_hash = filename.gsub('.md', '').split('_')
    post = OpenStruct.new
    year = file_hash.shift
    month = file_hash.shift
    day = file_hash.shift
    file_path = "posts/#{filename}"

    post.date = Date.civil(year.to_i, month.to_i, day.to_i)
    post.permalink = "/" + [ year, month, day, URI.escape(file_hash.join('_'))].join('/')
    post.title = file_hash.join(' ').capitalize
    post.content = File.open(file_path).read

    post = check_for_modifications(post, file_path)
  end

  private

  def self.check_for_modifications(post, file_path)
    authors = `git log "#{file_path}" | grep "Author"`.split("\n")
    dates = `git log "#{file_path}" | grep "Date"`.split("\n")
    post.modified = false
    if authors.size >= 2 && dates.size >= 2
      post.modified = true
      post.modified_by = authors.first.gsub("Author: ", "")
      post.modified_on = Date.parse(dates.first.gsub("Date: ", ""))
    end
    post
  end

end
