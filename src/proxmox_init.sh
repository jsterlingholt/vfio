#!/bin/bash
# disable proxmox subscription warning
echo 'Disabling Proxmox Subscription Warning'
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
echo ''

echo 'Fixing repos'
