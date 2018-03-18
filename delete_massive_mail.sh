#!/bin/bash
# delete_massive_mail.sh user@domain.com 

addr=$1

for acct in `/opt/zimbra/bin/zmprov -l gaa | grep -E -v '(^admin@|^spam\..*@|^ham\..*@|^virus-quarantine.*@|^galsync.*@)'|sort` ; do
    echo "Searching $acct"
    for msg in `/opt/zimbra/bin/zmmailbox -z -m "$acct" s -l 999 -t message "from:$addr"|awk '{ if (NR!=1) {print}}' | grep -v -e Id -e "-" -e "^$" | awk '{ print $2 }'`
    do
		  echo "Removing "$msg" from "$acct""
		  /opt/zimbra/bin/zmmailbox -z -m $acct gm $msg || echo "fail" && echo "good job"
    done
done
