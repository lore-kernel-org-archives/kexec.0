Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844DBC28B28
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=30Jr6wkyoaAqZ4wqhViXmy9edkJu76AE/m1k7L8k7CI=; b=2PY4EQJLysJ1JLbCINNyLn/m47
	EzlsCgbUYHw7glpkaOkBGcPEJUl/lo6J7YIyaXGp4WpnuhHXqL15hTy/XDN//pi5FOyZujK6+5od6
	S0Z7WcpevALCGKz5GGJ3kOUyhOgryfMzDr1H1dR9h+5uMfjcT01xJik2QKG63rWNn08875tWkhTRH
	183z6VI2hsgwJPCbX4/GtnaV3JGM+kOdVsQReAPy4WrLaZZl4J3GmDIYQ/bDFKlvJpOV5aZUXC9Bb
	RfBaSGBlpYVT3oN1OLI+Hm3il+12zDkQprHMTR8MSLfng+caA85RmvJsniqhHXUNdWYd8Hr+8F/fs
	3lYRPt2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOM4-00000008vib-3hxQ;
	Wed, 12 Mar 2025 15:50:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIU-00000008jRO-14e9
	for kexec@bombadil.infradead.org;
	Wed, 12 Mar 2025 14:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=30Jr6wkyoaAqZ4wqhViXmy9edkJu76AE/m1k7L8k7CI=; b=u54vPQjsFi50BYPhRmvDFNcrc+
	JOT54WX/vxOyRRGJnKo1hvzsJrVBpBMheQZETRjYdXacYtg6W3pBHre854Z8MeoZKUd9fgqA7VHsQ
	NQMs0xa7aWRKYVXFoo3u7wGBqQIPMJkJLVGvXarHcG93EMBOYWFu1l32Aq/bwSxSusw0I2dvOmc32
	LqHWIdXC2M+oTh5uubAgt6iWp6vBvQiv4JANP6vEbnWOIBR39W7jbfb3wJgOhmNFWvHknbMLTgncG
	hbVQ7oKKJ7A1qf9XPJURGJtXRX8TtRanoq84VOlwnYb4wKF1O5aIXcy6Cji+5SMtiimnEc2VH+/ZN
	uxiimmgQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-0000000CxJE-2Re5;
	Wed, 12 Mar 2025 14:42:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uTu-1IV5;
	Wed, 12 Mar 2025 14:42:59 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v7 0/8] x86/kexec: Add exception handling for relocate_kernel
Date: Wed, 12 Mar 2025 14:34:12 +0000
Message-ID: <20250312144257.2348250-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Debugging kexec failures is painful, as anything going wrong in execution
of the critical relocate_kernel() function tends to just lead to a triple
fault. Thus leading to *weeks* of my life that I won't get back. Having
hacked something up for my own use, I figured I should share it...

Add a trivial exception handler in the relocate_kernel environment which 
outputs to the early_printk serial console if configured. Currently only 
8250-compatible serial ports are supported, but that could be extended.

I had to hack up QEMU support for a PCI serial port which matches what
the existing early_printk code can drive, and the *real* 8250_pci driver
doesn't seem to cope with that setup at all, but whatever... the kexec
code now drives the same 32-bit stride which is all that earlyprintk
supports. We can always add more later, if anyone cares.

Someone who cares might want to bring the i386 version into line with
this, although the lack of rip-based addressing makes all the PIC code a
bit harder.

David Woodhouse (8):
      x86/kexec: Debugging support: load a GDT
      x86/kexec: Debugging support: Load an IDT and basic exception entry points
      x86/kexec: Debugging support: Dump registers on exception
      x86/kexec: Add 8250 serial port output
      x86/kexec: Add 8250 MMIO serial port output
      x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
      [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
      [DO NOT MERGE] x86/kexec: Add CFI type information to relocate_kernel()

 arch/x86/include/asm/kexec.h         |   7 ++
 arch/x86/kernel/early_printk.c       |   9 ++
 arch/x86/kernel/machine_kexec_64.c   |  50 ++++++--
 arch/x86/kernel/relocate_kernel_64.S | 254 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 308 insertions(+), 12 deletions(-)


v7:
 • Drop CONFIG_KEXEC_DEBUG and make it all unconditional in order to
   "throw regressions back into the face of whoever manages to introduce
   them" (Ingo, https://lore.kernel.org/kexec/Z7rwA-qVauX7lY8G@gmail.com/)
 • Move IDT invalidation into relocate_kernel() itself.

v6: https://lore.kernel.org/kexec/20250115191423.587774-1-dwmw2@infradead.org/
 • Rebase onto already-merged fixes in tip/x86/boot.
 • Move CONFIG_KEXEC_DEBUG to generic kernel/Kconfig.kexec as Bartosz is
   working on an Arm64 version.

v5: https://lore.kernel.org/kexec/20241205153343.3275139-1-dwmw2@infradead.org/T/
 • Drop [RFC].
 • Drop _PAGE_NOPTISHADOW fix, which Ingo already took into tip/x86/urgent.
 • Add memory-mapped serial port support (32-bit MMIO spacing only).

v4 (RFC): https://lore.kernel.org/kexec/20241127190343.44916-1-dwmw2@infradead.org/T/
 • Add _PAGE_NOPTISHADOW fix for the identmap code.
 • Drop explicit map of control page, which was masking the identmap bug.

v3 (RFC): https://lore.kernel.org/kexec/20241125100815.2512-1-dwmw2@infradead.org/T/
 • Add CONFIG_KEXEC_DEBUG option and use earlyprintk config.
 • Allocate PGD separately from control page.
 • Explicitly map control page into identmap.

V2 (RFC): https://lore.kernel.org/kexec/20241122224715.171751-1-dwmw2@infradead.org/T/
 • Introduce linker script, start to clean up data access.

V1 (RFC): https://lore.kernel.org/kexec/20241103054019.3795299-1-dwmw2@infradead.org/T/
 • Initial proof-of-concept hacks.


