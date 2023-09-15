Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A08EEAA42
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 03:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dy6efoX7KeWdVjyAxQPjFyD8VNqU3pQ4lXZa0KpD9QE=; b=JirW/PZdoorklE
	JQJ/BjG3jCIy9gTeA7LzH2U7fXnrdKS56viuUypK/IhMwvkyiO87P+dsaUvULrfz3Zl+4LrKzVwC4
	NYxAgit/UVNOYRWcPEZ1DR9M9H83LSeTVJhb/y3oSUAe0kUH0GiiEGWHZEmuJUHuVf7LvL4+QiLC9
	5z9t+MdOHxVijL/Oi7+14tbL+dg0JTq7SXaQc7i22kzQMT/Fimv6EjfNlolsj8yiQWXvoIFp7BO5M
	Ly7hn44Poqwm0FlqQoVNGwp+MYjohT2DrMTM8pRKraXTu330+/vkK3I2hrPdnuQsG7AHcWRo/gQrD
	4ecVgCrGG/4hQIIUKLPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzuo-009hdA-2g;
	Fri, 15 Sep 2023 03:54:46 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzul-009hcf-1l
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 03:54:45 +0000
X-QQ-mid: bizesmtp80t1694750064tfqiy398
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Sep 2023 11:54:22 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: KPLRjuLOXqFAcZRxvt7RuvCtX7GEHiNmciQg0uztlgdECrFEQirJJUrkDGE1J
	YsGVokPVSGafFVCh2U+KPZATwgOAkMXOo+osIZkYVO87QKtq97KmnFe0cyz33Lq9UHBnPqq
	TQT+TleKs/I9VzUTAY6t59zag5lncMe4YXtBKLBCar0M8q6F7J6nndT2EiPtf8ANXfwfani
	2V9YZnrtqJuiiTMHD9thBJFL6GIEpauUxAqib/vx+wx4Tq5vqWg1fxvUcXFzeODAgbrWhJy
	8rLkeV/POMPtyL+PYcwFUciHqOFan7tSBc8e83l/kQEWzlE7suSAjcSL4IzZwHmfSj8ycZJ
	uJFKkaNiBIC95NzydaW5xtRHb5y33SsVui//Fdem3XjFY/VKtISuGtkKQ93p7nBP10lwhwb
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16177380298087972565
From: Song Shuai <songshuaishuai@tinylab.org>
To: lizhengyu3@huawei.com,
	liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com,
	guoren@kernel.org,
	horms@kernel.org,
	horms@verge.net.au,
	huanyi.xj@alibaba-inc.com,
	mick@ics.forth.gr,
	yixun.lan@gmail.com
Cc: kexec@lists.infradead.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 3/7] RISC-V: Get memory ranges from iomem
Date: Fri, 15 Sep 2023 11:50:09 +0800
Message-Id: <20230915035013.1582679-4-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_205443_915665_D89625A6 
X-CRM114-Status: GOOD (  19.58  )
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

When booting with UEFI, Linux marks the Runtime Code/Data memory
as no-map and then exports it to "Reserved" iomem_resource.

Kexc-tools uses dtb_get_memory_ranges() function to get memory ranges
via parsing dtb, but it can't see the Reserved EFI Runtime memory.
That would corrupt EFI Runtime memory and fail the kexeced kernel to
deal EFI stuff.

In my test, the kexeced kernel warned "efi: System table signature incorrect!"
and then paniced at efi_call_rts() due to the null efi.runtime.

So we should use /proc/iomem to get memory ranges.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kexec/arch/riscv/iomem.h       | 10 +++++
 kexec/arch/riscv/kexec-riscv.c | 69 +++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 26 deletions(-)
 create mode 100644 kexec/arch/riscv/iomem.h

