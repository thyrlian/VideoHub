module VideoHub
  class App < Sinatra::Base
    get '/' do
      haml :videos
    end
  end
end