require_relative 'app'

Dir.glob('app/lib/*.rb').each {|name| require_relative "lib/#{File.basename(name, '.*')}" }

class Blog < App

  set :post_service, PostService.new
  set :rss, RSSBuilder.new(settings.site, settings.post_service.posts)

  before do
    @site_config = settings.site
  end

  get '/:year/:month/:day/:post' do
    filename = params.values_at("year", "month", "day", "post").join('_') + '.md'
    @post = settings.post_service.find_by_filename( filename )
    pass unless @post
    haml :show_post
  end

  get '/rss' do
    content_type 'text/xml'
    feed = settings.rss.feed
    "#{feed}"
  end

  get '/' do
    @posts = settings.post_service.posts
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