diff --git a/kexec/arch/riscv/iomem.h b/kexec/arch/riscv/iomem.h
new file mode 100644
index 0000000..7671e26
--- /dev/null
+++ b/kexec/arch/riscv/iomem.h
@@ -0,0 +1,10 @@
+#ifndef IOMEM_H
+#define IOMEM_H
+
+#define SYSTEM_RAM		"System RAM\n"
+#define KERNEL_CODE		"Kernel code\n"
+#define KERNEL_DATA		"Kernel data\n"
+#define CRASH_KERNEL		"Crash kernel\n"
+#define IOMEM_RESERVED		"Reserved\n"
+
+#endif
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index 5aea035..a6f1b6f 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -15,6 +15,7 @@
 #include <errno.h>		/* For EINVAL */
 #include <libfdt.h>		/* For DeviceTree handling */
 #include "kexec-riscv.h"
+#include "iomem.h"
 
 const struct arch_map_entry arches[] = {
 	{ "riscv32", KEXEC_ARCH_RISCV },
@@ -37,7 +38,6 @@ static const char riscv_opts_usage[] =
 
 static struct riscv_opts arch_options = {0};
 static struct fdt_image provided_fdt = {0};
-static struct memory_ranges sysmem_ranges = {0};
 
 /****************\
 * COMMON HELPERS *
@@ -313,40 +313,57 @@ void arch_reuse_initrd(void)
 int get_memory_ranges(struct memory_range **range, int *num_ranges,
 		      unsigned long kexec_flags)
 {
-	const struct fdt_image *fdt = &provided_fdt;
-	struct memory_ranges *extra_ranges = NULL;
-	int i = 0;
+	struct memory_ranges sysmem_ranges = {0};
 	int ret = 0;
 
-	if (arch_options.initrd_start && arch_options.initrd_end) {
-		int initrd_size = arch_options.initrd_end - arch_options.initrd_start;
-		dbgprintf("Marking current intird image as reserved\n");
-		ret = mem_regions_alloc_and_add(extra_ranges,
-						arch_options.initrd_start,
-						initrd_size,
-						RANGE_RESERVED);
-		if (ret)
-			return ret;
+	const char *iomem = proc_iomem();
+	char line[MAX_LINE], *str;
+	FILE *fp;
+	unsigned long long start, end;
+	int consumed, count;
+
+	fp = fopen(iomem, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n", iomem, strerror(errno));
+		return -1;
 	}
 
-	ret = dtb_get_memory_ranges(fdt->buf, &sysmem_ranges, extra_ranges);
-	if (ret) {
-		fprintf(stderr, "Could not get memory ranges from device tree (%i) !\n", ret);
-		return ret;
+	while (fgets(line, sizeof(line), fp) != 0) {
+		count = sscanf(line, "%llx-%llx : %n", &start, &end, &consumed);
+		if (count != 2)
+			continue;
+		str = line + consumed;
+
+		if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM))){
+			ret = mem_regions_alloc_and_add(&sysmem_ranges,
+					start, end - start + 1, RANGE_RAM);
+			if (ret) {
+				fprintf(stderr,
+					"Cannot allocate memory for ranges\n");
+				fclose(fp);
+				return -ENOMEM;
+			}
+
+		} else if (!strncmp(str, IOMEM_RESERVED, strlen(IOMEM_RESERVED))){
+			ret = mem_regions_alloc_and_add(&sysmem_ranges,
+					start, end - start + 1, RANGE_RESERVED);
+			if (ret) {
+				fprintf(stderr,
+					"Cannot allocate memory for ranges\n");
+				fclose(fp);
+				return -ENOMEM;
+			}
+		} else
+			continue;
 	}
 
+	fclose(fp);
+
 	*range = sysmem_ranges.ranges;
 	*num_ranges = sysmem_ranges.size;
 
-	dbgprintf("Memory regions:\n");
-	for (i = 0; i < sysmem_ranges.size; i++) {
-		dbgprintf("\t0x%llx - 0x%llx : %s (%i)\n",
-			  sysmem_ranges.ranges[i].start,
-			  sysmem_ranges.ranges[i].end,
-			  sysmem_ranges.ranges[i].type == RANGE_RESERVED ?
-			  "RANGE_RESERVED" : "RANGE_RAM",
-			  sysmem_ranges.ranges[i].type);
-	}
+	dbgprint_mem_range("System RAM ranges;",
+				sysmem_ranges.ranges, sysmem_ranges.size);
 
 	return 0;
 }
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
