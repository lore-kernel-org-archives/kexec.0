Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90046FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 06:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2q9dPj7TNisCrTMpZ3igJmznQK/scPvx1hraOs9ZEkA=; b=f+E/WiYJ+gpUOq7r0wlCT3Xw9I
	iROPq4L36mfUoeh/EAbfVqdsH1oL1to1oDrLg/dr+31T3V1tdKJ2jq5i2efzwNlrBIyi2UhkpbX/9
	lQAifweN1Iv/OyDyakHc99/g62MXxe3Hk0jjJNTYqJp3jplc8dI0/B2eU16X7cUeIK8QwfBDTNVLQ
	QfHOTKSzBKdgQX4Cr2k7WJ+MhGTSmcL4ekxsxW4FVZeYdw4s/s7HeAXjeZdUS1wLh+go2XhdjOApP
	4eYjWfACui6JJBScowBMZmyOX8fs4Z7hP6ySHUSGf0jng+PEgFGfva4IKhsgObDUFPJKyw6RQkEHf
	B1saoTKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHytm-000000035c4-1h2n;
	Wed, 29 Apr 2026 06:59:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHytk-000000035ZL-2QfF
	for kexec@bombadil.infradead.org;
	Wed, 29 Apr 2026 06:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2q9dPj7TNisCrTMpZ3igJmznQK/scPvx1hraOs9ZEkA=; b=HFFVNDBCNbkhDqyVk09yfIb5T1
	bg7ffGab4RrICJxeQqWcYzbO/E8h6qfIYgGoYrX3axuDnJ6wj5HKDXJCNuexDCoCZRMil6zKMsFqv
	H4Z9xZOsLqyiPB5dpO4uaDOt3GE8PzrtgRIEHCl7zaSu/fsCHuT91m1xyBVsArJQ254hPGywsASp2
	C56w//xFKOKTPJGi4zyD5hazKchQJ6K8yHsN0n8mV3gz190QtDAKoDONJ68fVmYamM7qlmKV1h1Jp
	n142e+PKdrkIvuCkTgLlih9HvoPtk8Aa1STe/TwqaJfLr3OZyUN6I7k7OtxspuCmXYyEa/yw5q6ZR
	DxDVI/Sw==;
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHytd-00000004i54-3mf4
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 06:59:47 +0000
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso4822219b3a.0
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777445983; x=1778050783; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q9dPj7TNisCrTMpZ3igJmznQK/scPvx1hraOs9ZEkA=;
        b=VoTaBsd53E7f5I+Pa43cIvyHThx2aIeqCkfOD4WtD84VdnPNEjjNm+7f+4p5OAyZ//
         R4n9QiCiqpHrvs2v8t63cHeJL1tR+nZSfvPTfeg0IXhGPti/Cj21vIjK4SqpgJ/VxxPq
         YQEUVpk56Zi0Y9iCym02lkI/grNeS4x/PWdjffEAebzZprOL2XmrjpeVr3POrz18P2GS
         2jYTNcdmqj06l5lcU2jdDRK/vLTiJlGegj9p1eYj1GShWkj//KNF0VcBkYsVWUIMOz2Y
         tDcC7ct+LNDAxlJOlgd2bWdbAAKOOo7LBUfP8juL6R8tYBEltOM/2adql7AyKtoypN49
         pu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445983; x=1778050783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2q9dPj7TNisCrTMpZ3igJmznQK/scPvx1hraOs9ZEkA=;
        b=SL+qR17bb4LiP8UGd2R6mDfbJQnrBFoiG/4PfwxV8lZyXV1SO1bq7n/AfDX5lm1H/o
         Hix8Fi4WEaK78xQhn5ZttLI0nSUB/nsqwOVPEjznWBM0lrqUbVWD18gjI+gzZr2LjxZ3
         GE/WqKAh9RHTbqv7OIKE8mJtVbz8cf8aRmUTyrkkKG9r0jk7AXCF9bntM9Th+58zASSI
         gey4RU83EoduhBuLm3xi8H+Jh2XitKZDgkcRCFl2nAZxffex9iGS+cvhSYHl1vkrgzAO
         Ve1f18HrOUbTKi2tSJfyb3LJlQiltGdSA3bOQP9+IBONMGfoRcPguloezZvga3FlozP3
         kOXQ==
