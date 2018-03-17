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
