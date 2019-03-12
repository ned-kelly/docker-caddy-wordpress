# Docker Caddy Wordpress

An "all-in-one" multi-container Dockerised deployment of Wordpress & the Caddy webserver (including a local SCP/SFTP user) for rapid deployment on your webhost (such as AWS & Amazon Linux)

-------------------


## Steps to get started:

Get up and running on your favourite webhost...
_(If you're not sure where to start, try ["Amazon Linux"](https://aws.amazon.com/marketplace/pp/B00635Y2IW?qid=1552363107319&sr=0-2&ref_=srh_res_product_title) on AWS EC2 - At less than [$4.00 Per month](https://calculator.s3.amazonaws.com/index.html#r=IAD&s=EC2&key=calc-8D55BFFA-7956-4BE1-903D-C2D734D2982D) you can't go wrong!)_

You will need the following prerequisites:

 - SSH (Root credentials) access to your Server/VPS
 - DNS/Domain already configured to point to IP of your Server/VPS

## Setting up & configuring:
Once running clone clone down the project repo and set your site/domain name like so:

```
# Switch to root user if you're not running as root
sudo -s

# Pull down sources
cd /opt
git clone https://github.com/ned-kelly/docker-caddy-wordpress.git wordpress

# Edit config/Caddyfile and replace '<YOUR-SITE-NAME>',
# with the DNS site-name that you've already configured i.e. www.yoursite.com

vi config/Caddyfile

# Run the install script that will setup the deployment & your SCP/SFTP user.
./setup.sh
```

## Uploading files to wordpress

- Once you've got the container running you may go to https://yoursite.com/ and follow the prompts for the wordpress setup.
- You will want to upload files to your server also -- you can do this using a SCP/SFTP client such as [Filezilla](https://filezilla-project.org/).
  - Use the `wordpress` user to login to the server
  - The SSH KEY that you will need to connect as the wordpress user will be echoed to your output in the setup steps - Make sure you note it down!
  - The default directory you should save your files that will be accessible from within the Docker container can be found in: `/opt/wordpress/www/`
