Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EF7CD4F4A
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 06:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02MLtmc3CshHHeA50kvhAPpMrYWWHmT4O24XG/PZOJY=; b=uBd4jQMLWt4BGgLBpb+iHhvrTy
	UDFalJ5nD6sqQ3l8ZZ3R0Q8VdQHVlKszEj8t8xhKwZPIh3k++BYAzjdIw+hqKP8QQ+LQY+8753+o+
	zVBNnkFIWE/qRCCes1BhaPQsrSL5lr0bl3UqUS6NfmeNwxhEIvgOWeCudTMmEl/eKM6gQ+grCMFmH
	aXz1Bc1To7zKg+KEAthQBWKmXErMu34/fig3/grr6tqsL0IiTOxB9/wz8LCL41/TOSyBLDn/nxLsr
	0uGtHbLDrN1FGdq6RWjXo+aJpGA/4YgDF8drYDVPOLNMMFNxi8nbmT6AWzv1NHaTjQBnBlLHJlVHm
	mHPKFl+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrwa-0000000EV79-2srw;
	Mon, 18 May 2026 06:59:16 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrwY-0000000EV5y-47ep
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 06:59:16 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gJpZ52nlfz51Srn;
	Mon, 18 May 2026 14:59:09 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 64I6wwt1094535;
	Mon, 18 May 2026 14:58:58 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 18 May 2026 14:59:00 +0800 (CST)
X-Zmail-TransId: 2afa6a0ab8b4c33-08a96
X-Mailer: Zmail v1.0
Message-ID: <20260518145900121tCLnAGYor_GFRCPfLajz5@zte.com.cn>
In-Reply-To: <20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn>
References: 20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn
Date: Mon, 18 May 2026 14:59:00 +0800 (CST)
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <hu.shengming@zte.com.cn>
Cc: <horms@kernel.org>, <kexec@lists.infradead.org>, <luo.haiyang@zte.com.cn>,
        <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDEvM10gUklTQy1WOiBmaXggY3Jhc2hkdW1wIGxvYWQgbWVtb3J5IHJhbmdlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 64I6wwt1094535
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 18 May 2026 14:59:09 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0AB8BD.000/4gJpZ52nlfz51Srn
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_235915_346623_D464BC9A 
X-CRM114-Status: GOOD (  20.13  )
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

From: Luo Haiyang <luo.haiyang@zte.com.cn>

The kdump service reported the following error:

 kdump.sh[338]: readpage_elf: Attempt to read non-existent page at 0x17ee12000.
 kdump.sh[338]: readmem: type_addr: 0, addr:ffffffd6fee12b00, size:8
 kdump.sh[338]: validate_mem_section: Can't read mem_section array.
 kdump.sh[338]: readpage_elf: Attempt to read non-existent page at 0x17ee12000.
 kdump.sh[338]: readmem: type_addr: 0, addr:ffffffd6fee12b00, size:8
 kdump.sh[338]: get_mm_sparsemem: Can't get the address of mem_section.
 kdump.sh[338]: The kernel version is not supported.
 kdump.sh[338]: The makedumpfile operation may be incomplete.

crash_mem_ranges only includes available memory, not all system RAM.
Inspired by the arm64 architecture, use system_mem_ranges in the
load_elfcorehdr function.

Fixes: b3fd54b (RISC-V: Add support for riscv kexec/kdump on kexec-tools)
Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
---
 kexec/arch/riscv/crashdump-riscv.c | 167 ++++++++++++++++++-----------
 1 file changed, 102 insertions(+), 65 deletions(-)

diff --git a/kexec/arch/riscv/crashdump-riscv.c b/kexec/arch/riscv/crashdump-riscv.c
index 336d7a7..e923a71 100644
--- a/kexec/arch/riscv/crashdump-riscv.c
+++ b/kexec/arch/riscv/crashdump-riscv.c
@@ -6,6 +6,7 @@
 #include "crashdump.h"
 #include "kexec-elf.h"
 #include "mem_regions.h"
