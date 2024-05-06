#
WordPress_Server_Installation
=========
WordPress is the most popular CMS (content management system) on the internet, allowing users to set up flexible blogs and websites on top of a MySQL backend with PHP processing. After setup, almost all administration can be done through the web frontend. And this is our goal . 

Below are the tasks that will be carried out after running this playbook:

-Install prerequisites

-Install the required LAMP packages and PHP extensions.

### Apache Configuration
-Create document Root

-Create and enable a new Apache VirtualHost for the WordPress website.

-Enable the Apache rewrite (mod_rewrite) module.

-Enable new site.

-Disable the default Apache website.

### UFW Configuration
-Set up UFW to allow HTTP traffic on the configured port (80 by default).

-Set WordPress_server_IP for machines with IP of webserver_prod and webserver_dr

### WordPress Configuration
-Download and unpack latest WordPress

-Set ownership

-Set permissions for directories and files

-Set up wp-config


Requirements
------------

1. An Ansible control node: 
   - Ubuntu 18.04 machine with Ansible installed
   - Configured to connect to Ansible hosts using SSH keys
   - A regular user with sudo permissions
   - Firewall enabled as per Initial Server Setup guide
   - Follow guide on How to Install and Configure Ansible on Ubuntu 18.04 to set up Ansible

2. One or more Ansible Hosts:
   - Remote Ubuntu 18.04 servers
   - Previously set up following the guide on How to Use Ansible to Automate Initial Server Setup on Ubuntu 18.04.

Role Variables
--------------

The variables for this Role do not need to be changed in vars/default.yml
The variables in vars/secrets.yml are encrypted for greater security.

Dependencies
------------

This role does not have any dependencies.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------
GPL

Author Information
------------------

This role was created by LSF. You can reach me at (https://github.com/sirgeadas/Projeto-Ansible_LSF)

Feel free to customize this role to fit your specific requirements and contribute back to the Ansible community. 

Thank you for using this role!
