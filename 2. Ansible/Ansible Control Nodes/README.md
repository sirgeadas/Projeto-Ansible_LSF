# Gerar chaves SSH para enviar

1. navegar para 
2. ssh keygen
3. Chamar de:
WebServerPROD
DatabaseServerPROD
WebServerDR
DatabaseServerDR

# Executar estes passos na máquina onde está instalado o Terraform:

1. Navegar para a pasta 'Terraform Files'
2. Terraform init -upgrade
3. Isto pode ser necessário executar no terminal do VSC: 
set TF_VAR_password_Windows-PROD="SUBSTITUIR POR PASSWORD AQUI"
set TF_VAR_password_Windows-DR="SUBSTITUIR POR PASSWORD AQUI"
4. Terraform plan -out main.tfplan
5. Terraform apply main.tfplan

# Guardar as chaves SSH geradas na pasta .ssh do vosso PC

1. Entrar no Powershell ou Windows terminal.
2. ssh -i ~/.ssh/ControlnodePROD controlnodeprod@IP_PUBLICO_DA_MAQUINA.
2. ssh -i ~/.ssh/ControlnodeDR controlnodedr@IP_PUBLICO_DA_MAQUINA.

scp -i ~/.ssh/ControlNodePROD  ~/.ssh/DatabaseServerPROD controlnodeprod@IP_PUBLICO_DA_MAQUINA.:~/.ssh  
scp -i ~/.ssh/ControlNodePROD  ~/.ssh/WebServerPROD controlnodeprod@IP_PUBLICO_DA_MAQUINA.:~/.ssh  

scp -i ~/.ssh/ControlNodeDR  ~/.ssh/DatabaseServerDR controlnodedr@IP_PUBLICO_DA_MAQUINA.:~/.ssh  
scp -i ~/.ssh/ControlNodeDr  ~/.ssh/WebServerDR controlnodedr@IP_PUBLICO_DA_MAQUINA.:~/.ssh  


###################################################3

ansible-vault encrypt_string 'EMAIL' --name 'vault_email_address'

ansible-playbook setup_ansible-server.yml --ask-vault-pass

