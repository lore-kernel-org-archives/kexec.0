Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6B4C02187
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gSlCkcjgZBWAkesEhGWssA+8sh3qmIYNjsyEtgrDo9o=; b=zlxPXIBCxWVsK7m6CKAxh+uLRc
	3BhB20r2V3kjZg7UtVQwlWyCNPM9fO+7DENWGz5iwxJgtxPq2KTIm2hu6mKvU1x6+eyMdjODm7HkQ
	N7wDuWgeUGRpd/YMINzlGSl0ykbe1WafulxZKsNekGreLzGWi9E0YKxxBNITbCRGTC9dtJtKRnkLq
	NvkqgM4fGyau3fjRn5m0dk8KGs+3mPjSf1f9zHHndajQjlcdd4FZxs3lF576ZnD7Z0fNhFFWZSor3
	+w4D5EL2bRVi61hyKunXtNHIGMMioAcfCNnU65fM5BC2U0vDQVOFGR1AI9SF990NVqJbH/9yMoNBZ
	kQExHLhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8rO-0000000CsBW-0cb2;
	Wed, 15 Jan 2025 19:15:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qV-0000000CrwV-3z4L
	for kexec@bombadil.infradead.org;
	Wed, 15 Jan 2025 19:14:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gSlCkcjgZBWAkesEhGWssA+8sh3qmIYNjsyEtgrDo9o=; b=CmJydDU/dAvjj4CnxjPLH6YzMp
	xL7tbn0ps9im7A6cSChwUu7TxpcKV0+MpI4IDFG868u6Mp00Ci1pPnFj5E4xWxaRnzp9Vy6kTJykI
	KWDB0XphijgmIpsYjCOZnA7j75hLVXzWlP37SefhuHRFM2hdEa7z8EFjVjYpQUQP3CgjIhYQo8ieP
	00mwG9JQJyLXAp5LFTESxbaMo21zpkMi5O5hVivkOy9QwQIO6m2z1RlJfJgIiXV6vsVvVdfy39AGQ
	Hx3kIsIk2X40EJzhRF96dxqQCBDrAODLkAIe1Tc0wXNVeinWMWTR/uQkq0l0YVpW33Ghst0qneIqJ
	0QrbJaUQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qS-0000000AvMc-07ML;
	Wed, 15 Jan 2025 19:14:29 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qO-00000002Uvx-3ogr;
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
Subject: [PATCH v6 2/7] x86/kexec: Debugging support: load a GDT
Date: Wed, 15 Jan 2025 19:09:31 +0000
Message-ID: <20250115191423.587774-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115191423.587774-1-dwmw2@infradead.org>
References: <20250115191423.587774-1-dwmw2@infradead.org>
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
index af2cd06ff318..c62f03808f18 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,18 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
+#ifdef CONFIG_KEXEC_DEBUG
+	.balign 16
+SYM_DATA_START_LOCAL(kexec_debug_gdt)
+	.word   kexec_debug_gdt_end - kexec_debug_gdt - 1
+	.long   0
+	.word   0
+	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
+	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
+	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
+SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
+#endif /* CONFIG_KEXEC_DEBUG */
+
 	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
@@ -115,6 +127,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
+#ifdef CONFIG_KEXEC_DEBUG
+	/* Create a GDTR (16 bits limit, 64 bits addr) on stack */
+	leaq	kexec_debug_gdt(%rip), %rax
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
+#endif /* CONFIG_KEXEC_DEBUG */
+
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
 	 * below.
-- 
2.47.0


