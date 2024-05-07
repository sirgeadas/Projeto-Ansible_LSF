
# This project was made with Terraform and Ansible :earth_americas: 
---


<br/>

This project uses **ansible** nad **Terraform** to create and manage the Infrastructure hosted in Microsoft **Azure**.

<br/>

## Environments

There are two environments in this project:

1. **Production**
2. **Disaster Recovery**

Each environment is hosted in a different region.

## Terraform

Terraform is used to create servers in Microsoft Azure.


## Ansible

Ansible is used for the following tasks:

- Creation of a single inventory, servers grouped based on operating system type, region, server type, and environment.
- Creation of a specific playbook to perform operating system updates on each server.
- Creation of a playbook for user management.
- Web server, database, and Windows server configurations.


## How to use :question:

Please read the `Getting Started` section to be familiar on how to get this project started.

#### Getting Started
- [What you'll need](0.%20Getting%20Started/Readme.md)
- [Part 1, Terraform](0.%20Getting%20Started/Part1.md )
- [Part 2, Installing and configuring WSL](0.%20Getting%20Started/Part2.md)
- [Part 3, Configuring the Ansible Control Nodes](0.%20Getting%20Started/Part3.md)
- [Part 4, Configuring the Firewall on Windows Servers](0.%20Getting%20Started/Part4.md)


## Contribution :handshake:

If you wish to contribute, please contact us. Cheers!

## License :scroll:

This project is licensed under the MIT License - See the [LICENSE.md](#license-) file for details.
