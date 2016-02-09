require 'sinatra/base'
require 'haml'

require_relative 'models/init'
require_relative 'routes/init'
require_relative 'helpers/init'

module VideoHub
  class App < Sinatra::Base
    configure do
      root_dir = File.dirname(__FILE__)
      set :root, root_dir
      set :app_file, File.join(root_dir, File.basename(__FILE__))
      set :views, "#{root_dir}/views"
      set :public_folder, "#{root_dir}/public"
      set :bind, '0.0.0.0'
    end
    
    before do
      dir_video = File.join(File.dirname(__FILE__), 'public/media/video')
      @videos = VideoFactory.get_all_modeled_videos(dir_video, :mp4)
    end
  end
end

run VideoHub::App