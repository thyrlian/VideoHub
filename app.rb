require 'sinatra/base'
require 'haml'

require_relative 'models/init'
require_relative 'routes/init'
require_relative 'helpers/init'

module VideoHub
  class App < Sinatra::Base
    current_working_dir = File.dirname(__FILE__)
    set :views, "#{current_working_dir}/views"
    set :public_folder, "#{current_working_dir}/public"
    
    before do
      dir_video = File.join(File.dirname(__FILE__), 'public/media/video')
      @videos = VideoFactory.get_all_modeled_videos(dir_video, :mp4)
    end
  end
end

VideoHub::App.run!