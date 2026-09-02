Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADA8C624D6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 07:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDn9kL+O/DcgCowWQhzjL1E+vRjYGvPyhLWTC672vfE=; b=Sa1XxfJEhdNXF0YIoTbbHXDv0X
	8SOG8lGfTHUIcndpSjWx40EN1GaykA+2ddSWroUTi1Kfq2NLQ3t0K5Lmhsvlx5sFynN/mcPo41eXr
	SbMW0xli9LxeqaAjz9QTkrEOnNLCOwFva+kNeIoUHQENkPfnXWjqznxlFbLJY3aDiRK1zsfuRW9Lz
	cXOntB56G3+FZxJH291FqVvRZORYEZ6c46Jx7MSX5OhXGD9Rkqp+Ha32PYu/FLvR57qEfsoeEV+UV
	hZF6q6x8JPr/V+pvbSeNr9jzg9eGvMTzNXmwEeNGGlFmUOUFAFYze4vayq/ePkMM/jmae2Y4CsRRw
	3OCccwGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fSi-0000000DwNf-0BL3;
	Wed, 02 Sep 2026 07:32:48 +0000
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fSY-0000000DwG7-3Cdn
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 07:32:43 +0000
Received: by mail-pz2-x01.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so237480a12.1
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334358; x=1788939158; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QDn9kL+O/DcgCowWQhzjL1E+vRjYGvPyhLWTC672vfE=;
        b=sKN6dp0xFA3KBsIyFai7kdNUjNZKjTCSeqnQEhg6IPD7/jKt6ExmPZ4N6WprLWJZ6W
         FCUUw6/lQrkY0Bms2oT8lcLrQo+9g/x+j+kF2kBbOOHQyoQwd8/MACzwkl4tb7W5kVA/
         XFXeSZ/ZUNrJQxD6szc8IyuJBdt6A4Ijwc9A/EaKeTTu2tz/L77VtXB94/7BV/edsrRc
         CNq8mF4SgCaLk1fFD0VV53sxxhZjivwE1U+k4hhIykyhkx4AVfhH20h1sAh2TaUJ1T4G
         KYM7k+Fw9GNb7V84H9vy8UHDQt6jc5w3v5FYTvnZNIcLWZin3b3KnP4hlOcmREuyrv6O
         2q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334358; x=1788939158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QDn9kL+O/DcgCowWQhzjL1E+vRjYGvPyhLWTC672vfE=;
        b=j0KzIU3GF3pOxLaAzrbGIIitzjXHuTYaw9VxCDspG5VZ++NdZ5mrGruYkkC9mM9VyG
         qSHRA6eiZVK4gLbeGQvpamhNmxk9UbDOAbuCbeVGXHSkq3bapFUpNtmXuWLnC/R80b4W
         Qc+mPpNTdwm3k0Yh9DsejZ+2mncdhPnCM6zPYmxej9UKG1Z5LBm7kwWgJlerNOXAL0eU
         uge6GZa+Sx0vBVJYnpaM00nzMuPhdSB2703I3RtbZM/2Bn77khQ5lOV2f8V0+ZoVGo+p
         yBQltCwEAVufdr+Al7jkRe2wGEDpVVd9WUMQl3Bbj9F+xKYby0pZkLxgjyqPNbAtYJgN
         zXyg==
X-Forwarded-Encrypted: i=1; AKwUvBzklaf5qaKaFj+Oj3n4h3x7z2fMoZjwjRotwvsKp2DqWZ2PcG3suSZLk8clAx87KAPaeuBn0Q==@lists.infradead.org
X-Gm-Message-State: AFuF++nebtJiDDDLxse2zZuxpEz0yXdGRjj7WGpCLwjrN7SrSJW5C2Da
	su7dbwW3F24jGk7NN+6nJ8Sslbt42YmA3YsTIb8nep1gJk59kiHY0hTb
X-Gm-Gg: AYBFou1wodxOABH2KIRcZILGLOts9fm3eggOh1JzJH5CG5976e3/yfow/yEB/H9koJl
	/PDw8qsKQKsEreSEkMlkaXQ3EA0/VJKg/3RQKjR5w12z8Nok+T7XuC65a6uYiTnlh56Utdpy5wh
	zxwI2B2cNgfzJjKZ4dZcvv4JAdyYHjAGDNgDyc2lpTiNHgSDirkEvm0E/7pWzXzWR836wwelr7Q
	rK9c4SrXM8bIrQqqlAUb2RA4YQ8Snu4r8DrC8b4ayr1m5DZbzVlLhzu/2PoqPk/NmGJNQYZEusi
	+oRBN3W0SfaCYK8iyfTeBRFpayOHitqBzrs+MRGw8YMaSohGvz2MsKhZ0Kp/WHVFAAEWfOtfY61
	AjpDMhX5ZozGc+Dal1OPa3uk0Mf6v6+n+luae6uJA4AXY52KgCS/GR8wQTsjHVC2gytx+aQDf41
	YYdL7jLsCzQth4xc/gaTn25KdxTtnmRfVGNac2jL8eRju6pa4v/N/1AxvRNWln6fgdfOjPyzIt
X-Received: by 2002:a05:6a00:391c:b0:842:5b66:3c7f with SMTP id d2e1a72fcca58-85ed444854fmr4147616b3a.0.1788334358011;
        Wed, 02 Sep 2026 00:32:38 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:32:36 -0700 (PDT)
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
Subject: [PATCH v6 05/10] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Wed,  2 Sep 2026 15:31:11 +0800
Message-ID: <20260902073116.802752-6-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_003239_658436_CDB43509 
X-CRM114-Status: GOOD (  13.00  )
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
index 3adee1ae120c..bd64cf585795 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -270,6 +270,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
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
@@ -285,22 +291,25 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
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


