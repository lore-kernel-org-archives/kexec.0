Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3199C624D4
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vi97MWhfZddiqmimgtB8vYuipDLussxDN6BUz0TYMFc=; b=bm9Vm6AgRzEMq+OjYICQcN3zag
	VI3ywTZMmZXRaXMiADN7Am8irYdt1oAQfjTFNDU6BlQBJ2ERvTA4F4W0C4l9fx135csCVnLa3rT70
	UgTB0LRwwiLZU6J4s91WaDhKp32evHhSzgoytAD0sBY2p/z5aGeOYyoYtDIrBwJnF9alq2IMCP5cG
	+USlnv0fNaAH8GGg1rDGZwhVN3ySxiuYZgdgC5EEY0Q+PwQ9wKG6HywIXdBztR2rw+9QGgEq30Qkk
	V2rQTLvCbvRbtfw9y6aHsHQkmsfVLb0MXzq3Wjw8bcgZZLjino7ktpne0NZb2dGkOAX0Y9iPY5zL7
	tSULJI5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fSw-0000000DwZw-1uWi;
	Wed, 02 Sep 2026 07:33:02 +0000
Received: from mail-pz2-x00.google.com ([2607:f8b0:4864:3b::])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fSk-0000000DwQW-41Kr
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 07:32:54 +0000
Received: by mail-pz2-x00.google.com with SMTP id 41be03b00d2f7-ca7fcfe1669so413731a12.0
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334370; x=1788939170; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vi97MWhfZddiqmimgtB8vYuipDLussxDN6BUz0TYMFc=;
        b=F0Q2WI90kCmV5i/mmBfxV2h6wAuCPPhQrWjdSW7WfVluoe4B8Y0bO7iyRQisb8Uj/7
         pGxffmpeaOnTVBnEm6O33c9JdaFVm5axHGPJyUPpEnX12yxzzENPaDn7//TvBoJbt6kG
         CAOvnImfSh0IEwJ3rih8gw8F6PSPtOX/3lggJOc+ZIp2qrqSWyiY5HW6vF5nTX6IHgZF
         WrXNSZsPmcyjgpNZum4r1FGM7BS6kYBsUPhxo0mQHEm42JSS2RvwsvcZoVt6A9fAsEL1
         E1Llw6jxFouxmuCkZTPC54jmhTAHvmRxFPeXifF7CT9EWDC6uI53dSj3td/cQrhbzDUQ
         xctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334370; x=1788939170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vi97MWhfZddiqmimgtB8vYuipDLussxDN6BUz0TYMFc=;
        b=Y04GQD4AszG4MbhUOSr3TQcbP0TGBQ7883XQkkwj55BeYYl5vN87TvME/QgfIXNTnH
         kAT0/RMhCKlkpPwC4kpH52M6JJ8Su8D3Ey7pcIBy/3bw7oqmhubaD1BMTjAG/RGAtGRH
         nafQBa8S4hCdD+CtjMo1JDb+OR39EtShq+RD2RtKyskWww/n+mjYNTnqYhjQrMycO38n
         lhvCKPQCPCXdf9kipv23cYLCp7sXL9DY+T7fnQsLKnLKCh/GnYopapHCUMydWMOZtg6W
         VtXCRS3RE4Xrz7ceRKzhHm3xEf2onNU7Rxvk1HBhychHIE2wZTzTUZq4FXIVU8X7JW7j
         a5nA==
X-Forwarded-Encrypted: i=1; AKwUvBwgPyhkcAwW2Trzd3rhaBHk5qb1c6adcPINkKXBjcxRPzVssBd7Wez/QoDrst7Gy2VwlnNf6Q==@lists.infradead.org
X-Gm-Message-State: AFuF++m2OgX3QtKC8DocRxUJInOQes3OvQuLX6MQzRTZY5aeg/27DtPG
	jJGgWcKxf3wgspEj4XVr3TK/nPZ/xl0Zg+AYWs6lrp4QZjeUsJCQOsGX
X-Gm-Gg: AYBFou04wHz9Eg52nDl5SvpKhoaFEHDjwUSz9b6B7ni4IwE2yLsi4p4T/SL3YmkIZFI
	qRgud8aATNXaVVe5YDfy36nz0FGl8V18rDzf8aj0pFgma1j6HoGGNbDElEROOye2GOxcoSu4gH2
	97lL7mfH10r7/QCAiQt1zisgteKGQZl0NZ70Ph7c7jMRJ+vmsyjL6cWGlZp+3YV81fai5seASRN
	S0PboF4PbXhP/sdaLjQKweALNdVwwalnlVcvoIRxiYpn50Sk1B6putu0JhqC/qTvUFf3IDEYdhB
	FIs693WDwcdUX+YzKjQ65UwIDgZpqNgWfswAkuTe8r73f6J0EbO/u3TyUbywKRkvmY2hDmuuqAh
	yo2YAcie6ZqCgRbZIwvBg6rcB6BMhEGApWXOaicgLUOwEgJIqgtvv2ohXUOAQeY9sQb/lvRYpeA
	wsF1/AA5F/wANPAy7XAI3dKpS2dmOeNKBcqn5rFl0yeDIJ3EUR4hOjIkOsKNJFjLMocTZvU8PY
X-Received: by 2002:a05:6a00:8017:b0:851:ba04:ca02 with SMTP id d2e1a72fcca58-85ed398adccmr5532767b3a.16.1788334370199;
        Wed, 02 Sep 2026 00:32:50 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:32:49 -0700 (PDT)
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
Subject: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Date: Wed,  2 Sep 2026 15:31:12 +0800
Message-ID: <20260902073116.802752-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_003251_109673_A368DF94 
X-CRM114-Status: GOOD (  14.24  )
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

Add MEMBLOCK_NODUMP to mark regions that should be excluded from
kdump vmcores.

The flag is meant for reserved memory that carries no data useful for
crash analysis. Reusable reserved regions such as CMA may hold useful
data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
patches wire this up for /reserved-memory and /memreserve/ entries.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d62db9e776cf..b2fcf11fba2b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
  * kernel that we know is good to use. It is the only memory that
  * allocations may happen from in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
+ * for crash analysis (e.g. firmware carveouts).
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +65,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
 };
 
 /**
@@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 void reset_all_zones_managed_pages(void);
@@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_SCRATCH;
 }
 
+static inline bool memblock_is_nodump(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_NODUMP;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index f2952d725c10..2e87f39826dd 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1204,6 +1204,21 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_SCRATCH);
 }
 
+/**
+ * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Mark the region as not to be included in crash dumps.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_NODUMP);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0


