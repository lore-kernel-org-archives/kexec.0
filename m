Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98965C56208
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 09:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qD4VW4BZeNXzCi3gbNaQKdLxxRurNtLyN+adWk+/0t8=; b=pjln6VVj8EUOD0BAXRaBGBkrr/
	dzH0KcysC1mr3kVkzw+l4kMZFjchrTaV//KpDWkaH2FSrgfgYZZuB0UtPfEVvfCmm7XaPltiwrUY9
	gHWfAp3NhhSSe7A+lnjQwGy7B+wXKka/LtTOz2a3xjYYQCHmlDCsMG0RsQRXs8qBSxlDvV8h5PDwk
	ixdPNG6tr0NSxPjQmYv1pihGan5mKD1nkNPxtwbS4pJz5n3j/GIKohnhP3sq5oJ0fJb7WtSMbkqvX
	zHxoLzAdVNRkQbsSuye27Wx0WKOP+DmutQkWtMwAjz2dY2Q10bbXFYBabQ2Z6HbfuLda0oibqpAio
	/JfSbpLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruXD-00000005QsF-2P2d;
	Thu, 06 Aug 2026 09:37:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruXB-00000005QqB-38hJ
	for kexec@bombadil.infradead.org;
	Thu, 06 Aug 2026 09:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qD4VW4BZeNXzCi3gbNaQKdLxxRurNtLyN+adWk+/0t8=; b=JXLxM5gqPBYsrSIefU0hzV+ved
	jEr/7ks4xICNIL+scWoMsPocZboJe7Akg07iYqxtV96ds02ISvRpexkRnbNJe5Z+g6Svi4A1h/KBa
	V/aUHTBiSItLT0VVqQIqyHPN9/76T6YE54SP7E31H6J1uOcyfoX/zBGPDjyoG4/ALOUC+MCs+yxrz
	9jkX6sBBz2sUA/UM9rQVK2mQdb5kWhzECqcbjnZ0HZrrNG6RhlrHn+N9dpRwQQYYgwgLNlb9Tkea2
	jCDs6XoXK3W85Mt7egt71sFi6g0rvk4ePsQoCJZHPpb/W60wJMaEFwoNbsFIjtoNbTY7sEYlQ5qDu
	7mi8OxXQ==;
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wruX6-0000000BNXG-3Hic
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 09:37:04 +0000
Received: by mail-pj2-x04.google.com with SMTP id d9443c01a7336-2cabe9335f1so10843745ad.0
        for <kexec@lists.infradead.org>; Thu, 06 Aug 2026 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786009018; x=1786613818; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qD4VW4BZeNXzCi3gbNaQKdLxxRurNtLyN+adWk+/0t8=;
        b=O54xxo+l8FLuoL8qdDPS3wXMses2/ZDQfxqvWbnFBiX2b7zkKty7vbpplVbeAbuxKV
         TmgQUj91fkTeo4R2h2arJ9MI1OyuMfRLVzWvc8/7xrpz5HQu6qrDIkrFuzfvUBWyPqAA
         kpBPBFVgU6VENvnDQVeXkzFY8Cl54N7AdsQ9snIhvHQDsfCD2VUAWFcNY9J7dB+aQ/HO
         JEObwT1vKOA+nATuqd2c7CN/QCVNiLJvN4C9+P8DlgReIJYUZ0Qg2vVuZwB+K8QZ2ddN
         atZNWQSyhnaAzXToHVRHypb07BB9NIpfITQ0a/M/9MQvTldFTpDigsklu7V9Aje90Z7b
         PCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009018; x=1786613818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qD4VW4BZeNXzCi3gbNaQKdLxxRurNtLyN+adWk+/0t8=;
        b=q7AQ200TMHHBoN8rZFBpoNArK4trcREMBuopSM9oHD2pWm3gptd815Rahifjltfh6A
         UlTeb6Nk0blPyFUwishJoSR2kM20APXz494gi0kNYaiMG5n0Yamc0bJJS5Txqqsx5xXs
         OarGvqHIX/laOW0BRmmWJC98b7ePLk3e04YrH/5FIrBHxq6o+xga2Ccdyje8rVRdgCYO
         /u8ehy9EpC0U8Q6cocZyUjYA0/MmpIzz8QPI/BnYR7YtxoWV+hOMUsVWT9pNA4OnBGtu
         6GqnYpUrXGrJKr0SCYAPkc84MUv6qcWs/CQ+lRfMcDP1KH4CF8QWW/SfBFEnRvnbDJ+5
         FWRA==
X-Forwarded-Encrypted: i=1; AHgh+RpT+rgtvDfDjhZa6IUpuaFW42V4UmQqXAzBjyE+vfqoaeRCAZM6vsnyn5kCMiYrRI9wSO1Kkg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzYXo1rEkFi85uDfPCdNexfiFDWoXF8hU2oxskVkyjFf34cFQOx
	wgMg6lSI0q3fE6Pcej/PZcdl/MfaiM42IJ6g8lfTtww7iVvJJpyrGJUs
X-Gm-Gg: AR+sD12JPUZkkP/iYv3iA0xVRKt+dDDfWCb0WYnv/QfROoKLc6am4AN+FUPRr6jvo7p
	lNS03q7TBbGIYj2QkBTHFEXZzIyRmNhWmL977nw1J/iGGuhRi/wkxgIqjJB2NtV6MUkUKs7if3T
	e6G90S62XiiIzFh0e8ZW5u2MBUJ8biIA5p67OK+dBBgYa/7HzXiKW9fzNjXOEaPrd2ql5UcL7Iy
	Zk2JexPJ/6dq5Mg6SjbsgpPvGAU93AZKR1vxFbABgYutoilEqC11vxGybNkwnI1KeubZhbMSmRN
	L4gpzjHcEkELlYYvzNONbPbpkwqvH61ncQvbuxqwaJ+C6HyzAjMk0gRGF+KFNc3Y1PeAb/tmn8M
	xW/J5H5Hyew/GEX/+pyQp70Mr64h4yCTkikjKkoqSW2k2bfwLrnLYzep7sTSdZrc4nuygMF4NeD
	XKszV2gCbdBjhA6bGZ9nbCw9HrZWZNPxsm/QfAQbrFZKhbrqqFJqTPqKvDPmBnGYtZbby7TyQcK
	g==
X-Received: by 2002:a05:6a00:2d81:b0:848:6c9c:4074 with SMTP id d2e1a72fcca58-84f2dff6cd5mr14050456b3a.1.1786009018224;
        Thu, 06 Aug 2026 02:36:58 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:36:57 -0700 (PDT)
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
Subject: [PATCH v5 7/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Thu,  6 Aug 2026 17:35:18 +0800
Message-ID: <20260806093519.2907771-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
References: <20260806093519.2907771-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_103700_971173_EC280760 
X-CRM114-Status: GOOD (  11.99  )
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

for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
weak defaults to for_each_mem_region(), which exposes struct
memblock_region and per-region flags, and filter NOMAP regions explicitly
via the new crash_should_skip_region() helper. This prepares for a
subsequent patch to extend the skip filter.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 kernel/crash_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 77285ae3ce60..fb78b7814f18 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -269,6 +269,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
+/* Exclude NOMAP regions from the vmcore. */
+static bool crash_should_skip_region(struct memblock_region *reg)
+{
+	return memblock_is_nomap(reg);
+}
+
 static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 {
 	struct crash_mem *cmem;
@@ -284,22 +290,25 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
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


