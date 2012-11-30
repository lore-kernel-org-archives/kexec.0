Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TeR7K-0000AR-R6
 for kexec@lists.infradead.org; Fri, 30 Nov 2012 13:58:59 +0000
Received: by mail-qa0-f49.google.com with SMTP id r4so501232qaq.15
 for <kexec@lists.infradead.org>; Fri, 30 Nov 2012 05:58:57 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 30 Nov 2012 19:28:56 +0530
Message-ID: <CAJXQGfJRQ9SO5MLpG5RC1DffaRRaWvRzpX1Rq=wEM5V=Pm31EA@mail.gmail.com>
Subject: 
From: Naresh Bhat <nareshgbhat@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: magnus.damm@gmail.com, Daniel Mack <zonque@gmail.com>

Hi,

I am using Versatile express target at Daughterboard Site 1:
V2P-CA15_A7 Cortex A15

root@arm-cortex-a15:~# kexec -f zImage --dtb=vexpress.dtb
--append="root=/dev/nfs rw ip=dhcp
nfsroot=<Host-IP>:/mnt/sda3/nfs/cortexa15/core-image
console=ttyAMA0,38400n8 nosmp"
Starting new kernel
Bye!
Uncompressing Linux...

It stops here nothing is coming on serial console/terminal.

1. vexpress.dtb is generated from vexpress-v2p-ca15_a7.dts file.
2. Kernel version:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
3. Userland Tool:
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Please, help me to overcome from the above issue.  I appreciate your help

My questions are
1. My command line parameters are correct ?
2. Is it possible to test kexec using ATAGs on ca15_a7 architecture ??

Thanks and Regards
-Naresh Bhat

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
