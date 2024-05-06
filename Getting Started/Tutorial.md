# Tutorial: Installing WSL and Ansible on Windows 10

This tutorial will guide you through the process of installing the Windows Subsystem for Linux (WSL) on Windows 10 and then installing Ansible within WSL. This guide is designed for complete novices, so we'll walk through each step in detail.

## Step 1: Install WSL on Windows 10

1. Open PowerShell as Administrator.
2. Enter the following command to install WSL: `wsl --install`
3. Restart your computer to finish the WSL installation.

**Note:** The `wsl --install` command will enable the features necessary to run WSL and install the Ubuntu distribution of Linux. If you want to install a different Linux distribution, you can use the command `wsl --install -d <Distribution Name>`, replacing `<Distribution Name>` with the name of the distribution you would like to install.

## Step 2: Set Up Your Linux Distribution

1. Launch the installed Linux distribution from the Start menu.
2. Follow the prompts to set up your user account and password.

## Step 3: Install Ansible in WSL

1. Update the package manager by entering: `sudo apt update`
2. Install Ansible by entering: `pip install ansible`.

**Note:** Ansible will be installed into the user local directory for your WSL distro.

## Step 4: Confirm Your Installation

You can confirm that Ansible has been installed correctly by entering: `ansible --version`. This should display the version of Ansible that has been installed.

If you have any questions or need further clarification, feel free to ask. Happy learning!
