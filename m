Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C909E77184
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 23:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qnDZGmQXXRBfaYMiHf8RcgZ8w0/B4+1DdFBULwwOb1o=; b=3RJ9lziMdUS7fQw+9QDdoMZtfF
	D9pUn4+6Q6CX6XiRkq65kslamC6+n6l5cUYA6dkKESCRt6p/TY7zbq2revYfJdLH9CE9G0o39NrB/
	afw24Me8rTUbN76k5eAj8WPeOjzcNbmJYWNo7teSUbV6dGubddMV+CtlNUO0dy/eWFUzLXTyPN5+c
	7hSa5n9RC/HMU0D6U7KuhnNjktsxBh75PowDWeCs9EjxNZhV+iMtfHaRPOIAETyjF/QDOp7waGH7x
	aDYkqNIZcckQRcp5tM0UN6nQM1ndWYDw7mmtcUdWS4qaHFIHlYLI8+WK+dJqv9u2gVP24wBw1UEPe
	FGdfFGLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeP-0000000Bewx-1PZJ;
	Mon, 16 Dec 2024 23:37:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeM-0000000Beth-2Njd
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 23:37:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=qnDZGmQXXRBfaYMiHf8RcgZ8w0/B4+1DdFBULwwOb1o=; b=C4BhlY9tosLdIgFYuh5FbO/pL/
	7pNlWsSUXRZ1uO0qtK2mm/dZ0iRLw8BpfekA09Za0yudhv6GpxK5wD9LykP53btHBu8t84yPPLeJc
	hR4RYsxmPxIjQ+gIfBazGmf3BYNpEgmJuQVvPgQiBny2vTiCeytTB1OrzDrwiwjGLf9pLrFOKu+SA
	X3AS/tMDFA29VUlMJdqqTllWAqPSXjP6LTmuQ4oUP6EGhKLRleXwIBhpqe+eXYSsny4nZ/OhwQ95n
	R1pH7h1yp/HOhIEXY6kRe9vqzQKXt/+qGQlM1G3hWAZ3paIT2bnB3dX4UJrUOA8hfayYQ+LdkrPwn
	hPpVuuVw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeB-00000004xiQ-2AqD;
	Mon, 16 Dec 2024 23:37:09 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWV-1XPO;
	Mon, 16 Dec 2024 23:37:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: [PATCH 8/9] x86/kexec: Cope with relocate_kernel() not being at the start of the page
Date: Mon, 16 Dec 2024 23:24:15 +0000
Message-ID: <20241216233704.3208607-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
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

A few places in the kexec control code page make the assumption that the
first instruction of relocate_kernel is at the very start of the page.

To allow for Clang CFI information to be added to relocate_kernel(), as
well as the general principle of removing unwarranted assumptions, fix
them to use the external __relocate_kernel_start symbol that the linker
adds. This means using a separate addq and subq for calculating offsets,
as the assembler can no longer calculate the delta directly for itself
and relocations aren't that versatile.

Turn the jump from relocate_kernel() to identity_mapped() into a real
indirect 'jmp *%rsi' too, while touching it. There was no real reason
for it to be a push+ret in the first place, and adding Clang CFI info
will also give objtool enough visibility to start complaining 'return
with modified stack frame' about it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1996cea909ff..d74798d78263 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -95,11 +95,10 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	lea	PAGE_SIZE(%rsi), %rsp
 
 	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %rsi
-	pushq	%rsi
-	ANNOTATE_UNRET_SAFE
-	ret
-	int3
+	addq	$identity_mapped, %rsi
+	subq	$__relocate_kernel_start, %rsi
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rsi
 SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
@@ -219,16 +218,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 	/* get the re-entry point of the peer system */
 	popq	%rbp
-	leaq	relocate_kernel(%rip), %r8
 	movq	kexec_pa_swap_page(%rip), %r10
 	movq	pa_backup_pages_map(%rip), %rdi
 	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
+
+	/* Find start (and end) of this physical mapping of control page */
+	leaq	(%rip), %r8
+	ANNOTATE_NOENDBR
+	andq	$PAGE_MASK, %r8
 	lea	PAGE_SIZE(%r8), %rsp
 	movq	$1, %r11	/* Ensure preserve_context flag is set */
 	call	swap_pages
 	movq	kexec_va_control_page(%rip), %rax
-	addq	$(virtual_mapped - relocate_kernel), %rax
+	addq	$virtual_mapped, %rax
+	subq	$__relocate_kernel_start, %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
 	ret
-- 
2.47.0


