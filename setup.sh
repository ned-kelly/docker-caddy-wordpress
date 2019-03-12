#!/bin/bash

# Setup Docker/Docker Compose
yum install docker -y
chkconfig docker on && service docker start

sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /sbin/docker-compose

mkdir -p /opt/wordpress/www && chmod 777 /opt/wordpress && chmod 777 /opt/wordpress/www

# Add wp user/group for SCPing files to server...
useradd -u 82 -d /opt/wordpress wordpress
chown wordpress: /opt/wordpress

# Create SCP Keys...
su -c " 

    mkdir -p /opt/wordpress/.ssh/
    yes | ssh-keygen -t rsa -b 4096 -C 'Wordpress SCP user' -f '/opt/wordpress/.ssh/id_rsa' -q -N ''
    cat /opt/wordpress/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

    # We need to set permissions so users can SCP in:
    chmod go-w ~/
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

" -s /bin/bash wordpress

docker-compose up -d

echo "YOUR PRIVATE KEY FOR SCP ACCESS TO SERVER IS: "
cat  /opt/wordpress/.ssh/id_rsa
