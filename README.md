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

## How to validate ubuntu16.json template
~/packer validate ubuntu16.json

## How to create image from ubuntu16.json tempplate
~/packer build ubuntu16.json

## How to validate variables.json.example template
~/packer validate -var 'project_id=infra-197906' -var 'source_image_family=ubuntu-1604-lts' variables.json.example

## How to create image from variables.json.example template
~/packer build -var 'project_id=infra-197906' -var 'source_image_family=ubuntu-1604-lts' variables.json.example

## How to validate immutable.json template
~/packer validate -var 'project_id=infra-197906' -var 'source_image_family-ubuntu-1604-lts' immutable.json

## How to create image from immutable.json template
~/packer build -var 'proejct_id=infra-197906' -var 'source_image_family=ubuntu-1604-lts' immutable.json

## How to create imstance using gcloud from reddit-full image
gcloud compute instances create reddit-app --machine-type=g1-small --tags puma-server --restart-on-failure --zone europe-west1-b --image reddit-full-1511608151

## Output variables for terraform
***
app_external_ip - IP address for microservices
***
gcb_lb_external_ip - IP address for Load Balancer GCP
***
## How to check configuration files, launch microservices and Load Balancer in Terraform
***
terraform plan
***
terraform apply
***
## How to access application using GCP Load Balancer
Use IP address in gcp_lb_external_ip variable
