Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C3i-0008RP-MM
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:27:25 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 04/14] x86,
	boot: unify use LOAD_PHYSICAL_ADDR and LOAD_PHYSICAL_ALIGN
Date: Thu,  7 May 2009 15:26:52 -0700
Message-Id: <1241735222-6640-5-git-send-email-hpa@linux.intel.com>
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

Instead of using CONFIG_PHYSICAL_ALIGN and CONFIG_PHYSICAL_START
directly, use LOAD_PHYSICAL_ALIGN (CONFIG_PHYSICAL_ALIGN or the
smallest valid number, whichever is greater) and LOAD_PHYSICAL_ADDR
(CONFIG_PHYSICAL_START rounded up to the nearest alignment datum) for
both 32 and 64-bit mode.

[ Impact: Avoids problems in case of kernel misconfiguration ]

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/boot/compressed/head_32.S |    4 ++--
 arch/x86/boot/compressed/head_64.S |   21 +++++++++------------
 arch/x86/boot/header.S             |    2 +-
 arch/x86/include/asm/boot.h        |   13 +++++++++++--
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 31fc6dc..2d7cd0f 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -70,8 +70,8 @@ ENTRY(startup_32)
 	jbe 1f
 	movl %eax, %ebx
 1:
-	addl $(CONFIG_PHYSICAL_ALIGN - 1), %ebx
-	andl $(~(CONFIG_PHYSICAL_ALIGN - 1)), %ebx
+	addl $(LOAD_PHYSICAL_ALIGN - 1), %ebx
+	andl $(~(LOAD_PHYSICAL_ALIGN - 1)), %ebx
 #else
 	movl $LOAD_PHYSICAL_ADDR, %ebx
 #endif
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f4ddd02..201af02 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -22,7 +22,6 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/pgtable_types.h>
-#include <asm/page_types.h>
 #include <asm/boot.h>
 #include <asm/msr.h>
 #include <asm/processor-flags.h>
@@ -72,19 +71,17 @@ ENTRY(startup_32)
  * contains the address where we should move the kernel image temporarily
  * for safe in-place decompression.
  */
-ALIGN_MASK	= (CONFIG_PHYSICAL_ALIGN-1) | (PMD_PAGE_SIZE-1)
-
 #ifdef CONFIG_RELOCATABLE
-	movl	$CONFIG_PHYSICAL_START, %eax
+	movl	$LOAD_PHYSICAL_ADDR, %eax
 	movl	%ebp, %ebx
-	addl	$ALIGN_MASK, %ebx
-	andl	$~ALIGN_MASK, %ebx
+	addl	$(LOAD_PHYSICAL_ALIGN - 1), %ebx
+	andl	$~(LOAD_PHYSICAL_ALIGN - 1), %ebx
 	cmpl	%ebx, %eax
 	jbe	1f
 	movl	%eax, %ebx
 1:
 #else
-	movl	$CONFIG_PHYSICAL_START, %ebx
+	movl	$LOAD_PHYSICAL_ADDR, %ebx
 #endif
 
 	/* Replace the compressed data size with the uncompressed size */
@@ -216,21 +213,21 @@ ENTRY(startup_64)
 	 *
 	 * If it is a relocatable kernel then decompress and run the kernel
 	 * from load address aligned to 2MB addr, otherwise decompress and
-	 * run the kernel from CONFIG_PHYSICAL_START
+	 * run the kernel from LOAD_PHYSICAL_ADDR
 	 */
 
 	/* Start with the delta to where the kernel will run at. */
 #ifdef CONFIG_RELOCATABLE
 	leaq	startup_32(%rip) /* - $startup_32 */, %rbp
-	movq	$CONFIG_PHYSICAL_START, %rax
-	addq	$ALIGN_MASK, %rbp
-	andq	$~ALIGN_MASK, %rbp
+	movq	$LOAD_PHYSICAL_ADDR, %rax
+	addq	$(LOAD_PHYSICAL_ALIGN - 1), %rbp
+	andq	$~(LOAD_PHYSICAL_ALIGN - 1), %rbp
 	cmpq	%rbp, %rax
 	jbe	1f
 	movq	%rax, %rbp
 1:
 #else
-	movq	$CONFIG_PHYSICAL_START, %rbp
+	movq	$LOAD_PHYSICAL_ADDR, %rbp
 #endif
 	movq	%rbp, %rbx
 
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 5d84d1c..cfd3bc4 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -192,7 +192,7 @@ ramdisk_max:	.long 0x7fffffff
 					# but leave it at 2 GB to avoid
 					# possible bootloader bugs.
 
-kernel_alignment:  .long CONFIG_PHYSICAL_ALIGN	#physical addr alignment
+kernel_alignment:  .long LOAD_PHYSICAL_ALIGN	#physical addr alignment
 						#required for protected mode
 						#kernel
 #ifdef CONFIG_RELOCATABLE
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 6ba23dd..641debb 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -8,10 +8,19 @@
 
 #ifdef __KERNEL__
 
+#include <asm/page_types.h>
+
+/* Permitted physical alignment of the kernel */
+#if defined(CONFIG_X86_64) && CONFIG_PHYSICAL_ALIGN < PMD_PAGE_SIZE
+#define LOAD_PHYSICAL_ALIGN	PMD_PAGE_SIZE
+#else
+#define LOAD_PHYSICAL_ALIGN	CONFIG_PHYSICAL_ALIGN
+#endif
+
 /* Physical address where kernel should be loaded. */
 #define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
-				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
-				& ~(CONFIG_PHYSICAL_ALIGN - 1))
+				+ (LOAD_PHYSICAL_ALIGN - 1)) \
+				& ~(LOAD_PHYSICAL_ALIGN - 1))
 
 #ifdef CONFIG_KERNEL_BZIP2
 #define BOOT_HEAP_SIZE             0x400000
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
