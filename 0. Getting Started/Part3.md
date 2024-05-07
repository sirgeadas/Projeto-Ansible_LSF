## Part 3, Configuring the Ansible Control Nodes

In this part, we will configure the Ansible Control Nodes. Follow these steps:

<br/>
<br/>

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
> [!WARNING]
>Azure might give a different public IP address every time the Terraform creates the machines. So keep this in mind. 

Go to portal.azure.com and check if the machines IP's match the ones stored on this file. If they do, then you don't need to do anything. If they do not, edit the file and save it by going to `File` and then press `Save` or by pressing `CTRL + S`.

<br/>      

### Step 2: Copying the SSH Keys to Repository 
In case you've missed the **Readme** file - first of all why? This took a long time writing! - someone on our team will send you the keys in a encrypted `.zip` format. Extract them to the root of the project folder.

It should be something like this:
```
Projeto-Ansible_LSF
├── ssh_keys  
|    ├── controlnodedr    -> These are the keyes needed!
|    └── controlnodeprod  -> These are the keyes needed!
├── 0. Getting Started 
├── 1. Terraform Files 
├── 2. Ansible 
├── .gitignore 
├── LICENCE.md 
└── README.md
```

### Step 3: Copying the Repository files to the WSL machine

Since our terminal on **VSC** is still on the WSL Ubuntu machine and we need to copy some files. type:
```
exit
```
and then:
```powershell
Copy-Item -Path "C:\Users\$env:USERNAME\Documents\Projeto-Ansible_LSF" -Destination "\\wsl$\Ubuntu\home\YOUR_WSL_USERNAME\" -Recurse
```
Replace `YOUR_WSL_USERNAME` with the username that you gave on `Part2 - Step 2` <p>
This will copy the repository to the WSL Ubuntu machine, which will allow the machine to run the necessary playbooks on the Azure machines <sub>(that soon will become Ansible Control nodes)</sub> and the SSH keys necessary to target the machines with the playbook.

<br/>

### Step 4: Login back to WSL machine
Now that the WSL has all the files necessary to do what we need, on the **VSC** terminal type:
```powershell
WSL
```
and then
```bash
cd
```
Just to make sure that we are in the home directory of the WSL machine.

<br/>

### Step 5: Copying the SSH Keys to the correct place
Previously, we've copied the keys that where supplied to the `Projeto-Ansible_LSF` folder. Now we need to move them to the right place. Type:

```bash
mkdir -p ~/.ssh && cp ~/Projeto-Ansible_LSF/ssh_keys/ControlNode* ~/.ssh/ && chmod 0600 ~/.ssh/ControlNode* && touch ~/.ssh/known_hosts && for keyfile in ~/.ssh/ControlNode*; do ssh-keygen -lf $keyfile >> ~/.ssh/known_hosts; done
```
We can now run ansible to the target machines! :smile:

<br/>

### Step 6: Using ansible to ping the machines.

Type:
```bash
cd Projeto-Ansible_LSF/2.\ Ansible/Ansible\ Control\ Nodes/
```
and then:
```bash
ansible all -m ansible.builtin.ping 
```
If everything went correctly, both machines should respond with an pong. :tennis:

<br/>

### Step 7: Running the setup playbook
type:
```bash
ansible-playbook 1_setup_ansible-server.yml --ask-vault-password
```
This playbook will install and configure everything and turn the machines into ansible control nodes. :dart:
The `--ask-vault-password` is required because there's variables that must parse sensitive data, so it must be encrypted.
The password was given by one of your collegues. Its a secret! :innocent:

The WSL machine will output two ssh key yhrough ansible's debug module.
Copy them and paste them on your `Github's SSH and GPG keys` (located in settings).

<br>

### Step 8: Running the clonegit playbook
Type:
```bash
ansible-playbook 2_clonegit_ansible-server.yml
```

This playbook simply does a git pull of the `Projeto-Ansible_LSF` main repository.

<br>
*** 


The machines are ready to do ansible playbooks on the target machines. 🎉:partying_face:

[Onto Part 4!](Part4.md) :arrow_forward:
