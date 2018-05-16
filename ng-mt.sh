#!/bin/bash
#color
RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

echo -e ${LGREEN}
echo "#################################"
echo "### Setting Server for WebApp ###"
echo "#################################"
echo -e ${RESTORE}
read -p 'Host Name example.com or domain.example.com : ' hostName
sudo mkdir -p /var/www/$hostName/html
sudo chown -R $USER:$USER /var/www/$hostName/html
sudo chmod -R 755 /var/www
cat > /var/www/$hostName/html/index.html <<EOF
<html>
    <head>
        <title>Welcome to ${hostName}</title>
    </head>
    <body>
        <h1>Success!  The ${hostName} server block is working!</h1>
    </body>
</html>
EOF
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$hostName
cat > /etc/nginx/sites-available/$hostName <<EOF
server {
    listen 80;
    listen [::]:80;

    root /var/www/${hostName}/html;
    index index.html index.htm;

    server_name ${hostName};

    location / {
        try_files '$uri $uri/' =404;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/$hostName /etc/nginx/sites-enabled/
sudo service nginx restart
