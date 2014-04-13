require 'sinatra/base'
require 'haml'

require_relative 'video_factory'

module VideoHub
  class App < Sinatra::Base
    before do
      # dir_of_original_videos = '[dir_of_your_local_videos]'
      # dir_of_public_video = File.join(File.dirname(__FILE__), 'public/media/video')
      # begin
      #   FileUtils.symlink(dir_of_original_videos, dir_of_public_video)
      # rescue Errno::EEXIST
      #   puts "Did not create any symbolic link, target already exists."
      # end
      # dir_of_new_symbolic_link = File.join(dir_of_public_video, File.basename(dir_of_original_videos))
      # @videos = VideoFactory.get_all_modeled_videos(dir_of_new_symbolic_link, :mp4)
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