+#include "iomem.h"

 static struct crash_elf_info elf_info = {
 #if __riscv_xlen == 64
@@ -18,6 +19,7 @@ static struct crash_elf_info elf_info = {
 };

 static struct memory_ranges crash_mem_ranges = {0};
+static struct memory_ranges system_mem_ranges = {0};
 struct memory_range elfcorehdr_mem = {0};

 static unsigned long long get_page_offset(struct kexec_info *info)
@@ -34,86 +36,114 @@ static unsigned long long get_page_offset(struct kexec_info *info)
 	return vaddr_off;
 }

-int load_elfcorehdr(struct kexec_info *info)
+/*
+ * iomem_range_callback() - callback called for each iomem region
+ * @data: not used
+ * @nr: not used
+ * @str: name of the memory region
+ * @base: start address of the memory region
+ * @length: size of the memory region
+ *
+ * This function is called once for each memory region found in /proc/iomem.
+ * It locates system RAM and crashkernel reserved memory and places these to
+ * variables, respectively, system_memory_rgns and crash_mem_ranges.
+ */
+static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
+				char *str, unsigned long long base,
+				unsigned long long length)
 {
-	struct memory_range crashkern_range = {0};
-	struct memory_range *ranges = NULL;
-	unsigned long start = 0;
-	unsigned long end = 0;
-	unsigned long buf_size = 0;
-	unsigned long elfcorehdr_addr = 0;
-	void* buf = NULL;
-	int i = 0;
-	int ret = 0;
+	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
+		return mem_regions_alloc_and_add(&crash_mem_ranges,
+						base, length, RANGE_RAM);
+	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
+		return mem_regions_alloc_and_add(&system_mem_ranges,
+						base, length, RANGE_RAM);
+	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0)
+		elf_info.kern_paddr_start = base;
+	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
+		elf_info.kern_size = base + length - elf_info.kern_paddr_start;

