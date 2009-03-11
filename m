Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nf-out-0910.google.com ([64.233.182.189])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LhKI8-00028n-F8
	for kexec@lists.infradead.org; Wed, 11 Mar 2009 08:59:59 +0000
Received: by nf-out-0910.google.com with SMTP id k4so370451nfd.22
	for <kexec@lists.infradead.org>; Wed, 11 Mar 2009 01:59:35 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Mar 2009 09:59:35 +0100
Message-ID: <f69abfc30903110159m485ae02cwfe42f318863d6b45@mail.gmail.com>
Subject: ARM: atags_offset at 0x100
From: Yegor Yefremov <yegorslists@googlemail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

I'm working with KS8695 SoC. Everything is functioning so far. The
only issue I have now is the atags_offset. In kexec-zImage-arm.c it is
defined as 0x1000 (4k), but many ARM based boards await ATAGs at 0x100
(see http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=arch/arm/mach-ks8695/board-dsm320.c;hb=HEAD).
If I change this settings in kernel, then I see the atags, but I can't
simply change the atags_offset in kexec-zImage-arm.c, because it is
not 4k aligned. I get the following error message:

Base address:  100 is not page aligned

Unfortunately I cannot change the kernel, cause backward compatibility
with older kernels must be guarantied. Is there any solution for this
problem how to bring kexec to put ATAGs at 0x100?

Thank you in advance.

Best regards,
Yegor Yefremov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
