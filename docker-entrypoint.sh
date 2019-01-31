#!/bin/bash

if [ `ls /etc/dirvish/ | wc -l` -eq 0 ]
then
  cp -r /etc/dirvish_default/* /etc/dirvish/
fi

cron && tail -f /var/log/cron.log
