require_relative 'models/video'

module VideoHub
  class VideoFactory
    class << self
      def get_all_videos(dir, *supported_formats)
        videos = Dir["#{dir}/**/*"].select { |f| File.file?(f) }.sort
        unless supported_formats.empty?
          supported_formats.map! { |sf| sf.to_s.downcase }
          videos.select! do |video|
            video_ext = File.extname(video).gsub(/^\./, '').downcase
            supported_formats.include?(video_ext)
          end
        end
        videos
      end

      def get_all_modeled_videos(dir, *supported_formats)
        get_all_videos(dir, *supported_formats).map! { |video| Video.new(video) }
      end
    end

    private_class_method :new
  end
end