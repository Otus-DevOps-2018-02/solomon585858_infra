#### solomon585858_infra
solomon585858 Infra repository

#### IP addresses for bastion host and someinternalhost
***
bastion_IP=35.187.31.144
***
someinternalhost_IP=10.132.0.3
***
#### Connection to someinternalhost using one command
*ssh -o ProxyCommand='ssh -W %h:%p volshebnik1985@35.187.31.144' volshebnik1985@10.132.0.3*

#### Connection to someinternalhost using ssh internalhost
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

#### Cloud-testapp configuration
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
#### Create instance using gcloud startup_script
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata-from-file startup-script=startup_script.sh

#### Create instance using gcloud startup-script-url
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script-url="https://gist.githubusercontent.com/solomon585858/2e35266f4ef92e17dd3164070c1f22e0/raw/3f43846eeda762c0cf46bcd709ff883591ab91f0/startup_script.sh"


#### Add firefall rule using gcloud
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags=puma-server

#### How to validate ubuntu16.json template
~/packer validate ubuntu16.json

#### How to create image from ubuntu16.json tempplate
~/packer build ubuntu16.json

#### How to validate variables.json.example template
~/packer validate -var 'project_id=infra-197906' -var 'source_image_family=ubuntu-1604-lts' variables.json.example

#### How to create image from variables.json.example template
~/packer build -var 'project_id=infra-197906' -var 'source_image_family=ubuntu-1604-lts' variables.json.example

#### How to validate immutable.json template
~/packer validate -var 'project_id=infra-197906' -var 'source_image_family-ubuntu-1604-lts' immutable.json

#### How to create image from immutable.json template
~/packer build -var 'proejct_id=infra-197906' -var 'source_image_family=ubuntu-1604-lts' immutable.json

#### How to create imstance using gcloud from reddit-full image
gcloud compute instances create reddit-app --machine-type=g1-small --tags puma-server --restart-on-failure --zone europe-west1-b --image reddit-full-1511608151

## ДЗ 7. Terraform
##### В процессе сделано:
 - Был установлен **Terraform** на рабочую машину
 - В папке terraform были созданы конфигурационные файлы с расширением **.tf** для запуска шаблона
 - Были продекларированы входные переменные в файле **variables.tf** и выходные в **outputs.tf**
 - Были добавлены рабочие файлы в файл **.gitignore**
 - Была создана папка **terraform/files**, в которую были размещены скрипт для развертывания  приложения и **systemd unit**
 - Была проверена корректность выполнения приложения **Terraform** по созданию и изменению инфраструктуры с последующим деплоем приложения
 - Для задания со * была проверена работа **Terraform** по созданию метаданных проекта с помощью ssh ключей (при использовании **google_compute_project_metadata_item** все ключи заменяются Terraform-ом, при использовании **google_compute_project_metadata** ключи не добавляются при наличии созданных ключей)
 - Для задания с ** в конфигурацию был добавлен Load Balancer и проверена создание нескольких инстансов с помощью **count**

## ДЗ 8. Terraform 2
#### В процессе сделано:
 - Были созданы два шаблона для создания образа в packer (**app.json**, **db.json**)
 - Были созданы конфигурации для app и db
 - Были созданы два окружения **stage** и **prod**
 - Была создана конфигурация для bucket в GCS - **storage-bucket.tf**

## ДЗ 9. Ansible
#### В процессе сделано:
 - Были проинсталлированы **WSL**, **Ubuntu** на **WSL**, **python**, **pip** и **ansible**
 - Была создана инфраструктура **stage**
 - Был создан файл **inventory** для ansible, в который были добавлены текущие инстансы для **app** и **db**
 - Была протестирована доступность инстансов с помощью **inventory** 
 - Был создан файл **ansible.cfg** для ansible в целях упрощения работы с **inventory**
 - Была протестирована работа с группой хостов с помощью **inventory**
 - Был создан файл для ansible - **inventory.yml**
 - Была протестирована работа с группой хостов с помощью **inventory.yml**
 - Было протестировано выполнение команд на инстансах с помощью модулей **command**, **shell**, **systemd**, **service**, **git**
 - Был написан ansible playbook **clone.yml** и протестирована его работа
 - После удаления папки **reddit** и запуска **clone.yml** playbook-а мы видим статус **changed**, который сигнализирует, что произошли изменения. Все tasks в ansible должны быть idempotent. Если task не модифицирует что-либо, то он должен возвращать статус **ok**, а не **changed**

#### Как запустить проект:
 - Запустить создание инфраструктуры **stage** можно с помощью команды **terraform apply** из папки **/stage**

#### Как проверить работоспособность: 
 - Протестировать доступ до appserver можно с помощью команды **ansible appserver -i inventory -m ping**
 - Протестировать доступ до dbserver можно с помощью команды **ansible dbserver -i inventory -m ping**
 - Протестировать доступ до всех серверов можно с помощью команды **ansible all -m ping**
 - Протестировать запуск playbook **clone.yml** можно с помощью команды **ansible-playbook clone.yml**
 - Проверить статус сервиса **mongod** на инстансе **db** можно одним из этих способов - **ansible db -m command -a 'sys
temctl status mongod'**, **ansible db -m shell -a 'systemctl status mongod'**, **ansible db -m systemd -a name=mongod**,
 **ansible db -m service -a name=mongod**

#### PR checklist
 - Выставил label **Homework-9** с номером домашнего задания
 - Выставил label **ansible** с номером домашнего задания
