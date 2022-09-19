Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AFDC54EE9
	for <kexec@archiver.kernel.org>; Mon, 19 Sep 2022 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nk0UP67kijZpj6kH4U8ujxMe8YjFSDC+JzXZurXlSoE=; b=DuMkoJpYbB68UI
	0ByTakUJh7mug5nYiZgtDFFomxYHwzhErlFR8DVOTHXQMCg6jFiE5rRnPzVlTCWzVvvEwkQuMvjgl
	296APTGEDRxWqs2e8qhxkNcgOoYfZeNy7Ghte4mxORldBhCfpQgicf+hVFBUrrA9mraQW1Ax/SkwR
	87KC0JBGnCFYudknEE45N8IsJ2l6OGeoHiVLaSrL8EEDv/Ja3mQj9MMHOO+xvL9TpqZamF9g2k2BE
	ipnryzfYgGdhIU/MkX7ncTwopfpmlkcr2gjglwtLO+CGZ05fQzeGRAt8b3RMo30ArkwGpVtahdmeY
	KS8cuv5HxWu3dAkokCsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oa8gv-007hhp-Pf; Mon, 19 Sep 2022 04:47:33 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oa8gq-007haB-HK
	for kexec@lists.infradead.org; Mon, 19 Sep 2022 04:47:31 +0000
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOJV9CdjkHsdAA--.46496S2;
	Mon, 19 Sep 2022 12:47:17 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: Kazuhito Hagio <k-hagio-ab@nec.com>
Cc: kexec-ml <kexec@lists.infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	tangyouling@loongson.cn
Subject: [PATCH] makedumpfile: Add initial LoongArch64 support
Date: Mon, 19 Sep 2022 12:47:17 +0800
Message-Id: <1663562837-20075-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxYOJV9CdjkHsdAA--.46496S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr17XryxCw1UGw1DAF43KFg_yoW3Cw15pF
	y5Ca93Kr48KFy7Gw4fGa45Xr13Jr1I9F1aqF92qrW09F1xZr40gr1IkFZxZFW8Jrs5WFyI
	qrs5Ja4jg3ZrJaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gryl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUOVyxUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_214729_008888_7AB37B9C 
X-CRM114-Status: GOOD (  20.12  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Patch adds support for LoongArch64 in makedumpfile. It takes care of
vmalloc, module and directly map kernel memory region's translation.
Currently we only support 3 leverl 16K pages and VA_BITS as 48.

The changes were tested on a LoongArch64 Loongson-3A5000 processor.
The dump compression and filtering (for all dump levels 1,2,4,8,16
and 31) tests are succussfull.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
Note: kexec/kdump support patch see link [1]:
[1] Link: https://lore.kernel.org/loongarch/1663210426-15446-1-git-send-email-tangyouling@loongson.cn/T/#t

 Makefile           |   2 +-
 arch/loongarch64.c | 113 +++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h     |  58 +++++++++++++++++++++++
 3 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch64.c

diff --git a/Makefile b/Makefile
index 370a97c..e07f466 100644
--- a/Makefile
+++ b/Makefile
@@ -47,7 +47,7 @@ endif
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
 SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
-SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c
+SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
 
 LIBS = -ldw -lbz2 -ldl -lelf -lz
diff --git a/arch/loongarch64.c b/arch/loongarch64.c
new file mode 100644
index 0000000..42a02ab
--- /dev/null
+++ b/arch/loongarch64.c
@@ -0,0 +1,113 @@
+/*
+ * loongarch64.c
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
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
+#ifdef __loongarch64__
+
+#include "../print_info.h"
+#include "../elf_info.h"
+#include "../makedumpfile.h"
+
+int
+get_phys_base_loongarch64(void)
+{
+	info->phys_base = 0ULL;
+
+	DEBUG_MSG("phys_base    : %lx\n", info->phys_base);
+
+	return TRUE;
+}
+
+int
+get_machdep_info_loongarch64(void)
+{
+	info->section_size_bits = _SECTION_SIZE_BITS;
+
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+	else
+		info->max_physmem_bits = _MAX_PHYSMEM_BITS;
+
+	/* Check if we can get SECTION_SIZE_BITS from vmcoreinfo */
+	if (NUMBER(SECTION_SIZE_BITS) != NOT_FOUND_NUMBER)
+		info->section_size_bits = NUMBER(SECTION_SIZE_BITS);
+	else
+		info->section_size_bits = _SECTION_SIZE_BITS;
+
+	DEBUG_MSG("max_physmem_bits : %ld\n", info->max_physmem_bits);
+	DEBUG_MSG("section_size_bits: %ld\n", info->section_size_bits);
+
+	return TRUE;
+}
+
+int
+get_versiondep_info_loongarch64(void)
+{
+	info->page_offset  = _PAGE_OFFSET;
+
+	DEBUG_MSG("page_offset : %lx\n", info->page_offset);
+
+	return TRUE;
+}
+
+unsigned long long
+vaddr_to_paddr_loongarch64(unsigned long vaddr)
+{
+	unsigned long long paddr = NOT_PADDR;
+	pgd_t *pgda, pgdv;
+	pmd_t *pmda, pmdv;
+	pte_t *ptea, ptev;
+
+	if (vaddr >= _XKPRANGE && vaddr < _XKVRANGE)
+		return vaddr & ((1ULL << MAX_PHYSMEM_BITS()) - 1);
+
+	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
+		return NOT_PADDR;
+	}
+
+	pgda = pgd_offset(SYMBOL(swapper_pg_dir), vaddr);
+	if (!readmem(VADDR, (unsigned long long)pgda, &pgdv, sizeof(pgdv))) {
+		ERRMSG("Can't read pgd\n");
+		return NOT_PADDR;
+	}
+
+	pmda = pmd_offset(&pgdv, vaddr);
+	if (!readmem(VADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
+		ERRMSG("Can't read pmd\n");
+		return NOT_PADDR;
+	}
+
+	if (pmdv & _PAGE_HUGE) {
+		paddr = (pmdv & PMD_MASK) + (vaddr & (PMD_SIZE - 1));
+		return paddr;
+	}
+
+	ptea = pte_offset(&pmdv, vaddr);
+	if (!readmem(VADDR, (unsigned long long)ptea, &ptev, sizeof(ptev))) {
+		ERRMSG("Can't read pte\n");
+		return NOT_PADDR;
+	}
+
+	if (!(ptev & _PAGE_PRESENT)) {
+		ERRMSG("Can't get a valid pte.\n");
+		return NOT_PADDR;
+	}
+
+	paddr = PAGEBASE(ptev) + (vaddr & (PAGESIZE() - 1));
+	return paddr;
+}
+
+#endif /* loongarch64 */
diff --git a/makedumpfile.h b/makedumpfile.h
index 49b9242..a70b1de 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1013,6 +1013,42 @@ typedef unsigned long pgd_t;
 
 #endif		/* mips64 */
 
