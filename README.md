# ProxyBypass
An simple and easy way to download files blocked by a proxy using an external relay

## What is it ?
Have you already experienced this ?

You have to download something from sourceforge / google drive / other site but your (corporate) proxy blocks access to that site.

This small script provides a solution.
Just put the file to download URL in the subject of a a mail and send it.
A small mail bot will download the file for you and put it on a wwwroot you provide.

## What is needed ?
- Linux (mine is Raspbian)
- fetchmail
- procmail
- ssmtp
- A mail address that can be accessed by (selfhosted or external) POP3 or IMAP  and a (self hosted or external) SMTP.

## How to configure ?

### Fetchmail
