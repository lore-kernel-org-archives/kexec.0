Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEA0CD5BD1
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrSylNUfVMz9fGhknfQmD+9F4TfLhiOlPkwxJFsVly8=; b=su5x0ewL4IdESQr+nVhOkH37PX
	RwEoCMKkHf7/tRTFVMxcT8HEffcSMwXxuVxP7tEtnbU3padSvVEjZ0Pg9zPcKS5EFzhyAo/TYnUET
	V4STL5hYZRzzrjVJ/7idhRI+lLNrPCMl/ENgq78n4Ajtj2TZrkWTIxWy6BBQ7LsH3qFbI+1zEBJp0
	wJYnsQ2aHk4/t/brFgkLX55vejjRIpB2g8oWvoeBLKwe2zeo768TUAnpPkmA0RIHX61ZvdTRHO92U
	k4zBhslUmMRLZae88Q86Sgh6OktiLUILEuIVdlwB+QAgAprjS0RwyDE/yd3Lowi1BjfB5TGxug58J
	U6xgKSiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4z6-00000003Fir-14Ds;
	Wed, 27 May 2026 03:31:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4z4-00000003FgH-3Qjp
	for kexec@bombadil.infradead.org;
	Wed, 27 May 2026 03:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hrSylNUfVMz9fGhknfQmD+9F4TfLhiOlPkwxJFsVly8=; b=IGNuVaIcRa4Om4RQPJPnBvH4zH
	B2JN2C32l1iUIwW2JZbP4mfzjQNIB0Z0xfzG+7+QrBmMLkoaLmsJ6AzXXLjKWi3dR4ztlhtcQkY6E
	5UAtWzW9i3o6GAOhQr0xKP464dXYfI7qzZH+oeIEQ86e3NvYSlciNJXb55rgObje5/KJTP4GMqhYA
	QMY8tpc/xACeE3Jj9hKQeHaeEF1TVw4ziX40CKh3pEVhknxMva6QNXxbcCNT59dXwtUZ3g7Amq3ZT
	LvUaVhfMrGrh4k4i0/iLZANY/JanGPZEDta0k+vlMZ87hfqUhKRil+6XtdTWlWjkOH2xfTS2gu5/g
	wzb9QwyA==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4z1-0000000CqpL-1arE
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:31:05 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-83659d38e38so4604414b3a.1
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852662; x=1780457462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrSylNUfVMz9fGhknfQmD+9F4TfLhiOlPkwxJFsVly8=;
        b=nxPcgQ8oJOQcf27vLO2kH1+W7vmwjlB1JMpnSPG4JLll7iPRYjUh6fCIwaf47qus8B
         C1jGtShK6ooEl4PMSsw9RXs0nhlr1KVOTQ4gosp9vdJCvAhhWu/TcG3deMQKUXK41C83
         +SGT95Eg4w5vQq/ABZCkEVJ6s9rutCCCmBf2GfRXUv4/FTSajieGLG0iZuEnNKKLhduH
         DVtfXXLfeaLihzpQNT6slvTmNiU6WGLAWGjnYhhgsun2Pbp4nwiEECaZ5auxyOjP9/3u
         3nSk0/MtnjyrLt883cTqFfVqeS/EzAav4uNWXQNxS6MjGuYQCXhTgcbn8qmuqHLWsCYp
         ZE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852662; x=1780457462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hrSylNUfVMz9fGhknfQmD+9F4TfLhiOlPkwxJFsVly8=;
        b=ltkUgPyqfnr77AL0KgceDUcNJk0UDmPZjT3LtEDCXvnRg56pe7bKQU8b1d1UG2zst1
         bShrtrMW5JKGIHWzoRFkVDnqVlHRLzEgDj84c9XZDa4IYfuF5LglneRpWT9cnTqMOHkN
         6KQG+GHt3HDTGFQLBCxTVKmjShhN8YjS0St6oDNmYVrvx0Ca2otHulyvwICVxHrdHJVg
         d1baVGbF1si5Vse9UMXXyjAGehkket6s7343+1sB3s3tBzazJEDIVGSXt5U9NudiqEVh
         zsIc+HfYxZvyK+U/hl1hwihZUVmT1GTgXoLwGPoHwca0ADTWKtk8EIEa3iIz4Xw//uHe
         PKaw==
X-Forwarded-Encrypted: i=1; AFNElJ+MEPUxbfdEVQSMAk1Vkjvq8VvywzPJeroEUwWH2sGyg3UooJRg/d7CrEfAr1ZpOAL7Q62oIQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyloxV+q4fKKH2PQDKR4H1FyK+FqKWD1PSVuMqUWVuRXJXBAnV3
	ha2yGC0eAuwA3BGrV7tOceo1F7iSy5+WhZuLMn/X9RYaPbz+2L8uSVgG
X-Gm-Gg: Acq92OFE89rt10SvDQlsPnMwNluT5KrJR7Ody3V6lAuGplj4+9bBbOzO5Ze/momh6L3
	Cgm/zVHN4KqJ8Cz3hDnKU/Km1Ej0/IMOzAO9z9SVMwXbzSd7uzMDI2gXNUnVIyMqZwYEnLk3FG0
	qO94JkPRC8+/CNxtW1iyKO2nb2Kc2dQlqAgW2i+OhE8m6R4jdLnW/Yhrc0fumu6GbEvkuKXIAGT
	PuJYzAvavRP8MIDqIkmGCCFMqFUkl6Qt8rg1EEL77TUDElZJvWBLMQyiQrHw99ULHznZ8qQHJjT
	SbEp47NppF+QysZ2Mhktmbyqb+SI5xSaxJJcC1LEU1YW7qX8DtrQL08V4TesHj8DKd/H13yuUWI
	LQHNMA8ygY1UQMIDb+eRwI6uCUjiwBS5o18m5OMB87cf2AzE9ZeNYItgF4DfWwC/Rll4dSC+Cjt
	vrLK/71vKU8R4SdNl56HWNitMrLaEuChpvk143huMryTj8dFA=
X-Received: by 2002:a05:6a00:13a6:b0:83e:b22f:373a with SMTP id d2e1a72fcca58-8415f31db44mr19548057b3a.11.1779852662047;
        Tue, 26 May 2026 20:31:02 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:31:01 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 08/11] of: reserved_mem: add kdump helpers to exclude non-dumpable regions
Date: Wed, 27 May 2026 11:29:14 +0800
Message-ID: <20260527032917.3385849-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_043104_246716_CE314025 
X-CRM114-Status: GOOD (  14.68  )
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
index 5e27f9403786..1d9aa332325b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/crash_core.h>
 
 #include "of_private.h"
 
@@ -858,6 +859,39 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
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


