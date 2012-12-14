require 'sinatra'
require 'sprockets'

Dir.glob('lib/*.rb').each {|name| require_relative name.gsub('.rb', '') }

class Blog < Sinatra::Base
  set :root, File.expand_path('../', __FILE__)
  set :sprockets, Sprockets::Environment.new(root)
  set :precompile, [ /\w+\.(?!js|css).+/, /(application|vendor).(css|js)$/ ]
  set :assets_prefix, 'assets'
  set :assets_path, File.join(root, 'public', assets_prefix)
  set :views, Proc.new { File.join(root, "app/views") }

  set :site_config, Site.new.config
  set :post_service, PostService.new
  set :rss, RSSBuilder.new(settings.site_config, settings.post_service.posts)

  configure do
    ["assets", "vendor"].each do |path|
      ["stylesheets", "javascripts", "images"].each do |asset_folder|
        sprockets.append_path(File.join(root, path, asset_folder))
      end
    end

    sprockets.context_class.instance_eval do
      include AssetHelpers
    end
  end

  helpers do
    include AssetHelpers
  end

  before do
    @site_config = settings.site_config
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

  get '/404' do
    haml :'404'
  end

  get '/500' do
    haml :'500'
  end

end
