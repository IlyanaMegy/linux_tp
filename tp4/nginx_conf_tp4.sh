user web;
worker_processes 1;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*.conf;

    server {
        listen       80 default_server;
#       listen       [::]:80 default_server;

        server_name   nginxserv.site2;

        location / {
                root /srv/site2;
                index index.html index.htm index.nginx-debian.html;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
     }
     server {
        listen       80;
#       listen       [::]:80;

        server_name   nginxserv.site1;
#       index index.html index.htm index.nginx-debian.html;

        location / {
                root /srv/site1;
                index index.html index.htm index.nginx-debian.html;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
     }


# Settings for a TLS enabled server.

    server {
        listen       443 ssl http2;
        listen       [::]:443 ssl http2 ;
        server_name  nginxserv.site1;

        ssl_certificate "nginxserv.site1.crt";
        ssl_certificate_key "nginxserv.site1.key";

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
                root /srv/site1;
                index index.html index.htm index.nginx-debian.html;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

    server {
        listen       443 ssl http2;
        listen       [::]:443 ssl http2;
        server_name  nginxserv.site2;

        ssl_certificate "nginxserv.site2.crt";
        ssl_certificate_key "nginxserv.site2.key";

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
                root /srv/site2;
                index index.html index.htm index.nginx-debian.html;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

    upstream gitea {
        server 127.0.0.1:3000
    }

    server {
        listen 80;
        server_name git.tp4;

        location / {
            proxy_pass http://gitea;
        }
    }
}