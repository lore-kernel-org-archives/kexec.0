Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZN2LK-0003Rp-HD
 for kexec@lists.infradead.org; Wed, 05 Aug 2015 17:19:07 +0000
Received: by ioea135 with SMTP id a135so56105107ioe.1
 for <kexec@lists.infradead.org>; Wed, 05 Aug 2015 10:18:45 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 5 Aug 2015 13:18:45 -0400
Message-ID: <CAAn3ePLGQnsT6JMSSBtUQS4Ukn+Pm2q-2ns7b3F_YcKnN_1t3A@mail.gmail.com>
Subject: kexec of FIT image hangs, however kexec of zImage and DTB succeeds
From: Justin DeFields <justindefields@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

All,

I'm having an issue on my ARM based platform (Xilinx Zynq, dual
cortex-A9 ARM cores, 512MB RAM) where linux is hanging after 'kexec
-e' is performed when I provide a FIT (flattened image tree) image:

CMDLINE=$(zcat /proc/cmdline)
kexec -l /boot/zImage  --append="$CMDLINE" --dtb=/boot/system.dtb
kexec -e
---console output---
kexec: Starting new kernel
Disabling non-boot CPUs ...
CPU1: shutdown
Bye!
-- unit hangs indefinitely


But 'kexec -e' succeeds when the files are passed in seperately:

CMDLINE=$(zcat /proc/cmdline)
kexec -l /boot/zImage  --append="$CMDLINE" --dtb=/boot/system.dtb
kexec -e
---console output---
kexec: Starting new kernel
Disabling non-boot CPUs ...
CPU1: shutdown
Bye!
console [ttyPS0] enabled
bootconsole [earlycon0] disabled
-- unit gets all the way to root login

I am thinking that perhaps there is an issue pulling zImage out of the
FIT image somewhere in the kexec code.  Is anyone familiar with this,
or has seen a similar issue?

Thanks,

Justin DeFields
Embedded Software Engineer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
