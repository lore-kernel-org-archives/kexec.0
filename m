Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3513E810CF
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tInUdQ+ai+zLXZZb2VSVsldGW7SDRHU/e5522alo93E=; b=VsQBn215qPDfl+
	QiGwx1JjfRH9VeO/7tJ2Rqkw3EwgMsw5MjLo/+gIyK6qH7R7z2GglKsy1sNONGFoamjkd/LPQCIZF
	cbSSaoGHRGHqDDOWqYU6ERw2XmqFD/MDZgBg82wJBB7oskD+ZApAlXu2dAYAicuDd9u/W1lh9EJry
	oZjK3uHnpyi7vHKTEDn3OAG9HGliqZXBEU2tkIVi5w9D8gXy6SGWn96/erGHO7iEtzNcLRykVNpqK
	22BgdmfajBAEUl0HYClPCEZVR1OlmAJ8vGiOrjscQ7ggABS5mM85W8+2G7lvTquyxVF8rn2ZVMMNy
	XgJ/wzy2h9DlgwykBBLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSa5-000nMh-1I;
	Wed, 27 Sep 2023 11:19:49 +0000
Received: from bg4.exmail.qq.com ([43.154.221.58])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSa1-000nMB-1V
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 11:19:47 +0000
X-QQ-mid: bizesmtp83t1695813580txd96d2p
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Sep 2023 19:19:39 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: Up0ovoMzSFnpLDzlXs4vlM/ri16p6OYTjNc2k/FyNaZSj/btIpWpq4inb4En+
	cOX3oruzI6prIlbYFxLPnSteSalcZk/GJhfyOMjd/HS0U7l+3PVT/4h9LsDOZr5mL6Vatl3
	DpGFs0nzM8r16lTjKoh1hLpgU5mO6+AyEf9vmA+ciVCj5SWvA+g+XifRniqbRx1nBR38q29
	dicJVO/3bN408OE3umg9QGVSCIMMzVfXeB4KSjqMGLCKdbHBjX0F+EK3zaKMfUrIgcqpaL9
	QQIO4KcJ+cbhvoiRPhr/yWGrFvMsESwDDjO3+N3+FTMC+8EmJkXyx8yLbbCSD+VeJEKvErr
	sXcf4QN+ZSrmi11IrtDv1JryEx1fWuJeii0STZCxPKHq/nDc1s=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16779920767971154200
