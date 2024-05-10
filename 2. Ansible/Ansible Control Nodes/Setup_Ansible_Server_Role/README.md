# Ansible Control Node Setup Role

This Ansible role sets up an Ansible control node. It performs the following tasks:

- Updates and upgrades repositories
- Installs Ansible and Python3-pip
- Installs pywinrm
- Generates an SSH key
- Prints the SSH public key
- Starts the SSH agent and adds the SSH key
- Creates an SSH config file
- Adds GitHub to known hosts
- Checks if UFW is enabled and enables it if not
- Allows SSH (Port 22) through the firewall
- Denies all other incoming traffic
- Copies the host SSH keys
- Displays a success message

## Requirements

This role requires Ansible 2.9 or higher.

## Role Variables

The variables that can be passed to this role and a brief description about them are as follows:

- `vault_email_address`: The email address used when generating the SSH key.
- `GH_key_name`: The name of the GitHub key.
- `ssh_keys`: The SSH keys to copy.

## Example Playbook

Here is an example playbook:

```yaml
- hosts: servers
  roles:
    - { role: ansible_control_node_setup }
```

### License
-------
GPL

### Author Information
-------

This role was created by LSF. You can reach me at (https://github.com/sirgeadas/Projeto-Ansible_LSF)

Feel free to customize this role to fit your specific requirements and contribute back to the Ansible community. Thank you for using this role!