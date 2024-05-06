# Part two, Installing and configuring WSL

Why are we installing a Linux Subsystem on our Windows machine? The answer is simple! We’ve created a playbook that automates the installation and configuration process on the two Ubuntu servers that were created in Azure. This transforms them into Ansible Control Nodes. With just a few commands, they’ll be ready to go!

<br/>
<br/>

### Step 1: Enable the Windows Subsystem for Linux

On the terminal in Visual Studio code, type:
```bash
wsl --install

```
This command installs the Ubuntu distribution of Linux by default. This is exactly what we want! After the installation process, restart your computer to begin using WSL.

<br/>

### Step 2: Set Up Ubuntu
The first time you launch Ubuntu, a console window will open, and you'll be asked to wait for a minute or two for the installation to complete. Once it's done, you will be asked to create a UNIX username along with a password.<sup>[[1]](#password)</sup>

<br/>

### Step 3: Update and Upgrade Ubuntu Repository
Before installing any new packages, it's a good practice to update and upgrade the repository. You can do this by running:
```bash
sudo apt update && sudo apt upgrade -y
```

<br/>

### Step 4: Install Ansible
You can install Ansible on Ubuntu by running:
```bash
sudo apt install ansible -y
```

<br/>

### Step 5: Verify Ansible Installation
To ensure Ansible has been installed correctly, you can check its version by running:
```bash
ansible --version
```

**Awesome!** Now we are ready to turn those two Ubuntu Servers with public IP into full fledged *Ansible Control nodes*!
<br/>
<br/>

[Onto Part 3!](Part3.md) :arrow_forward:


<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<a name="password">[1]</a>: There are a few things to note here:

- The username and password created here will be considered the Linux administrator, with the ability to run sudo ("superuser do") administrative commands.
- Each user account is specific to each separate Linux distribution that you install and is not related to your Windows username. If you install more than one Linux distribution, each will have its own separate Linux user accounts and passwords. You'll have to configure a new username and password every time you add a distribution, reinstall, or reset.
- The username and password will accept almost anything as valid, but some characters may cause trouble in various contexts. Punctuation like underscores is generally okay, but periods, slashes, or colons, such as /:. may cause trouble. You should definitely not begin your username with the - hyphen/minus character. We recommend stripping out unusual punctuation. You should also note that while entering the password, nothing will appear on the screen (this normal behavior is called "blind typing").
- If you need to change or reset your password, or if you forget the password for a Linux distribution that you've installed, see the WSL documentation avaiable online.