+#ifdef __loongarch64__
+#define KVBASE			(0x8000000000000000ULL)
+#define _PAGE_OFFSET		(0x9000000000000000ULL)
+#define _XKPRANGE		(0x8000000000000000ULL)
+#define _XKVRANGE		(0xc000000000000000ULL)
+#define _SECTION_SIZE_BITS	(29)
+#define _MAX_PHYSMEM_BITS	(48)
+#define _PAGE_HUGE		(1 << 6) /* HUGE is a PMD bit */
+#define _PAGE_PRESENT		(1 << 7)
+
+typedef unsigned long pte_t;
+typedef unsigned long pmd_t;
+typedef unsigned long pgd_t;
+
+#define PAGE_MASK		(~(PAGESIZE() - 1))
+#define PMD_MASK		(~(PMD_SIZE - 1))
+#define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
+#define PMD_SIZE		(1UL << PMD_SHIFT)
+#define PGDIR_SHIFT		((PAGESHIFT() - 3) * 3 + 3)
+#define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
+#define PTRS_PER_PMD		PTRS_PER_PTE
+#define PTRS_PER_PGD		PTRS_PER_PTE
+
+#define pte_index(vaddr)		(((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
+#define pmd_page_paddr(pmd)		(pmd & (int32_t)PAGE_MASK)
+#define pte_offset(dir, vaddr)		((pte_t *)pmd_page_paddr((*dir)) + pte_index(vaddr))
+
+#define pmd_index(vaddr)		(((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+#define pgd_page_paddr(pgd)		(pgd & (int32_t)PAGE_MASK)
+#define pmd_offset(pgd, vaddr)		((pmd_t *)pgd_page_paddr((*pgd)) + pmd_index(vaddr))
+
+#define pgd_index(vaddr)		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
+
+#endif          /* loongarch64 */
+
 /*
  * The function of dependence on machine
  */
@@ -1184,6 +1220,22 @@ unsigned long long vaddr_to_paddr_mips64(unsigned long vaddr);
 #define arch_crashkernel_mem_size()	stub_false()
 #endif		/* mips64 */
 
+#ifdef __loongarch64__ /* loongarch64 */
+int get_phys_base_loongarch64(void);
+int get_machdep_info_loongarch64(void);
+int get_versiondep_info_loongarch64(void);
+unsigned long long vaddr_to_paddr_loongarch64(unsigned long vaddr);
+#define find_vmemmap()		stub_false()
+#define get_phys_base()		get_phys_base_loongarch64()
+#define get_machdep_info()	get_machdep_info_loongarch64()
+#define get_versiondep_info()   get_versiondep_info_loongarch64()
+#define get_kaslr_offset(X)	stub_false()
+#define vaddr_to_paddr(X)       vaddr_to_paddr_loongarch64(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
+#define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
+#endif		/* loongarch64 */
+
 typedef unsigned long long mdf_pfn_t;
 
 #ifndef ARCH_PFN_OFFSET
@@ -2318,6 +2370,12 @@ int get_xen_info_ia64(void);
 #define get_xen_info_arch(X) FALSE
 #endif	/* mips64 */
 
+#ifdef __loongarch64__ /* loongarch64 */
+#define kvtop_xen(X)	FALSE
+#define get_xen_basic_info_arch(X) FALSE
+#define get_xen_info_arch(X) FALSE
+#endif	/* loongarch64 */
+
 struct cycle {
 	mdf_pfn_t start_pfn;
 	mdf_pfn_t end_pfn;
-- 
2.36.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
