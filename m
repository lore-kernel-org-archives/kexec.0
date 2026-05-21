Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917E8CD4F3D
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 03:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zj5onQORcwTcXqGaMlslqUfVIKyafxiuDV0ciH4VDSI=; b=ayRlDncTQI/Xoz3moiA3D5jtuu
	OdbQik8Fe3i4XB3ZRSJIXWpbfRNuwq8uMo88FlWp+xF5brHXniV/dYQp0/drOwOLE6MfJXUt5lExf
	tvBspk7g2mL63gW3GN7epXgUE7nRSJ78kep6bqc7cEKqTKpggqlIg0RB+5Ty//+XoZ7Prz3D28dhw
	PDE0tAD72IpGP3tFasguQmDV+/F8aBM35Fx6QbLj6z0OcXzFhLCiFBlKZzXRaqGO7rN0Ntbq3+4s4
	MA1Qw0xzzj4xTek5z8Suphc0wvLtmEyEh0cIr2J3XhS0fIY25weKXZb0PmiRpHtB0ETnfqcNqXiUl
	KIiBiK+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPuTh-00000006b6N-1Wnd;
	Thu, 21 May 2026 03:53:45 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPuTe-00000006b5X-0IE2
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 03:53:43 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gLZJg41G0z8Xrr9;
	Thu, 21 May 2026 11:53:39 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl1.zte.com.cn with SMTP id 64L3rZVq005565;
	Thu, 21 May 2026 11:53:35 +0800 (+08)
	(envelope-from luo.haiyang@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
	by mapi (Zmail) with MAPI id mid18;
	Thu, 21 May 2026 11:53:36 +0800 (CST)
X-Zmail-TransId: 2b056a0e81c0f35-98a65
X-Mailer: Zmail v1.0
Message-ID: <20260521115336553PqpEkTjTdtzwo2Jnk_1Tn@zte.com.cn>
In-Reply-To: <202605211147336599soXOrzLshSGck0QWydIB@zte.com.cn>
References: 202605211147336599soXOrzLshSGck0QWydIB@zte.com.cn
Date: Thu, 21 May 2026 11:53:36 +0800 (CST)
Mime-Version: 1.0
From: <luo.haiyang@zte.com.cn>
To: <luo.haiyang@zte.com.cn>
Cc: <kexec@lists.infradead.org>, <horms@kernel.org>, <zhang.run@zte.com.cn>,
        <cai.qu@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIDIvNF0gUklTQ1Y6IEZpeCBpbmNvcnJlY3QgdmlydHVhbCBhZGRyZXNzIHRyYW5zbGF0aW9uIGluCiBjcmFzaGR1bXAgbG9hZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 64L3rZVq005565
X-TLS: YES
X-ENVELOPE-SENDER: luo.haiyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 21 May 2026 11:53:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0E81C3.000/4gLZJg41G0z8Xrr9
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_205342_414765_BE9799B1 
X-CRM114-Status: GOOD (  15.55  )
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

The kexec shows the following crashdump log:

  Elf header: p_type = 1, p_offset = 0x80100000 p_paddr = 0x80100000 p_vaddr = 0xcff000 ...
  Elf header: p_type = 1, p_offset = 0x100000000 p_paddr = 0x100000000 p_vaddr = 0x80bff000 ...
  Elf header: p_type = 1, p_offset = 0x87ffff000 p_paddr = 0x87ffff000 p_vaddr = 0x800bfe000 ...

Obviously, phys_to_virt returns an incorrect virtual address (vaddr). On the RISC-V architecture,
the linear address mapping is defined as:
  va = pa + kernel_map.va_pa_offset (kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base)
Both PAGE_OFFSET and phys_ram_base can be read from /proc/kcore.

Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
---
 kexec/arch/riscv/Makefile          |  2 ++
 kexec/arch/riscv/crashdump-riscv.c | 55 ++++++++++++++++++++++++------
 util_lib/elf_info.c                | 41 +++++++++++++++++-----
 util_lib/include/elf_info.h        |  1 +
 4 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/kexec/arch/riscv/Makefile b/kexec/arch/riscv/Makefile
index 18a997b..e886770 100644
--- a/kexec/arch/riscv/Makefile
+++ b/kexec/arch/riscv/Makefile
@@ -14,6 +14,8 @@ riscv_ARCH_REUSE_INITRD =

 riscv_CPPFLAGS += -I $(srcdir)/kexec/

+riscv_PHYS_TO_VIRT =
+
 dist += $(riscv_KEXEC_SRCS)				\
 	kexec/arch/riscv/image-header.h			\
 	kexec/arch/riscv/include/arch/options.h		\
diff --git a/kexec/arch/riscv/crashdump-riscv.c b/kexec/arch/riscv/crashdump-riscv.c
index e923a71..6875249 100644
--- a/kexec/arch/riscv/crashdump-riscv.c
+++ b/kexec/arch/riscv/crashdump-riscv.c
@@ -1,5 +1,6 @@
 #include <errno.h>
 #include <elf.h>
+#include <elf_info.h>
 #include <unistd.h>

 #include "kexec.h"
@@ -22,18 +23,45 @@ static struct memory_ranges crash_mem_ranges = {0};
 static struct memory_ranges system_mem_ranges = {0};
 struct memory_range elfcorehdr_mem = {0};

-static unsigned long long get_page_offset(struct kexec_info *info)
+static unsigned long long phys_offset;
+
+static int get_page_offset(unsigned long long *page_offset)
 {
-	unsigned long long vaddr_off = 0;
-	unsigned long long page_size = sysconf(_SC_PAGESIZE);
-	unsigned long long init_start = get_kernel_sym("_sinittext");
+	int fd, ret = 0;

-	/*
-	 * Begining of init section is aligned to page size
-	 */
-	vaddr_off = init_start - page_size;
+	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
+		fprintf(stderr, "Can't open (%s).\n", "/proc/kcore");
+		return EFAILED;
+	}
+
+	ret = read_page_offset_elf_kcore(fd, (long *)page_offset);
+	if (ret)
+		fprintf(stderr, "Can't get page_offset from /proc/kcore\n");
+
+	close(fd);
+	return ret;
+}
+
+static int get_phys_offset(unsigned long long *phys_offset)
+{
+	int fd, ret = 0;
+
+	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
+		fprintf(stderr, "Can't open (%s).\n", "/proc/kcore");
+		return EFAILED;
+	}
+
+	ret = read_phys_offset_elf_kcore(fd, (long *)phys_offset);
+	if (ret)
+		fprintf(stderr, "Can't get phys_offset from /proc/kcore\n");

