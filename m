Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F80CDB470
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yHUbHbg0NHWvDo8yTFOCqboowfLZ9w9xz1XRJqZVgvg=; b=OAsZNg9WqksqzOwayscGKRbn+D
	tY6t/7mSqRtXI3MDaU+bUbqQTXhLiyo9iALo24dCl40/cQFFWij3GDw/+bNd8nSykWeTttO0CGNeD
	N7NOJjjML9fxyONJOD0UgSSK8/2DSAY5MRWxpvtqcT4kdbRZiNXIYOJvD/NMaAmJGJxd8UIfcvO2G
	B7gzAqgVA77w7KaryO8QP+yf5zHmt1e51u8xnx+02upsM74zAqIQl3jUb3HiSj/pGp+uBtELw1Zkb
	cve9Yd73vJXx1WCFKeJ7GZCHzyj5bJwK53dz5k1eVbrY/f2RDTb0jXEX+DATnhL9H8/gSPVOOnTLA
	4z3kML4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcI3q-00000007JsF-2yDc;
	Wed, 24 Jun 2026 07:30:14 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcI3o-00000007Jrn-0NP7
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 07:30:13 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4glYVn5Vxhz8Xrrl;
	Wed, 24 Jun 2026 15:30:09 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl2.zte.com.cn with SMTP id 65O7TqH4033957;
	Wed, 24 Jun 2026 15:29:52 +0800 (+08)
	(envelope-from luo.haiyang@zte.com.cn)
Received: from mapi (szxl2zmapp07[null])
	by mapi (Zmail) with MAPI id mid18;
	Wed, 24 Jun 2026 15:29:54 +0800 (CST)
X-Zmail-TransId: 2b096a3b8772b19-5dfd5
X-Mailer: Zmail v1.0
Message-ID: <20260624152954074063WjbOEZ65zHfKn2kVEU@zte.com.cn>
In-Reply-To: <20260624151934989G934gVJVvk0Mc95CogNWd@zte.com.cn>
References: 20260624151934989G934gVJVvk0Mc95CogNWd@zte.com.cn
Date: Wed, 24 Jun 2026 15:29:54 +0800 (CST)
Mime-Version: 1.0
From: <luo.haiyang@zte.com.cn>
To: <luo.haiyang@zte.com.cn>
Cc: <kexec@lists.infradead.org>, <horms@kernel.org>, <zhang.run@zte.com.cn>,
        <cai.qu@zte.com.cn>
Subject: =?UTF-8?B?W1JFU0VORCBQQVRDSCAzLzRdIFJJU0MtVjogdXNlIGtlcm5lbCBpbWFnZSB0byBjcmVhdCBrZXJuZWwgdGV4dCBlbGYgaGVhZGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 65O7TqH4033957
X-TLS: YES
X-ENVELOPE-SENDER: luo.haiyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 24 Jun 2026 15:30:09 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3B8781.002/4glYVn5Vxhz8Xrrl
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_003012_286244_E141D3AD 
X-CRM114-Status: GOOD (  11.42  )
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

  No program header covering vaddr 0xffffffff819fa200 found kexec bug?
  saving vmcore-dmesg.txt failed

prb stores the address of printk_rb_dynamic, which resides in the bss segment.
But the PHDR (Program Header) does not contains it. The correct approach is to
use the entire kernel memory range (includs text, rodata, data, bss) to create
the Kernel text Elf header. On RISC-V, we can use the "kernel image" directly,
which can be read from /proc/iomem.

Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
---
 kexec/arch/riscv/crashdump-riscv.c | 10 +++++-----
 kexec/arch/riscv/iomem.h           |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/riscv/crashdump-riscv.c b/kexec/arch/riscv/crashdump-riscv.c
index 6875249..deb9a49 100644
--- a/kexec/arch/riscv/crashdump-riscv.c
+++ b/kexec/arch/riscv/crashdump-riscv.c
@@ -80,16 +80,16 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 				char *str, unsigned long long base,
 				unsigned long long length)
 {
-	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
+	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
 		return mem_regions_alloc_and_add(&crash_mem_ranges,
 						base, length, RANGE_RAM);
-	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
+	} else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
 		return mem_regions_alloc_and_add(&system_mem_ranges,
 						base, length, RANGE_RAM);
-	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0)
+	} else if (strncmp(str, KERNEL_IMAGE, strlen(KERNEL_IMAGE)) == 0) {
 		elf_info.kern_paddr_start = base;
-	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
-		elf_info.kern_size = base + length - elf_info.kern_paddr_start;
+		elf_info.kern_size = length;
+	}

 	return 0;
 }
diff --git a/kexec/arch/riscv/iomem.h b/kexec/arch/riscv/iomem.h
index 7671e26..86da971 100644
--- a/kexec/arch/riscv/iomem.h
+++ b/kexec/arch/riscv/iomem.h
@@ -4,6 +4,7 @@
 #define SYSTEM_RAM		"System RAM\n"
 #define KERNEL_CODE		"Kernel code\n"
 #define KERNEL_DATA		"Kernel data\n"
+#define KERNEL_IMAGE		"Kernel image\n"
 #define CRASH_KERNEL		"Crash kernel\n"
 #define IOMEM_RESERVED		"Reserved\n"

-- 
2.27.0

