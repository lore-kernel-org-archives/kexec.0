Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpG1z-0005W5-FT
 for kexec@lists.infradead.org; Mon, 04 May 2015 13:03:33 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC 1/3] arm64: Add enable/disable d-cache support for
 purgatory
Date: Mon,  4 May 2015 18:32:49 +0530
Message-Id: <8b40614f4c1925fe94f274dfc69d1a63537fe399.1430742915.git.panand@redhat.com>
In-Reply-To: <cover.1430742915.git.panand@redhat.com>
References: <cover.1430742915.git.panand@redhat.com>
In-Reply-To: <cover.1430742915.git.panand@redhat.com>
References: <cover.1430742915.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: geoff@infradead.org
Cc: Pratyush Anand <panand@redhat.com>, takahiro.akashi@linaro.org, kexec@lists.infradead.org

This patch adds support to enable/disable d-cache, which can be used for
faster purgatory sha256 verification.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 purgatory/arch/arm64/Makefile |   1 +
 purgatory/arch/arm64/cache.S  | 222 ++++++++++++++++++++++++++++++++++++++++++
 purgatory/arch/arm64/cache.h  |  42 ++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 purgatory/arch/arm64/cache.S
 create mode 100644 purgatory/arch/arm64/cache.h

diff --git a/purgatory/arch/arm64/Makefile b/purgatory/arch/arm64/Makefile
index 5d35161fc5f4..04fef16476fb 100644
--- a/purgatory/arch/arm64/Makefile
+++ b/purgatory/arch/arm64/Makefile
@@ -12,6 +12,7 @@ arm64_PURGATORY_EXTRA_CFLAGS = \
 
 arm64_PURGATORY_SRCS += \
 	purgatory/arch/arm64/entry.S \
+	purgatory/arch/arm64/cache.S \
 	purgatory/arch/arm64/purgatory-arm64.c
 
 dist += \
