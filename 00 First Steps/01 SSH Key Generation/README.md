# Creating an SSH Key Pair

This article outlines how to create SSH key pairs on Windows, Mac OS, and Linux, and how to use them to access GW HPC clusters.

Mac OS and Linux use the same process, since both are built from a Unix foundation. These instructions may also be used if you are using Unix-like software (e.g. GitBash or Cygwin) on Windows. 

## Background Information on SSH

Secure Shell (SSH) access is how many Systems Administrators and Application Administrators connect to server systems to manage their applications and operating systems.  Servers can be accessed via password authentication, or secure shell (SSH) key authentication.  A key, in public key cryptography, is something that you as a user keep to yourself to provide access to certain services or systems. In SSH, key authentication is known to be a more secure method of both connecting to, and encrypting traffic to and from, a remote server system.

### SSH Key Authentication

At GW, all high-performance computing (HPC) clusters are accessed via SSH, thus requiring all prospective users to generate an SSH key pair on their device. When submitting a request for HPC access via [this form](https://hpc.gwu.edu/getting-access/), you will need to put the contents of your public key (the file titled id\_rsa.pub) in the relevant box.

**Note:** SSH keys can be generated with or without a passphrase to lock them. For all access to GW’s HPC systems, we require users to include a passphrase with their SSH key pairs, as a security measure. The following instructions explain when and how to write this passphrase and the importance of choosing a passphrase you won’t forget\!

---

## Methods for Generating SSH Keys

### Unix-Like Operating Systems (Mac OS, Linux, Windows on GitBash/Cygwin)

1. Open the Terminal on your operating system, or GitBash/Cygwin on Windows.  
2. Check to make sure you do not already have SSH keys on your computer.  
   1. To check for SSH keys, input “ls \~/.ssh” into Terminal and hit **Enter**. If you see files named **id\_rsa** and **id\_rsa.pub**, you already have SSH keys generated on your device.   
      1. **id\_rsa** is the private key.  
      2. **id\_rsa.pub** is the public key.  
3. If you do not find those files in Step 2, please input “ssh-keygen \-t rsa \-b 4096”, then press **Enter**.  
4. Your Terminal will then prompt you for a location to save your SSH keys to. Keep the default location by pressing **Enter** on your keyboard.  
5. If done properly, you should now be prompted to enter a passphrase to lock your SSH key pair. Type your desired passphrase in, then hit **Enter**. You should then be prompted to re-enter your passphrase; retype your passphrase and press **Enter** once done.  
   1. **Note:** Research Technology Services (RTS) suggests that new users generate a passphrase via Diceware, a method of generating secure passphrases with the use of [this handy widget](https://diceware.dmuth.org/). We recommend a minimum of 4 rolls to properly secure your files.  
6. To verify your keys have been successfully generated, repeat Step 2\. If the files aren’t present, return to Step 3 and try again.  
7. In order to see the contents of your public key (id\_rsa.pub), input “cat \~/.ssh/id\_rsa.pub” into the Terminal, then press **Enter** to get the full public key within the window. **We need the full key, starting from "ssh-rsa" all the way through to and including the device identifier after the double equals sign.** Copy and paste or upload this key into the **output of your public key** field of the [HPC Access Form](https://hpc.gwu.edu/getting-access/).

### Alternative Method for Windows

Should you not have or wish to download software to interface with Windows in a Unix-like environment, we have a separate method that can be done from the Command Prompt with no additional requirements.

1. Open the Command Prompt on Windows.  
2. Check to make sure you do not already have SSH keys on your computer.  
   1. To check for SSH keys, input “dir %userprofile%\\.ssh” into Command Prompt and hit **Enter**. If you see files named **id\_rsa** and **id\_rsa.pub**, you already have SSH keys generated on your device.   
      1. **id\_rsa** is the private key.  
      2. **id\_rsa.pub** is the public key.  
3. If you do not find those files in Step 2, please input “ssh-keygen \-t rsa \-b 4096”, then press **Enter**.  
4. Your Command Prompt will then prompt you for a location to save your SSH keys to. Keep the default location by pressing **Enter** on your keyboard.  
5. If done properly, you should now be prompted to enter a passphrase to lock your SSH key pair. Type your desired passphrase in, then hit **Enter**. You should then be prompted to re-enter your passphrase; retype your passphrase and press **Enter** once done.  
   1. **Note:** Research Technology Services (RTS) suggests that new users generate a passphrase via Diceware, a method of generating secure passphrases with the use of [this handy widget](https://diceware.dmuth.org/). We recommend a minimum of 4 rolls to properly secure your files.  
6. To verify your keys have been successfully generated, repeat Step 2\. If the files aren’t present, return to Step 3 and try again.  
7. In order to see the contents of your public key (id\_rsa.pub), input “notepad %userprofile%\\.ssh\\id\_rsa.pub” into the Command Prompt, then press **Enter** to get the full public key within an instance of Notepad. **We need the full key, starting from "ssh-rsa" all the way through to and including the device identifier after the double equals sign.** Copy and paste or upload this key into the **output of your public key** field of the [HPC Access Form](https://hpc.gwu.edu/getting-access/).

---

## Logging in to HPC Clusters with SSH

Once you have properly generated the SSH key pair, you should keep these keys on the device you generated them on (and thus will access HPC clusters from). RTS will maintain the public key under your profile within the system, and check for and authenticate with the private key on your device to give proper access. GW VPN is required to access these clusters if you are not connected to a GW network connection. [Access the GW VPN Using Global Protect](https://ithelp.gwu.edu/en-us/article/1665784).

When accessing an HPC cluster at GW, using the command “ssh \[UserID\]@\[clustername\].arc.gwu.edu” in Unix-like environments, the first thing you will be prompted for is the passphrase you set for your SSH key pair. For security reasons, your inputs will be detected but not displayed. This means that as you type out your passphrase, you won’t see it appear on screen, but the system will know if you gave the correct or incorrect passphrase once you hit **Enter**; yet another reason to ensure you give a passphrase you will remember\!

Once the passphrase has been accepted, you will then be prompted for your two-factor authentication (2FA) code. If this is your first time signing into an HPC cluster, please see the article [How to: Set Up 2FA on HPC Clusters](https://zero.comaround.com/en-us/content/1933189/#/) for instructions on initialization of this feature. **Note:** All HPC users at GW are required to set up 2FA to use Pegasus, Cerberus and other clusters offered by RTS. Said 2FA is separate from the 2FA required for logging in to services such as Gmail, GWeb and more.

If both of these checks are passed through successfully, you should be on the HPC cluster you requested\!

### Technical Notes:

Operating Systems//Linux \- General//Commands;Graphics and Publishing//Web Site Administration//ACAD Home Pages \- UNIX Server
