module VideoHub
  class App < Sinatra::Base
    get '/videos/:idx' do |idx|
      @idx = idx.to_i
      @video = @videos[@idx]
      haml :video
    end
  end
end