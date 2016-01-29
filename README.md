# VideoHub

##Introduction
The idea of this project is just to:
* set up a simple online video system
* allow all of your home devices to access your private video resources
* cast your video content to [Chromecast](https://www.google.com/chromecast)

##Config
It's working out of the box (zero config with the default WEBrick server).

But sometimes the video file could be very large, for instance I have a MP4 file which is over 1GB, and WEBrick (1.3.1) could not handle it properly.
```Shell
ERROR Errno::EPROTOTYPE: Protocol wrong type for socket
/ruby/2.0.0/webrick/httpresponse.rb:458:in `write'
/ruby/2.0.0/webrick/httpresponse.rb:458:in `<<'
/ruby/2.0.0/webrick/httpresponse.rb:458:in `_write_data'
/ruby/2.0.0/webrick/httpresponse.rb:451:in `_send_file'
/ruby/2.0.0/webrick/httpresponse.rb:406:in `send_body_io'
/ruby/2.0.0/webrick/httpresponse.rb:303:in `send_body'
/ruby/2.0.0/webrick/httpresponse.rb:207:in `send_response'
```

Thus it's encouraged to use high performance server, e.g.: [Nginx + Unicorn](http://recipes.sinatrarb.com/p/deployment/nginx_proxied_to_unicorn).

##License
Copyright (c) 2016 Jing Li. See the LICENSE file for license rights and limitations (MIT).
