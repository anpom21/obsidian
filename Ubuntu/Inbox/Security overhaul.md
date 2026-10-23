---
created: 2026-06-09
tags:
source:
aliases:
---

Passwordless [[SSH]]
1. Make the '# Confirm host key of simon (10.0.0.11)' More intuitive. Have the command be in a code block easy to copy paste.
2. In the 
```
## Bootstrap a machine

From your own session on this VPN server, replace `YOU` with your account on the dev machine:
```
have IP also be placed in ` `  and have it say more clearly that the bootstrap should be run from the VPN machine. And add a copy button.



# Christian Eberhardt added as `christian`

Key fingerprint: `SHA256:0RFLINHRj8keHl/hhJta4ou+XtMgTQqXsBzpYEUdbHQ`. Pushing to all machines now. [Open Christian Eberhardt](http://localhost:8181/person/christian)

Temporary password (shown once; must be changed at first login; only set on machines where `christian` has no password yet): **5165d7-9025ed-49eaf4-66f1ee**

## Send this to Christian Eberhardt

Hi Christian,

You have SSH access to the office dev machines as "christian" until 2045-10-19.

Next time you need access from a new laptop:
1. Create a key on that laptop:
     Ubuntu:              ssh-keygen -t ed25519 -C "christian@LAPTOPNAME"
     Windows PowerShell:  ssh-keygen -t ed25519 -C "christian@LAPTOPNAME"
   Choose a passphrase when asked.
2. Send only the PUBLIC key file to an admin:
     Ubuntu:   ~/.ssh/id_ed25519.pub
     Windows:  C:\Users\YOU\.ssh\id_ed25519.pub
   Never send the file without ".pub".

To log in (office network or VPN):
     ssh christian@10.0.0.11     # simon

Your temporary password (for sudo) is given to you separately. You must change it at
your first login on each machine.

[Add another person](http://localhost:8181/person/new)


3. Call the 'main user file' option for 'Grant access to the main user' and have an info text below explain what it actually does. That way it is more intuitive for my boss as he hasnt researched any of this and the GUI should be fairly easy to use
4. Make adding machines its own page. And how the commands:
```
scp /var/lib/keysync/public/keysync-bootstrap.sh YOU@IP:/tmp/keysync-bootstrap.sh
ssh -t YOU@IP sudo bash /tmp/keysync-bootstrap.sh
```
Be autofilled with the hostname and ip over the VPN so the user dont have to type it again.



5. I typed the main user name in the machine hostname but it seems to work fine? Is it fine though?
6. How does the git log work? And why do we use git?
7. The sshd mode and remove button with type hostname to remove is not very intuitive on their own. Instead have the options as their own cols and if the user attempts to change them a pop up will appear where they should type the hostname to apply the changes.



Have a very simple README.md with the following sections:

## Adding a user
## Removing a user

## Adding a machine
## Removing a machine

---
When dev machines needs to update then add a button that can be clicked to copy the bootstrap commands one by one.

I have this error even after running the bootstrap command:
```
unreachable since 2026-10-20T09:28:03+02:00  
unreachable: keysync@192.168.25.21: Permission denied (publickey,password).
```
Do i need to add the deploy authorized key first for the keysync account?

---
What does 
 **An existing account on chosen machines**

E.g. log in as `simon` on ARISAI. keysync only adds their key to that account; it never creates, locks or changes the account itself.
do under add a person? ELI5

It should be possible to distinguish development machines and production machines. And it should be possible to create a user for only certain machines. And right now we often just add access to the main user on every machine so when we think of users we dont think of users on the machines just access to the main user on every machine (this might already be supported), it should be clear when we just want to give a person (in keysync) access to the main users it will just add their key to the machines, but when they login they just use the main user password, this is therefore also only relevant when a user is given sudo, but here in the begin we will rarely not give users sudo, so make it intuitive so it fits our current mental model and workflow, feel free to ask if it is confusing.

---
New machine names:
simon pc:
`aris-falcon`

aris-pc 
`aris`