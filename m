Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F46C02187
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZIq3ewJlqtYJa5dehpWmIo+EteWA3lQCzBKImc1PUJk=; b=hr63/g2x3WIdlvtAjbl2BD3k0I
	ZueH7cv/bW6dQeXxt35ETp2f54cTH4FRonvPjEkzn7BA13JwDaRvKpoRflEtlVGHxOgwdvAjAfMQT
	C3hYwDR5S53+rw7rUGYvVwhK7g3srO9/X88aIA3sVm6Oj2iIrixSgKQC7ceL+/qZqI4mHLbh39euq
	cimpwUo2HsJxkitUMpxnoUxvhqum2t/cWx9KeOfv6AZasuyPqoCBKYXpb6Ep+KPzch8MFBHYteIr+
	cT4uosz5SLOiYSjUhng0kHrFlRubc4k8QHFCZW+fcWT5IvGyuz1JsEShaLqWC9EkhTLiMp/2j3OSS
	bCzGMoSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8rK-0000000Cs7j-33fn;
	Wed, 15 Jan 2025 19:15:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qT-0000000Crvg-3yIV
	for kexec@bombadil.infradead.org;
	Wed, 15 Jan 2025 19:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZIq3ewJlqtYJa5dehpWmIo+EteWA3lQCzBKImc1PUJk=; b=SGaQLFjbg3gsu1DcF5hwxmshxs
	bN2iHel/D6LSmm0iJVuMzOlxhatvr9XtFCsoAlT8/ik5HnvLJolzLMtCylgdrk3NWADLW/wYJPCRo
	+oWBlrbxy7FdNTQIOTCSAoNkn3MIcwp4GjW26qxXfmeI3v+qmE37A+uc349XQWICXWLkgQHi+vw0n
	QRM+AeW2D32xFNBvxnwC2VokSGBEYuglYYutNWZnUhI7sJXaKjOnxHr3ej0pIwxIrZbKPiP9AigKg
	a1aUv33/HVz1U3aFKdZ2gpUwpwGPFA0O45INL+STS7wHBhtJtZYzCne53bXQPQuhFG77YXfJb8llB
	CYlwJjYA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qQ-00000000X80-3KeS;
	Wed, 15 Jan 2025 19:14:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qO-00000002Uvn-3R6j;
	Wed, 15 Jan 2025 19:14:24 +0000
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
Subject: [PATCH v6 0/7] x86/kexec: Add exception handling for relocate_kernel
Date: Wed, 15 Jan 2025 19:09:29 +0000
Message-ID: <20250115191423.587774-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
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

Add a CONFIG_KEXEC_DEBUG option which sets up a trivial exception
handler in that environment, and outputs to the early_printk serial
console if configured. Currently only 8250-compatible serial ports are
supported, but that could be extended.

I had to hack up QEMU support for a PCI serial port which matches what
the existing early_printk code can drive, and the *real* 8250_pci driver
doesn't seem to cope with that setup at all, but whatever... the kexec
code now drives the same 32-bit stride which is all that earlyprintk
supports. We can always add more later, if anyone cares.

Someone who cares might want to bring the i386 version into line with
this, although the lack of rip-based addressing makes all the PIC code a
bit harder.

David Woodhouse (7):
      x86/kexec: Add CONFIG_KEXEC_DEBUG option
      x86/kexec: Debugging support: load a GDT
      x86/kexec: Debugging support: Load an IDT and basic exception entry points
      x86/kexec: Debugging support: Dump registers on exception
      x86/kexec: Add 8250 serial port output
      x86/kexec: Add 8250 MMIO serial port output
      [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing

 arch/x86/Kconfig.debug               |   1 +
 arch/x86/include/asm/kexec.h         |   7 +
 arch/x86/kernel/early_printk.c       |   9 ++
 arch/x86/kernel/machine_kexec_64.c   |  45 +++++++
 arch/x86/kernel/relocate_kernel_64.S | 248 +++++++++++++++++++++++++++++++++++
 kernel/Kconfig.kexec                 |  11 ++
 6 files changed, 321 insertions(+)

v6:
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



