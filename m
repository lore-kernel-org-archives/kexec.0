Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EE1E6ADCE
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PM8M+JIu8uZjpEQfel8bzCRRPJYH7fSk33eUzo/nnU0=; b=TosniXEfDA+25W2ytIkEYaMlXX
	Jg/PZeT5O+6hlC+voLUnhqK6ozkGAiuJ2K0Iw3YJYFzX3DAgk0Pa1hqNWKfuEZIs/JlEODTEZ53dk
	WQGR8pskPSj1K5yeBOusQRQN17PT2A+yGoKU56M2g9PAjURpN2Ychdio/Wzt5G8wgQY5GTER6Gw+3
	HikLOMlFdSiEPTNxXqQNknr9z2DE6NWyKsxQ4+iEeoZVqZ5vyFOmZPn1MErtoeiHFQvEbCW9kHjLf
	EC++MGaQQ5y0yAc7L56T//xYHr5Epg1sZ202LrCmJOk1+E7Kn6IsVkwWuBfxszZ0PnPmVzgpHjx0f
	BqVph3mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcRG-00000003RgR-2K6b;
	Fri, 22 Nov 2024 22:47:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcRE-00000003Rcx-0YMW
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PM8M+JIu8uZjpEQfel8bzCRRPJYH7fSk33eUzo/nnU0=; b=rF3QGRXPlEJmi4zzK2yeUu9q6o
	+MQhF7dc6fsRF6mRBksfr6ZvhnvFHLqOWro4HxxT9Hktex8e2Gln1L/BAKF3gBBgvhqyPCF8NdkZD
	rTi5X/0XG2g//sjIrvTY4H4+ma2j9wmoDBw7Kgvlfz1NXdneyys8+DIntjjw5n50wU83wapX1neYI
	CVvTFerkxoO86GxLLykO44W5BSwliMZWG8BijcOvUijggdAdJcpYRJI7cie73Meo0VV5f35wwwFh7
	HjpwpSnPNO3TYvLqI1aQ34kgOF/xAqYvlDGif8EullkmJtpGzcR44F/Jt9spM5/p7NS9qaJZWGGr7
	q7fa0QIQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000000maL-3C75;
	Fri, 22 Nov 2024 22:47:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iid-1guO;
	Fri, 22 Nov 2024 22:47:19 +0000
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
Subject: [RFC PATCH v2 13/16] x86/kexec: Debugging support: load a GDT
Date: Fri, 22 Nov 2024 22:38:22 +0000
Message-ID: <20241122224715.171751-14-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

There are some failure modes which lead to triple-faults in the
relocate_kernel function, which is fairly much undebuggable for normal
mortals.

Adding a GDT in the relocate_kernel environment is step 1 towards being
able to catch faults and do something more useful.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 51dc55ac4395..5c174829f794 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,18 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
+#ifdef DEBUG
+SYM_DATA_START_LOCAL(reloc_kernel_gdt)
+	.balign 16
+	.word   reloc_kernel_gdt_end - reloc_kernel_gdt - 1
+	.long   0
+	.word   0
+	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
+	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
+	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
+SYM_DATA_END_LABEL(reloc_kernel_gdt, SYM_L_LOCAL, reloc_kernel_gdt_end)
+#endif /* DEBUG */
+
 	.section .text.relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
@@ -112,6 +124,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
+#ifdef DEBUG
+	/* Create a GDTR (16 bits limit, 64 bits addr) on stack */
+	leaq	reloc_kernel_gdt(%rip), %rax
+	pushq	%rax
+	pushw	(%rax)
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
-- 
2.47.0


