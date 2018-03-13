# solomon585858_infra
solomon585858 Infra repository

# Connection to internalhost using one command
ssh -o ProxyCommand='ssh -W %h:%p volshebnik1985@35.187.31.144' volshebnik1985@10.132.0.3

# Connection to internalhost using ssh internalhost
1. Create ~/.ssh/config file
2. Add following lines to config file:
Host bastion
  Hostname 35.187.31.144
  User volshebnik1985

Host internalhost
  Hostname 10.132.0.3
  User volshebnik1985
  ProxyCommand ssh bastion -W %h:%p
3. Connect to internal host using 'ssh internal' command
