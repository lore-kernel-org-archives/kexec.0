Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C19606A31E
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rQYTqXej;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=jyc1AIII;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JbNgvrSZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vXO/Y/CYrpQIxWyPESy68yxl237JHlY56bkJQSv87LI=; b=rQYTqXejsaCeGU
	qH0YA45jzTPlyPp3XkZ4b3OLp7dFVLa3iQLLNZllK/zb81d56J4WDktXUrl3XUxvc8eO0bgPNR6Lb
	jaNUZ1DMBWy8HWjBrQLN1Pg0CbR2SkVGK5PP5KHtP7WHDiySu/OW1zTl+iQnYXD8NcreZQrREarmx
	LxJIeQoG2jurqb5BJW8Cbja0O4wgpnEZbv98jEINgmLxzn2MjFvFx5V9Q0TVvqRaeLvi3PWSlo2Fk
	ql0mizyHT5GiLerc1GgCEQOanA/5ttnt3BJFhnyCQ2CIBwmaoMK7LAV0k4GVU6qD2BDKR6ikAGEJ3
	/2KtgbTJIpAz5i6fXlXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrxF-0000000FN65-44zt;
	Fri, 27 Nov 2026 09:09:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrxF-0000000FN58-0YgA
	for kexec@bombadil.infradead.org;
	Fri, 27 Nov 2026 09:09:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vXO/Y/CYrpQIxWyPESy68yxl237JHlY56bkJQSv87LI=; b=jyc1AIII1TbKA47Pn3m9FOzRU6
	JQG7Tq/E4Hq3Cgei+k5Gr3enRVW7AatAIh05n5S/8Jl23w4qPYLsBPa+byuXqZw80Yi1i1bih0eMU
	q06gKvnn1enPTWVZv9qXD6Q0RHf3VAAndnF1rTVTgK0qZW3QHrMVfYOD+cjmlEbmHnfePiFxaLThN
	/ktwmwVTH7xJGBOW2hVahp2Y/N0uHJg8Y2xtGk8zsTcUIskoEBXFxCw2UbCBX7NExdcbCfc3RdLRl
	6n7XTs6jV/DZVRSzBaJOpqo8jjKT4E07KgoONq9vdZugazcWHTMlw9WEC+4wb3C9QCfyjmyF0ndpz
	JiLZeXSw==;
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrxB-00000007UgX-27vJ
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 09:09:15 +0000
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-3b094d5f1b4so1403212a91.0
        for <kexec@lists.infradead.org>; Fri, 27 Nov 2026 01:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770551; x=1796375351; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXO/Y/CYrpQIxWyPESy68yxl237JHlY56bkJQSv87LI=;
        b=JbNgvrSZYQcHPQrUpJHHxX2aYilJ8+uDLNW2myUUSLPA+gj1RYSE23BvAUks2cSn4i
         6/jK1uHXUGDdFB418YDsgTUohjjEnOdiiku1zhHwNBC/TFqmlD3xQE0312Ts8kCA0E2U
         kWgFYc830xjZAHcC7d+GqhOv7kt813DxNT6F4rh6Uz9KJy9FUYLesdPlXD62rtwvpIZB
         rQ6syctgmuCh5Yi0pZQd0IZjmshUhKCPHtIc++okJNPoo2wPeQfA5Kv1+OMTdQOrcO2T
         1ivkCh3xZu9J7tW5xSau+x8IGVh3TgHRkVE6KGEDKpEFKgBj7xoC68+2G7l6BM459vJN
         HBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770551; x=1796375351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXO/Y/CYrpQIxWyPESy68yxl237JHlY56bkJQSv87LI=;
        b=v2p7KlzMBIq2V2+pcKF775GDTjWwF4yMbX20sDYFK425wl2roYjSEnHHAEgHkEUa3g
         PXPXq0XVBYuMRvdzHr1XV3kFTWLffRl/Q+qRJZyUvtgseUkbz4A+0gthaGZ6DSzmJmsb
         3Rou3sP+4LvD/t9p71M2wPH6dS0/tQe2TxJ90OTN1xd/4R4FF1eDR85leeiVXMIc9Jjw
         mfHGarxnZG9400igwRusnmAoCjR3QA53250jPqiY+g7Sf56n4nPqRN3eQzLFU5WSeyiI
         lh48Woy6LrS8Op42p/haHqJlLNpk+oz9dnosvZIQ6kvjA+c05gfOvs2EnUd/ug9Yun1S
         BRCg==
X-Forwarded-Encrypted: i=1; AL+hErEQUWmvfs7IU15Tp8xrOcIVSwrhQqlQDVDsUVUK5VQpzuhY017vzFC+mNzbfTcVYsSthgaJKw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+1oAKyWVGfmcFuC6jX6LTQj40rMaqAen1tFbOF1TCNYvALXgh8
	U2CyCzUPcuq3yB7WHERn/buA1H4fBmnAsD50bamJqFZ4ZBlagJAvKoyh
X-Gm-Gg: AZFdTZdxhgveF6MlTktL3MoLVhNH0qAdgIOKZfY3/Ny9pgllblP0xpYXzwvStdJ0Stn
	g/IJjrDxuT8pchyJAKtjHN/tOyF5gUYN0E6wfqUJFr9lXciEKjOaPfk26mzeLvTqfzBz9eY/VXa
	Ej7alSRDY61NSCsAYNZd4KBoF3QYLk25sxEizdNH2ds/1adfY9LOKcfMy+TrY1Kd5ZvTXQ8kp77
	Ar9U0RgoP+bn9LOa6ukbJCD6fQIJuoOwinS+9doUcKKTzFqHSvSfbMRt489KDYzHuvE+Sb4apzu
	Ffq3lNogiXBz2XuQwLRwfOwnR/3a9kGx6CFeRytGzyGo6UvCt0fYIP9mDHrJtgUPHUWZaj3ueR7
	Tn+yUuiDys2H23uD5XOPIA78LlmDcBRvwGqHEceRlk3SdSKUS5gHhsz6j+0qYPearlBe27cdbgb
	T60i9sP/FXUeYPVjUotuAWpYW8NG/jXi0mTE5ZR+Vks+q9+FPhfaDYAgCc3sHigqVLEnUBExxHt
	rX4XQMLoVI/uxqWJXs6Gvh5SNNiLG0KXokZj9czGeypH30MDeOidn96iB2/fIB6hUceq6YAednK
	PJzLtAyB5+42KRus1oN1MUUyCiEnGcsngjfJwgDUm4o=
X-Received: by 2002:a17:90b:5907:b0:3b5:29e:11b4 with SMTP id 98e67ed59e1d1-3b5029e1464mr6516552a91.44.1795770551516;
        Fri, 27 Nov 2026 01:09:11 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:09:10 -0800 (PST)
From: Wandun Chen <chenwandun1@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v10 7/8] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Fri, 27 Nov 2026 17:07:22 +0800
Message-ID: <20261127090723.741253-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_090913_460661_DE2FA653 
X-CRM114-Status: GOOD (  14.40  )
X-Spam-Score: 0.1 (/)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wandun Chen <chenwandun@lixiang.com>

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP and either CONFIG_KEXEC_FILE
or CONFIG_CRASH_HOTPLUG, so kernels that do not build or update crash
ELF headers do not pay the cost of splitting memblock.memory entries
at NODUMP boundaries.

Clamp the marked range to page boundaries, since a sub-page split
would leave fragments that cannot be represented as valid System
RAM resources [1].

Link: https://sashiko.dev/#/message/sashiko-outbox-181183@kernel.org [1]
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt.c             |  2 ++
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a58efdcbac7f..f3a766310d11 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1283,6 +1283,8 @@ void __init unflatten_device_tree(void)
 {
 	void *fdt = initial_boot_params;
 
+	fdt_mark_reserve_mem_nodump();
+
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
 		fdt = (void *) __dtb_empty_root_begin;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 895f868b4cfa..00f776819dab 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -185,6 +185,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
+void __init fdt_mark_reserve_mem_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index a5cd8c2fffc3..cef444d4c1a3 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -610,6 +610,36 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	reserved_mem_count++;
 }
 
+void __init fdt_mark_reserve_mem_nodump(void)
+{
+	struct reserved_mem *rmem;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_FILE) && !IS_ENABLED(CONFIG_CRASH_HOTPLUG))
+		return;
+
+	if (reserved_mem_reserve_failed)
+		return;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		phys_addr_t base, end;
+
+		rmem = &reserved_mem[i];
+		if (!rmem->size || rmem->dumpable)
+			continue;
+
+		base = round_up(rmem->base, PAGE_SIZE);
+		end = round_down(rmem->base + rmem->size, PAGE_SIZE);
+		if (base >= end)
+			continue;
+
+		memblock_mark_nodump(base, end - base);
+	}
+}
+
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
-- 
2.43.0


