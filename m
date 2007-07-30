Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IFdff-0000uh-J0
	for kexec@lists.infradead.org; Mon, 30 Jul 2007 18:25:01 -0400
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
	by netops-testserver-3.corp.sgi.com (Postfix) with ESMTP id 75B2A9089A
	for <kexec@lists.infradead.org>; Mon, 30 Jul 2007 15:24:57 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
	by estes.americas.sgi.com (Postfix) with ESMTP id 394EF70001DE
	for <kexec@lists.infradead.org>; Mon, 30 Jul 2007 17:24:57 -0500 (CDT)
Date: Mon, 30 Jul 2007 17:24:57 -0500
Subject: kdump not working under 2.6.22 kernel
Message-ID: <46AE6539.mailxBA21IP79F@eag09.americas.sgi.com>
MIME-Version: 1.0
From: cpw@sgi.com (Cliff Wickman)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org



I can't get kdump to work under a 2.6.22 kernel.
I'm running on 2-processor x86_64 box.  It has 2 scsi disks, /dev/sda and
/dev/sdb

Any capture kernel that I load with kexec and boot on a panic only finds sda.


the system kernel configuration has:
   CONFIG_DEBUG_INFO=y
   CONFIG_KEXEC=y
   CONFIG_SYSFS=y
   # CONFIG_RELOCATABLE
   CONFIG_SMP=y
   CONFIG_PHYSICAL_START=0x200000
   # CONFIG_CRASH_DUMP
   # CONFIG_PROC_VMCORE

kexec is executed as:

/sbin/kexec -p /boot/vmlinux-kdump --append=" 1 CRASH=1 root=/dev/sdb3 irqpoll console=ttyS0,38400n8 maxcpus=1 1" --initrd=/boot/initrd-kdump  --args-linux


The ATA scsi driver is not waiting to find the second disk.
I put some printk's into the driver and get this:

Standalone:
                                                   [nv_adma_error_handler]
cpw: ata_host_register probe port 1 (error_handler:ffffffff81348625)
cpw: ata_host_register call ata_port_probe
cpw: ata_host_register call ata_port_schedule
cpw: ata_host_register call ata_port_wait_eh
cpw: ata_port_wait_eh entered
cpw: ata_port_wait_eh, preparing to wait
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
cpw: ata_dev_configure entered
cpw: ata_dev_configure testing class
cpw: ata_dev_configure class is ATA_DEV_ATA
ata2.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
ata2.00: 390721968 sectors, multi 16: LBA48
cpw: ata_dev_configure exiting
cpw: ata_dev_configure entered
cpw: ata_dev_configure testing class
cpw: ata_dev_configure class is ATA_DEV_ATA
cpw: ata_dev_configure exiting
cpw: ata_dev_set_mode printing:
ata2.00: configured for UDMA/133
cpw: ata_port_wait_eh, finished wait
cpw: ata_port_wait_eh exiting
cpw: ata_host_register done with probe port 1


When loaded with kexec and booted on a panic:

cpw: ata_host_register probe port 1 (error_handler:ffffffff81348625)
cpw: ata_host_register call ata_port_probe
cpw: ata_host_register call ata_port_schedule
cpw: ata_host_register call ata_port_wait_eh
cpw: ata_port_wait_eh entered
cpw: ata_port_wait_eh, preparing to wait
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
cpw: ata_port_wait_eh, finished wait
cpw: ata_port_wait_eh exiting
cpw: ata_host_register done with probe port 1

There is currently some device (udev?) problem with the 2.6.23 kernel. Could
this be related?

-Cliff Wickman
 SGI

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
