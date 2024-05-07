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

## Playbook number 1


<br/>

## Playbook number 2

<br/>

## Playbook number 3

<br/>

## Playbook number 4