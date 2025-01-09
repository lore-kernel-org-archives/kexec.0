Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBE8E7719B
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UXXMy8NjgmXapI75A+lfqUhBwTskcOXo5TKctXbko48=; b=4rtPEGdoZLUUZR1BXROguhi6nz
	RgKCx9cXhpkm6ogc3xVUFAQ7r7Y+o4ciCOr84ipAcYN4Ssm6Vo8uSrRrwthFULAaGVWdqxQNzK7PB
	8SZpSrzLSuSgZXQTxR7k+bOlTJ0hYc4XkvSVnALjTVhT8JhlQJxbYWF38pcNe8wrrqgK1cnJT/9rs
	YIciZV6wgxK/jc/ZJRcqJCnX50JrbsxOvQxtUvx9RcfteBc/AR5RseWVG3kFEj1ePX1U1MvKrAvpm
	d+mr5tITqL1PPLUAF9+XLEC5cwKvcF1YxgLGU+lhmNfKtft6DgtB5x1Dy2NP0KUqKFgHgMkhtRoer
	9fgt9yqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtDt-0000000CB1N-3ESt;
	Thu, 09 Jan 2025 14:09:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCf-0000000CAe1-1GD0
	for kexec@bombadil.infradead.org;
	Thu, 09 Jan 2025 14:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=UXXMy8NjgmXapI75A+lfqUhBwTskcOXo5TKctXbko48=; b=eEewo2DqTqYsZN0oqse9fjK050
	Bkp6wVR+qVdk9ZRZSMunW1WYpzMyKt0yh2LCYqLhNpBiMAmQ5BXufoemNej9jBhlVSpklEAgHxuxU
	0hZPf5RkIyhWuUqxzTjdZ8duCJA16X3u5Yi/Vvn0rd7ZpnhyRW7EdLJtAdx/HNg/l/S5wCrc2u4xv
	uQ1FFZWzIqiLIlaYIJ77sDhTe8rUa5l53vQlSPNoP7KD0ZQy6PN2P2EtjRGL7tlEcfGezlOOgehl0
	3jFiKFQTgMNa/u58uh16wSpIbLNbghwn1TnE5Ty3XbboyMYnykVXQ0hkg9+hv0hXLHyCMwEOUCO5E
	UHlfmhow==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCZ-00000006IQH-30ko;
	Thu, 09 Jan 2025 14:07:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCY-0000000Bx6B-35Gp;
	Thu, 09 Jan 2025 14:07:58 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>,
	Tao Liu <ltao@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Rong Xu <xur@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bsz@amazon.de,
	nathan@kernel.org
Subject: [PATCH v2 4/9] x86/kexec: Fix stack and handling of re-entry point for ::preserve_context
Date: Thu,  9 Jan 2025 14:04:16 +0000
Message-ID: <20250109140757.2841269-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250109140757.2841269-1-dwmw2@infradead.org>
References: <20250109140757.2841269-1-dwmw2@infradead.org>
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

A ::preserve_context kimage can be invoked more than once, and the entry
point can be different every time. When the callee returns to the kernel,
it leaves the address of its entry point for next time on the stack.

That being the case, one might reasonably assume that the caller would
allocate space for it on the stack fram before actually performing the
'call' into the callee.

Apparently not, though. Ever since the kjump code was first added in
2009, it has set up a *new* stack at the top of the swap_page scratch
page, then just performed the 'call' without allocating any space for
the re-entry address to be returned. It then reads the re-entry point
for next time from 0(%rsp) which is actually the first qword of the page
*after* the swap page, which might not exist at all! And if the callee
has written to that, then it will have corrupted memory it doesn't own.

Correct this by pushing the entry point of the callee onto the stack
before calling it. The callee may then adjust it, or not, as it sees fit,
and subsequent invocations should work correctly either way.

Remove a stray push of zero to the *relocate_kernel* stack, which may
have been intended for this purpose, but which was actually just noise.

Also, loading the stack for the callee relied on the address of the swap
page being in %r10 without ever documenting that fact. Recent code
changes made that no longer true, so load it directly from the local
kexec_pa_swap_page variable instead.

Fixes: b3adabae8a96 ("x86/kexec: Drop page_list argument from relocate_kernel()")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 3ca3bf6b3f49..a95691b42c5c 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -113,8 +113,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * %r13 original CR4 when relocate_kernel() was invoked
 	 */
 
-	/* set return address to 0 if not preserving context */
-	pushq	$0
 	/* store the start address on the stack */
 	pushq   %rdx
 
@@ -208,12 +206,19 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 .Lrelocate:
 	popq	%rdx
+
+	/* Use the swap page for the callee's stack */
+	movq	kexec_pa_swap_page(%rip), %r10
 	leaq	PAGE_SIZE(%r10), %rsp
+
+	/* push the existing entry point onto the callee's stack */
+	pushq	%rdx
+
 	ANNOTATE_RETPOLINE_SAFE
 	call	*%rdx
 
 	/* get the re-entry point of the peer system */
-	movq	0(%rsp), %rbp
+	popq	%rbp
 	leaq	relocate_kernel(%rip), %r8
 	movq	kexec_pa_swap_page(%rip), %r10
 	movq	pa_backup_pages_map(%rip), %rdi
@@ -247,6 +252,7 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	lgdt    saved_context_gdt_desc(%rax)
 #endif
 
+	/* relocate_kernel() returns the re-entry point for next time */
 	movq	%rbp, %rax
 
 	popf
-- 
2.47.0


