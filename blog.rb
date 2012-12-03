require_relative 'lib/post'
require_relative 'lib/site'
require_relative 'lib/rss_builder'

class Blog < Sinatra::Base

  set :site_config, Site.new.config
  set :posts, Post.all
  set :rss, RSSBuilder.new(settings.site_config, settings.posts)

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
    feed = settings.rss.feed
    "#{feed}"
  end

  get '/' do
    @site_config = settings.site_config
    @posts = settings.posts
    haml :index
  end

  post '/' do
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    puts "Remote IP #{remote_ip}"
    trusted_github_ips = ["207.97.227.253", "50.57.128.197", "108.171.174.178"]
    if trusted_github_ips.include? remote_ip
      puts "Push received from trusted source."
      post_pushed = JSON.parse(params[:payload])['commits'].select { |c| c['message'].downcase.include? 'post' }.any?
      if post_pushed
        puts "A post has recently been pushed. Updating!"
        puts `git pull --rebase origin master`
        puts `bundle exec cap deploy`
      end
    end
  end

end
