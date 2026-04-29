Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E0CFF8873
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y02uBvZORLsA6xImd4974JLfXXgs5mmuCn2J28MpgzI=; b=hSrOMkp3P11N1SB7r+NY9n0T1d
	FwX9Aa2PvKd1i/FWi3Fv7Ihnux1vGqG+bpl5Gu/K3+bwGFfE8mt6M8KZlL3nacvIYkdU5Lg0bhWbD
	VQP2WqdNQT/nYDf6p6/wtJ/9RT6LnggITq1Vm1iWuyqfbI/+q5UaJTB8h7eUoxiaNRclPLLGSCxhR
	N+2RREd4gV0xFDb3KvrvfU+wlEqMCKOs3XVrpQtvg3Zmdq5/zZOO7H5JWSGKMmcZ5xVr3x6yy4zMi
	sQmt7ou6MZw3Im7dQkiW9qQ3WZiQMfmVlKXZADcV8z/YCIC/Wa5N8MWNgCaGevXnar/eGeT8IaOH1
	uN0OCOYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHysr-000000034lO-3Cn9;
	Wed, 29 Apr 2026 06:58:57 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHysp-000000034jd-1dOr
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 06:58:56 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-82f1f6103afso5714400b3a.1
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777445934; x=1778050734; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y02uBvZORLsA6xImd4974JLfXXgs5mmuCn2J28MpgzI=;
        b=nsEJ5mB/HDCQXlzzAn9y5EsmXCnjyr8VV63WScD0hcMSUjJKj3EqpqeK4JEXoFuxFj
         uc871exGbBnMLI+nmVIo3hX5d94AL3B807EVbmn9GbXjc6nQCBLQPg/YjDlr004ax6Jz
         /wLg7yK+nOZYq05EV18fTZ6ePdNMnNtTW5DJiwDR9chq+abKSBLyIa5VjUaH08EvGEiP
         thxRkq+VGCBrpnyNWPqwc0XjA8Sbt8+ZZaPTYjO7tPwMkjPZpPtL1PpLtd1Bpq2cNa90
         EWth8KBzj6cXE5ZtbRp0lMGCJlkDS80lefKXgTuS5U1qiU5P0zuDcQu6iXlmjxvpw51v
         l+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445934; x=1778050734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y02uBvZORLsA6xImd4974JLfXXgs5mmuCn2J28MpgzI=;
        b=TC7D1hq3u4YiMS30osYRpgwn9WLe7PYNfguHGBDYMMckQmBS7582KP6tJ01gyzkanP
         NKNo1sziumFxmEykZJW6j8DSHfS6MSPDbMBPIc/swURcUbOWQE6GddXtmllCZVk0PyLF
         nGIoLiQJsjEJtlKKwxHu/NBDBf+tgIX7Vf1l/ZBz1NH1r/T6EU8iraO/kpZRxhCjREJg
         6Stw949NljxFCBThV0v9BXi3yS+RYA0xIcZm5eR/fAFbRqgq+hhMbYSSkcg0qfFQXAme
         OyXpn2l3TZi3IEBi8RIWWWoTwUue9z5dN+s+qRd3E9VboQ6ycWk+7+4w+FJoxXkf4xrr
         +yVQ==
X-Gm-Message-State: AOJu0YwhKBo+ycsZD3f30Oh6rCdINteB1G7X+b/3HyVGrfJ3oHYn8nAB
	XFF8Yua2w7OBlti8wnPZpGQWjwscdzbspydI9Qsd+tLyggETKlryblkQL54IuE3Q3vXJsLQY
X-Gm-Gg: AeBDiet41glMmxvdM9VHC8kYxvhYuTKvUfdqA3QXrIjbKT87kKp96vmhUkkMNz+ucCU
	xv/VKcGwaeHT/eWFAddWLxIWcK4B4rGwThLT3s19XRvBmV5y79UX03EXy+Fcp9U0Bp70h6S8tR6
	TVYoDZuUQEki8jANWl1Vly4BfKhLj9PEwQwo+C2y286U+v4AqWxUd4qSoaVLn6zHUUaxEEH+J7q
	VuYAm+JUUSvjYYnw+8je83hEUqljVzkdhly/DQf2aR6E64J0yht9iA1zYH5AdVyl6IqBam50Pd3
	skjAxn+GXEjIOTuoVzUBN/ZKuJwGWB0gsB0A8q+i77FRyDPBB2l8//gjsQX7wER0lLJ52eQ4f8R
	Do6PjSylj9xMW20t18umIni8zuexOOPxs33DZ1Llw34T0P88Dzi/KZWcrkxdLLEyQd5/FvvAiCm
	rlPWz15sN8BiqzXc7agoDfIXQhabjMcBJTzqSURYus1elt7+BY
X-Received: by 2002:a05:6a00:2d85:b0:82c:dd31:b83d with SMTP id d2e1a72fcca58-834ddc5879cmr6667128b3a.38.1777445934284;
        Tue, 28 Apr 2026 23:58:54 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eaf93sm1043146b3a.40.2026.04.28.23.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:58:53 -0700 (PDT)
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
Subject: [PATCH 01/11] of: reserved_mem: fix region count for nodes with multiple reg entries
Date: Wed, 29 Apr 2026 14:58:21 +0800
Message-ID: <20260429065831.1510858-2-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429065831.1510858-1-chenwandun@lixiang.com>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_235855_427976_8E8290D8 
X-CRM114-Status: GOOD (  19.50  )
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

When a reserved-memory node contains multiple reg entries (e.g.,
reg = <base1 size1>, <base2 size2>), the count used for
total_reserved_mem_cnt is wrong in two places:

1) __reserved_mem_reserve_reg() returns 0 on success regardless of how
   many regions it reserved in memblock. The caller in
   fdt_scan_reserved_mem() then increments count by just 1.

2) fdt_scan_reserved_mem_late() uses of_flat_dt_get_addr_size() which
   only reads the first reg entry. Subsequent entries are never
   initialized via fdt_init_reserved_mem_node(), so their metadata is
   lost.

Fix both issues:
 - Make __reserved_mem_reserve_reg() return the actual number of
   regions successfully reserved. Update the caller to accumulate
   the returned count.
 - Rewrite fdt_scan_reserved_mem_late() to use
   of_flat_dt_get_addr_size_prop() and iterate all reg entries,
   initializing each one via fdt_init_reserved_mem_node().

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")
Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 37 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8d5777cb5d1b..9d1b0193864c 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -129,6 +129,8 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 
 /*
  * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
+ *
+ * Returns: number of regions successfully reserved, or negative error code
  */
 static int __init __reserved_mem_reserve_reg(unsigned long node,
 					     const char *uname)
@@ -137,6 +139,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	int i, len, err;
 	const __be32 *prop;
 	bool nomap;
+	int reserved_count = 0;
 
 	prop = of_flat_dt_get_addr_size_prop(node, "reg", &len);
 	if (!prop)
@@ -160,12 +163,13 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			fdt_fixup_reserved_mem_node(node, base, size);
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
+			reserved_count++;
 		} else {
 			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
 			       uname, &base, (unsigned long)(size / SZ_1M));
 		}
 	}
-	return 0;
+	return reserved_count;
 }
 
 /*
@@ -275,25 +279,32 @@ void __init fdt_scan_reserved_mem_late(void)
 
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
-		u64 b, s;
+		int i, len;
+		const __be32 *prop;
 		int ret;
 
 		if (!of_fdt_device_is_available(fdt, child))
 			continue;
 
-		if (!of_flat_dt_get_addr_size(child, "reg", &b, &s))
+		prop = of_flat_dt_get_addr_size_prop(child, "reg", &len);
+		if (!prop)
 			continue;
 
 		ret = fdt_validate_reserved_mem_node(child, NULL);
 		if (ret && ret != -ENODEV)
 			continue;
 
-		base = b;
-		size = s;
+		uname = fdt_get_name(fdt, child, NULL);
+		for (i = 0; i < len; i++) {
+			u64 b, s;
 
-		if (size) {
-			uname = fdt_get_name(fdt, child, NULL);
-			fdt_init_reserved_mem_node(child, uname, base, size);
+			of_flat_dt_read_addr_size(prop, i, &b, &s);
+
+			base = b;
+			size = s;
+
+			if (size)
+				fdt_init_reserved_mem_node(child, uname, base, size);
 		}
 	}
 
@@ -331,16 +342,16 @@ int __init fdt_scan_reserved_mem(void)
 
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
-		int err;
+		int ret;
 
 		if (!of_fdt_device_is_available(fdt, child))
 			continue;
 
 		uname = fdt_get_name(fdt, child, NULL);
 
-		err = __reserved_mem_reserve_reg(child, uname);
-		if (!err)
-			count++;
+		ret = __reserved_mem_reserve_reg(child, uname);
+		if (ret > 0)
+			count += ret;
 		/*
 		 * Save the nodes for the dynamically-placed regions
 		 * into an array which will be used for allocation right
@@ -348,7 +359,7 @@ int __init fdt_scan_reserved_mem(void)
 		 * or marked as no-map. This is done to avoid dynamically
 		 * allocating from one of the statically-placed regions.
 		 */
-		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
+		if (ret == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
 			dynamic_nodes[dynamic_nodes_cnt] = child;
 			dynamic_nodes_cnt++;
 		}
-- 
2.43.0


