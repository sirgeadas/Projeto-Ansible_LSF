# Part 4, How to prepare the Windows Servers machines so that that ansible can access them.

In this part we will get the Windows Servers ready so that Ansible can access them and do it's magic! 🐰🎩

<br/>
<br>

## Step 1: Access your Windows Server machine by RDP.
Go to portal.azure.com and then press `G + /` ant type Virtual Machines. <p/>
Go to your machines and click on connect. Download the `.rdp` file and login.

<br/>

## Step 2: Run powershell as administrator
Use the combo Win+R and then type: 
```cmd
powershell
```
<br/>

## Step 3: Add an exception to the Firewall

Paste this command in powershell:

```powershell
 netsh advfirewall firewall add rule name="Allow WinRM" dir=in action=allow protocol=TCP localport=5985
```
This will add an exception on the Windows Server so that ansible can reach the machine using `WinRM` protocol.


**Repeat this step on the other Windows machine.** :performing_arts:

> [!NOTE]
>Your Windows Server is now ready to accept ansible commands. :partying_face:

<br>

Test the connection on your control node using this command:
```Bash
ansible win_prod_server -m win_ping -k
```
or 

```Bash
ansible win_dr_server -m win_ping -k
```

This will send an ping command to the host machine. The "-k" suffix is needed to access the machine with an Password.

<br>
<br>

**Optional:**  

If you want the machine to accept ICMP requests run this command as Administrator on PowerShell:

```powershell
netsh advfirewall firewall add rule name="Allow ICMP" dir=in action=allow protocol=ICMPv4
```

<br>

And we are done! Cheers! :raised_hands: <p>
Coffee time! :coffee:

