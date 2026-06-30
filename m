Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A36C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nur8Ymdh1FRAljY2SkKXlWeVVD/O0p+FPkDXgbutnT4=; b=EGfE4dz4CXgtvrzx8uYRtTmBex
	xXJbwULJh05jbdoJlP7eQXkmmO5//z3RhYhZHFYhM03dhGE7FoxU96CiJLbW9t+t3iQtIEytYrlp2
	j+m10QDfm1LzqQcv8NSjFRHauqPy5PnZo5k37qJqqhyKqJCv0J0LB2hpKe7ncZFkvEWLuaMHbTYqu
	UHw9BW6e4r4DYr7knFBbpwGn+VwILM8pnjyVXBZodsVlXLKzI6YnF3rE/AcgDW1y2LJAP4XS4zYU1
	QbvOB+tURtKc2G+7YrO81MuzsS0LW/uiefnNGeQC3cId14N1clGxswxxB237bRcxt/vsOhvXPT9Er
	8Mr8E3UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTD6-0000000GAG6-4APe;
	Tue, 30 Jun 2026 07:48:48 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTCy-0000000GA9B-3C12
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 07:48:47 +0000
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-2c7ebfb63c6so26023875ad.3
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805720; x=1783410520; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nur8Ymdh1FRAljY2SkKXlWeVVD/O0p+FPkDXgbutnT4=;
        b=PJhn2Hq2sx31wkhsPtNucYJx+zE2iibLxk5rr4zXMDzeMt6dzpRslxdiuTaULiJhHu
         TGmMnwvgdLtPEkYzVvjbBIyBPIR1okLCFhrTr/MlbzCvLJM6/CIx0uKxjk7ca67nxVNu
         hJUqG1GjdTp0KgZTw06M8s2u07At0L11URpS+i/j6lHxP3V74Xgrj97Tp6WSaCFLF5cV
         AhKGGqRF1zU3COwkvvh+NYn735xo8Cu8AQDqW2iA7mEEUo/Rc8O6eGvCEdhGwWwyi3GX
         OMiRz3MlkseA7M0TCFnibSrh7+QoYwiwAU337qc9p/WjBPgOceTx0VsOGMmGheFV2A5s
         pV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805720; x=1783410520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nur8Ymdh1FRAljY2SkKXlWeVVD/O0p+FPkDXgbutnT4=;
        b=fWlQ8OsAIuzC8uWoDP4kosw9XpjSGjyRAvhBx9OFvIUXCy70E4YqKYHiytAdupSGm8
         Lj5fVZxqvDP/LzIdQzRrUwEvOWpF+KtOzFmivgkVB+Qteh44CZQUhY5aY5YwYkTMkWY4
         SFjf2D3Telpifv0LSYQ5dcJUhw0TcYKIyzoppqI6XYm0fPnShfpmH8oCZJ59ob3GCB3c
         9+YDPMGaM3hGIR5YgpP1HO8tjc1Lp3xFGyr/oWK1Y+yeMrSKmDyQ4rzNqrBEhSjxGBSx
         YqMmtEXoqpuUa3ExBaEs1NUH3ryPbv/+iICVjd6q+2drEQr6hO35Cc3aaoYzu6RD3vBP
         e5SQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0IXUz6K59+TC3zeGyJ9K6miu6YyJXQIIzjNEAdR8gX1l9z7rMgrCxtaTl5mDxwRyJ+CmBPg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxPraG85zGvMzqnaCqqgbq0TMGs/9CQm32BAb0ujsNQJgOjnujt
	HSDbyFfPIooemLnghSFRsMXalXf3f1yjWPi9tcrRBS38FhvBTV/XoDv3
