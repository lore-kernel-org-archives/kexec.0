Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4387BD3B7F8
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+cdGMrXlLMQ5gF/V+Me3rwZRfmBgngjB82bVhN99Q4=; b=Da6B41vDOKmDlPGJ3nwAOGPM8G
	d+ycOQOBcRRTYE8phIhrqbD/eOgi5A7caQJg/h3T+DyGzvWfwQouYqUt/MU/b4Q9XsG77HE9PQXh2
	2RCemLVRT6KHuwenlYPmnat8NKKmheQpvJYROhzTC2YGooiZZ54ShXvNJ7cLRHE3pcwYKjfGfRbST
	dtXAAcaB0afzqKiBNZlL8HGQUBDs8xwK3qZSAATJO84MNR/WAsoVAVQM7WKq6P7wv7EV3nbZSwpdz
	TWlddTniFslD0PV70VCk/B8mL9ZtVK4+PtGbpzOTElCSjA6eHH3c1UY8LkiWytvk/p5vT2kYaV2JW
	GjtJx+7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWB1-00000007jNd-3RIB;
	Mon, 25 Nov 2024 10:18:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW13-00000007gGS-3Z2c
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 10:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B+cdGMrXlLMQ5gF/V+Me3rwZRfmBgngjB82bVhN99Q4=; b=YzQA5ETnr/Im+ADmC/KzXaTFok
	vkCg1JlIisTZXb1jWqhN40o2xK6gpGuLArSnwWaG/zOtJhpdO52ERcs85taAz4OHzJPBjpbUNLUMr
	v6emJMYNM4g9FeJL0NAl3BK7sbgdV7Y+R3mCggElIAOsDHC3mVDWjcgYKH5lk1ePhHRGb1PaPEdZn
	Vbr2G/Ubrp4+npuOHsPvRZFRKlEXVH9SHY8mHLyKHXUyNEdx+POtlXc71kE8qBYVPNdXonnKtUY+d
	jTsoviQJU4DNFO5uL4NPyuxSkabrE+GgCkZ3T5V7Mpo1thpTOW5tYK7FTAwg3oHQ4ZFqWFOL0MYGE
	1O0pQMNg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW12-000000014f7-16h0;
	Mon, 25 Nov 2024 10:08:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000lU-3LPM;
	Mon, 25 Nov 2024 10:08:21 +0000
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
Subject: [RFC PATCH v3 13/20] x86/kexec: Clean up register usage in relocate_kernel()
Date: Mon, 25 Nov 2024 09:54:43 +0000
Message-ID: <20241125100815.2512-14-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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

The memory encryption flag is passed in %r8 because that's where the
calling convention puts it. Instead of moving it to %r12 and then using
%r8 for other things, just leave it in %r8 and use other registers
instead.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 288dfc08c63d..b24198eb1fe9 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -79,24 +79,18 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%cr4, %r13
 	movq	%r13, saved_cr4(%rip)
 
-	/* Save SME active flag */
-	movq	%r8, %r12
-
 	/* save indirection list for jumping back */
 	movq	%rdi, pa_backup_pages_map(%rip)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 
-	/* Physical address of control page */
-	movq    %rsi, %r8
-
 	/* setup a new stack at the end of the physical control page */
-	lea	PAGE_SIZE(%r8), %rsp
+	lea	PAGE_SIZE(%rsi), %rsp
 
 	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %r8
-	pushq	%r8
+	addq	$(identity_mapped - relocate_kernel), %rsi
+	pushq	%rsi
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -107,8 +101,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/*
 	 * %rdi	indirection page
 	 * %rdx start address
+	 * %r8 host_mem_enc_active
+	 * %r9 page table page
 	 * %r11 preserve_context
-	 * %r12 host_mem_enc_active
 	 * %r13 original CR4 when relocate_kernel() was invoked
 	 */
 
@@ -161,7 +156,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * entries that will conflict with the now unencrypted memory
 	 * used by kexec. Flush the caches before copying the kernel.
 	 */
-	testq	%r12, %r12
+	testq	%r8, %r8
 	jz .Lsme_off
 	wbinvd
 .Lsme_off:
-- 
2.47.0