-	ret = parse_iomem_single("Kernel code\n", &start, NULL);
-	if (ret) {
-		fprintf(stderr, "Cannot determine kernel physical base addr\n");
-		return -EINVAL;
-	}
-	elf_info.kern_paddr_start = start;
+	return 0;
+}
+
+/*
+ * crash_get_memory_ranges() - read system physical memory
+ *
+ * Function reads through system physical memory and stores found memory
+ * regions in system_memory_ranges.
+ * Regions are sorted in ascending order.
+ *
+ * Returns 0 in case of success and a negative value otherwise.
+ */
+static int crash_get_memory_ranges(void)
+{
+	int i;
+
+	if (!crash_mem_ranges.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);

-	ret = parse_iomem_single("Kernel bss\n", NULL, &end);
-	if (ret) {
-		fprintf(stderr, "Cannot determine kernel physical bss addr\n");
+	if (!crash_mem_ranges.size)
 		return -EINVAL;
+
+	dbgprint_mem_range("Reserved memory range",
+			crash_mem_ranges.ranges, crash_mem_ranges.size);
+
+	for (i = 0; i < crash_mem_ranges.size; i++) {
+		if (mem_regions_alloc_and_exclude(&system_mem_ranges,
+					&crash_mem_ranges.ranges[i])) {
+			fprintf(stderr, "Cannot allocate memory for ranges\n");
+			return -ENOMEM;
+		}
 	}
-	elf_info.kern_paddr_start = start;
-	elf_info.kern_size = end - start;

+	/*
+	 * Make sure that the memory regions are sorted.
+	 */
+	mem_regions_sort(&system_mem_ranges);
+
+	dbgprint_mem_range("Coredump memory ranges",
+			   system_mem_ranges.ranges, system_mem_ranges.size);
+
+	/*
+	 * For additional kernel code/data segment.
+	 * kern_paddr_start/kern_size are determined in iomem_range_callback
+	 */
 	elf_info.kern_vaddr_start = get_kernel_sym("_text");
-	if (!elf_info.kern_vaddr_start) {
+	if (!elf_info.kern_vaddr_start)
 		elf_info.kern_vaddr_start = UINT64_MAX;
-	}

-	elf_info.page_offset = get_page_offset(info);
-	dbgprintf("page_offset:   %016llx\n", elf_info.page_offset);
+	return 0;
+}

-	ret = parse_iomem_single("Crash kernel\n", &start, &end);
-	if (ret) {
-		fprintf(stderr, "Cannot determine kernel physical bss addr\n");
-		return -EINVAL;
-	}
-	crashkern_range.start = start;
-	crashkern_range.end = end;
-	crashkern_range.type = RANGE_RESERVED;
-
-	ranges = info->memory_range;
-	for (i = 0; i < info->memory_ranges; i++) {
-		ret = mem_regions_alloc_and_add(&crash_mem_ranges,
-						ranges[i].start,
-						ranges[i].end - ranges[i].start + 1,
-						ranges[i].type);
-		if (ret ) {
-			fprintf(stderr, "Could not create crash_mem_ranges\n");
-			return ret;
-		}
-	}
+int load_elfcorehdr(struct kexec_info *info)
+{
+	unsigned long buf_size = 0;
+	unsigned long elfcorehdr_addr = 0;
+	void* buf = NULL;

-	ret = mem_regions_alloc_and_exclude(&crash_mem_ranges,
-					    &crashkern_range);
-	if (ret) {
-		fprintf(stderr, "Could not exclude crashkern_range\n");
-		return ret;
-	}
+	if (crash_get_memory_ranges())
+		return EFAILED;
+
+	elf_info.page_offset = get_page_offset(info);
+	dbgprintf("page_offset:   %016llx\n", elf_info.page_offset);

 #if __riscv_xlen == 64
-	crash_create_elf64_headers(info, &elf_info, crash_mem_ranges.ranges,
-				   crash_mem_ranges.size, &buf, &buf_size,
+	crash_create_elf64_headers(info, &elf_info, system_mem_ranges.ranges,
+				   system_mem_ranges.size, &buf, &buf_size,
 				   ELF_CORE_HEADER_ALIGN);

 #else
-	crash_create_elf32_headers(info, &elf_info, crash_mem_ranges.ranges,
-				   crash_mem_ranges.size, &buf, &buf_size,
+	crash_create_elf32_headers(info, &elf_info, system_mem_ranges.ranges,
+				   system_mem_ranges.size, &buf, &buf_size,
 				   ELF_CORE_HEADER_ALIGN);
 #endif


 	elfcorehdr_addr = add_buffer_phys_virt(info, buf, buf_size,
-					       buf_size, 0,
-					       crashkern_range.start,
-					       crashkern_range.end,
-					       -1, 0);
+					    buf_size, 0,
+					    crash_mem_ranges.ranges[crash_mem_ranges.size - 1].start,
+					    crash_mem_ranges.ranges[crash_mem_ranges.size - 1].end,
+					    -1, 0);

 	elfcorehdr_mem.start = elfcorehdr_addr;
 	elfcorehdr_mem.end = elfcorehdr_addr + buf_size - 1;
@@ -126,15 +156,22 @@ int load_elfcorehdr(struct kexec_info *info)

 int is_crashkernel_mem_reserved(void)
 {
-	uint64_t start = 0;
-	uint64_t end = 0;
+	if (!crash_mem_ranges.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);

-	return parse_iomem_single("Crash kernel\n", &start, &end) == 0 ?
-	       (start != end) : 0;
+	return crash_mem_ranges.size;
 }

 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
 {
-	return parse_iomem_single("Crash kernel\n", start, end);
-}
+	if (!crash_mem_ranges.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	if (!crash_mem_ranges.size)
+		return -1;
+
+	*start = crash_mem_ranges.ranges[crash_mem_ranges.size - 1].start;
+	*end = crash_mem_ranges.ranges[crash_mem_ranges.size - 1].end;

+	return 0;
+}
-- 
2.27.0

