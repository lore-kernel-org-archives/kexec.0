Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C49-0008TS-KD
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:28:04 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 11/14] x86, boot: use rep movsq to move kernel on 64 bits
Date: Thu,  7 May 2009 15:26:59 -0700
Message-Id: <1241735222-6640-12-git-send-email-hpa@linux.intel.com>
In-Reply-To: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com

From: H. Peter Anvin <hpa@zytor.com>

rep movsq is the architecturally preferred way to move a block of
data.  It isn't the fastest way on all existing CPUs, but it it likely
to be in the future, and perhaps more importantly, we should encourage
the architecturally right thing to do.

This means saving and restoring %rsi around the copy code, which is
easily done by setting up the stack early.  However, we should not
copy .bss (which we are about to zero anyway); we should only copy up
to the *beginning* of .bss (just as on 32 bits.)

This also makes the code quite a bit more similar between 32 and 64 bits.

[ Impact: trivial optimization ]

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/boot/compressed/head_64.S |   41 ++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 2678fdf..8bc8ed8 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -220,18 +220,30 @@ ENTRY(startup_64)
 #endif
 	leaq	z_extract_offset(%rbp), %rbx
 
-/* Copy the compressed kernel to the end of our buffer
+/*
+ * Set up the stack
+ */
+	leaq boot_stack_end(%rbx), %rsp
+
+/*
+ * Zero EFLAGS after setting rsp
+ */
+	pushq	$0
+	popfq
+
+/*
+ * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
-	leaq	_end_before_pgt(%rip), %r8
-	leaq	_end_before_pgt(%rbx), %r9
-	movq	$_end_before_pgt /* - $startup_32 */, %rcx
-1:	subq	$8, %r8
-	subq	$8, %r9
-	movq	0(%r8), %rax
-	movq	%rax, 0(%r9)
-	subq	$8, %rcx
-	jnz	1b
+	pushq	%rsi		/* Kernel structure pointer */
+	leaq	(_bss-8)(%rip), %rsi
+	leaq	(_bss-8)(%rbx), %rdi
+	movq	$_bss /* - $startup_32 */, %rcx
+	shrq	$3, %rcx
+	std
+	rep	movsq
+	cld
+	popq	%rsi
 
 /*
  * Jump to the relocated address.
@@ -243,7 +255,7 @@ ENTRY(startup_64)
 relocated:
 
 /*
- * Clear BSS
+ * Clear BSS (stack is empty at this point)
  */
 	xorl	%eax, %eax
 	leaq    _edata(%rip), %rdi
@@ -253,13 +265,6 @@ relocated:
 	cld
 	rep	stosq
 
-	/* Setup the stack */
-	leaq	boot_stack_end(%rip), %rsp
-
-	/* zero EFLAGS after setting rsp */
-	pushq	$0
-	popfq
-
 /*
  * Do the decompression, and jump to the new kernel..
  */
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
