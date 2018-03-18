# ZIMBRA SCRIPT

Little script for massive changes.

* show_accounts_dumpster 

```
#!/bin/bash

for acct in `/opt/zimbra/bin/zmprov -l gaa | grep -E -v '(^admin@|^spam\..*@|^ham\..*@|^virus-quarantine.*@|^galsync.*@)'|sort` ; do
    echo "Show dumpster $acct"
      zmmailbox -z -m $acct s --dumpster -l 30 --types message larger:1kb  
    done 
done
```

In this case, we show the dumpster of each zimbra's mailbox

[Zimbra: Operate with Dumpster](https://wiki.zimbra.com/wiki/Enable_and_operate_Zimbra_Dumpster)

* delete_massive_mail 

```
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
```

In this case, we could make a massive delete of emails from a address mail.

[Zimbra: Deleting message from account](https://wiki.zimbra.com/wiki/Deleting_messages_from_account_using_the_CLI)



