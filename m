Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr5Jo-0003IS-O5
 for kexec@lists.infradead.org; Thu, 02 Jul 2020 19:56:25 +0000
Subject: [PATCH v2 08/12] ppc64/kexec_file: setup the stack for purgatory
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Fri, 03 Jul 2020 01:26:10 +0530
Message-ID: <159371976272.21555.11015926634292123159.stgit@hbathini.in.ibm.com>
In-Reply-To: <159371956443.21555.18251597651350106920.stgit@hbathini.in.ibm.com>
References: <159371956443.21555.18251597651350106920.stgit@hbathini.in.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Mimi Zohar <zohar@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

To avoid any weird errors, the purgatory should run with its own
stack. Set one up by adding the stack buffer to .data section of
the purgatory. Also, setup opal base & entry values in r8 & r9
registers to help early OPAL debugging.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* Setting up opal base & entry values in r8 & r9 for early OPAL debug.


 arch/powerpc/include/asm/kexec.h       |    4 ++++
 arch/powerpc/kexec/file_load_64.c      |   29 +++++++++++++++++++++++++++++
 arch/powerpc/purgatory/trampoline_64.S |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index bf47a01..e78cd0a 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -45,6 +45,10 @@
 #define KEXEC_ARCH KEXEC_ARCH_PPC
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+#define KEXEC_PURGATORY_STACK_SIZE	16384	/* 16KB stack size */
+#endif
+
 #define KEXEC_STATE_NONE 0
 #define KEXEC_STATE_IRQS_OFF 1
 #define KEXEC_STATE_REAL_MODE 2
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index adca9c0..f06dcf1 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -873,6 +873,8 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
 			  const void *fdt, unsigned long kernel_load_addr,
 			  unsigned long fdt_load_addr)
 {
+	struct device_node *dn;
+	void *stack_buf;
 	uint64_t val;
 	int ret;
 
@@ -896,10 +898,37 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
 			goto out;
 	}
 
+	/* Setup the stack top */
+	stack_buf = kexec_purgatory_get_symbol_addr(image, "stack_buf");
+	if (!stack_buf)
+		goto out;
+
+	val = (u64)stack_buf + KEXEC_PURGATORY_STACK_SIZE;
+	ret = kexec_purgatory_get_set_symbol(image, "stack", &val, sizeof(val),
+					     false);
+	if (ret)
+		goto out;
+
 	/* Setup the TOC pointer */
 	val = get_toc_ptr(image->purgatory_info.ehdr);
 	ret = kexec_purgatory_get_set_symbol(image, "my_toc", &val, sizeof(val),
 					     false);
+	if (ret)
+		goto out;
+
+	/* Setup OPAL base & entry values */
+	dn = of_find_node_by_path("/ibm,opal");
+	if (dn) {
+		of_property_read_u64(dn, "opal-base-address", &val);
+		ret = kexec_purgatory_get_set_symbol(image, "opal_base", &val,
+						     sizeof(val), false);
+		if (ret)
+			goto out;
+
+		of_property_read_u64(dn, "opal-entry-address", &val);
+		ret = kexec_purgatory_get_set_symbol(image, "opal_entry", &val,
+						     sizeof(val), false);
+	}
 out:
 	if (ret)
 		pr_err("Failed to setup purgatory symbols");
diff --git a/arch/powerpc/purgatory/trampoline_64.S b/arch/powerpc/purgatory/trampoline_64.S
index 7b4a5f7..83e93b7 100644
--- a/arch/powerpc/purgatory/trampoline_64.S
+++ b/arch/powerpc/purgatory/trampoline_64.S
@@ -9,6 +9,7 @@
  * Copyright (C) 2013, Anton Blanchard, IBM Corporation
  */
 
+#include <asm/kexec.h>
 #include <asm/asm-compat.h>
 
 	.machine ppc64
@@ -53,6 +54,8 @@ master:
 
 	ld	%r2,(my_toc - 0b)(%r18)		/* setup toc */
 
+	ld	%r1,(stack - 0b)(%r18)		/* setup stack */
+
 	/* load device-tree address */
 	ld	%r3, (dt_offset - 0b)(%r18)
 	mr	%r16,%r3	/* save dt address in reg16 */
@@ -63,6 +66,11 @@ master:
 	li	%r4,28
 	STWX_BE	%r17,%r3,%r4	/* Store my cpu as __be32 at byte 28 */
 1:
+
+	/* Load opal base and entry values in r8 & r9 respectively */
+	ld	%r8,(opal_base - 0b)(%r18)
+	ld	%r9,(opal_entry - 0b)(%r18)
+
 	/* load the kernel address */
 	ld	%r4,(kernel - 0b)(%r18)
 
@@ -111,6 +119,24 @@ my_toc:
 	.8byte  0x0
 	.size my_toc, . - my_toc
 
+	.balign 8
+	.globl stack
+stack:
+	.8byte  0x0
+	.size stack, . - stack
+
+	.balign 8
+	.globl opal_base
+opal_base:
+	.8byte  0x0
+	.size opal_base, . - opal_base
+
+	.balign 8
+	.globl opal_entry
+opal_entry:
+	.8byte  0x0
+	.size opal_entry, . - opal_entry
+
 	.data
 	.balign 8
 .globl purgatory_sha256_digest
@@ -123,3 +149,9 @@ purgatory_sha256_digest:
 purgatory_sha_regions:
 	.skip	8 * 2 * 16
 	.size purgatory_sha_regions, . - purgatory_sha_regions
+
+	.balign 8
+.globl stack_buf
+stack_buf:
+	.skip	KEXEC_PURGATORY_STACK_SIZE
+	.size stack_buf, . - stack_buf


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
