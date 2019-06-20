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
