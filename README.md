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

 - [x] Основное ДЗ
 - [x] Задание со *

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
 - Был добавлен скрипт на python - **inventory.py**, который используется для dynamic inventory


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
 - Протестировать работу скрипта **inventory.py** можно с помощью команды **ansible all -i inventory.py -m ping**

#### PR checklist
 - [x] Выставил label **Homework-9** с номером домашнего задания
 - [x] Выставил label **Ansible** с номером домашнего задания
 
## ДЗ 10. Ansible 2

 - [x] Основное ДЗ
 - [x] Задание со *

#### В процессе сделано:
 - Была добавлена строка в **.gitignore** для того. чтобы не запушить в репоизторий временные файлы
 - Был создан playbook **reddit_app.yml** с одним сценарием для управления конфигурацией обоих хостов (приложения и бд), который впоследствии был переименован в **reddit_app_one_play.yml**
 - Был создан playbook **reddit_app2.yml**. В него было прописано несколько сценариев (plays), в которые были объединены задачи, относящиеся к используемым в плейбуке тегам. Playbook впоследствии был переименован в впоследствии был переименован в **reddit_app_multiple_plays_yml**
 - Все playbooks (**reddit_app.yml** и **reddit_app2.yml**) были проверены на базе **stage** инфраструктуры
 - Были созданы playbooks **app.yml (настройка хоста приложения)**, **db.yml (настройка БД)**, **deploy.yml (для деплоя)**, а также файл **site.yml** для управления конфигурацией всей инфраструктуры. Инструкция **include** была заменена на *import_playbook** в **site.yml**
 - Все playbooks (**app.yml**, **db.yml**, **deploy.yml**, **site.yml** были проверены на базе **stage** инфраструктуры
 - Были созданы playbooks **packer_app.yml** и **packer_db.yml**, которые были использованы для изменения **Provision** в образах **packer/app.json** и **pacer/db.json**
 - На базе новых образов был проверен build образов с помощью **packer**, создание **stage** инфраструктуры. конфиуграция и деплой окружения с помощью **site.yml**
 - В задании со * **dynamic inventory** было реализовано с помощью скриптов **dyn_inventory.sh**, **yatadis.py (https://raw.githubusercontent.com/wtsi-hgi/yatadis/master/yatadis/yatadis.py)**. Использование скрипта **dyn_inventory.sh** было добавлено в **ansible.cfg**.

#### Как запустить проект:
 - После запуска **stage** инфраструктуры и  playbooks приложение должно быть доступно по адресу **http://35.187.45.148:9292/**
 - Для проверки работы **dynamic inventory** нужно закомментировать в **ansible.cfg** строку *inventory = ./inventory* и раскомментировать строку *inventory = ./dyn_inventory.sh*

#### Как проверить работоспособность:
 - Проверить playbook для группы хостов **db** можно командой **ansible-playbook reddit_app.yml --check --limit db**
 - Запустить playbook для группы хостов **db** можно командой **ansible-playbook reddit_app.yml --limit db**
 - Проверить playbook для группы хостов **app** с тэгами **app-tag** можно командой ansible-playbook reddit_app.yml --check --limit app --tags app-tag**
 - Запустить playbook для группы хостов **app** с тэгами **app-tag** можно командой ansible-playbook reddit_app.yml  --limit app --tags app-tag**
 - Пересоздать **stage** инфраструктуру можно с помощью команд **terraform destroy** и **terraform apply -auto-approve=false**
 - Проверить группу playbooks на базе **site.yml** можно командой **ansible-playbook site.yml --check**
 - Запустить группу playbooks на базе **site.yml** можно командой **ansible-playbook site.yml**

#### PR checklist
 - [x] Выставил label **Homework-10** с номером домашнего задания
 - [x] Выставил label **Ansible** с номером домашнего задания

## ДЗ 11. Ansible 3

 - [x] Основное ДЗ
 - [ ] Задание со *

#### В процессе сделано:
 - Были созданы роли для конфигурации Mongo DB (**db.yml**) и для управления конфигурацией приложения (**app.yml**)
 - Были созданы два окружения **stage** и **prod** в директории **ansible/environments**
 - Были созданы настройки окружений **stage** и **prod** с помощью групповых переменных **group_vars**
 - Были реорганизованы файлы и папки в каталоге **ansible**: в директорию **playbooks** были перенесены все playbooks, в директорию **old** были перенесены оставшиеся файлы, а в папке **ansible** были оставлены файлы **ansible.cfg** и **requrements.txt**
 - Были внесены изменения в **ansible.cfg** (явно было указано где роли, выключено создание **.retry** файлов, настроен показ дифф при изменениях)
 - Была установлена комьюнити роль **jdauphant.nginx** с помощью утилиты **ansible-galaxy**, добавлено открытие 80 порта в конфигурации терраформа, добавлен вызов роли **jdauphant.nginx** в playbook **app.yml**
 - Был протестирован механизм **Ansible Vault**, в рамках которого был создан улюч **vault.key**, изменен файл **ansible.cfg**, добавлен playbook для создания пользователей **users.yml**, созданы файлы с данными пользователей для окружений **stage** и **prod**

#### Как запустить проект:
 - После запуска **stage** инфраструктуры и playbooks приложение должно быть доступно по адресу **http://IPaddressOFApplication:80/**

#### Как проверить работоспособность:
 - Пересоздать **stage** инфраструктуру можно с помощью команд **terraform destroy** и **terraform apply -auto-approve=false**
 - Проверку и создание **stage** окружения можно выполнить с помощью команд **ansible-playbook playbooks/site.yml --check** и **ansible-playbook playbooks/site.yml**
 - Проверку и создание **prod** окружения можно выполнить с помощью команд **ansible-playbook -i environments/prod/inventory playbooks/site.yml --check** и **ansible-playbook -i environments/prod/inventory playbooks/site.yml**
 - Проверку шифрования файлов для окружений **stage** и **prod** можно выполнить с помощью команд **ansible-vault encrypt environments/prod/credentials.yml** и **ansible-vault encrypt environments/stage/credentials.yml**
 
#### PR checklist
 - [x] Выставил label **Homework-11** с номером домашнего задания
 - [x] Выставил label **Ansible** с номером домашнего задания
