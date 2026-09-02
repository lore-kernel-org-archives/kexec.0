Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44691C624D4
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 07:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IlegJqwkFPej4fFKCV2MAr7wlJV+QNtxUfZHapDGJcw=; b=odQ5egfL6LikU+cr5Z347XsGZ/
	I5vb/bb0vI2sjwEbHjBUR+CfWrLe8duU/ce4L2Sto9jI5nKRh64TFuN/7H57aE8cVowxRxgnFfHq1
	2VSKV5GtLxL6Pw+t8nIhx7P4WiWDW7IpQgQXUALVOyKVfT4yLO5+yMG3eLG8oniN7ayRl45L5aX9I
	Ia8SdI9C1Iqn7RBj/hZCtfGAxkDM8nuUxHeRLPEZwIqzhuhrW6bpQKqF+9EfOOKk8n5YqFcLF9Anp
	4vTRqaHalNpcSxzMc35GSuQ/YBz1Gp/WSetQTdiYJunclBfCtGytoFxWKnMtPIUTc3e7GPjkAx+Ng
	wqbBRV5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fTf-0000000Dx6H-1737;
	Wed, 02 Sep 2026 07:33:51 +0000
Received: from mail-pz2-x03.google.com ([2607:f8b0:4864:3b::3])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fTO-0000000DwwI-48aN
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 07:33:34 +0000
Received: by mail-pz2-x03.google.com with SMTP id 41be03b00d2f7-cc1c2963c92so225104a12.0
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334410; x=1788939210; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlegJqwkFPej4fFKCV2MAr7wlJV+QNtxUfZHapDGJcw=;
        b=LRjyrchoDe0/9SlQNuOTdckSxhwQ4K9AReq5EuzhXjSpjI7oQQwLm2fSg1fvpqmMdI
         aZpsrxyW4oemsLIlz0SQo5APfufJAXb1LlQ6liP+uQ6Pv9/TSzGPZsoT5GkZvCzIHplL
         vJ4MxSc8VU3XCUWoARn7Fz/9BFLFxgNokBsjdl/DfMKpCRGMG71swd3F/WWqge2guUsL
         hAc+fWqkzvzvdV2ooq92tJEtnKsra7dI6v+YmhtJNoaJrJwBDbr2+UMwMu5Vn7172dTk
         6XoiNhp8ym6J5fkZq0NZTN/TH5Sf4Fcx6juNQMm3UWK6FSkqgMnjLUfprAkj7hdQ3jlc
         GG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334410; x=1788939210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlegJqwkFPej4fFKCV2MAr7wlJV+QNtxUfZHapDGJcw=;
        b=alJwRe46EDEh1ZxRFRKvz4SBxMtG/rRzvLzCvOKXUN7Ngx0FdD2RI3Qs9UdSqFMVx4
         XhCpmPGZAPWbNrKL3tccQzxAc3Q6xhCvcOR37u6FvX5Mm/XGE2u8CtWAZYWJwhB5qqxh
         TaP7gUNVHy/G58m4rstNfHFa/zuHjkj+kMAoA6WlOQWr7s64LZtd0vlKhxookjBORiAy
         lMWc9T0CDv4PUSxNyhO5KrlzFtyuRGeHC9mOXYIuUABka8QIfQkf7mnjtc0o0eOCMa8d
         QG7cFncAY2Y+ndZP5GbBkHsy3q6w+XUVgMK3wAJk+ZJrF2lQ0s5jMQkRnmDHnY/45OBq
         3MQg==
X-Forwarded-Encrypted: i=1; AKwUvBxem63HE+YIgCujYvXGaIO6NpeJBQM10KpbUu3jXmNmb/zC+GxpPussqUyAqd04uWMVy6ZxrQ==@lists.infradead.org
X-Gm-Message-State: AFuF++mlvM7mlJ7Qb/yzV/88ii+u4j7nrzEfIqvyRde6XMrw72ZpH+PH
	xpLInfgXzSrIH0GXmRgrw/forMQCdypJVjc1Ky/QjaP4v/KU9XDZf3fu
X-Gm-Gg: AYBFou2rmV5ZPaZm9+3fuc3oEJPoFQjQQ/RuS5UWytMravkacti2VtW05DE0ZU8qI7N
	9CXIlXh7hzjHkEmSytHQkdHLxnlABFAWyUYHjntT71+VSrhnJ1hX9l8/9wL/HFyzp4M7G/lFJ3a
	/FOge+Rs9wA/16X8WinXEe8kNXqK4XaoOnAN7eecZPxiI9XHacUMiRq3NhZfqs883Knt39vuBEN
	m2umsHBEV37bWGgTceIfJsLt480+xwDHnQ0yaNKUoHDYpmTyeV/qaluSo9aPYQUX9tg3CyUciZR
	npPYIiQQcLXUBMbX5bG1oM/4Q8kYvfioiwE3tpwFOXu27cWXtXGuApafDmcvvvP2Dnz3bebsqO8
	RTwiPLMTCVkHLZevYIPjrPHadGJAFtAc/MVrMXmtJ7Y4N28KM7sVB/RKtJmgCN+0ZTH7Rt8hEA4
	T3zIaBpMcbQncgIbaDjCLFf+TOGHqtKrwhvEDBG5dPpeWjjHMhA1z0vg8IZ9riGykVoTTCnQ8X
X-Received: by 2002:a05:6a00:4408:b0:857:4dea:e2fe with SMTP id d2e1a72fcca58-85ed8ed8414mr5132871b3a.13.1788334410213;
        Wed, 02 Sep 2026 00:33:30 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:33:28 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v6 09/10] of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
Date: Wed,  2 Sep 2026 15:31:15 +0800
Message-ID: <20260902073116.802752-10-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_003331_269078_4CD09DB0 
X-CRM114-Status: GOOD (  16.12  )
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

The /memreserve/ entries are memory reservations made by the bootloader
or firmware, their contents are not needed for kernel crash analysis,
so mark them MEMBLOCK_NODUMP to have kdump omit them from the vmcore.

Entries that overlap a dumpable region (such as CMA) are left unmarked,
because the pages of a dumpable region may carry crash-relevant data.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 286fd4db6312..9a727941b5af 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1286,6 +1286,7 @@ void __init unflatten_device_tree(void)
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
 	fdt_mark_reserve_mem_nodump();
+	fdt_mark_memreserve_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 505735732c13..6497404ec751 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -188,6 +188,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
 void __init fdt_mark_reserve_mem_nodump(void);
+void __init fdt_mark_memreserve_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index f29a07e8fb23..a42cf6eac55b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -251,6 +251,39 @@ static void __init __rmem_check_for_overlap(void)
 	}
 }
 
+void __init fdt_mark_memreserve_nodump(void)
+{
+	u64 base, size;
+	int n;
+	const void *fdt = initial_boot_params;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	if (!fdt)
+		return;
+
+	for (n = 0; ; n++) {
+		int i;
+
+		if (fdt_get_mem_rsv(fdt, n, &base, &size))
+			break;
+		if (!size)
+			break;
+
+		for (i = 0; i < reserved_mem_count; i++) {
+			struct reserved_mem *rmem = &reserved_mem[i];
+
+			if (rmem->dumpable &&
+			    base < (u64)rmem->base + (u64)rmem->size &&
+			    (u64)rmem->base < base + size)
+				break;
+		}
+		if (i == reserved_mem_count)
+			memblock_mark_nodump(base, size);
+	}
+}
+
 /**
  * fdt_scan_reserved_mem_late() - Scan FDT and initialize remaining reserved
  * memory regions.
-- 
2.43.0


