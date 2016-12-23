Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cKEPU-0004Mq-Ey
 for kexec@lists.infradead.org; Fri, 23 Dec 2016 01:12:37 +0000
Received: by mail-qk0-x243.google.com with SMTP id u25so14935655qki.2
 for <kexec@lists.infradead.org>; Thu, 22 Dec 2016 17:12:15 -0800 (PST)
From: Jay Lan <jay.zen.lan@gmail.com>
Subject: kdump failed to load: /sys/firmware/edd does not exist
Message-ID: <345de9dc-d728-2c5c-5634-2e70c4c6e030@gmail.com>
Date: Thu, 22 Dec 2016 17:12:12 -0800
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: "jay.j.lan@nasa.gov" <jay.j.lan@nasa.gov>

Hi,

I encountered kdump load failure problem at SLES12 SP1 and SLES12 SP2.
The 'systemctl status kdump.service' returned:

tpfe2 /var/log # systemctl status kdump.service
kdump.service - Load kdump kernel on startup
    Loaded: loaded (/usr/lib/systemd/system/kdump.service; enabled)
    Active: failed (Result: exit-code) since Thu 2016-12-22 09:24:46 
PST; 32min ago
   Process: 18982 ExecStart=/lib/kdump/load.sh (code=exited, 
status=1/FAILURE)
  Main PID: 18982 (code=exited, status=1/FAILURE)

Dec 22 09:24:46 tpfe2 systemd[1]: kdump.service: main process exited, 
code=...RE
Dec 22 09:24:46 tpfe2 systemd[1]: Failed to start Load kdump kernel on 
startup.
Dec 22 09:24:46 tpfe2 systemd[1]: Unit kdump.service entered failed state.
Dec 22 09:24:46 tpfe2 load.sh[18982]: + logger -i -t kdump 'FAILED to 
load ...OR
Dec 22 09:24:46 tpfe2 load.sh[18982]: kexec_file_load failed: Key was 
rejec...e'
Dec 22 09:24:46 tpfe2 load.sh[18982]: + return 1
Dec 22 09:24:46 tpfe2 load.sh[18982]: + result=1
Dec 22 09:24:46 tpfe2 load.sh[18982]: + '[' 1 = 0 ']'
Hint: Some lines were ellipsized, use -l to show in full.

When I ran '/sbin/kexec -d -p ...', the only suspicious output line was:
     /sys/firmware/edd does not exist.

The kexec cmdline is:

# /sbin/kexec -d -p /boot/vmlinuz-3.12.62-60.64.8.2.20161026-nasa 
--append="MAC=60:eb:69:21:2c:00 ROOTFS=disk IMAGE_PENDING=0 
IMAGE=pfe-160901 SLOT=1 console=ttyS0,38400n8 MONITOR_CONSOLE=yes 
intel_idle.max_cstate=1 processor.max_cstate=1 TRANSPORT=udpcast TTL=1 
MCAST_RDV_ADDR=224.0.0.1 FLAMETHROWER_DIRECTORY_PORTBASE=9000 
START_TIMEOUT=30 RECEIVE_TIMEOUT=5 elevator=deadline sysrq=yes 
reset_devices acpi_no_memhotplug cgroup_disable=memory irqpoll nr_cpus=1 
root=kdump rootflags=bind rd.udev.children-max=8 disable_cpu_apicid=0   
panic=1" --initrd=/boot/initrd-3.12.62-60.64.8.2.20161026-nasa-kdump

Could someone advise what might have caused /sys/firmware/edd not created?
The kexec-tools in SLES12 SP1 version is
     kexec-tools-2.0.5-17.2.x86_64

I looked at sles11sp4 systems, the directory did exist.

Thanks in advance,
Jay



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
