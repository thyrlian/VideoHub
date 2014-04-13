require 'sinatra/base'
require 'haml'

require_relative 'video_factory'

module VideoHub
  class App < Sinatra::Base
    before do
      dir_video = File.join(File.dirname(__FILE__), 'public/media/video')
      @videos = VideoFactory.get_all_modeled_videos(dir_video, :mp4)
    end

    get '/' do
      haml :videos
    end

    get '/videos/:idx' do |idx|
      @idx = idx.to_i
      @video = @videos[@idx]
      haml :video
    end
  end
end

VideoHub::App.run!