# Do this so that ansible can access the Windows Server machines

Step 1: Run powershell as administrator

Step 2: Paste this and press ENTER: 

```bash
 netsh advfirewall firewall add rule name="MACHINE_NAME" dir=in action=allow protocol=TCP localport=5985
````

Optional:  

If you want the machine to accept ICMP requests run this command as Administrator on PowerShell:

```Bash
netsh advfirewall firewall add rule name="MACHINE_NAME" dir=in action=allow protocol=TCP localport=5985
````