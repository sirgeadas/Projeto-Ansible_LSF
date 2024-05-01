# How to prepare the Windows Servers machines
# So that that ansible can access them.

</p>

**Step 1:** Access your Windows Server machine by RDP.
</p>
</p>

**Step 2:** Run powershell as administrator </p>
Use the combo Win+R and then type: powershell
</p>
</p>

**Step 2:** Copy this code: 

```bash
 netsh advfirewall firewall add rule name="Allow WinRM" dir=in action=allow protocol=TCP localport=5985
````

</p>

**Step 3:** Paste it on your machines powershell terminal.

</p>
</p>

**Optional:**  

If you want the machine to accept ICMP requests run this command as Administrator on PowerShell:

```Bash
netsh advfirewall firewall add rule name="Allow ICMP" dir=in action=allow protocol=ICMPv4
````


</p>
</p>
</p>
</p>


##### Your Windows Server is now ready to accept ansible commands.


Test the connection on your control node using this command:
```Bash
ansible -i inventory.yml ANSIBLE_WIN_HOST_NAME -m win_ping -k
````
> Replace "inventory.yml" with your Inventory's location.
> Replace ANSIBLE_WIN_HOST_NAME with your actual host's name thats in your Inventory file. EX: WinPROD

This will send an ping command to the host machine. The "-k" suffix is needed to access the machine with an Password.


Cheers! :raised_hands: