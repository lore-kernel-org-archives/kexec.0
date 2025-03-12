Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B527C35FF1
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ybsUY7o8yqbkApk0dzSa8UzXZgQrXii7fmhg0Fzl2SU=; b=4K9gS+Y4MTIQdm+2ozMJJjDVph
	j/dTDsgArHgxB5+28TIiwLY+Zv9M8htGsSqbqGPiiB/p3uH9SdRkIGnTMtCU77cKHvrJE4qUub3mz
	Yj/GZh63fIWg76P7XnppNs8XKTPD5gYE9oULGJahZHGZm5Gd60b/e1OWp9HFGyc0ZjjPr728VSkRx
	p7RmDi9Ru1xBbii+Nz5F+bk7c81ym0X5i24xP3gnVClZdcy67QWrKvViErTBHAA7N7SMAjV/1604l
	Xx7PjOezNzafFx8Wf7zn9QI5UhMXLSLLw8WmJWpfrB7f69c0CK1vGuIji5ku50UJo9w63X73HvwoZ
	fkR1aMcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOM5-00000008vii-1Cnm;
	Wed, 12 Mar 2025 15:50:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIU-00000008jRM-14gY
	for kexec@bombadil.infradead.org;
	Wed, 12 Mar 2025 14:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ybsUY7o8yqbkApk0dzSa8UzXZgQrXii7fmhg0Fzl2SU=; b=Lpf4zUwQXV7/cVzR0agKC2C9cL
	1Aij1V44AFbT3Eh+UqJSrf28DqUd42eB0vvUbmcZJ7ZvBraR10bkf1ANYoL8bedlgbnv/iCrhA/4C
	ISSo9W2ge9dsnoBjn/wbBOFQ+fHxhutRxplYf/P324OSo3oRHTCr5BcbPsNOnfJ4LgSEZ5UO4C/tn
	xP4GdZ0aZx8mqpdsiD7IyqndEOaeVpdUt8Rr22g62dDbPIiV9TCpLRc+z15g2eK6T+WQsoRkSM/IM
	SPsyOv3dRw8WWA+3xaL9peTlJF2tpIed7wZLzlYx3gQn3MFsbqyfY8P9z0kmXtklkgg/4/49zF7Rh
	LQZXf7uQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-0000000CxJF-2VLv;
	Wed, 12 Mar 2025 14:42:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uU3-1de1;
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
Subject: [PATCH v7 1/8] x86/kexec: Debugging support: load a GDT
Date: Wed, 12 Mar 2025 14:34:13 +0000
Message-ID: <20250312144257.2348250-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

There are some failure modes which lead to triple-faults in the
relocate_kernel function, which is fairly much undebuggable for normal
mortals.

Adding a GDT in the relocate_kernel environment is step 1 towards being
able to catch faults and do something more useful.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b44d8863e57f..ac058971a382 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -40,6 +40,16 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
+	.balign 16
+SYM_DATA_START_LOCAL(kexec_debug_gdt)
+	.word   kexec_debug_gdt_end - kexec_debug_gdt - 1
+	.long   0
+	.word   0
+	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
+	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
+	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
+SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
+
 	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
@@ -116,6 +126,19 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
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
+
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
 	 * below.
-- 
2.48.1


