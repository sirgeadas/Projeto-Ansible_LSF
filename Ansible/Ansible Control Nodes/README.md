# Execute this command 

ansible-vault encrypt_string 'filipe1625@gmail.com' --name 'vault_email_address'

ansible-playbook setup_ansible-server.yml --ask-vault-pass
