Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2200D6D238
	for <kexec@archiver.kernel.org>; Wed, 27 Nov 2024 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OTgmGqkzjiMCAdM9XAGVnWmAd0bZ2mIoBGOGiUYyUyI=; b=03jiR2KoJLzHlN5ASjgi2e6IVe
	ukmtVMzfGDR5XNTbPtHA+Zzb8tPTJqy5B/rb9V7WZoQET3fnFFcNhmJwK1dAyDvJo5BkJVDAAxQ9j
	9VWtP+b41E8CuzKJIArC/GP24HO8whbx5OYzhO5+mScSFHAF7ecUVB+hGA8Dk2rfruHye9apzlylR
	/zHriT9EWNEMpkLMxpIJwTp1+91QFzUDxshWH1/RA+ucb/lgruo2Eb2UZl3uEpkK2XM/05PlMxN5w
	OOnUB7P7hAq6diaJiXsKIPY2bNVLcJyqCevfzQ69LK3dX5POneGl+hs+ZYjfSHbf2ZPE6yj2giacy
	0eLNXwhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGOJN-0000000E0pp-35KF;
	Wed, 27 Nov 2024 20:06:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKH-0000000DszV-0OjV
	for kexec@bombadil.infradead.org;
	Wed, 27 Nov 2024 19:03:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OTgmGqkzjiMCAdM9XAGVnWmAd0bZ2mIoBGOGiUYyUyI=; b=hIXc1feLdzn5u5UgzQVtmgzb0L
	tIIR/OVSGOFdLZ/bDLsU+8k0HWQJAfnJBBbU1hDGxJI8NkcxP3Feu3mbhtlip4PnBWeUboSVaR0TG
	td797DNJ62Agu3iRmioCN+/QhRwcXOG1zI6YAvqrCLw70X6pKJgvDRmjPcJCZ6i43M1PuQOPKUy5B
	Cf7IGkWg9C5RQgTzljoY9ngd6fyz3gjlBxteE6L/iGhm6+4dhUE/u76oagvPdUB9CkUj8uUUcxnDx
	f6XNW5n/pJM4+neVN8kAVbj6619Wf2egv2kmqBdmEZ9z9kS+nRO6OtI6wIdq9gUvtstIyxfI+8px9
	JDZaUXGQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKC-00000001cW2-3BcR;
	Wed, 27 Nov 2024 19:03:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKD-00000000Bi7-39d2;
	Wed, 27 Nov 2024 19:03:45 +0000
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
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v4 00/20] x86/kexec: Add exception handling for relocate_kernel and further yak-shaving
Date: Wed, 27 Nov 2024 19:00:14 +0000
Message-ID: <20241127190343.44916-1-dwmw2@infradead.org>
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

Debugging kexec failures is painful, as anything going wrong in execution
of the critical relocate_kernel() function tends to just lead to a triple
fault. Thus leading to *weeks* of my life that I won't get back. Having
hacked something up for my own use, I figured I should share it...

Add a CONFIG_KEXEC_DEBUG option which sets up a trivial exception handler
in that environment, and outputs to the early_printk serial console if
configured. Currently only I/O-based 8250 serial ports are supported, but
that could be extended.

While we're here, clean the code up a little and fix some other problems. 
Most notably, load a suitable GDT on the way back into the kernel after a 
KEXEC_PRESERVE_CONTEXT invocation instead of trusting the called code to do 
so. And (new in v4) fix the interaction of PTI and the identmap code so that 
it doesn't scribble over the end of the 4KiB region allocated for the PGD 
expecting there to be a userspace PGD there.

I should probably bring the i386 version into line with this, although
the lack of rip-based addressing makes all the PIC code a bit harder.

David Woodhouse (20):
      x86/kexec: Restore GDT on return from preserve_context kexec
      x86/kexec: Clean up and document register use in relocate_kernel_64.S
      x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
      x86/kexec: Only swap pages for preserve_context mode
      x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables
      x86/kexec: Allocate PGD for x86_64 transition page tables separately
      x86/kexec: Copy control page into place in machine_kexec_prepare()
      x86/kexec: Invoke copy of relocate_kernel() instead of the original
      x86/kexec: Move relocate_kernel to kernel .data section
      x86/kexec: Add data section to relocate_kernel
      x86/kexec: Drop page_list argument from relocate_kernel()
      x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page
      x86/kexec: Clean up register usage in relocate_kernel()
      x86/kexec: Mark relocate_kernel page as ROX instead of RWX
      x86/kexec: Add CONFIG_KEXEC_DEBUG option
      x86/kexec: Debugging support: load a GDT
      x86/kexec: Debugging support: Load an IDT and basic exception entry points
      x86/kexec: Debugging support: Dump registers on exception
      x86/kexec: Add 8250 serial port output
      [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing

 arch/x86/Kconfig.debug               |   8 +
 arch/x86/include/asm/kexec.h         |  34 +++-
 arch/x86/include/asm/pgtable_types.h |   8 +-
 arch/x86/include/asm/sections.h      |   1 +
 arch/x86/kernel/callthunks.c         |   6 +
 arch/x86/kernel/early_printk.c       |   6 +
 arch/x86/kernel/machine_kexec_64.c   | 121 +++++++----
 arch/x86/kernel/relocate_kernel_64.S | 385 +++++++++++++++++++++++++++--------
 arch/x86/kernel/vmlinux.lds.S        |  16 +-
 arch/x86/mm/ident_map.c              |   6 +-
 arch/x86/mm/pti.c                    |   2 +-
 11 files changed, 457 insertions(+), 136 deletions(-)