From: Song Shuai <songshuaishuai@tinylab.org>
To: kexec@lists.infradead.org
Cc: Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH makedumpfile 1/2] Add riscv64 support
Date: Wed, 27 Sep 2023 19:18:21 +0800
Message-Id: <20230927111822.180630-2-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230927111822.180630-1-songshuaishuai@tinylab.org>
References: <20230927111822.180630-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_041945_831159_AF6CE321 
X-CRM114-Status: GOOD (  22.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This patch adds support for riscv64 in makedumpfile.
It implements the "vtop" for kenrel memory regions
and supports Sv39/Sv48/Sv57 page modes for RV64.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 Makefile       |   2 +-
 arch/riscv64.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |  14 ++++
 makedumpfile.h | 107 ++++++++++++++++++++++++
 4 files changed, 341 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv64.c

diff --git a/Makefile b/Makefile
index 0608035..1d0644c 100644
--- a/Makefile
+++ b/Makefile
@@ -47,7 +47,7 @@ endif
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
 SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
-SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c
+SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
 
 LIBS = -ldw -lbz2 -ldl -lelf -lz
diff --git a/arch/riscv64.c b/arch/riscv64.c
new file mode 100644
index 0000000..b4101e7
--- /dev/null
+++ b/arch/riscv64.c
@@ -0,0 +1,219 @@
+/*
+ * riscv64.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifdef __riscv64__
+
+#include "../print_info.h"
+#include "../elf_info.h"
+#include "../makedumpfile.h"
+
+int
+get_phys_base_riscv64(void)
+{
+	if (NUMBER(phys_ram_base) != NOT_FOUND_NUMBER)
+		info->phys_base = NUMBER(phys_ram_base);
+	else
+		/* In case that you are using qemu rv64 env */
+		info->phys_base = 0x80200000;
+
+	DEBUG_MSG("phys_base    : %lx\n", info->phys_base);
+	return TRUE;
+}
+
+int
+get_machdep_info_riscv64(void)
+{
+
+	if(NUMBER(va_bits) == NOT_FOUND_NUMBER ||  NUMBER(page_offset) == NOT_FOUND_NUMBER ||
+	   NUMBER(vmalloc_start) == NOT_FOUND_NUMBER || NUMBER(vmalloc_end) == NOT_FOUND_NUMBER ||
+	   NUMBER(vmemmap_start) == NOT_FOUND_NUMBER ||  NUMBER(vmemmap_end) == NOT_FOUND_NUMBER ||
+	   NUMBER(modules_vaddr) == NOT_FOUND_NUMBER ||  NUMBER(modules_end) == NOT_FOUND_NUMBER ||
+	   NUMBER(kernel_link_addr) == NOT_FOUND_NUMBER || NUMBER(va_kernel_pa_offset) == NOT_FOUND_NUMBER)
+		return FALSE;
+
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+	else
+		info->max_physmem_bits = _MAX_PHYSMEM_BITS;
+
+	if (NUMBER(SECTION_SIZE_BITS) != NOT_FOUND_NUMBER)
+		info->section_size_bits = NUMBER(SECTION_SIZE_BITS);
+	else
+		info->section_size_bits = _SECTION_SIZE_BITS;
+
+	info->page_offset = NUMBER(page_offset);
+
+	DEBUG_MSG("va_bits    : %ld\n", NUMBER(va_bits));
+	DEBUG_MSG("page_offset    : %lx\n", NUMBER(page_offset));
+	DEBUG_MSG("vmalloc_start    : %lx\n", NUMBER(vmalloc_start));
+	DEBUG_MSG("vmalloc_end    : %lx\n", NUMBER(vmalloc_end));
+	DEBUG_MSG("vmemmap_start    : %lx\n", NUMBER(vmemmap_start));
+	DEBUG_MSG("vmemmap_end    : %lx\n", NUMBER(vmemmap_end));
+	DEBUG_MSG("modules_vaddr    : %lx\n", NUMBER(modules_vaddr));
+	DEBUG_MSG("modules_end    : %lx\n", NUMBER(modules_end));
+	DEBUG_MSG("kernel_link_addr    : %lx\n", NUMBER(kernel_link_addr));
+	DEBUG_MSG("va_kernel_pa_offset    : %lx\n", NUMBER(va_kernel_pa_offset));
+
+	return TRUE;
+}
+
+/*
+ * For direct memory mapping
+ */
+
+#define VTOP(X) ({ 									\
+	ulong _X = X;									\
+	(_X) >= NUMBER(kernel_link_addr) ? ((_X) - (NUMBER(va_kernel_pa_offset))):	\
+	((_X) - PAGE_OFFSET + (info->phys_base));					\
+	})
+
+static unsigned long long
+vtop_riscv64(pgd_t * pgd, unsigned long vaddr, long va_bits)
+{
+	unsigned long long paddr = NOT_PADDR;
+	pgd_t *pgda;
+	p4d_t *p4da;
+	pud_t *puda;
+	pmd_t *pmda;
+	pte_t *ptea;
+	ulong pt_val, pt_phys;
+
+#define pgd_index(X) ((va_bits == VA_BITS_SV57) ? pgd_index_l5(X) : 	\
+	((va_bits == VA_BITS_SV48) ? pgd_index_l4(X) : pgd_index_l3(X)))
+
+	/* PGD */
+	pgda = (pgd_t *)(pgd) + pgd_index(vaddr);
+	if (!readmem(PADDR, (unsigned long long)pgda, &pt_val, sizeof(pt_val))) {
+		ERRMSG("Can't read pgd\n");
+		goto invalid;
+	}
+
+	pt_val &= PTE_PFN_PROT_MASK;
+
+	if (!(pt_val & _PAGE_PRESENT)) {
+		ERRMSG("Can't get a valid pgd.\n");
+		goto invalid;
+	}
+
+	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
+
+	if(pt_val & _PAGE_LEAF)
+		goto out;
+
+	if(va_bits == VA_BITS_SV57)
+		goto p4d;
+	else if (va_bits == VA_BITS_SV48)
+		goto pud;
+	else
+		goto pmd;
+p4d:
+	/* P4D */
+	p4da = (p4d_t *)(pt_phys) + p4d_index(vaddr);
+	if (!readmem(PADDR, (unsigned long long)p4da, &pt_val, sizeof(pt_val))) {
+		ERRMSG("Can't read p4d\n");
+		goto invalid;
+	}
+
+	pt_val &= PTE_PFN_PROT_MASK;
+
+	if (!(pt_val & _PAGE_PRESENT)) {
+		ERRMSG("Can't get a valid p4d.\n");
+		goto invalid;
+	}
+
+	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
+
+	if(pt_val & _PAGE_LEAF)
+		goto out;
+pud:
+	/* PUD */
+	puda = (pud_t *)(pt_phys) + pud_index(vaddr);
+	if (!readmem(PADDR, (unsigned long long)puda, &pt_val, sizeof(pt_val))) {
+		ERRMSG("Can't read pud\n");
+		goto invalid;
+	}
+
+	pt_val &= PTE_PFN_PROT_MASK;
+
+	if (!(pt_val & _PAGE_PRESENT)) {
+		ERRMSG("Can't get a valid pud.\n");
+		goto invalid;
+	}
+
+	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
+
+	if(pt_val & _PAGE_LEAF)
+		goto out;
+pmd:
+	/* PMD */
+	pmda = (pmd_t *)(pt_phys) + pmd_index(vaddr);
+	if (!readmem(PADDR, (unsigned long long)pmda, &pt_val, sizeof(pt_val))) {
+		ERRMSG("Can't read pmd\n");
+		goto invalid;
+	}
+
+	pt_val &= PTE_PFN_PROT_MASK;
+
+	if (!(pt_val & _PAGE_PRESENT)) {
+		ERRMSG("Can't get a valid pmd.\n");
+		goto invalid;
+	}
+
+	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
+
+	if(pt_val & _PAGE_LEAF)
+		goto out;
+
+	/* PTE */
+	ptea = (pte_t *)(pt_phys) + pte_index(vaddr);
+	if (!readmem(PADDR, (unsigned long long)ptea, &pt_val, sizeof(pt_val))) {
+		ERRMSG("Can't read pte\n");
+		goto invalid;
+	}
+
+	pt_val &= PTE_PFN_PROT_MASK;
+
+	if (!(pt_val & _PAGE_PRESENT)) {
+		ERRMSG("Can't get a valid pte.\n");
+		goto invalid;
+	}
+
+	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
+
+out:
+	paddr = pt_phys + PAGEOFFSET(vaddr);
+invalid:
+	return paddr;
+}
+
+unsigned long long
+vaddr_to_paddr_riscv64(unsigned long vaddr)
+{
+	unsigned long long swapper_phys;
+
+	if (vaddr >= PAGE_OFFSET &&
+	    !(vaddr >= NUMBER(modules_vaddr) && vaddr <= NUMBER(modules_end))){
+		return VTOP(vaddr);
+	}
+
+	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
+		return NOT_PADDR;
+	}
+
+	swapper_phys = VTOP(SYMBOL(swapper_pg_dir));
+
+	return vtop_riscv64((pgd_t *)swapper_phys, vaddr, NUMBER(va_bits));
+}
+
+#endif /* __riscv64__ */
diff --git a/makedumpfile.c b/makedumpfile.c
index cadc596..42d5565 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2972,6 +2972,20 @@ read_vmcoreinfo(void)
 	READ_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
 #endif
 
