#!/bin/sh

# No configuration, create it!
if [ ! -f /boot/cgminer.conf ] ; then
    cp /boot/cgminer.conf.factory /boot/cgminer.conf
fi

url=`cat /boot/cgminer.conf|grep '"url" :' | awk -F\" '{print $4}'`
account=`cat /boot/cgminer.conf|grep '"user" :' | awk -F\" '{print $4}'`
password=`cat /boot/cgminer.conf|grep '"pass" :' | awk -F\" '{print $4}'`
r_mgmt=`cat /boot/cgminer.conf|grep '"api-listen" :' | awk '{print $3}'`

if [ "$r_mgmt" = "true" ] ; then
    sed  '
s&#%#Pool_url#%#&'$url'&g
s&#%#Account#%#&'$account'&g
s&#%#Password#%#&'$password'&g
s&#%#r_mgmt_on_checked#%#&checked&g
s&#%#r_mgmt_off_checked#%#&&g' < /www/tmpl/miner_setting.html_tmpl > /www/pages/miner_setting.html
else
    sed  '
s&#%#Pool_url#%#&'$url'&g
s&#%#Account#%#&'$account'&g
s&#%#Password#%#&'$password'&g
s&#%#r_mgmt_on_checked#%#&&g
s&#%#r_mgmt_off_checked#%#&checked&g' < /www/tmpl/miner_setting.html_tmpl > /www/pages/miner_setting.html
fi
