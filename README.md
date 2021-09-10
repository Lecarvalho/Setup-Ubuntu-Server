# Setup Ubuntu Server

The base scripts to run to setup a new ubuntu server

run to create cicd user:
```
adduser cicd
```
add user to sudo group
```
usermod -aG sudo cicd
```
run to don't ask password to cicd user when runs "sudo"
```
sudo visudo
```
add at the bottom of the file:
```
cicd ALL=(ALL) NOPASSWD: ALL
```
save the file

generate the public and private key locally using ssh-keygen  
on server, create the file /home/cicd/.ssh/authorized_keys with the content of the public key

copy the content of the private key and put it on your CI / CD tool (example on Azure Pipelines, go to Project Settings > Service Connection > New Service Connection > SSH)

disable login using password
```
sudo nano /etc/ssh/sshd_config
```
Change the lines:  
```
ChallengeResponseAuthentication no  
PasswordAuthentication no  
UsePAM no  
PermitRootLogin prohibit-password
```

Save and reload ssh service
```
/etc/init.d/ssh reload
```