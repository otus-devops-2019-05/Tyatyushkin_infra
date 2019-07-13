# Tyatyushkin_infra
Tyatyushkin Infra repository
1) Remote SSH only one command
ssh -A -t  masterplan@35.241.239.250 'ssh 10.132.0.3'
2) Create alias for command "ssh someinternalhost"
cat .ssh/config 
	Host someinternalhost
	ForwardAgent yes
	User masterplan
	Port 22
	Hostname 35.241.239.250
	RequestTTY force
	RemoteCommand ssh 10.132.0.3
bastion_IP = 35.241.239.250
someinternalhost_IP = 10.132.0.3
3) Parametres testapp
testapp_IP = 35.198.103.131
testapp_port = 9292
4) Create instance with script: 
gcloud compute instances create reddit-app  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --zone=europe-west3-b --metadata-from-file startup-script=startup_script.sh
5) Create firewall rules with gcloud:
gcloud compute --project=infra-244205 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
6) Create packer config for reddit-base
7) Create advanced config for reddit-base
8) Create packer config for reddit-full
9) Create script for create instance from reddit-full image
10) Добавлен SSH ключ польльзователя appuser1 в метаданные проекта
11) Добавлены несколько пользователей в метаданные проекта
12) Добавлен ключ через web, но после выполнения terraform apply он был затерт и все вернулось на конфигурацию которая описана в terraform
13) Создан файл балансировщика lb.tf
14) Создан файл с конфигурацией reddit-app2.tf для второго сервера, и отключен сервис пума для  проверки работы балансировщика
15) Удалена конфигурация reddit-app2.tf и созданна переменная count
