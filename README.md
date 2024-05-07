
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
- [Part one, Terraform](#getting-started/Part1.md )
- [Part two, Installing and configuring WSL](#getting-started/Part2.md)
- [Part three, Configuring the Ansible Control Nodes](#getting-started/Part3.md)


## Contribution :handshake:

If you wish to contribute, please contact us. Cheers!

## License :scroll:

This project is licensed under the MIT License - See the LICENSE.md file for details.
