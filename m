Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B22BE77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CgoaEkYIZX+dJ3COQN6/N0SHLTDEo7W5MwBROBJCJy8=; b=N96hGFiX0l4aMfVENcV7DccTfy
	fJqIONE48Ccqm1uK2Y8Ddwz2unIo1QbM/hykS5+ybHlvGcxIcjChZXt1NsZR9vmLc6ZGCM2NJrmFz
	m/zXA5e5BL5fy6VLGNtswri+ZqJIrZNZ3usCSMT1SW7Eg4+i/znu1hx9x71CYOL9A1a9WsjmzoFgN
	/MgE7GEpKt2XOXm/As5Le9ZwC4t/Wci52jXog/WSiJOWPSALlZGoa58Rd5utgd6vfVLJ+CFTqyHDJ
	d0r67tkuob1RPqlVuFt7N1Hd9ETZ7j0qDrmH+LHYiKsmIUDyxrVbWU+FiP5cdfnMnzg6U9k2Mxbxi
	FZwfPijA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtDr-0000000CAzT-41WW;
	Thu, 09 Jan 2025 14:09:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCf-0000000CAe3-1GCi
	for kexec@bombadil.infradead.org;
	Thu, 09 Jan 2025 14:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=CgoaEkYIZX+dJ3COQN6/N0SHLTDEo7W5MwBROBJCJy8=; b=i9Jh/0QT/Ac0mjoxeiCq+bqKCM
	tdInaXsmQCUbQO/dA5zfAn4hyLKsMHi49QgNt9SsUsBJhKnFxEfEXlDcuaELkdeu9IXPT6Zz/XSOl
	RJlSOJOPfiN0Lul3Ay7LpweJRuCJSYq3lmEqFaiBouvLrZnD8aQlfJFSumItXZUmvP5BN2sLrwimW
	UMphoMTA7yu4R82OORrSb+LHC68gi7F5I2hmEeiT+GP8O8JmooJoy2YgAw/pLiLNsAzFamWvOrD8c
	ua/6X9kJNXIk0NiFToIFsmOEc43Ne22UbTxNRNSnnnjpfeK3Zpfz0N2H0u2fRpuIAMtpmoL9Ou8iR
	pYSaA3CA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCZ-00000006IQN-3eVv;
	Thu, 09 Jan 2025 14:07:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCY-0000000Bx6V-3oum;
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
Subject: [PATCH v2 8/9] x86/kexec: Cope with relocate_kernel() not being at the start of the page
Date: Thu,  9 Jan 2025 14:04:20 +0000
Message-ID: <20250109140757.2841269-9-dwmw2@infradead.org>
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

A few places in the kexec control code page make the assumption that the
first instruction of relocate_kernel is at the very start of the page.

To allow for Clang CFI information to be added to relocate_kernel(), as
well as the general principle of removing unwarranted assumptions, fix
them to use the external __relocate_kernel_start symbol that the linker
adds. This means using a separate addq and subq for calculating offsets,
as the assembler can no longer calculate the delta directly for itself
and relocations aren't that versatile. But we can at least use values
relative to a local label to avoid absolute relocations.

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
index 14ed40b7f322..af2cd06ff318 100644
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
+0:	addq	$identity_mapped - 0b, %rsi
+	subq	$__relocate_kernel_start - 0b, %rsi
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
 	movl	$1, %r11d	/* Ensure preserve_context flag is set */
 	call	swap_pages
 	movq	kexec_va_control_page(%rip), %rax
-	addq	$(virtual_mapped - relocate_kernel), %rax
+0:	addq	$virtual_mapped - 0b, %rax
+	subq	$__relocate_kernel_start - 0b, %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
 	ret
-- 
2.47.0


