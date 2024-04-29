# Do this so that ansible can access the Windows Server machines

**Step 1:** Run powershell as administrator </p>
Win+R -> powershell
</p>
</p>

**Step 2:** Copy this code: 

```bash
 netsh advfirewall firewall add rule name="MACHINE_NAME" dir=in action=allow protocol=TCP localport=5985
````
>  Replace MACHINE_NAME with your machine's name. 

</p>

**Step 3:** Paste it on your machine's powershell terminal:
</p>
</p>
</p>
</p>


**Optional:**  

If you want the machine to accept ICMP requests run this command as Administrator on PowerShell:

```Bash
netsh advfirewall firewall add rule name="MACHINE_NAME" dir=in action=allow protocol=TCP localport=5985
````

> Replace MACHINE_NAME with your machine's name.

</p>
</p>
</p>
</p>


##### Your Windows Server is now ready to accept ansible commands.

Cheers! :raised_hands: