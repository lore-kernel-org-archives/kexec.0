Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02C4FF8864
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 06:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ejmHsY9aPO4mjE6CDrxULTYgFgw7tdPgcMhiefmNm8=; b=OM8V6SnQL4TpSejjIPG+yc7dmi
	FY3UQLqx7uR7EKm3yAuXwlfIFjcjYaqXkehQ/lLn2zbjm8VelaET4VFoBJWEvG3UgF6vfCI0iLOg4
	PaWoVENmIuPtO+V5k6rQvAGfGDdbiDV4/Ckxgrk9BoDv9+hyfsfFcAyz0YaDDXgYCVzQQCZZuqXL4
	m0O//sP39dPrN7geblFh9zSyfm35P0DUe0XFAlxV5zShWXiKgqxxmJphRaiRo796RIZ2Rml9MjAmR
	sLJU53QoVDlgN4zNOxgCW6ZlFYP3CHcRvo3xXLzidaAkiBwHWLYyK86HshENKqHlJTP75/AS3ePlz
	7QEQWFTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHytZ-000000035QP-1IKv;
	Wed, 29 Apr 2026 06:59:41 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHytS-000000035J6-2lyw
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 06:59:39 +0000
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso389090b3a.1
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777445973; x=1778050773; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ejmHsY9aPO4mjE6CDrxULTYgFgw7tdPgcMhiefmNm8=;
        b=UTu2oixlGqRGYxZ4LCMzwJEzB4VnaXbdUkh2QceAPsDwx5icYaL+uJ7snt9/QINbTX
         Cu3b8jvgfQ9HoaPZhyi02ZAL1HCDJKkjcRu371yu8+wyran1aWIQky9dHEayhbyWbjKD
         QsV6Rgly7Z0CeBUM70Tdn7fxb6PYlUDW1x7jex5WGLpiRgQ0pVd35SnArzspAT0JnP9D
         Q5qVOyc12koJKB8+gvjaJ4HhZCHUMZOzdxeDaRSyeOAxd7iosQZaQwrXPjLEjQefEvAa
         kTxKuJ+hkBoVEPcWnGu//B2Zj8+VFl3+dUAHFL+ca4YNL+kpm6jgZhmGd+1QcB/QQbbJ
         sy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445973; x=1778050773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ejmHsY9aPO4mjE6CDrxULTYgFgw7tdPgcMhiefmNm8=;
        b=hDo3w1INyS51ieSVAz2LnaGyGqkDaL3cq8bfldGbE0KYEFC7R1tvxOfoNE0AT5UJro
         6ybOWGvFnImlfJaVkOB9NuF2wbkWQXb3dZW1PtZlHq7jW33YU5NgaMvTj2tqUcEpxww7
         qvBd9dDjPAxfxVxQyj/E6YaMETVWW5LYMer+x0pU161j4msHAMjAYYSfpEhUPBZZ/Jkl
         Fjw0uoaoVT75Ko3Ryfmm60YxgHNvuowooLS62MYGfr9NGIcJS8r41TB/PgDvf2CpW6iZ
         F3ntm4thXJe4U/DIDZoAWrpBA1kLqcFjkeBAEwaYSBOz+YlskiQXeZA1H3ASUgre7sA9
         eQUg==
X-Gm-Message-State: AOJu0Yz8gWcFLrxeCabuN90W9iM5IPNGzVe/hTQMAP1Mqj0hvzOcH2EM
	lUqmHR3A+Z4GxmJf9+zg/xVsyvSwl+4aD5m0Vi5McVLQLnINo16A4vsuYsHMaC2IZqcsBu4D
X-Gm-Gg: AeBDievuKJjEFACiKIc0AiID4M+sxqj/o03keHYPUnjpEHsXKGRkzOP1+WwXLcxBE8l
	FpBVgLMC45ySC+pxr0+bP50YUc5vdvhVqt5Iv4XfbQYKzo0YumPLWGK9fFWP5J1kPr4nIYpNqYV
	1rJx55UL4UGKs4LanHTXV1ucSIviJ7+c2USNaCvG1Kiw1psmc64jBJEI1wm5Z08iLA+sxnasI7N
	15Unh3ebb2UnF11UUGuqRTfBVHUWf0tJsdcGIHCFJGhVDCGGOknZjeDk3kE6DK+keAQ5e51vChY
	lG5ZZLz4rmzPAHtNS3ubT2AN2C/gxuqdwvgLtUbWT2WFAOH67HfDxNXh2/A7qsHVLZGGF6NfFGD
	jDfD6HgMywl8GmFk3A7bjjQvmiasVT82MpHCv400srFwCgiEpdX/FMcBN0iqvYrFcX8nr1lgtIu
	15BhCrlqclkn3X4gjSN2IhgcqaAaAA3tLH7QeNca8uLHPJF+Wz5Jc0BYX1iwE=
X-Received: by 2002:a05:6a00:2e93:b0:82f:2d48:f8fc with SMTP id d2e1a72fcca58-834eb3e4d01mr1774850b3a.6.1777445973470;
        Tue, 28 Apr 2026 23:59:33 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eaf93sm1043146b3a.40.2026.04.28.23.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:59:32 -0700 (PDT)
From: Chen Wandun <chenwandun1@gmail.com>
X-Google-Original-From: Chen Wandun <chenwandun@lixiang.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	chenwandun@lixiang.com,
	zhaomeijing@lixiang.com,
	everyzhao@126.com
Subject: [PATCH 05/11] of: reserved_mem: add linux,no-dump property support for reserved memory regions
Date: Wed, 29 Apr 2026 14:58:25 +0800
Message-ID: <20260429065831.1510858-6-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429065831.1510858-1-chenwandun@lixiang.com>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_235934_716145_1FA7F3C8 
X-CRM114-Status: GOOD (  17.96  )
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

Add a 'no_dump' field to struct reserved_mem and parse the
'linux,no-dump' device tree property during reserved memory node
initialization. This property allows device tree authors to mark
specific reserved memory regions that should be excluded from kdump
vmcore dumps.

Reserved memory regions used by device firmware (e.g., GPU, DSP, modem)
typically contain data that is not useful for kernel crash analysis and
can significantly increase vmcore size. The 'linux,no-dump' property
provides a declarative way to indicate these regions should be filtered
out when constructing the elfcorehdr for kdump.

The property is named with a 'linux,' prefix because kdump/vmcore is
Linux-specific and the property is an OS hint rather than a hardware
description, matching existing properties such as 'linux,cma-default'
and 'linux,usable-memory-range'.

The 'linux,no-dump' property is only effective when the region:
 - Does not have 'no-map': these regions are already excluded from
   vmcore since they are removed from the linear mapping (MEMBLOCK_NOMAP).
 - Does not have 'reusable': CMA reusable regions are actively used by
   the kernel for movable page allocations, and their contents are
   valuable for crash analysis.

The no-dump status is also printed in the boot log alongside the
existing nomap and reusable flags for diagnostic purposes.

Corresponding dt-schema binding update:
  https://github.com/devicetree-org/dt-schema/pull/193

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c    | 13 ++++++++-----
 include/linux/of_reserved_mem.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 93585af9f8a3..ac3d8b837d61 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -654,6 +654,7 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 {
 	int err = 0;
 	bool nomap;
+	bool reusable;
 
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
@@ -662,11 +663,14 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 		return;
 	}
 
+	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	reusable = of_get_flat_dt_prop(node, "reusable", NULL) != NULL;
+
 	rmem->name = uname;
 	rmem->base = base;
 	rmem->size = size;
-
-	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	rmem->no_dump = !nomap && !reusable &&
+			of_get_flat_dt_prop(node, "linux,no-dump", NULL) != NULL;
 
 	err = __reserved_mem_init_node(rmem, node);
 	if (err != 0 && err != -ENODEV) {
@@ -680,13 +684,12 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 		return;
 	} else {
 		phys_addr_t end = rmem->base + rmem->size - 1;
-		bool reusable =
-			(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
 
-		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+		pr_info("%pa..%pa (%lu KiB) %s %s %s %s\n",
 			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
 			nomap ? "nomap" : "map",
 			reusable ? "reusable" : "non-reusable",
+			rmem->no_dump ? "no-dump" : "dump",
 			rmem->name ? rmem->name : "unknown");
 	}
 
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e8b20b29fa68..29674f572673 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				no_dump;
 };
 
 struct reserved_mem_ops {
-- 
2.43.0


