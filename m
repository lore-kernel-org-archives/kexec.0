Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ED2E6ADCF
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+oSJHlgV54zQ7Ilpi6mCzhyeYrpeSvM1VALAybOIPd0=; b=kWV/yAcJe1ghCZrfbMlduzC4Qt
	YVc2zGr8UVYOoGGLqwJBVPQkqqxhDQN+RQLCh6ip0plBYk9wtjL0LU8ttw+fpuUSaKvN5VINQyG2U
	pIaJffyHlTxYj0lXGLkL19Kpm9E+DWiwLaHYbezz5q9hoaYhpQIbDZSwTnchTt9QPDPV2ckq0AlZT
	aOZhqHXB76U0ix9cq+QrXsFZR1+lT4Vvg0PTLWwr8KmR0gOPIlVAj+Pb0+MlNtwiNBFpy9Fhj/7w3
	dXvqS9CuJZPguD8u0eZEuKXOd9IsedajKeeJQKPmx00qBL/i+Nla5z0b6o0jjPlPAhSCJ61nxWrwR
	MbH/di7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQw-00000003RLm-2811;
	Fri, 22 Nov 2024 22:47:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQu-00000003RKO-3V3Q
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+oSJHlgV54zQ7Ilpi6mCzhyeYrpeSvM1VALAybOIPd0=; b=oZwCXBxyf3LX4kt9xkqnEnZi3m
	DT5jtVsOPBjGPWS80jhzvpj3OuU5qT5QvqVk+j6H4TkiPlWZaO6q/bfQOlzLVTFvdm5758w90KCyc
	a8sjguiPu8Hmu6CF9jCyPkJSWDEt3TUQi5u2z0xJlDNn8yngqs/cuywEzE5bzaWpy8AGsxKbOTcQr
	zcAhXaGatUKEKh9UOS3/yFfj4oapYs88zQk1ZRBsckCOrij1ziYcIMsAdKY82YIfnSPt/4eCp0gNy
	Eaaa7CV+gYti52YSDvHK1jqbnvpT1EF26pVFwv1EoVMwkIRHZLLHtjGBICNtCBFYFAh4VTIYalURC
	3SvlrMkw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000008PHU-2DsT;
	Fri, 22 Nov 2024 22:47:21 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQo-00000000ii0-3L7f;
	Fri, 22 Nov 2024 22:47:18 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org
Subject: [RFC PATCH v2 0/16] x86/kexec: Add exception handling for relocate_kernel and further yak-shaving
Date: Fri, 22 Nov 2024 22:38:09 +0000
Message-ID: <20241122224715.171751-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
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

Make it easier to pass information into relocate_kernel by allowing it to
have actual variables which are set from the real kernel. To do this, move
it into the kernel's .data section, keeping its data and code together
with linker script rules. Execute it from the *copy* instead of its
original in the kernel data section, and clean it up a bit.

Then do what I originally started with, which is add a GDT+IDT and some
exception handling so we can actually catch problems instead of just
suffering a triple fault and wondering why the world hates us.

The serial output of the debug mode can be cleaned up a little, and it's
even now possible to pass in information about which serial port to write
to.

I'll also work on resyncing with the i386 code and applying as many of
these cleanups there as possible. And probably also make the 64-bit one
use a separate image->arch.pgd instead of lumping it into a single 8KiB
"control page" as we do on x86_64 at the moment.

But the basic cleanups are probably ready for another round of bikeshedding.

Testing the preserve_context mode with the following test case:

 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/kexec.h>
 #include <linux/reboot.h>
 #include <sys/reboot.h>
 #include <sys/syscall.h>

int main (void)
{
        struct kexec_segment segment = {};
	unsigned char purgatory[] = {
		0x66, 0xba, 0xf8, 0x03,	// mov $0x3f8, %dx
		0xb0, 0x42,		// mov $0x42, %al
		0xee,			// outb %al, (%dx)
		0xc3,			// ret
	};
	int ret;

	segment.buf = &purgatory;
	segment.bufsz = sizeof(purgatory);
	segment.mem = (void *)0x400000;
	segment.memsz = 0x1000;
	ret = syscall(__NR_kexec_load, 0x400000, 1, &segment, KEXEC_PRESERVE_CONTEXT);
	if (ret) {
		perror("kexec_load");
		exit(1);
	}
	return 0;
}


David Woodhouse (16):
      x86/kexec: Clean up and document register use in relocate_kernel_64.S
      x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
      x86/kexec: Restore GDT on return from preserve_context kexec
      x86/kexec: Only swap pages for preserve_context mode
      x86/kexec: Invoke copy of relocate_kernel() instead of the original
      x86/kexec: Move relocate_kernel to kernel .data section
      x86/kexec: Add data section to relocate_kernel
      x86/kexec: Copy control page into place in machine_kexec_prepare()
      x86/kexec: Drop page_list argument from relocate_kernel()
      x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page
      x86/kexec: Clean up register usage in relocate_kernel()
      x86/kexec: Mark relocate_kernel page as ROX instead of RWX
      x86/kexec: Debugging support: load a GDT
      x86/kexec: Debugging support: Load an IDT and basic exception entry points
      x86/kexec: Debugging support: Dump registers on exception
      [DO NOT MERGE] x86/kexec: enable DEBUG

 arch/x86/include/asm/kexec.h         |  13 +-
 arch/x86/include/asm/sections.h      |   1 +
 arch/x86/kernel/machine_kexec_64.c   |  55 +++--
 arch/x86/kernel/relocate_kernel_64.S | 384 +++++++++++++++++++++++++++--------
 arch/x86/kernel/vmlinux.lds.S        |  12 +-
 5 files changed, 358 insertions(+), 107 deletions(-)


