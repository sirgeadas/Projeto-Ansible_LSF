# How-to run the playbooks:
---

The playbooks where made to be deployed in order.
If you take a look at the playbooks, they start with a number:

```
1. Create_Users_and_Groups.yml
2. Install_MySQL_and_configure.yml
3. Install_MySQL_Workbench.yml
4. Install_Wordpress.yml
```
>[!IMPORTANT]
>Please respect the order for proper function of the playbooks.

On your control node, navigate to the following directory:

```bash
cd Github/2.\ Ansible/Ansible\ Hosts/Playbooks_and_Roles/
```

This directory serves as the base from which all commands will be deployed. Within this directory, you’ll find folders containing roles, playbooks, and an `ansible.cfg` file. <p>
The `ansible.cfg` file specifies the location of the inventory, eliminating the need to invoke the inventory file each time an Ansible command is used. 😉

<br/>

## Playbook number 1, Create_Users_and_Groups.yml
To run this playbook, just type:
```bash
ansible-playbook 1.Create_Users_and_Groups.yml -l Production
```
<sup> Use this on the Production control node </sup>
```bash
ansible-playbook 1.Create_Users_and_Groups.yml -l Disaster
```
<sup> Use this on the Disaster control node </sup>

This will create the Groups and users on the targeted machines. 

>[!CAUTION]
> Since the Windows servers machines are also included in this group, Ansible will throw an error that the machine is unreachable. Please ignore. :cowboy_hat_face:

<br/>

## Playbook number 2, Install_MySQL_and_configure.yml

And now, for our next trick: Installing MySQL-Server on Debian machines.
To run this playbook, just type:
```bash
ansible-playbook 2.Install_MySQL_and_configure.yml -l dbservers --ask-vault-password
```
Ansible will now ask you for the vault password:
```
Vault password:
```
You know the password! Just type it in! :grin:
This is because there is a file that contains passwords and usernames that must remain encrypted (called `secrets.yml`)

> [!TIP]
>If you wish to see what that file contains, type:
>```bash 
>ansible-vault edit MySQL_Server_Role/vars/secrets.yml
>```
>Ansible will ask you for the vault password:
>```
>Vault password:
>```
>Just type it in and you can now see the variables and they values.

Since each Ansible Control node can only reach the machines in its respective Resource Group, an error will occur as one of the machines is unreachable. Ignore the error. It's all good! :upside_down_face: <p>
Do the same command on the other Ansible Control node.

<br/>

## Playbook number 3, Install_MySQL_Workbench.yml
Now, this role targets the Windows machines. This one was a doozy... :woozy_face: <p>
Type:
```bash
ansible-playbook 3.Install_MySQL_Workbench.yml -l windows_servers -k
```
Since we are using WinRM to acess the target machine and using an convencional password access, we need to input that. That is why we are using the `-k` command.
After pressing `ENTER` on your keyboard, Ansible will ask you for the password:
```
SSH password: 
```
You now what's the password. Just type it in! :grin:

Do the same command on the other Ansible Control node.

<br/>

## Playbook number 4, Install_Wordpress.yml

And here it is, the last one! Just type:
```bash
ansible-playbook 4.Install_Wordpress.yml -l webservers --ask-vault-password
```
Ansible will now ask you for the vault password:
```
Vault password:
```
You now what's the password. Just type it in! :grin:
Do the same command on the other Ansible Control node.
