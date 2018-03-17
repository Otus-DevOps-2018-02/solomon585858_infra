## solomon585858_infra
solomon585858 Infra repository

## IP addresses for bastion host and someinternalhost
***
bastion_IP=35.187.31.144
***
someinternalhost_IP=10.132.0.3
***
## Connection to someinternalhost using one command
*ssh -o ProxyCommand='ssh -W %h:%p volshebnik1985@35.187.31.144' volshebnik1985@10.132.0.3*

## Connection to someinternalhost using ssh internalhost
1. Create *~/.ssh/config* file <br />
2. Add following lines to *config* file:
***
*Host bastion <br />
&nbsp;&nbsp;Hostname 35.187.31.144 <br />
&nbsp;&nbsp;User volshebnik1985* <br />

*Host internalhost <br />
&nbsp;&nbsp;Hostname 10.132.0.3 <br />
&nbsp;&nbsp;User volshebnik1985 <br />
&nbsp;&nbsp;ProxyCommand ssh bastion -W %h:%p* <br />
***
3. Connect to internal host using *ssh internalhost* command <br />

## Cloud-testapp configuration
***
reddit-app_IP = 35.205.94.85
***
testapp_IP = 35.205.94.85
***
testapp_PORT = 9292
***
install_ruby.sh - Ruby installation script
***
install_mongodb.sh - Mongodb installation script
***
deploy.sh - Puma installation script
***
startup_script.sh - Puma automatic installation and deployment script
***
## Create instance using gcloud startup_script
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata-from-file startup-script=startup_script.sh

## Create instance using gcloud startup-script-url
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script-url="https://gist.githubusercontent.com/solomon585858/2e35266f4ef92e17dd3164070c1f22e0/raw/3f43846eeda762c0cf46bcd709ff883591ab91f0/startup_script.sh"


## Add firefall rule using gcloud
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags=puma-server