+#ifdef __riscv64__
+	READ_NUMBER("VA_BITS", va_bits);
+	READ_NUMBER_UNSIGNED("phys_ram_base", phys_ram_base);
+	READ_NUMBER_UNSIGNED("PAGE_OFFSET", page_offset);
+	READ_NUMBER_UNSIGNED("VMALLOC_START", vmalloc_start);
+	READ_NUMBER_UNSIGNED("VMALLOC_END", vmalloc_end);
+	READ_NUMBER_UNSIGNED("VMEMMAP_START", vmemmap_start);
+	READ_NUMBER_UNSIGNED("VMEMMAP_END", vmemmap_end);
+	READ_NUMBER_UNSIGNED("MODULES_VADDR", modules_vaddr);
+	READ_NUMBER_UNSIGNED("MODULES_END", modules_end);
+	READ_NUMBER_UNSIGNED("KERNEL_LINK_ADDR", kernel_link_addr);
+	READ_NUMBER_UNSIGNED("va_kernel_pa_offset", va_kernel_pa_offset);
+#endif
+
 	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
 
 	return TRUE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 85e5a49..bb496e8 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1046,6 +1046,77 @@ typedef unsigned long pgd_t;
 
 #endif /* loongarch64 */
 
+#ifdef __riscv64__
+/*
+ * Referencing the riscv64_is_kvaddr() in Crash-utility,
+ * set the vmemmap start address as the lowest kernel virtual base.
+ * */
+#define KVBASE			(NUMBER(vmemmap_start))
+#define _SECTION_SIZE_BITS	(27)
+#define _MAX_PHYSMEM_BITS	(56)
+
+typedef ulong pgd_t;
+typedef ulong p4d_t;
+typedef ulong pud_t;
+typedef ulong pmd_t;
+typedef ulong pte_t;
+
+/* arch/riscv/include/asm/pgtable-64.h */
+
+#define PGD_SHIFT_L3		(30)
+#define PGD_SHIFT_L4		(39)
+#define PGD_SHIFT_L5		(48)
+
+#define P4D_SHIFT		(39)
+#define PUD_SHIFT		(30)
+#define PMD_SHIFT		(21)
+
+#define PTRS_PER_PGD		(512)
+#define PTRS_PER_P4D		(512)
+#define PTRS_PER_PUD		(512)
+#define PTRS_PER_PMD		(512)
+#define PTRS_PER_PTE		(512)
+
+/*
+ * 3/4/5-levels pg indexs
+ */
+#define pgd_index_l3(addr) (((addr) >> PGD_SHIFT_L3) & (PTRS_PER_PGD - 1))
+#define pgd_index_l4(addr) (((addr) >> PGD_SHIFT_L4) & (PTRS_PER_PGD - 1))
+#define pgd_index_l5(addr) (((addr) >> PGD_SHIFT_L5) & (PTRS_PER_PGD - 1))
+#define p4d_index(addr) (((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
+#define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+#define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+#define pte_index(addr) (((addr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
+
+/* arch/riscv/include/asm/pgtable-bits.h */
+
+#define _PAGE_PRESENT	(1 << 0)
+#define _PAGE_READ	(1 << 1)	/* Readable */
+#define _PAGE_WRITE	(1 << 2)	/* Writable */
+#define _PAGE_EXEC	(1 << 3)	/* Executable */
+#define _PAGE_USER	(1 << 4)	/* User */
+#define _PAGE_GLOBAL	(1 << 5)	/* Global */
+#define _PAGE_ACCESSED	(1 << 6)	/* Set by hardware on any access */
+#define _PAGE_DIRTY	(1 << 7)	/* Set by hardware on any write */
+#define _PAGE_SOFT	(1 << 8)	/* Reserved for software */
+
+#define _PAGE_PFN_SHIFT	(10)
+#define _PAGE_LEAF	(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
+
+/*
+ * Mask for bit 0~53(PROT and PPN) of PTE
+ * 63 6261  60    54  53 10  9 8 7 6 5 4 3 2 1 0
+ * N  PBMT  Reserved  P P N  RSW D A G U X W R V
+ */
+#define PTE_PFN_PROT_MASK	0x3FFFFFFFFFFFFF
+
+#define VA_BITS_SV39	(39)
+#define VA_BITS_SV48	(48)
+#define VA_BITS_SV57	(57)
+
+#endif /* riscv64 */
+
+
 /*
  * The function of dependence on machine
  */