X-Gm-Gg: AfdE7cncdhNRnHTx8vEDjL6WrmvEbKKT05wCdy27vlpk/rjg6oSzlJrQf7TfHkmT2Ku
	2zEY8k7CVP+QatrUW48DDzWH+uW8Pux3hbxNJLo1Xz5gCziwb85ykBP0pI9WUvXxXA4qfqOVUcI
	hBz4xi+KdDKqICmYc0XyV+W+VzMtCOxJag81f0BrmlgFFJSK2A0e7DKp4KlZE3eUHBb209VDj7R
	mk0zaOs29LME5fbQb/qBgTcqZElQ3G6wiu0weBOnnreW3K+GlvjMDwT3/QQUGBVnKHo8FT3uXq5
	f4dzQsEQa/wWX9uMMo3G5bwZc5W1NkwnVt8fHDXJpNcQf3HzttOxzImhu3ZO19LC2iNIDETTIhl
	/UdxsBwbz9gQNDLqxnND05Fu7TO3sekJV4WNG65B+NlY7F9RXiPF+y8fAJ+SGGHHZUm9gtxsNCX
	L87LAPAhTDiw4vndZR8AQC++CLnw==
X-Received: by 2002:a17:902:ecc1:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2ca2d52aa74mr18805135ad.4.1782805719998;
        Tue, 30 Jun 2026 00:48:39 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:48:39 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 07/10] of: reserved_mem: add kdump helpers to exclude non-dumpable regions
Date: Tue, 30 Jun 2026 15:47:11 +0800
Message-ID: <20260630074715.4126796-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_004845_913671_B0D78E4B 
X-CRM114-Status: GOOD (  14.22  )
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

From: Wandun Chen <chenwandun@lixiang.com>

Add two helpers to exclude non-dumpable regions for arch-specific
code.

 - of_reserved_mem_kdump_nr_ranges() returns the count of regions
   that are not dumpable. Each excluded region may split an existing
   crash_mem range into two, so callers use this to calculate
   crash_mem allocation size.

 - of_reserved_mem_kdump_exclude() walks reserved_mem[] and calls
   crash_exclude_mem_range() for every non-dumpable region.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c    | 34 +++++++++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h | 14 ++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9db0502989c3..c83ef88dffe2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/crash_core.h>
 
 #include "of_private.h"
 
@@ -856,6 +857,39 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
 
+/*
+ * Count non-dumpable reserved regions. Excluding each one may split a
+ * crash_mem range in two, callers use this to size the allocation.
+ */
+unsigned int of_reserved_mem_kdump_nr_ranges(void)
+{
+	unsigned int i, n = 0;
+
+	for (i = 0; i < reserved_mem_count; i++)
+		if (reserved_mem[i].size && !reserved_mem[i].dumpable)
+			n++;
+	return n;
+}
+
+/* Exclude non-dumpable reserved regions from @cmem. */
+int of_reserved_mem_kdump_exclude(struct crash_mem *cmem)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserved_mem *r = &reserved_mem[i];
+
+		if (!r->size || r->dumpable)
+			continue;
+		ret = crash_exclude_mem_range(cmem, r->base,
+					      r->base + r->size - 1);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * of_reserved_mem_region_to_resource() - Get a reserved memory region as a resource
  * @np:		node containing 'memory-region' property
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 55a67cee41ea..70db99f1fbff 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -8,6 +8,7 @@
 struct of_phandle_args;
 struct reserved_mem_ops;
 struct resource;
+struct crash_mem;
 
 struct reserved_mem {
 	const char			*name;
@@ -48,6 +49,9 @@ int of_reserved_mem_region_to_resource_byname(const struct device_node *np,
 					      const char *name, struct resource *res);
 int of_reserved_mem_region_count(const struct device_node *np);
 
+unsigned int of_reserved_mem_kdump_nr_ranges(void);
+int of_reserved_mem_kdump_exclude(struct crash_mem *cmem);
+
 #else
 
 #define RESERVEDMEM_OF_DECLARE(name, compat, ops)			\
@@ -92,6 +96,16 @@ static inline int of_reserved_mem_region_count(const struct device_node *np)
 {
 	return 0;
 }
+
+static inline unsigned int of_reserved_mem_kdump_nr_ranges(void)
+{
+	return 0;
+}
+
+static inline int of_reserved_mem_kdump_exclude(struct crash_mem *cmem)
+{
+	return 0;
+}
 #endif
 
 /**
-- 
2.43.0


