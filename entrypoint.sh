#!/bin/sh

################### ssh
sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config

echo "root:${ROOT_PASSWORD}" | chpasswd

# generate host keys if not present
ssh-keygen -A

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -e "$@" &
################



########## cron back
rm -f /backup.sh
BACKUP_CMD="rsync -avzh -delete ${SRC_DIR} ${TARGET_DIR}"
cat <<EOF >> /backup.sh
#!/bin/sh
echo "=> Backup started"
if ${BACKUP_CMD} ;then
    echo "****************Backup succeeded***************"
else
    echo "****************Backup failed****************"   
fi
EOF

chmod +x /backup.sh
sh /backup.sh
echo "${CRON_TIME} sh /backup.sh & 2>&1 |less" > /crontab.conf
crontab  /crontab.conf
echo "=> Running cron job"
exec crond -f
#############