X-Gm-Message-State: AOJu0YzKs1aoqjPScvurfRR03/r6YocL+59varELcE7omHoMFNof2PbH
	7LTPRG9Km8f1RxMmKG5z17fAYOHTKsKHK+pU59vCZRd6b49PLJP8PYmPcwHbqSjiDp74QzbN
X-Gm-Gg: AeBDiet56Fc8c4xneA8OESY8WGSzYUPjc37bfyH1Ezye7+uE2PVmP7nHLprHsgiItr2
	2dCLwNF2e3Vt6GrmTeF/DUy0ovU3aNk10GMadHySFCTN7wvE4MFUcOMYW2+OX0Doxq0pgXjDvjZ
	YvdOkhaH+dgV6NHulABNJF7Z+HUiZgRXNfnittM3b5FDmyTWpD5eg70t+zI3ES/QjtI5MOuAhem
	rR69bajYsbRJ5zYgiXWs+rk4yJT0VKUKNZWrn3uhm7L6UlQWPK+/a1E27I+stwIQ7XH6Y1dDeVt
	DnY8dqOhxK8uD9km6BOcK1MoRLwpt357wifo4TGFsz7M625YnVFh2vzXQAI7mcaakMi7Bsn8aV/
	lGjeme3bJ190kBGcpGtmVExLDf/CUcfZ8grT13mMvh3N27sTXbgY/oyxORix61AWLUA94+Oz+58
	6Qg5w2cH8VpyyXpCQRxDw7vDesE8iBgv5UdsgAXNt+tbQLTUjT
X-Received: by 2002:a05:6a00:1802:b0:82f:bd8:70eb with SMTP id d2e1a72fcca58-834ddb5b988mr6406851b3a.21.1777445983273;
        Tue, 28 Apr 2026 23:59:43 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eaf93sm1043146b3a.40.2026.04.28.23.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:59:42 -0700 (PDT)
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
Subject: [PATCH 06/11] of: reserved_mem: save /memreserve/ entries into reserved_mem array
Date: Wed, 29 Apr 2026 14:58:26 +0800
Message-ID: <20260429065831.1510858-7-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429065831.1510858-1-chenwandun@lixiang.com>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_075946_199826_26BFFCF8 
X-CRM114-Status: GOOD (  22.53  )
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

Save /memreserve/ entries from the FDT header into the reserved_mem
array so they can be consumed as vmcore filtering metadata by kdump.

/memreserve/ regions hold firmware or bootloader state that is not
useful for kernel crash analysis, so saved /memreserve/ entries
default to no_dump=true and are tagged with name="memreserve" so
consumers can distinguish them from /reserved-memory/ child nodes.

Some DTBs declare the same or overlapping range in both
/memreserve/ and a /reserved-memory/ child. Commit b41328187629
("of: fdt: Scan /memreserve/ last") describes one such case on
Khadas Vim3 where the range is in /memreserve/ and also in a
/reserved-memory/ child carrying no-map. The /reserved-memory/
node's attributes (no-map, reusable, linux,no-dump) are the
explicit declaration and must win over the firmware default,
fdt_reserved_mem_save_memreserve() therefore inherits no_dump from
the overlapping /reserved-memory/ entry rather than silently
applying no_dump=true.

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 107 +++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 16 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index ac3d8b837d61..4b80420da2d2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -252,6 +252,49 @@ static void __init __rmem_check_for_overlap(void)
 	}
 }
 
