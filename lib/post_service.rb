class PostService

  attr_reader :posts

  def initialize
    @posts = get_posts
  end

  def find_by_filename( filename )
    posts = @posts.select { |p| p.path == "posts/#{filename}"}
    return posts.first if posts.any?
  end

  private

  def get_posts
    posts = []
    Dir.glob('posts/*.md') do |f|
      posts << get_post( f.split('/').last )
    end
    posts.sort_by(&:date).reverse
  end

  def get_post(filename)
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
    post.path = file_path

    post = check_for_modification_metadata(post, file_path)
  end

  def check_for_modification_metadata(post, file_path)
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