#!/bin/bash

#Read of mail in variable
a=""
while read line; do
   a+="${line}\n";
done

#Save last mail to a file (optional)
echo -e $a > $HOME/logfile

#Get Subject and Sender of the mail
subject="$(echo -e $a | grep '^Subject' |  head -n1 | sed "s/Subject: //g")";
from="$(echo -e $a | grep '^From' |  head -n1 | head -n 1 | sed "s/From: //g" | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b")";

#Preparing reply mail
mail="To: ${from}\n";
mail+="From: your_mail@provider\n";
mail+="Content-Type: text/plain; charset=UTF-8\n";

#Check that subject of received mail is containing an URL
regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]';
if [[ $subject =~ $regex ]]
then
    #If Subject is a link
    echo "Link valid";

    #Get the filename
    filename=$(basename $(curl -L --head -w '%{url_effective}' $subject  2>/dev/null | tail -n1 ));

    #Get the file
    curl -o $filename -J -L $subject > /dev/null

    #CHMOD the file (could be less)
    chmod 777 "${filename}";

    #Put the file to a wwwroot share
    mv "${filename}" /var/wwwroot/files/;
    mail+="Subject : Query OKK\n";
    mail+="\n";
    mail+="Asked to download URL : ${subject}\n";
    mail+="your file is here : https://your_webserver/files/"$filename;
else
    echo "Link not valid"
    mail+="Subject : Query Rejected\n";
    mail+="\n";
    mail+="To get a file, just put the file URL in the subject of a mail sent to your_mail@provider";
fi

echo "$from - $subject" >> $HOME/demands;
echo -e $mail | /usr/sbin/sendmail $from;