+/**
+ * fdt_reserved_mem_save_memreserve() - save a /memreserve/ entry
+ * @base: base address
+ * @size: size
+ *
+ * Save a /memreserve/ range into reserved_mem[] with no_dump=true
+ * as the firmware default. If the range overlaps a /reserved-memory/
+ * child already saved in this pass, inherit that entry's no_dump so
+ * node-level attributes (no-map, reusable, linux,no-dump) win over
+ * the firmware default.
+ */
+static void __init fdt_reserved_mem_save_memreserve(phys_addr_t base,
+						    phys_addr_t size)
+{
+	struct reserved_mem *rmem;
+	phys_addr_t end = base + size;
+	bool no_dump = true;
+	int i;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		phys_addr_t r_base = reserved_mem[i].base;
+		phys_addr_t r_end = r_base + reserved_mem[i].size;
+
+		if (base < r_end && end > r_base) {
+			no_dump = reserved_mem[i].no_dump;
+			break;
+		}
+	}
+
+	if (reserved_mem_count == total_reserved_mem_cnt) {
+		pr_err("not enough space for all defined regions.\n");
+		return;
+	}
+
+	rmem = &reserved_mem[reserved_mem_count];
+	rmem->name = "memreserve";
+	rmem->base = base;
+	rmem->size = size;
+	rmem->no_dump = no_dump;
+
+	reserved_mem_count++;
+}
+
 /**
  * fdt_scan_reserved_mem_late() - Scan FDT and initialize remaining reserved
  * memory regions.
@@ -260,6 +303,9 @@ static void __init __rmem_check_for_overlap(void)
  * "static" reserved memory regions, that are defined using the "reg"
  * property. Each such region is then initialized with its specific init
  * function and stored in the global reserved_mem array.
+ *
+ * In addition, /memreserve/ entries from the FDT header are saved into
+ * the reserved_mem array so they can be consumed as vmcore metadata.
  */
 void __init fdt_scan_reserved_mem_late(void)
 {
@@ -270,28 +316,32 @@ void __init fdt_scan_reserved_mem_late(void)
 	if (!fdt)
 		return;
 
+	/*
+	 * fdt_scan_reserved_mem() has set total_reserved_mem_cnt to the
+	 * total number of entries to be saved (reg-based + /memreserve/).
+	 * If it is zero there is nothing to allocate, save or check.
+	 */
+	if (!total_reserved_mem_cnt)
+		return;
+
+	/*
+	 * Allocate up front: /memreserve/ saves below may run on any
+	 * path and must write into a memblock-backed array, not the
+	 * __initdata reserved_mem_array which is freed at free_initmem().
+	 */
+	alloc_reserved_mem_array();
+
 	node = fdt_path_offset(fdt, "/reserved-memory");
 	if (node < 0) {
 		pr_info("Reserved memory: No reserved-memory node in the DT\n");
-		return;
+		goto memreserve;
 	}
 
 	if (__reserved_mem_check_root(node)) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
-		return;
+		goto memreserve;
 	}
 
-	/*
-	 * fdt_scan_reserved_mem() sets total_reserved_mem_cnt to the
-	 * number of entries that need a slot in reserved_mem[]. If it is
-	 * zero there is nothing to allocate or save.
-	 */
-	if (!total_reserved_mem_cnt)
-		return;
-
-	/* Attempt dynamic allocation of a new reserved_mem array */
-	alloc_reserved_mem_array();
-
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
 		int i, len;
@@ -342,6 +392,18 @@ void __init fdt_scan_reserved_mem_late(void)
 
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
+
+memreserve:
+	/* Save /memreserve/ entries (independent of /reserved-memory) */
+	for (int i = 0; ; i++) {
+		u64 mbase, msize;
+
+		if (fdt_get_mem_rsv(fdt, i, &mbase, &msize))
+			break;
+		if (!msize)
+			break;
+		fdt_reserved_mem_save_memreserve(mbase, msize);
+	}
 }
 
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
@@ -365,11 +427,11 @@ int __init fdt_scan_reserved_mem(void)
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
 	if (node < 0)
-		return -ENODEV;
+		goto memreserve;
 
 	if (__reserved_mem_check_root(node) != 0) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
-		return -EINVAL;
+		goto memreserve;
 	}
 
 	fdt_for_each_subnode(child, fdt, node) {
@@ -406,8 +468,21 @@ int __init fdt_scan_reserved_mem(void)
 		if (!err)
 			count++;
 	}
+
+memreserve:
+	/* Count /memreserve/ entries (independent of /reserved-memory) */
+	for (int i = 0; ; i++) {
+		u64 base, size;
+
+		if (fdt_get_mem_rsv(fdt, i, &base, &size))
+			break;
+		if (!size)
+			break;
+		count++;
+	}
+
 	total_reserved_mem_cnt = count;
-	return 0;
+	return count ? 0 : -ENODEV;
 }
 
 /*
-- 
2.43.0


