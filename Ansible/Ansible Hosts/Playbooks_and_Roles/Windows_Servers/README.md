# Do this so that ansible can access the Windows Server machines

**Step 1:** Run powershell as administrator \
Win+R -> powershell

**Step 2:** Paste this and press ENTER: 

```bash
 netsh advfirewall firewall add rule name="MACHINE_NAME" dir=in action=allow protocol=TCP localport=5985
````
[^]: Replace MACHINE_NAME with your machine's name.

**Optional:**  

If you want the machine to accept ICMP requests run this command as Administrator on PowerShell:

```Bash
netsh advfirewall firewall add rule name="MACHINE_NAME" dir=in action=allow protocol=TCP localport=5985
````

[^]: Replace MACHINE_NAME with your machine's name.


##### Your Windows Server is now ready to accept ansible commands.

Cheers! :raised_hands: