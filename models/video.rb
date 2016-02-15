require 'streamio-ffmpeg'

module VideoHub
  class Video
    attr_reader :path, :name, :type, :width, :height, :duration

    def initialize(path)
      @path = path
      @name = File.basename(path).chomp(File.extname(path))
      @type = process_type(File.extname(path).gsub(/^\./, '').downcase)
      metadata = FFMPEG::Movie.new(path)
      get_dimensions(metadata)
      get_duration(metadata)
    end
    
    def process_type(extname)
      case extname
      # mkv could be supported only by Chrome so far
      # mkv with AC3 audio encoding would be played without sound
      # transcode AC3 to AAC should work fine
      when 'mkv'
        return 'webm'
      else
        return extname
      end
    end

    def get_dimensions(metadata)
      @width = metadata.width
      @height = metadata.height
    end

    def get_duration(metadata)
      duration_in_secs = metadata.duration
      @duration = [[60, :seconds], [60, :minutes], [24, :hours], [1000, :days]].map { |count, name|
        if duration_in_secs > 0
          duration_in_secs, n = duration_in_secs.divmod(count)
          "#{n.to_i} #{name}"
        end
      }.compact.reverse.join(' ')
    end

    private :process_type, :get_dimensions, :get_duration
  end
end