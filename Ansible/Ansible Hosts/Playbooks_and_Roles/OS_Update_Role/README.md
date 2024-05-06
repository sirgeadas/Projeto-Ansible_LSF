# 
windows_update
=========

Ansible role to search for windows updates, install the updates and then reboot the server when reboot is required after installing the updates.
This Ansible role is responsible for performing the following tasks on a system:

-Update APT cache

-Upgrade packages using APT

-Update Yum cache

-Upgrade packages using Yum

-Check for missing updates

-List missing updates

-Install updates

-Detail the updates performed

-Restart the Windows system if necessary


### Requirements
------------

The target Windows machines must have whitelisted network access to download updates.

This role has been tested on Ubuntu and CentOS/RHEL systems. It requires Ansible to be installed on the control node.

### Role Variables
--------------

By default, this role installs the default categories of updates provided by the Ansible OS_Update_Role module.

### Dependencies
------------

This role does not have any dependencies.

Example Playbook
----------------
```
- hosts: all
  tasks:
  - name: Run Windows Updates.
    include_role:
     name:OS_Update_Role
```
### License
-------
GPL

### Author Information
-------

This role was created by LSF. You can reach me at (https://github.com/sirgeadas/Projeto-Ansible_LSF)

Feel free to customize this role to fit your specific requirements and contribute back to the Ansible community. Thank you for using this role!

Reference
--------
