# ProxyBypass
An simple and easy way to download files blocked by a proxy using an external relay

## What is it ?
Have you already experienced this ?

You have to download something from sourceforge / google drive / other site but your (corporate) proxy blocks access to that site.

This small script provides a solution.
Just put the file to download URL in the subject of a a mail and send it.
A small mail bot will download the file for you and put it on a wwwroot you provide.

## What is needed ?
- Linux (mine is Raspbian) machine that can access the file to download
- fetchmail
- procmail
- ssmtp
- A mail address that can be accessed by (selfhosted or external) POP3 or IMAP  and a (self hosted or external) SMTP. Gmail / Outlook adresses seem to be ok. It's better if the address is dedicated to download file, because the provided configuration gets all mails from IMAP dans delete them from the imap server.

## How to configure ?

### Fetchmail
Just edit or create $HOME/.fetchmailrc :
```
poll your_imap_server protocol imap:
  user "your_mail@provider" password "your_plaintext_password" mda "/usr/bin/procmail" ssl
```

### Procmail
Just edit or create $HOME/.procmailrc :
```
PATH=/bin:/usr/bin
MAILDIR=$HOME/user
LOGFILE=$HOME/procmail.log

:0 wif
| bash $HOME/download.sh
```

### ssmtp
Just edit /etc/ssmtp/ssmtp.conf
```
root=your_mail@provider
mailhub=your_smtp_server:port
AuthUser=your_mail@provider (or user to authenticate)
AuthPass=your_plaintext_password
rewritedomain=your_smtp_server_domain
UseTLS=YES (better)
hostname=your_local_machine_name
FromLineOverride=YES
```

And also edit /etc/ssmtp/revaliases (to map local accounts to mail)
```
your_local_linux_user:your_mail@provider:your_smtp_server:port
```

### Custom scripts
just move download.sh to $HOME and edit to put real wwwroot/domain/email adresses

## Usage
Just run 
>bash fetchmail_daemon

or if ssh'd:
>nohup bash fetchmail_daemon &

## Responsability
Running this script implies taking your responsability. Only use dedicated email address and not your personal email.
I won't be responsible of deleting your whole mail stack.
