# Ansible Machines:

Name: Grupo2-weu-prod-vm-ANSIBLE
User: controlnode
SSH Key: ControlNodePROD

Machine: Grupo2-neu-dr-vm-ANSIBLE
User: controlnode
SSH Key: ControlNodeDR

# Web Server Machines:

Machine: webserver_prod
User: ansible
SSH Key: WebServerPROD

Machine: webserver_dr
User: ansible
SSH Key: WebServerDR


# Windows Server Machines:

Machine: Grupo2-weu-prod-vm-WINDOWSSERVER
User= WinDR
Password: Formando2022

Machine: Grupo2-neu-dr-vm-WINDOWSSERVER
User= WinDR
Password: Formando2022


# Database Server Machines:

Machine: dbserver_prod
User: ansible
SSH Keys: DatabaseServerPROD

Machine: dbserver_dr
User: ansible
SSH Keys: DatabaseServerDR