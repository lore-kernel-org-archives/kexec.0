Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BCFE67806
	for <kexec@archiver.kernel.org>; Sun,  3 Nov 2024 05:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R4qFYjBHTEjACNMEBBO+XtpG2/oyTJsy/izj9A3Qyk8=; b=cKjaqGnncooiT3
	46XPbQIhOk9P1FtQOhx+kblroKCy6qifABx5uwjqg2ilWFlwV+BxFAmC7jpZVmanNvDoqtpl39T5T
	kPAu6qJNXeScdwMhbXLLXoA94YuuUgTyWmRm/8bQzrr71wk+sf4aYHs3yO3mP3RhjVex6OaN1qsXL
	vz/MwMEba4lfUR5PESay/7UNx1F4uQo7EVyLNksfu2MPor+T5g31PWwneLv8sZpm1XnKLTNxoOqL0
	Te1CxJoCUV35j9CS0zCMFv6vxkgrgW0LZdfgecpui5H33jHgpgDWHon2XGkujUifQ6xltRxk7cJY0
	o7gnPraY/p103nM/1qsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLi-0000000AzWC-3uTR;
	Sun, 03 Nov 2024 05:40:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLe-0000000AzVj-2l62
	for kexec@bombadil.infradead.org;
	Sun, 03 Nov 2024 05:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b9tRHLeN7pxr2xLddlnhC83jvrEl3kzVd1otLRBzbTE=; b=jO9C1c79487FhflAUbwCJXVvep
	IS2n0bhmHSa0v4UNoWe/2n9mZpNuTvAoBh+a6iE+2qJIoJ5RCVK1Yb3Y/F28Of9qEVlH2Nkme22eD
	MmdptXVsZXviyiN7cPhxIwAiatf1M4w7DH1STwE4AFwZkl4VVybStgt0rfPaoUgDJ5V74WFtlJuJ1
	tUCLZ5Q2obhJgUyNNiqNF0FvgbxzVzHTTUWlsd3ryjyaDToXWuMBJk7x3p60VkG/11V3L4TXdMO+V
	TbpFwFHmNMQaDRgrB4xHChR6ZWdx3UGuxnpTIdzsp30qH/fFv/8KMiXdFbnvEBamgKGI45dUK9SSr
	Pxld+mCQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLa-0000000HSiN-2SWN;
	Sun, 03 Nov 2024 05:40:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvLL-3x2L;
	Sun, 03 Nov 2024 05:40:22 +0000
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
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH 4/7] x86/kexec: Debugging support: load a GDT
Date: Sun,  3 Nov 2024 05:35:29 +0000
Message-ID: <20241103054019.3795299-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241103054019.3795299-1-dwmw2@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: David Woodhouse <dwmw@amazon.co.uk>

There are some failure modes which lead to triple-faults in the
relocate_kernel function, which is fairly much undebuggable for normal
mortals.

Adding a GDT in the relocate_kernel environment is step 1 towards being
able to catch faults and do something more useful.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 9b6ed08e00ea..2af4ce593645 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -131,6 +131,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
+#ifdef DEBUG
+	/* Create a GDTR (16 bits limit, 64 bits addr) on stack */
+	leaq	.Lreloc_kernel_gdt(%rip), %r8
+	pushq	%r8
+	pushw	(%r8)
+
+	/* Load the GDT, put the stack back */
+	lgdt	(%rsp)
+	addq	$10, %rsp
+
+	/* Test that we can load segments */
+	movq	%ds, %rax
+	movq	%rax, %ds
+#endif /* DEBUG */
+
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
 	 * below.
@@ -331,5 +346,16 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
+#ifdef DEBUG
+.Lreloc_kernel_gdt:
+	.word   1f - .Lreloc_kernel_gdt - 1
+	.long   0
+	.word   0
+	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
+	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
+	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
+1:
+#endif /* DEBUG */
+
 	.skip KEXEC_CONTROL_CODE_MAX_SIZE - (. - relocate_kernel), 0xcc
 SYM_CODE_END(relocate_range);
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
