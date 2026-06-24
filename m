Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3854CDB47F
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 07:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTKOFeif22tEGnhvdHONfgxJlZpHeIt9sn1ACXN2QQQ=; b=GkZrxp/vBt8Insgg9Arvto+mwu
	+4FI4ZJe1hJEXl+20uS9/pn9Glrl0PtP0NmatLy/5DZzraD0ASGFO55vmO41n0CgcR4fwxw8W1jvw
	PdC+4VF5JCsfEzC5XLnXfb7YxnN1P9JPjFCCQkKNzGloFnnDUiRUEf7aCXXLjax2FhkzdzNsC0BtZ
	MEryIrrL47B/cmY8wGnbykUk4qIfAWLmAaK0m2zzwIQBYblW55c6aIqeHPS3VNKPLDhCxrOLDqkhe
	pQqjVJM4osClZiKCraqC41AUFA6GPfIc4ne/JdZz4SYryd/Klvrw+tqW+msWIkGmMFjhgChZ0qHoE
	/WOs3Xww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcI5E-00000007Jza-1qXv;
	Wed, 24 Jun 2026 07:31:40 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcI5B-00000007Jyv-1Y0q
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 07:31:38 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4glYXD3Y0Kz5B13d;
	Wed, 24 Jun 2026 15:31:24 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 65O7VJYI019362;
	Wed, 24 Jun 2026 15:31:19 +0800 (+08)
	(envelope-from luo.haiyang@zte.com.cn)
Received: from mapi (szxl2zmapp07[null])
	by mapi (Zmail) with MAPI id mid18;
	Wed, 24 Jun 2026 15:31:21 +0800 (CST)
X-Zmail-TransId: 2b096a3b87c91cd-62684
X-Mailer: Zmail v1.0
Message-ID: <20260624153121303np_HjFew1So7uZdMDHeBg@zte.com.cn>
In-Reply-To: <20260624151934989G934gVJVvk0Mc95CogNWd@zte.com.cn>
References: 20260624151934989G934gVJVvk0Mc95CogNWd@zte.com.cn
Date: Wed, 24 Jun 2026 15:31:21 +0800 (CST)
Mime-Version: 1.0
From: <luo.haiyang@zte.com.cn>
To: <luo.haiyang@zte.com.cn>
Cc: <kexec@lists.infradead.org>, <horms@kernel.org>, <zhang.run@zte.com.cn>,
        <cai.qu@zte.com.cn>
Subject: =?UTF-8?B?W1JFU0VORCBQQVRDSCA0LzRdIFJJU0MtVjoga2VybmVsIGltYWdlIG1lbW9yeSByYW5nIHNob3VsZCBub3QgYmUgZXhjbHVkZWQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 65O7VJYI019362
X-TLS: YES
X-ENVELOPE-SENDER: luo.haiyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 24 Jun 2026 15:31:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3B87CC.000/4glYXD3Y0Kz5B13d
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_003137_563863_D468A985 
X-CRM114-Status: UNSURE (   8.04  )
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

