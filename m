Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B302CD4F3D
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 04:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTKOFeif22tEGnhvdHONfgxJlZpHeIt9sn1ACXN2QQQ=; b=Czmo83XrNWhrO1umimIqPluCKc
	uOtFaveNt0hkdi90Ev7UwtTGi+QTJqsusb2VVSKtzIbNp99FpYXPrBPSUpQJjq3Wa8CRvOMILwX6Z
	z1/wky+kWcM8YN8OQH44fZpZvHppgYPpV3jK/wWE0jmYnmdm1Ok4P9KeUur3Xo0y9PU5Rvem9Mnvt
	dMRKzowjzU43pxcsnHbSRD1hMSR9G/u024ejcNnq9cMiKFHtlIqhudcSr0t5zrRHu0NmDGp+1EZEj
	m1g+bsJse2wE479VmrnQO66PQwP8c8WlctKuzQoa+UBgzFtmoKaYqjv9Eaz+ahvkFp6IozQhhey+A
	GgDIwA4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPun5-00000006dET-1SKV;
	Thu, 21 May 2026 04:13:47 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPun3-00000006dE4-15M4
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 04:13:46 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gLZlp5Yffz8XrrJ;
	Thu, 21 May 2026 12:13:42 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 64L4DYi0062350;
	Thu, 21 May 2026 12:13:34 +0800 (+08)
	(envelope-from luo.haiyang@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid18;
	Thu, 21 May 2026 12:13:36 +0800 (CST)
X-Zmail-TransId: 2b066a0e8670ad0-25538
X-Mailer: Zmail v1.0
Message-ID: <20260521121336256QPCc5q-hUOhqOY00pLpR_@zte.com.cn>
In-Reply-To: <20260521120643491yZJMsKq2fLbFcvtV5ukN1@zte.com.cn>
References: 20260521120643491yZJMsKq2fLbFcvtV5ukN1@zte.com.cn
Date: Thu, 21 May 2026 12:13:36 +0800 (CST)
Mime-Version: 1.0
From: <luo.haiyang@zte.com.cn>
To: <luo.haiyang@zte.com.cn>
Cc: <kexec@lists.infradead.org>, <horms@kernel.org>, <zhang.run@zte.com.cn>,
        <cai.qu@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IDQvNF0gUklTQy1WOiBrZXJuZWwgaW1hZ2UgbWVtb3J5IHJhbmcgc2hvdWxkIG5vdCBiZSBleGNsdWRlZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 64L4DYi0062350
X-TLS: YES
X-ENVELOPE-SENDER: luo.haiyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 21 May 2026 12:13:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0E8676.001/4gLZlp5Yffz8XrrJ
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_211345_453180_E69BD990 
X-CRM114-Status: UNSURE (   8.92  )
X-CRM114-Notice: Please train this message.
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

On RISC-V, due to the kernel image being additionally exported
in /proc/iomem, the kernel memory range is not correctly handled
by to_be_excluded.

Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
---
 kexec/arch/riscv/iomem.h       | 2 --
 kexec/arch/riscv/kexec-riscv.c | 8 +++-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/riscv/iomem.h b/kexec/arch/riscv/iomem.h
index 86da971..1ab704c 100644
--- a/kexec/arch/riscv/iomem.h
+++ b/kexec/arch/riscv/iomem.h
@@ -2,8 +2,6 @@
 #define IOMEM_H

 #define SYSTEM_RAM		"System RAM\n"
-#define KERNEL_CODE		"Kernel code\n"
-#define KERNEL_DATA		"Kernel data\n"
 #define KERNEL_IMAGE		"Kernel image\n"
 #define CRASH_KERNEL		"Crash kernel\n"
 #define IOMEM_RESERVED		"Reserved\n"
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index a5a12a0..72fde08 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -417,12 +417,10 @@ static bool to_be_excluded(char *str, unsigned long long start, unsigned long lo
 		return true;
 	}

-	if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) ||
-	    !strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) ||
-	    !strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)))
-		return false;
-	else
+	if (!strncmp(str, IOMEM_RESERVED, strlen(IOMEM_RESERVED)))
 		return true;
+
+	return false;
 }

 int get_memory_ranges(struct memory_range **range, int *num_ranges,
-- 
2.27.0

