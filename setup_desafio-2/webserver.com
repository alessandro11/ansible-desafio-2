upstream desafio_2 {
    #
    # Load balancing is round-robin by default
    #
    server localhost:3001;
    server localhost:3002;
    server localhost:3003;
    server localhost:3004;
    server localhost:3005;
    server localhost:3006;
    server localhost:3007;
    server localhost:3008;
    server localhost:3009;
    server localhost:30010;
    server localhost:30011;
    server localhost:30012;
    server localhost:30013;
    server localhost:30014;
    server localhost:30015;
    server localhost:30016;
    server localhost:30017;
    server localhost:30018;
    server localhost:30019;
    server localhost:30020;
    server localhost:30021;
    server localhost:30022;
    server localhost:30023;
    server localhost:30024;
    server localhost:30025;
    server localhost:30026;
    server localhost:30027;
    server localhost:30028;
    server localhost:30029;
    server localhost:30030;
    server localhost:30031;
}

server {
    # SSL configuration
    #
    #ssl on;
    listen 443 ssl default_server;
    listen [::]:443 ssl default_server;
    server_name MYDOMAIN;
    #ssl_certificate /etc/ssl/certs/MYDOMAIN.pem;
    #ssl_certificate_key /etc/ssl/private/MYDOMAIN.pem;

    location / {
        include /etc/nginx/snippets/proxy.conf;
        proxy_pass http://desafio_2;
    }

    access_log /var/log/nginx/access_MYDOMAIN.log;
    error_log /var/log/nginx/error_MYDOMAIN.log error;
}

server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name MYDOMAIN;

    location / {
        include /etc/nginx/snippets/proxy.conf;
        proxy_pass http://desafio_2;
    }

    ##
    # Logging Settings
    ##
    access_log /var/log/nginx/access_MYDOMAIN.log;
    error_log /var/log/nginx/error_MYDOMAIN.log error;
}