@@ -1233,6 +1304,22 @@ unsigned long long vaddr_to_paddr_loongarch64(unsigned long vaddr);
 #define arch_crashkernel_mem_size()	stub_false()
 #endif /* loongarch64 */
 
+#ifdef __riscv64__
+int get_phys_base_riscv64(void);
+int get_machdep_info_riscv64(void);
+unsigned long long vaddr_to_paddr_riscv64(unsigned long vaddr);
+#define paddr_to_vaddr_riscv64(X) ((X) + PAGE_OFFSET - info->phys_base)
+#define find_vmemmap()		stub_false()
+#define get_phys_base()		get_phys_base_riscv64()
+#define get_machdep_info()	get_machdep_info_riscv64()
+#define get_versiondep_info()	stub_true()
+#define get_kaslr_offset(X)	stub_false()
+#define vaddr_to_paddr(X)	vaddr_to_paddr_riscv64(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_riscv64(X)
+#define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
+#endif /* riscv64 */
+
 typedef unsigned long long mdf_pfn_t;
 
 #ifndef ARCH_PFN_OFFSET
@@ -2151,6 +2238,20 @@ struct number_table {
 	long	TCR_EL1_T1SZ;
 	unsigned long	PHYS_OFFSET;
 	unsigned long	kimage_voffset;
+#endif
+	/**/
+#ifdef __riscv64__
+	long va_bits;
+	unsigned long phys_ram_base;
+	unsigned long page_offset;
+	unsigned long vmalloc_start;
+	unsigned long vmalloc_end;
+	unsigned long vmemmap_start;
+	unsigned long vmemmap_end;
+	unsigned long modules_vaddr;
+	unsigned long modules_end;
+	unsigned long kernel_link_addr;
+	unsigned long va_kernel_pa_offset;
 #endif
 };
 
@@ -2390,6 +2491,12 @@ int get_xen_info_ia64(void);
 #define get_xen_info_arch(X) FALSE
 #endif /* loongarch64 */
 
+#ifdef __riscv64__ /* riscv64 */
+#define kvtop_xen(X)	FALSE
+#define get_xen_basic_info_arch(X) FALSE
+#define get_xen_info_arch(X) FALSE
+#endif /* riscv64 */
+
 struct cycle {
 	mdf_pfn_t start_pfn;
 	mdf_pfn_t end_pfn;
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
