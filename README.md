# ZIMBRA SCRIPT

Little script for massive changes.

```
#!/bin/bash

for acct in `/opt/zimbra/bin/zmprov -l gaa | grep -E -v '(^admin@|^spam\..*@|^ham\..*@|^virus-quarantine.*@|^galsync.*@)'|sort` ; do
    echo "Show dumpster $acct"
      zmmailbox -z -m $acct s --dumpster -l 30 --types message larger:1kb  
    done 
done
```

In this case, we show the dumpster of each zimbra's mailbox
