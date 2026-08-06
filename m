Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64B6C5620A
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JoRhdZOCeEiS1VMpBUeU4kVAqK2jVYvx0TEggrSzApM=; b=BXJSj5SudEVT5GaOBi/fUlyk2B
	hRbbhr4UOgK7m8gM6nfZWUb9lnkwce1OwgAFnjRUDGzz4OxBGggqq0ljJdsrXSQby2Pm911Em0DJO
	WmdEmyriuI3rpcjiZUvFTBTWXhOH/tHYkgbIyn8GkY9Y9JB8wDxPKu30V4EDjIb9gGnH5wCbOfE/Y
	SRMSr53bNIJdgWTCHlI1Yhik1KCSanNiJYyt3LZrZdmM+fGIzAvhjJ3dn6n88ZA30poi0I/Xbj3Md
	OcWpv5l9k2+m9sbgjOy8Lyq9uS4hxU2rwAOdMX1oPrIzYPv/v4e1kEhUBB8nW6J8LsyhIuxWP+Cwo
	bnb+CVtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruWZ-00000005Q2g-3WgB;
	Thu, 06 Aug 2026 09:36:27 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruWW-00000005PyG-49wg
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 09:36:26 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-84a2c90e383so561099b3a.0
        for <kexec@lists.infradead.org>; Thu, 06 Aug 2026 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008984; x=1786613784; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JoRhdZOCeEiS1VMpBUeU4kVAqK2jVYvx0TEggrSzApM=;
        b=jOoiRaXmpKO068h2SB529JWPNPqLGn3Mk2afl5DZpWW1o0o7195tf6jU1rfJD7J2em
         7BEiv1kXyor/hbvxH3CoxBRt2zMc7oB7QTOvsTfDL/ST8msJwlizQ30nhRtUE/wichC6
         f3XTEJh5B3GZKvK7STzkPuF8E3jEpoZSP2cLnG1UQ9CkkpHIQogQSoCAexMIbOi5XI71
         iC7GN1WxeF7FUNxDLyLVZAgqPLm/uyrrC/0nv2AArBHsnRIlJMCwW/TvjRqAulK3xLXi
         wZBq0OVczeaXTtxR/aEcMuw9COF9hRKkQLRL38ArE2//VCfqxQoy4cGdYPGnhNnHlYK4
         /FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008984; x=1786613784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JoRhdZOCeEiS1VMpBUeU4kVAqK2jVYvx0TEggrSzApM=;
        b=dz9DOJvZ6fnaRVDV8kJPQfJ4Et3xIyOgnhYTcsAn5jEhRuO1qBOkXilpRuE7DtcXy9
         bMgVp4ryfxNEltkLlqaAfxY1o+j/SNXwAmid8/3HVKcOlPXTvwbrE2dfnl7Ae+HzvL3z
         BSVIdknXXKMXfU/MwhVHmIwTzRuflxKlHA/nhyLJ0z+WFoptMGnvkmK4jw3bcLUKziFX
         jA7DvtHr8tl21YvFtt5ZI14ujPTEtL45bhgiPrqDxiY5T0/ehFSdFNbBlziHJmWyovoW
         AuOXHZ6IyNCYIvrss3N9yZm0tIPFGh1GHgJfnzDcMNNczxfpAYqFy8uBml+k4zdxUo7g
         ap7w==
X-Forwarded-Encrypted: i=1; AHgh+RqtmWciJ24QANm/vf4TiU0iewoXsYsJCAV4beXqYPaFmecTGYMsqL/IJYYspMftD3HvtJ40fA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjE/zpWtubXOKbsDBrinM2Y48YNCjtp+KFnN8EHCxR6gjgttOS
	C9Bk3V97wa+m8Rb8v0TiIJNXDBU3HoU3zPRi9urM6v7t6pvRz3bkpMhj
X-Gm-Gg: AR+sD13kxNNXucZqIvagKT3mDLQDg8+E3ZAYlVJOyMxeN/5aqQZuDXPgi5LjsxODm3k
	g6VgeWjOLcZ5bNge5Nsu7EAKvsTEeozc5Il3CR5QL0qyWkJwFpuZdXxvY28EtYdfwwtJAoqjQUp
	YZ1Kf1R1KKXYgerWKivkPYdIdl+Haq5kMnXNX+DPFH3SRPyXB6ydBq695THPUHslwo3PKz6NoSE
	WJUCsmdlspj1HCdT90pJuauoH+HRrk4fdxdDkORN8AQICVoys38ZMv06oMfE41sRGPyUR5VmJjj
	iJ4VycKcXgOkjVa2aCg822WK+JFHyIKig2283x83Yf7V1Q07M7NW4+el1O9aSFugVsT3m+L3nw4
	hTWps5CTNA9OPm+icmUG2+Eo8pWK81JFFK1av0hhyJnaa48HCtN9r8BWG2jmKUOnO0L+QALrhib
	fmHEkDSu9G82cs9VP5rMoCqOVr7k4wJS+LtsL8D7VGatVsHMsz3AW/Dpi7t3DVasEp75DernDhm
	A==
X-Received: by 2002:a05:6a00:f8a:b0:847:9dd7:2683 with SMTP id d2e1a72fcca58-84f41df42ccmr6551184b3a.9.1786008984000;
        Thu, 06 Aug 2026 02:36:24 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:36:23 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	rppt@kernel.org,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel@xen0n.name,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com
Subject: [PATCH v5 4/8] of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
Date: Thu,  6 Aug 2026 17:35:15 +0800
Message-ID: <20260806093519.2907771-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
References: <20260806093519.2907771-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_023625_057115_2A893AFF 
X-CRM114-Status: GOOD (  15.86  )
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
 drivers/of/fdt.c             |  2 ++
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a64afc3ded3d..2aa888997e9b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1286,6 +1286,8 @@ void __init unflatten_device_tree(void)
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
 
+	fdt_mark_memreserve_nodump();
+
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
 		fdt = (void *) __dtb_empty_root_begin;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..667ce9e46aab 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+void __init fdt_mark_memreserve_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index f38d11df6f15..f0683b5d77b3 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -251,6 +251,38 @@ static void __init __rmem_check_for_overlap(void)
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
+			if (rmem->dumpable && base < rmem->base + rmem->size &&
+			    rmem->base < base + size)
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


