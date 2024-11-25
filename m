Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB838D3B7FB
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8KdxSUjA1BoxOPlX8D0AVdJHTOMU4u9sPbtmHj+Y10=; b=QjkmFre1WrXQt0AL/GJdfVhqLp
	sTbL9WTXHas+XzV6Fb9PqbWTa5li5EzfoKkMLQCTjZivnwUuID8ivLbd0pzuMt4e5v+1SmfuUGUBy
	MuFHdIBAJJyBRQrnj7dn4c1L81UdehGfLwKJeLxhO/Zj5KtI9FjirzRy277qWtD4OI7jAKsbVYxFL
	I7lFqxBDiMvGPYl2WtVwCtf/Z0u5isquD2eh7VM1OS+NNJ+oIuS66WRwkhhPf55diitXzmQPvWqu8
	UOyErmsfmqlrsX+Oz3pdecCdfIwD6D7wPGJjAEWPoQmAGmLgNgqoYNfAruDtjhhfveIXAm95+wiQa
	L9oTk8KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWAN-00000007iYI-2Xqd;
	Mon, 25 Nov 2024 10:18:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW12-00000007gFa-2iOt
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 10:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=G8KdxSUjA1BoxOPlX8D0AVdJHTOMU4u9sPbtmHj+Y10=; b=MBheZFKF24JvLnyhs/ErZ+c73n
	tpQrRx9ter9x2anW6+1mkzL6VSk+MMd8v8k8bVxi0T1GllWG/tLA1b0tLtCKb5mW2zgKCLv3PZLoz
	iY9GUBYn4WvoBmeHLc4Y7LLGjcr+FpC5kV+EVqoNXszYKyAFpY61eh+JiMyxUP/RshzufRZJaZUJY
	6D9GWntSFzvYvGtIPDSL75vz9jI24Nrkl+Is2+wVpVHcRgm4bNG0F66byprZfD2Js4F3F35ie835M
	1zJ8o9yFxdVQtVXpQg93hpdoEKuUjvmk21iIU/TT6XfMDECZ9H+OEf83O9cZEMwolulmIi7QooeiA
	WvezX/dA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0y-0000000Biqs-361M;
	Mon, 25 Nov 2024 10:08:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000kw-1WVJ;
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
Subject: [RFC PATCH v3 03/20] x86/kexec: Clean up and document register use in relocate_kernel_64.S
Date: Mon, 25 Nov 2024 09:54:33 +0000
Message-ID: <20241125100815.2512-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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

Add more comments explaining what each register contains, and save the
preserve_context flag to a non-clobbered register sooner, to keep things
simpler.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1236f25fc8d1..92478e2e254f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -100,6 +100,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%r10, CP_PA_SWAP_PAGE(%r11)
 	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
 
+	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
+	movq	%rcx, %r11
+
 	/* Switch to the identity mapped page tables */
 	movq	%r9, %cr3
 
@@ -116,6 +119,14 @@ SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	UNWIND_HINT_END_OF_STACK
+	/*
+	 * %rdi	indirection page
+	 * %rdx start address
+	 * %r11 preserve_context
+	 * %r12 host_mem_enc_active
+	 * %r13 original CR4 when relocate_kernel() was invoked
+	 */
+
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -170,8 +181,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 .Lsme_off:
 
-	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
-	movq	%rcx, %r11
 	call	swap_pages
 
 	/*
@@ -183,13 +192,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%cr3, %rax
 	movq	%rax, %cr3
 
+	testq	%r11, %r11	/* preserve_context */
+	jnz .Lrelocate
+
 	/*
 	 * set all of the registers to known values
 	 * leave %rsp alone
 	 */
 
-	testq	%r11, %r11
-	jnz .Lrelocate
 	xorl	%eax, %eax
 	xorl	%ebx, %ebx
 	xorl    %ecx, %ecx
-- 
2.47.0