-	return vaddr_off;
+	close(fd);
+	return ret;
+}
+
+unsigned long phys_to_virt(struct crash_elf_info *elf_info, unsigned long long p)
+{
+	return elf_info->page_offset - phys_offset + p;
 }

 /*
@@ -124,7 +152,14 @@ int load_elfcorehdr(struct kexec_info *info)
 	if (crash_get_memory_ranges())
 		return EFAILED;

-	elf_info.page_offset = get_page_offset(info);
+	if (get_phys_offset(&phys_offset))
+		return EFAILED;
+
+	dbgprintf("phys_offset:   %016llx\n", phys_offset);
+
+	if (get_page_offset(&elf_info.page_offset))
+		return EFAILED;
+
 	dbgprintf("page_offset:   %016llx\n", elf_info.page_offset);

 #if __riscv_xlen == 64
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 589bc1a..36eb895 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -1308,16 +1308,39 @@ int read_phys_offset_elf_kcore(int fd, long *phys_off)

 	*phys_off = ULONG_MAX;

+	if (phys_offset != UINT64_MAX) {
+		*phys_off = phys_offset;
+		return 0;
+	}
+
+	/* If we have a valid 'PHYS_OFFSET' by now,
+	 * return it to the caller now.
+	 */
 	ret = read_elf(fd);
-	if (!ret) {
-		/* If we have a valid 'PHYS_OFFSET' by now,
-		 * return it to the caller now.
-		 */
-		if (phys_offset != UINT64_MAX) {
-			*phys_off = phys_offset;
-			return ret;
-		}
+	if (!ret && phys_offset != UINT64_MAX) {
+		*phys_off = phys_offset;
+		return 0;
+	}
+
+	return -EFAULT;
+}
+
+int read_page_offset_elf_kcore(int fd, long *page_off)
+{
+	int ret;
+
+	*page_off = ULONG_MAX;
+
+	if (page_offset != UINT64_MAX) {
+		*page_off = page_offset;
+		return 0;
+	}
+
+	ret = read_elf(fd);
+	if (!ret && page_offset != UINT64_MAX) {
+		*page_off = page_offset;
+		return 0;
 	}

-	return 2;
+	return -EFAULT;
 }
diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
index fdf4c3d..3ccc950 100644
--- a/util_lib/include/elf_info.h
+++ b/util_lib/include/elf_info.h
@@ -29,6 +29,7 @@ int get_pt_load(int idx,
 	unsigned long long *virt_start,
 	unsigned long long *virt_end);
 int read_phys_offset_elf_kcore(int fd, long *phys_off);
+int read_page_offset_elf_kcore(int fd, long *page_off);
 int read_elf(int fd);
 void dump_dmesg(int fd, void (*handler)(char*, unsigned int));
 extern void (*arch_scan_vmcoreinfo)(char *pos);
-- 
2.27.0

