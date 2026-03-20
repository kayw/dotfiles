#!/usr/bin/env bash

todayDate=$(date)
echo "rsync full system backup beginning at $todayDate" >> /var/log/rsync_backup.log

# https://github.com/danisztls/arbie/blob/main/ignore
rsync -aAXv / /mnt/wdpurple/backup/rootrsync/ --exclude={/dev,/bin,/lib,/lib64,/sbin,/srv,/proc,/boot,/efi,/sys,/tmp,/run,/mnt,/media,/lost+found,/*/tmp,/**/tmp,/home/**/node_modules,/home/*/.cache,/home/*/.caches,/home/**/cache,/home/**/.tmp,/home/**/tmp,/home/**/_cache,/home/**/CachedData,/home/**/CachedExtensions,/home/**/cache-*,/home/**/chromium/**/CacheStorage,/etc/fstab,/etc/mtab,/home/*/.nv,/home/*/.local,/home/**/.npm,/home/**/.pip,/home/**/.gem,/home/**/.rustup,/home/**/kspace/env,/home/**/.dockercache,/home/**/.umi,/home/**/.next,/home/**/chromium/Crash\ Reports,/home/**/chromium/BrowserMetrics,/home/**/chromium/GrShaderCache,/home/**/chromium/GraphiteDawnCache,/home/**/chromium/ShaderCache,/home/**/chromium/component_crx_cache,/home/**/chromium/extensions_crx_cache,/home/**/.mozilla/**/datareporting,/home/**/volume/gitea/git/repositories,/home/**/reactstate/**/dist,/var/lib/systemd/coredump}  --log-file=/var/log/rsync_backup.log

# https://github.com/jeekkd/rsync-backup/blob/master/rsync_backup.sh
exitCodeDisk=$?

su -c "scp root@silver.lan:/var/lib/memos/memos_prod.db /mnt/wdpurple/backup/pve/memos/" kayw
su -c "scp root@silver.lan:/var/lib/memos/memos_prod.db-wal /mnt/wdpurple/backup/pve/memos/" kayw
su -c "scp root@silver.lan:/var/lib/memos/memos_prod.db-shm /mnt/wdpurple/backup/pve/memos/" kayw
su -c "scp -r root@silver.lan:/var/lib/memos/assets /mnt/wdpurple/backup/pve/memos/" kayw

todayDate=$(date)
backupDrive=/dev/sda
backupMount=/mnt/wdpurple/backup/

echo "Backup completed at:		$todayDate"	>> /var/log/rsync_backup.log

if [[ $exitCodeDisk == "0" ]]; then
	echo "The backup to $backupDrive mounted at $backupMount was successful and completed without error" >> /var/log/rsync_backup.log
else
	echo "Warning: The backup to $backupDrive mounted at $backupMount had an error occur with a non-zero exit code." >> /var/log/rsync_backup.log
fi
