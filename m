Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from email.exegy.com ([205.158.150.230])
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YENIC-00071w-Bb
 for kexec@lists.infradead.org; Thu, 22 Jan 2015 19:19:49 +0000
Received: from mail.exegy.com ([192.168.77.1])
 by email.exegy.com (8.14.3/8.14.3) with ESMTP id t0MJIm8Y007184
 for <kexec@lists.infradead.org>; Thu, 22 Jan 2015 13:18:54 -0600
Message-ID: <54C14D1A.1020307@exegy.com>
Date: Thu, 22 Jan 2015 13:18:50 -0600
From: "Mr. Berkley Shands" <bshands@exegy.com>
MIME-Version: 1.0
Subject: Failure to crashdump under Centos-6.4 x86_64 with kernel 3.12.30
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

My kernel crashdumps don't work with vanilla 3.12.30 on a 256GB x86_64
intel box.
Centos-6.4. With the standard makedumpfile, makedumpfile segfaults, and
no output is written to disk.
with makedumpfile 1.5.7, kexec-tools-2.0.8, and crash 7.0.2 I actually
get vmcore files,
but then crash rejects them with:

crash vmcore /boot/vmlinux-3.12.30

crash 7.0.2
...
GNU gdb (GDB) 7.6
...

crash: seek error: kernel virtual address: ffff88207fffcb60  type:
"pglist node_id"


the grub entry for this kernel is:
     kernel /boot/vmlinuz-3.12.30 ro root=LABEL=ROOT
numa_balancing=disable intel_idle.max_cstate=0 processor.max_cstate=0
mce=ignore_mce clocksource=tsc nohz=off nomodeset nodmraid rd_NO_LUKS
rd_NO_LVM rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16
KEYBOARDTYPE=pc KEYTABLE=us crashkernel=256M@256M  console=ttyS1,115200n8


CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x2000000
CONFIG_RELOCATABLE=y
CONFIG_PHYSICAL_ALIGN=0x1000000

A similar issue appears with a grub crashkernel=128M@32M

Turning off all the makedumpfile exclusions (dump all pages) results in
a much larger
vmcore, but it still gets the same failures.

Where do I start looking for the problems here?
kernel 3.10.65 won't dump either, but an old 3.0.29 kernel dumps just fine.
Is this a problem with some .config setting?

Berkley

--

//E. F. Berkley Shands, MSc
Senior Software Architect/Engineer
Exegy Systems Engineering//

**Exegy Inc.**

349 Marshall Road, Suite 100

St. Louis , MO 63119

Direct: (314) 218-3600 X450

Cell: (314) 303-2546

Office: (314) 218-3600

Fax: (314) 218-3601

The Usual Disclaimer follows...


________________________________

This e-mail and any documents accompanying it may contain legally privileged and/or confidential information belonging to Exegy, Inc. Such information may be protected from disclosure by law. The information is intended for use by only the addressee. If you are not the intended recipient, you are hereby notified that any disclosure or use of the information is strictly prohibited. If you have received this e-mail in error, please immediately contact the sender by e-mail or phone regarding instructions for return or destruction and do not use or disclose the content to others.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
