## Part 3: Configuring the Ansible Control Nodes

In this part, we will configure the Ansible Control Nodes. Follow these steps:

### Step 1: Edit the Inventory File
In Visual Studio Code, go to the explorer tab. Alternatively, you can press `CTRL+Shift+E`. <p>
Navigate to `2.Ansible > Ansible Control Nodes > Inventory` and edit the `Inventory.yml` file with the public IP addresses of `controlnodedr` and `controlnodeprod`.

The `Inventory.yml` might look something like this:
```yaml
ansible_servers: 
  hosts:
   ansible_prod:
      ansible_host: XXX.XXX.XXX.XXX
   ansible_dr: 
      ansible_host: XXX.XXX.XXX.XXX
```
Azure might give a different public IP address every time the Terraform creates the machines. So keep this in mind.
      