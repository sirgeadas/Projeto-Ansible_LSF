# Projecto Ansible com Terraform :earth_americas:

Este projecto utiliza **Ansible** e **Terraform** para gerir a infraestrutura em Microsoft **Azure**.

## Ambientes

Existem dois ambientes neste projecto:

1. **Produção**
2. **Disaster Recovery**

Cada ambiente está hospedado em uma região diferente.

## Ansible

O Ansible é usado para as seguintes tarefas:

- Criação de um único inventário, servidores agrupados com base no tipo de sistema operativo, região, tipo de servidor e ambiente.
- Criação de um playbook específico para realizar atualizações do sistema operativo em cada servidor.
- Criação de um playbook para gestão de utilizadores.
- Configurações de Servidores Web, base de dados e Windows.

## Terraform 

O Terraform é usado para criar servidores em Microsoft Azure.

## Como usar :question:

Descarregar e correr no Control node em Ansible.

## Contribuição  :handshake:

Nah, deixa estar isso.

## Licença :scroll:

Este projeto está licenciado sob a Licença MIT - Confirme o ficheiro LICENSE.md para detalhes.
