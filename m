Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on0088.outbound.protection.outlook.com
 ([104.47.38.88] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1db7i4-0007kC-GZ
 for kexec@lists.infradead.org; Fri, 28 Jul 2017 16:01:54 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 1/2] x86/mm,
 kexec: Fix memory corruption with SME on successive kexecs
Date: Fri, 28 Jul 2017 11:01:16 -0500
Message-Id: <e7fb8610af3a93e8f8ae6f214cd9249adc0df2b4.1501186516.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1501186516.git.thomas.lendacky@amd.com>
References: <cover.1501186516.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

After issuing successive kexecs it was found that the SHA hash failed
verification when booting the kexec'd kernel.  When SME is enabled, the
change from using pages that were marked encrypted to now being marked as
not encrypted (through new identify mapped page tables) results in memory
corruption if there are any cache entries for the previously encrypted
pages. This is because separate cache entries can exist for the same
physical location but tagged both with and without the encryption bit.

To prevent this, issue a wbinvd if SME is active before copying the pages
from the source location to the destination location to clear any possible
cache entry conflicts.

Cc: <kexec@lists.infradead.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/kexec.h         |  3 ++-
 arch/x86/kernel/machine_kexec_64.c   |  3 ++-
 arch/x86/kernel/relocate_kernel_64.S | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index e8183ac..942c1f4 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -147,7 +147,8 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
-		unsigned int preserve_context);
+		unsigned int preserve_context,
+		unsigned int sme_active);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9cf8daa..1f790cf 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -335,7 +335,8 @@ void machine_kexec(struct kimage *image)
 	image->start = relocate_kernel((unsigned long)image->head,
 				       (unsigned long)page_list,
 				       image->start,
-				       image->preserve_context);
+				       image->preserve_context,
+				       sme_active());
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 98111b3..307d3ba 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -47,6 +47,7 @@ relocate_kernel:
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
+	 * %r8  sme_active
 	 */
 
 	/* Save the CPU context, used for jumping back */
@@ -71,6 +72,9 @@ relocate_kernel:
 	pushq $0
 	popfq
 
+	/* Save SME active flag */
+	movq	%r8, %r12
+
 	/*
 	 * get physical address of control page now
 	 * this is impossible after page table switch
@@ -132,6 +136,16 @@ identity_mapped:
 	/* Flush the TLB (needed?) */
 	movq	%r9, %cr3
 
+	/*
+	 * If SME is active, there could be old encrypted cache line
+	 * entries that will conflict with the now unencrypted memory
+	 * used by kexec. Flush the caches before copying the kernel.
+	 */
+	testq	%r12, %r12
+	jz 1f
+	wbinvd
+1:
+
 	movq	%rcx, %r11
 	call	swap_pages
 
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
