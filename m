Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179E3CD4F4A
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N0pokHkp8uBJePVmDzNQX7cqu3TKwgJZEkJBTgrc1XQ=; b=rDzixkjysoFi98Cvyk/LiYIpd+
	+wucLNE0uq5M491nr2uqehpxuwehdyH9EhcEc87+jPR8Pv3FTX44yyFcC72EmS3JCBWkjuuCReh/z
	U8PbDzIV8VAbE8Y2eo9B3OuYsZGnv2lYvwOdEnQCWyPNQ7Qow2ya7XpGLDvl+IZkm6yqChBBrWbyY
	x/2Z7vP4WG9S2F5aUljnG4WWCUybwypkw0FJ/ShgV5lgBBvFGRYoTFbuHcOdoAYXzPEBY8tspOiQv
	AIxsS+NGwHL0CdIFHXUowFpyrglTdBtqwBXMUDvwMYUx4PIyT717o8sHdQlWPCHHxa1QbQx+CaKQd
	sDQ3GRqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrz6-0000000EVhz-1Vax;
	Mon, 18 May 2026 07:01:52 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrz4-0000000EVh9-0csl
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 07:01:51 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gJpd46JQDz51Srr;
	Mon, 18 May 2026 15:01:44 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 64I71cjn092110;
	Mon, 18 May 2026 15:01:38 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 18 May 2026 15:01:40 +0800 (CST)
X-Zmail-TransId: 2af96a0ab95466a-f14e3
X-Mailer: Zmail v1.0
Message-ID: <20260518150140578xGhdr-ct94HGGS4gmP_it@zte.com.cn>
In-Reply-To: <20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn>
References: 20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn
Date: Mon, 18 May 2026 15:01:40 +0800 (CST)
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <hu.shengming@zte.com.cn>
Cc: <horms@kernel.org>, <kexec@lists.infradead.org>, <luo.haiyang@zte.com.cn>,
        <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDMvM10gUklTQy1WOiBhZGQgYnNzIHNlY3Rpb24gdG8ga2VybmVsIHRleHQgZWxmIGhlYWRlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 64I71cjn092110
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 18 May 2026 15:01:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0AB958.001/4gJpd46JQDz51Srr
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_000150_343365_2412244D 
X-CRM114-Status: GOOD (  10.52  )
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

prb stores the address of printk_rb_dynamic. Since printk_rb_dynamic
resides in the bss segment and the PHDR (Program Header) does not include
the bss segment address. Therefore,  add the bss segment to the Kernel text.

Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
---
 kexec/arch/riscv/crashdump-riscv.c | 2 +-
 kexec/arch/riscv/iomem.h           | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/riscv/crashdump-riscv.c b/kexec/arch/riscv/crashdump-riscv.c
index 6875249..a892225 100644
--- a/kexec/arch/riscv/crashdump-riscv.c
+++ b/kexec/arch/riscv/crashdump-riscv.c
@@ -88,7 +88,7 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 						base, length, RANGE_RAM);
 	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0)
 		elf_info.kern_paddr_start = base;
-	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
+	else if (strncmp(str, KERNEL_BSS, strlen(KERNEL_BSS)) == 0)
 		elf_info.kern_size = base + length - elf_info.kern_paddr_start;

 	return 0;
diff --git a/kexec/arch/riscv/iomem.h b/kexec/arch/riscv/iomem.h
index 7671e26..fcc0d0a 100644
--- a/kexec/arch/riscv/iomem.h
+++ b/kexec/arch/riscv/iomem.h
@@ -4,6 +4,7 @@
 #define SYSTEM_RAM		"System RAM\n"
 #define KERNEL_CODE		"Kernel code\n"
 #define KERNEL_DATA		"Kernel data\n"
+#define KERNEL_BSS		"Kernel bss\n"
 #define CRASH_KERNEL		"Crash kernel\n"
 #define IOMEM_RESERVED		"Reserved\n"

-- 
2.27.0