diff --git a/purgatory/arch/arm64/cache.S b/purgatory/arch/arm64/cache.S
new file mode 100644
index 000000000000..6bbdeacdab47
--- /dev/null
+++ b/purgatory/arch/arm64/cache.S
@@ -0,0 +1,222 @@
+/*
+ * Cache maintenance
+ * Some of the routine has been copied from Linux Kernel, therefore
+ * copying the license as well.
+ *
+ * Copyright (C) 2001 Deep Blue Solutions Ltd.
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Pratyush Anand <panand@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "cache.h"
+
+/*
+ * dcache_line_size - get the minimum D-cache line size from the CTR register.
+ */
+	.macro	dcache_line_size, reg, tmp
+	mrs	\tmp, ctr_el0			// read CTR
+	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
+	mov	\reg, #4			// bytes per word
+	lsl	\reg, \reg, \tmp		// actual cache line size
+	.endm
+
+/*
+ *	__inval_cache_range(start, end)
+ *	- start	- start address of region
+ *	- end	- end address of region
+ */
+__inval_cache_range:
+	dcache_line_size x2, x3
+	sub	x3, x2, #1
+	tst	x1, x3				// end cache line aligned?
+	bic	x1, x1, x3
+	b.eq	1f
+	dc	civac, x1			// clean & invalidate D / U line
+1:	tst	x0, x3				// start cache line aligned?
+	bic	x0, x0, x3
+	b.eq	2f
+	dc	civac, x0			// clean & invalidate D / U line
+	b	3f
+2:	dc	ivac, x0			// invalidate D / U line
+3:	add	x0, x0, x2
+	cmp	x0, x1
+	b.lo	2b
+	dsb	sy
+	ret
+/*
+ *	__flush_dcache_range(start, end)
+ *	- start	- start address of region
+ *	- end	- end address of region
+ *
+ */
+__flush_dcache_range:
+	dcache_line_size x2, x3
+	sub	x3, x2, #1
+	bic	x0, x0, x3
+1:	dc	civac, x0			// clean & invalidate D line / unified line
+	add	x0, x0, x2
+	cmp	x0, x1
+	b.lo	1b
+	dsb	sy
+	ret
+
+/*
+ *	enable_dcache(start, end, page_table)
+ *	- start	- start address of ram
+ *	- end	- end address of ram
+ *	- page_table - base of page table
+ */
+.globl enable_dcache
+enable_dcache:
+	stp	x6, x7, [sp,#-16]!
+	stp	x16, x17, [sp,#-16]!
+	stp	x18, x19, [sp,#-16]!
+
+	/* save args */
+	mov x16, x0	/* first segment start */
+	mov x17, x1	/* last segment end */
+	mov x18, x2 	/* page table */
+	mov x19, x30	/* save ret addr */
+
+	/*
+	 * Invalidate the page tables to avoid potential
+	 * dirty cache lines being evicted.
+	 */
+	mov x0, x18
+	add x1, x0, #PAGE_TABLE_SIZE
+	bl __inval_cache_range
+
+	/*
+	 * Clear the page tables.
+	 */
+	mov x0, x18
+	add x1, x0, #PAGE_TABLE_SIZE
+1:	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	cmp	x0, x1
+	b.lo	1b
+
+	/*
+	 * Create the identity mapping.
+	 */
+	ldr	x6, =SECTION_SHIFT
+	ldr	x7, =MM_MMUFLAGS
+	lsr	x0, x16, x6	//first index
+	lsr	x1, x17, x6	//last index
+
+next_sect:
+	lsl	x2, x0, x6	//section
+	orr	x2, x2, x7
+	str	x2, [x18, x0, lsl #3]
+	add	x0, x0, #1
+	cmp	x0, x1
+	b.ls	next_sect
+
+	/*
+	 * Since the page tables have been populated with non-cacheable
+	 * accesses (MMU disabled), invalidate the idmap page
+	 * tables again to remove any speculatively loaded cache lines.
+	 */
+	mov x0, x18
+	add x1, x0, #PAGE_TABLE_SIZE
+	bl __inval_cache_range
+
+	mrs 	x0, CurrentEL
+	cmp	x0, #12	//EL3
+	b.eq	set_el3
+	cmp	x0, #8	//EL2
+	b.eq	set_el2
+	cmp	x0, #4	//EL1
+	b.eq	set_el1
+	b	done_enable
+
+set_el1:
+	msr	ttbr0_el1, x18
+	ldr	x0, =TCR_FLAGS
+	orr	x0, x0, #TCR_EL1_IPS_BITS
+	msr	tcr_el1, x0
+	ldr	x0, =MEMORY_ATTRIBUTES
+	msr	mair_el1, x0
+	mrs	x0, sctlr_el1
+	orr	x0, x0, #CR_M
+	orr	x0, x0, #CR_C
+	msr	sctlr_el1, x0
+	b	done_enable
+set_el2:
+	msr	ttbr0_el2, x18
+	ldr	x0, =TCR_FLAGS
+	orr	x0, x0, #TCR_EL2_IPS_BITS
+	msr	tcr_el2, x0
+	ldr	x0, =MEMORY_ATTRIBUTES
+	msr	mair_el2, x0
+	mrs	x0, sctlr_el2
+	orr	x0, x0, #CR_M
+	orr	x0, x0, #CR_C
+	msr	sctlr_el2, x0
+	b	done_enable
+set_el3:
+	msr	ttbr0_el3, x18
+	ldr	x0, =TCR_FLAGS
+	orr	x0, x0, #TCR_EL3_IPS_BITS
+	msr	tcr_el3, x0
+	ldr	x0, =MEMORY_ATTRIBUTES
+	msr	mair_el3, x0
+	mrs	x0, sctlr_el3
+	orr	x0, x0, #CR_M
+	orr	x0, x0, #CR_C
+	msr	sctlr_el3, x0
+done_enable:
+
+	mov	x30, x19
+	ldp	x18, x19, [sp],#16
+	ldp	x16, x17, [sp],#16
+	ldp	x6, x7, [sp],#16
+
+	ret
+
+.globl disable_dcache
+disable_dcache:
+	stp	x5, x30, [sp,#-16]!
+	mrs 	x5, CurrentEL
+	cmp	x5, #12	//EL3
+	b.eq	disable_el3
+	cmp	x5, #8	//EL2
+	b.eq	disable_el2
+	cmp	x5, #4	//EL1
+	b.eq	disable_el1
+	b	done_disable
+disable_el3:
+	mrs	x5, sctlr_el3
+	bic	x5, x2, #CR_M
+	bic	x5, x2, #CR_C
+	msr	sctlr_el3, x5
+	b	done_disable
+disable_el2:
+	mrs	x5, sctlr_el2
+	bic	x5, x2, #CR_M
+	bic	x5, x2, #CR_C
+	msr	sctlr_el2, x5
+	b	done_disable
+disable_el1:
+	mrs	x5, sctlr_el1
+	bic	x5, x2, #CR_M
+	bic	x5, x2, #CR_C
+	msr	sctlr_el1, x5
+done_disable:
+	bl __flush_dcache_range
+	ldp	x5, x30, [sp],#16
+	ret
diff --git a/purgatory/arch/arm64/cache.h b/purgatory/arch/arm64/cache.h
new file mode 100644
index 000000000000..3ca1d7f9a5ca
--- /dev/null
+++ b/purgatory/arch/arm64/cache.h
@@ -0,0 +1,42 @@
+#ifndef	__CACHE_H__
+#define __CACHE_H__
+
+#define VA_BITS			42
+#define SECTION_SHIFT		29
+#define PAGE_TABLE_SIZE		(1 << (VA_BITS - SECTION_SHIFT + 3))
+
+#define TCR_TG0_64K 		(1 << 14)
+#define TCR_SHARED_NON		(0 << 12)
+#define TCR_ORGN_WBWA		(1 << 10)
+#define TCR_IRGN_WBWA		(1 << 8)
+#define TCR_T0SZ(x)		((64 - (x)) << 0)
+#define TCR_EL1_IPS_BITS	(3 << 32) /* 42 bits physical address */
+#define TCR_EL2_IPS_BITS	(3 << 16) /* 42 bits physical address */
+#define TCR_EL3_IPS_BITS	(3 << 16) /* 42 bits physical address */
+
+#define TCR_FLAGS (TCR_TG0_64K | TCR_SHARED_NON | TCR_ORGN_WBWA | \
+		TCR_IRGN_WBWA | TCR_T0SZ(VA_BITS))
+
+#define MT_DEVICE_NGNRNE	0
+#define MT_DEVICE_NGNRE		1
+#define MT_DEVICE_GRE		2
+#define MT_NORMAL_NC		3
+#define MT_NORMAL		4
+
+#define MEMORY_ATTRIBUTES	((0x00 << (MT_DEVICE_NGNRNE*8)) | \
+				(0x04 << (MT_DEVICE_NGNRE*8)) | \
+				(0x0c << (MT_DEVICE_GRE*8)) | \
+				(0x44 << (MT_NORMAL_NC*8)) | \
+				(0xff << (MT_NORMAL*8)))
+
+#define CR_M			(1 << 0)	/* MMU enable */
+#define CR_C			(1 << 2)	/* Dcache enable */
+
+
+#define PMD_TYPE_SECT		(1 << 0)
+#define PMD_SECT_AF		(1 << 10)
+#define PMD_ATTRINDX(t)		((t) << 2)
+#define PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF)
+#define MM_MMUFLAGS	PMD_ATTRINDX(MT_NORMAL) | PMD_FLAGS
+
+#endif
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
