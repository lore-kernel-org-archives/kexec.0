Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217EBCCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=; b=iJCSH2sT/8Dm1dXkMLBZuLfvsW
	wPmtwGOPKbw380yU6QBcySagF6kF85/V28j0wFsl+yI7TsyAeEpNQDNHfjZYKR8Tqsqyn975S9xCe
	dwQ8q71obYreQwfSUQYPGmNXRdykuPxCcwlQurVYLae15fHsAAJ9n8aOBuEAImeHqmKmrnxkFX6KC
	3iXVhGv7JxtFSwY5bXea/QAZcE+vt4Oxb+oYFpSkDAT1Q82R2UiWh0fRsELtr4BxB6fRP9E2AbLO+
	dPNTdzQOqPisbyN45QEQIRQz51Euv+035P1ZqXaS6Ehg94uzl6oeqfuCOoQPgo9gXnUHdYlWtUL/c
	Z4WAQPkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbFT-000000025W0-0aMt;
	Fri, 16 Oct 2026 06:16:59 +0000
Received: from mail-pz2-x0b.google.com ([2607:f8b0:4864:3b::b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbFQ-000000025Sn-39UE
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:16:57 +0000
Received: by mail-pz2-x0b.google.com with SMTP id 41be03b00d2f7-cc1631a57d2so1161799a12.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 23:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131416; x=1792736216; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=pp1AAe/lFKiIimKk2DmJ2eWPLP5iCgM1pUo8Ytb+WvTHGPv4EZ/T7VIEd36aeRhrlJ
         N5wvNbGiQivEoq1Tl2McAj4pw1UGYH3wOuVGcd9FO5mL9pT6QWAuBzNcg/mlXGvw8Z1K
         5ZcVResE9ZjQ4NKdDCtE7rpwqjKd+iQIBgnx+v49P8ZJxwNyH0MyGVxBaRKnSp9xMEri
         6cM4YWKvNj3r9MmXll1CK2wfxSV/KQlI0z4AyjtjSbDgGnw80THERfiNL0eF6OcpsGQg
         hcLz6gv3shFCVxNLgNFKGXkLrWOrTKytVpwGye4ex+VeX48NdnVNgRSdafHFbs1bsZhS
         Ycjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131416; x=1792736216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=hAiFEgJ5LgabopMjvgFjc59HXGT4TYmG8fRVybUtZyUXYMzVaFs1tymk/6R/lhS9ol
         1jArRJpETHdr70BBa6fyJDSEeea1mynrtHnoh+x5tcBiNVcjSRClYbqzjXYa91feGNf5
         ohp8stDLhp37sN4oL0Ew5Ya4GtvSpUe9GlpKT9AptIqkfD04BCgXQBPEZN92BcrmlHKk
         JUXdV4SJb/nhyWBwOVQCEJcK2eykEFuCSTWqi0RA42ZuoLEfmbsSq6tXn9/KCnOVTRkT
         LvOgwlPWQDejm7Eu54w2QTKmFvCRyZZZjI4cfyDWzUV1V0otegzfVljROc48IjLObAJJ
         +qbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqwqj3533edRpG+N2gF+lWtlix+F7Szoq3PA36FBK7/45AmdLnFyZuoK+St/tooGaCXc9qXw==@lists.infradead.org
X-Gm-Message-State: AFq9FYIJNBtD8SDueIsO+LW9EN4FYg/7LYHEkJVkA2jDbWGGS1O/fWD2
	i//wkEm4yNdfIvyxca5xWtTeCEdLwmwOBhWVI/DwD3/jBH9kmPiQ1lT2
X-Gm-Gg: AYBFou1LItL2ugLrIAZ8c5EWtRkPobQ9ryOOUYmZ0pTQEGRoMJoYMwakwDaYBNVqJu0
	t99bjFb0KwW7x3LT9n+XSuGIUXq7w1gNyT7Rk4Ys7RtYsyqHsAPQhZ3VSRe/uAQVEvL3NlitHDM
	vXfDwTP8h0bIX8EQekpU/re1AteP84vB4N9gAr9R8KqgMx7pn1IHcWFvCCGQCrjD6kG3k7oYDKB
	tHp2UdqaDlQlnCRd9slj5hsiXxBCuYJyNtXVTHKwgFJ2aGY1tq80DJXlqt/niPWaDURh68uTa8+
	Whmsq44cRQWEFeDjbNDPRYjnUVGjngO9epfT1aL8QQUOoQNWlcUopAgEFGvQPIxEU2keijG/o5Q
	TnuK7fMY4STlw3IpiWICgIruYFuDMaKP28G8pfUpHT+rxwlvQAqoAGIGpwRsFCrgbAeehHKMqne
	b7FBFK9h4dRhPnT4Ium+W14WAg1J0glN2+rc10QLV65NZrV9nVeN5qqAjFMkjknGajPm+MoQieB
	MM4LfVKlQ8=
X-Received: by 2002:a05:6a00:b8d:b0:89d:ec58:ce47 with SMTP id d2e1a72fcca58-89dec58cf9dmr5849396b3a.55.1792131415787;
        Thu, 15 Oct 2026 23:16:55 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:55 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [RESEND PATCH v8 4/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Fri, 16 Oct 2026 14:15:45 +0800
Message-ID: <20261016061549.4181390-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016061549.4181390-1-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_231656_793272_CB07B296 
X-CRM114-Status: GOOD (  11.50  )
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


