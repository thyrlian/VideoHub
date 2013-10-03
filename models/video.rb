require 'streamio-ffmpeg'

module VideoHub
  class Video
    attr_reader :path, :name, :width, :height

    def initialize(path)
      @path = path
      @name = File.basename(path).chomp(File.extname(path))
      get_dimensions(path)
    end

    def get_dimensions(path)
      movie = FFMPEG::Movie.new(path)
      @width = movie.width
      @height = movie.height
    end

    private :get_dimensions
  end
end