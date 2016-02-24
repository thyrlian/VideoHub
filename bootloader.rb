#!/usr/bin/env ruby

root_dir       = File.expand_path(File.dirname(__FILE__))
nginx_conf_tpl = File.join(root_dir, 'nginx/nginx.conf.tpl')
nginx_conf     = File.join(root_dir, 'nginx/nginx.conf')

placeholders = {
  'nginx_dir'   => File.join(root_dir, 'nginx'),
  'unicorn_skt' => File.join(root_dir, 'tmp/sockets/unicorn.sock'),
  'public_dir'  => File.join(root_dir, 'public')
}

# generate a proper nginx configuration file
File.open(nginx_conf, 'w') do |f|
  File.readlines(nginx_conf_tpl).each do |l|
    placeholders.each do |k, v|
      l.gsub!("<[#{k}]>", v)
    end
    f.puts(l)
  end
end