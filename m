From: arshad hussain <arshad.super@gmail.com>
Date: Wed, 11 May 2022 13:38:26 +0530
Subject: kump/etc/pre.d/* Not getting executed.
Message-ID: <CAKsu7qwGQTfjGyt9WAuU=0wPwJBO_drcfTAYWF3SPt=ZO17i8A@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello,

I am trying to run a custom script before the dump (ie
/etc/kdump/pre.d/* ) which I am unable to do.
I can say this, as the script is supposed to create a folder under
/var/crash and a file which it is not. It also does not generate the
vmcore file.

I am failing to understand what obvious step I am missing. Can someone
please help out.

While the "echo c > /proc/sysrq-trigger" successfully reboots the
output is not what is expected.

Here is my setup for kdump/kexec.

Thanks!

-------Expected output-------
01. Under /var/crash we should be having a folder as "DBGMSG-<date>".
02. Under /var/crash we should be having a file as "test512".
03. vmcore file
04. dmesg file

-------current output-------
Nothing under /var/crash

-------Below are the info and conf script details-------
# uname -a (Kernel version)
Linux rocky8 4.18.0-240.1.1.el8.x86_64 #1 SMP Fri Feb 19 20:41:01 UTC
2021 x86_64 x86_64 x86_64 GNU/Linux

# rpm -qa | grep -i kexec (kexec-tool version)
kexec-tools-2.0.20-46.el8.x86_64

# cat /proc/cmdline
BOOT_IMAGE=(hd0,msdos1)/boot/vmlinuz-4.18.0-240.1.1.el8.x86_64
root=UUID=<UUID...> ro crashkernel=128M resume=UUID=<UUID...>


------/etc/kdump.conf-------
path /var/crash
core_collector makedumpfile -l --message-level 7 -d 31
extra_bins /var/crash/kdumppre.sh /bin/bash /usr/bin/cat /usr/bin/date
kdump_pre /var/crash/kdumppre.sh
force_rebuild 1

# tree /etc/kdump/
/etc/kdump/
??? post.d
??? pre.d
    ??? 50-collect.sh

-------/etc/kdump/pre.d/50-collect.sh-------
#!/bin/bash

# base location
LOC=/sysroot/var/crash
# dbgmsg identifier string
DBGMSG="DBGMSG"
# log file
LFILE=log.out
# Granularity in seconds
LOCFOLDER=${LOC}/$DBGMSG-$(date +%Y-%m-%d:%H:%M:%S)

# Create folder.
mkdir -p $LOCFOLDER

if [ -f "/proc/spl/kstat/zfs/dbgmsg" ]; then
    echo "/proc/spl/kstat/zfs/dbgmsg found" >> $LOCFOLDER/$LFILE
    cat /proc/spl/kstat/zfs/dbgmsg >> $LOCFOLDER/$LFILE
else
    echo "/proc/spl/kstat/zfs/dbgmsg not found" >> $LOCFOLDER/$LFILE
fi

exit 0

-------/var/crash/kdumppre.sh-------
#!/bin/bash
echo "Test512.......$(date)" >> /sysroot/var/carsh/test512
exit 0


(Lines starting with [Debug] is the debug statement put for debugging
to verify if we are picking up correct key=value pairs)
# kdumpctl restart
kdump: DEFAULT_DUMP_MODE=kdump
kdump: kexec: unloaded kdump kernel
kdump: Stopping kdump: [OK]
[DEBUG]found config... path : /var/crash
[DEBUG]found config... core_collector : makedumpfile -l --message-level 7 -d 31
[DEBUG]found config... extra_bins : /var/crash/kdumppre.sh /bin/bash
/usr/bin/cat /usr/bin/date
[DEBUG]found config... kdump_pre : /var/crash/kdumppre.sh
[DEBUG]found config... force_rebuild : 1
kdump: restore default initrd:
/boot/initramfs-4.18.0-240.1.1.el8_lustre.x86_64.img
[DEBUG]files=/etc/kdump.conf
/boot/vmlinuz-4.18.0-240.1.1.el8_lustre.x86_64  /var/crash/kdumppre.sh
/var/crash/kdumppre.sh /bin/bash /usr/bin/cat /usr/bin/date
/usr/sbin/makedumpfile
[DEBUG]hook files=/etc/kdump.conf
/boot/vmlinuz-4.18.0-240.1.1.el8_lustre.x86_64  /var/crash/kdumppre.sh
/var/crash/kdumppre.sh /bin/bash /usr/bin/cat /usr/bin/date
/usr/sbin/makedumpfile /etc/fstab /etc/kdump/post.d/ /etc/kdump/pre.d/
  /etc/kdump/pre.d/50-collect.sh :: /etc/kdump/post.d/
/etc/kdump/pre.d/   /etc/kdump/pre.d/50-collect.sh
kdump: Detected change(s) in the following file(s):  /etc/kdump/pre.d/
kdump: Force rebuild /boot/initramfs-4.18.0-240.1.1.el8_lustre.x86_64kdump.img
kdump: Rebuilding /boot/initramfs-4.18.0-240.1.1.el8_lustre.x86_64kdump.img
kdump: rebuild kdump initrd: /sbin/mkdumprd -f
/boot/initramfs-4.18.0-240.1.1.el8_lustre.x86_64kdump.img
4.18.0-240.1.1.el8_lustre.x86_64
kdump: /sbin/kexec -s -d -p
--command-line=BOOT_IMAGE=(hd0,msdos1)/boot/vmlinuz-4.18.0-240.1.1.el8_lustre.x86_64
ro resume=UUID=d5fad714-147f-419c-a8ea-9e7984b0ef2f irqpoll nr_cpus=1
reset_devices cgroup_disable=memory mce=off numa=off
udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug
transparent_hugepage=never nokaslr novmcoredd hest_disable
disable_cpu_apicid=0
--initrd=/boot/initramfs-4.18.0-240.1.1.el8_lustre.x86_64kdump.img
/boot/vmlinuz-4.18.0-240.1.1.el8_lustre.x86_64
kdump: kexec: loaded kdump kernel
kdump: Starting kdump: [OK]

