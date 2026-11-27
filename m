Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92934606A31E
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Km2ijHGh;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mkHcM7Ge;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qSZ/LUQQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=; b=Km2ijHGhNSa7gM
	PLxYDk7mUisNFrVIHVqFGSuoSqKRux+7TECk8cHeH7PRXomzQTvgqEQSYXYqT5mfOPdy12O56LPiX
	BXxH0hkUmTOuFQ2LTWkYTVr+VDRRgQgdzc45EC9JShzbz8EH2MSTKxN2xTCV46JhKZbS5ZhzSVqC/
	A6ab9TfR4ajOp5a48SJMM8gX0STyPHbQO0y2l4dsJHO9EAk0NqQ8nESauam4qnWagXkVrb2ZNalpB
	TvNavg2wLD3hPW7xp02mltv5284e08BOwHpkJjA+oRzr4IEgPCxUl3zWyYxRc4FhRLVnD6m7aRN3g
	Tq38ofQHCXlMRbhzY7rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrwf-0000000FMdK-0q7N;
	Fri, 27 Nov 2026 09:08:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrwd-0000000FMcM-3WDb
	for kexec@bombadil.infradead.org;
	Fri, 27 Nov 2026 09:08:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=; b=mkHcM7Gew9IcIqMQGYd/Ixgf3G
	5N7lahfyZYPCU+j6M60S6Yet+Y5DGOKKGP+xOrC86ubOU+I2F6MxK9eURPTHFYDdtjdy55m2lsCzB
	vchkELfgd6egCy11KcV/f69nOG0qg6tD+MWmgmwYRPuUYQ8WHdOq5dbaajvFCkFk1SJ9gX2unK0Xk
	fn8ZUzQtiGN4Q1Wjvp3Qm+Zaxd1UEht6kAeEbwO6utvakmW63q15ZXz7XZlZG+qOjcZbldntFlk63
	0P0PSbqWhIhp4WUWEbgx2aHxfPAcgrNC8MhQHVc5wlgkOBJJq78IueYKme1ReMOdGXGtKhk6STwnm
	bUnyAkAw==;
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrwZ-00000007UTN-1TeM
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 09:08:38 +0000
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-3b426133d98so2053001a91.1
        for <kexec@lists.infradead.org>; Fri, 27 Nov 2026 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770513; x=1796375313; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=qSZ/LUQQJCAY0eBWKLrV0vQJNSHhG6KE05bsTKhA8mJnaciMdF/QluTEfb7wsfwUNQ
         1zMs9X3a5iN6n14c1SUHCkGxk4Oy5kPB3BzCoQQqeoC5TkTS5gpSLAUL7en93+2ZWMc3
         w2RyqgHb+ECTfIt5zo+pENfnD/nc11o74acdN4+jbUsiatUIuoqifBksFIXpTVtGoZKq
         fDxMILX1nh9bXvmArDYUioVA8UAkwlM0/ZEjG7hYSiIVXFqZJal/VxApbmJl3+J5x2F0
         HTk+lmt+P5N79QsWxw2B8JZt50gVINLqfJNzbelr5Ja+TMhCtWz9eKP7nvxD/ulZQhy+
         BGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770513; x=1796375313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=BgvRxKt697ZK/WLng+piCWXS3K6T66n4HOMudC/aV+FgKZuvhpq87v2CS1HO1HLbnt
         KavGahf0tRKlzx+K8wGk3XaM45TEdc8NyCTolGv57dtPQHgNez9Vx++WGKKN4fkHYeO8
         R/7t7QdM5YktOBm1+in8rXyos2yPtGYoydX6Fi9pSorgGpjnvn5YmXiL0K75rMe39Xwx
         Gz8LXLkH7Ml4p80bAt8kUWtkZ5NEkXxY+13+RrqoTvtctMXWz+W8gYl1YMRJShDzErgY
         x0OilHyyk+mkZHEXElfDPpsl15OY1hfz+cRaDmkrEA0E2sHn4KSxv8mPqNHFM8QRebzd
         vOWQ==
X-Forwarded-Encrypted: i=1; AL+hErGUIWexCp4QSHxvXK8azkZC9l7ISXWBJKXcsoF4kPg84WfyYmBjup3eJFoq7ud7BHqDAV7ziA==@lists.infradead.org
X-Gm-Message-State: APuU4Z8Qp6nyYd6PR3XV96uisHrMbXaWXK+VpdUtM0n1jSXzPJtf7v9y
	kchSd1qC1LlyXBjsNl57k+fRsOUzgZYmzRiCEptQqpb3uYMK/FMvw9PL
X-Gm-Gg: AZFdTZcgiWL4bnaPJ4X4J/rFCDCU5spUadZFsZCqUHPXbUjAEAk4/apKZ4DNbFWCemb
	05BADLUmqtiQJmEu8ImWoPHKX2oqkeB/3WJmLty7ztWWgkoISJ9mUChJzG8fuxYFL6zFZGBkRV2
	lhjUo4coNCuaYLG6tokICVVSSQ/2K28OzknLOOMA08/vXWslVOzn8YvZ8j27lM1AF8zRvd4bZK0
	S2U+vApWfpAi5EjYXdSHwGRPQR/g4Z9zYU/+TMdT/EThms/5asuT23FnG3/gb6pctG+Rjyma7QY
	sAVhI1RQtpGPEBnW5zhmju7a+scx66svVgGS92Nobidldm6oIN1zEN1kklOxzdsCWq1nrKm+rMd
	5N1P8gWeQlcsCuCDNQPP01sjvOJDdnWO6jRNImaYZEoeVNes13nEUQdOMGoe+Qq4fWz7kW7uKRQ
	bMOmrJVjmnif0Iv2WlxTMUaUw/dv0upkqX4AAdfRNhgsjBvjynRXxpNc8tneVV0bMS53if8fnOg
	NZriZW9W7gWwW2i5MhvjPyGIY93f/KhPRYtkBwm8vRCKiLs+xitKVBcxaCiiH2Ukhv1PMDszuHX
	eEbYLXXuGl5HqRNGYhCpqjJPgMPQtQSExJeHYWff7w==
X-Received: by 2002:a17:90b:554d:b0:3ad:d29c:5e64 with SMTP id 98e67ed59e1d1-3b41c9b361fmr22966937a91.65.1795770513277;
        Fri, 27 Nov 2026 01:08:33 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:08:32 -0800 (PST)
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
Subject: [PATCH v10 4/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Fri, 27 Nov 2026 17:07:19 +0800
Message-ID: <20261127090723.741253-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_090837_035637_13B4102C 
X-CRM114-Status: GOOD (  12.01  )
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

for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
weak defaults to for_each_mem_region(), which exposes struct
memblock_region and per-region flags, and filter NOMAP regions explicitly
via the new crash_should_skip_region() helper. This prepares for a
subsequent patch to extend the skip filter.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 kernel/crash_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8a861a946e26..e161c8b65e00 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,25 +283,34 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 }
 
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+/* Exclude NOMAP regions from the vmcore. */
+static bool crash_should_skip_region(struct memblock_region *reg)
+{
+	return memblock_is_nomap(reg);
+}
+
 unsigned int __weak arch_get_system_nr_ranges(void)
 {
 	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end)
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
 		nr_ranges++;
+	}
 	return nr_ranges;
 }
 
 int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
+		cmem->ranges[cmem->nr_ranges].start = reg->base;
+		cmem->ranges[cmem->nr_ranges].end = reg->base + reg->size - 1;
 		cmem->nr_ranges++;
 	}
 	return 0;
-- 
2.43.0


