worker_processes  1;

error_log  <[nginx_dir]>/logs/nginx.error.log;
pid        <[nginx_dir]>/logs/nginx.pid;

events {
    worker_connections  1024;
    # set to on if you have more than 1 worker_processes
    accept_mutex off;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    access_log <[nginx_dir]>/logs/nginx.access.log combined;

    sendfile       on;
    tcp_nopush     on;
    tcp_nodelay    on;
    keepalive_timeout  65;
    types_hash_max_size 2048;

    gzip  on;
    gzip_disable "msie6";

    upstream unicorn_server {
        server unix:<[unicorn_skt]>
        fail_timeout=0;
    }

    server {
        listen       *:8080;
        server_name  _;

        root <[public_dir]>;

        client_max_body_size 4G;
        keepalive_timeout 5;

        location / {
            try_files $uri @app;
        }

        location @app {
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            proxy_pass http://unicorn_server;
        }
    }

    include servers/*;
}