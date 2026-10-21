Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05C606A319
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R3jBRFA7;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ADoDC1yW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G/RBfF3P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=; b=R3jBRFA720cooSNsEsXuGo2IM3
	bZSLPx9Ez2Yw7YvlEnUruLREjGpFlia+1jZMwfeRZ+vOVIaX9sRa//hmFW7yNkSIze2oRa6SaQRbH
	dvHX7uRTdZtR4ewHj67wKkNqQTmWQHWEj4JgVZco71oiitbgVCx1RpH9Pe/hVKedlSGLpxnibhk0v
	iDXfVeLt1y7L+oVabnCOM0YhF7siN/43Ig8VgwRhehTwC/n0oztqM13gBfheonC6GDAFE3+/V/3iH
	y6TwhNg8C82XdtJnlCt1jZSADARSKQmQVi4uVaoK+XqnwKC1lvU4OMYJLw7sQxHCng7WgNCsm9iM7
	qsS+mqSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRjU-0000000BMfW-2oly;
	Wed, 21 Oct 2026 08:31:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRjT-0000000BMe9-0SeU
	for kexec@bombadil.infradead.org;
	Wed, 21 Oct 2026 08:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=; b=ADoDC1yWwNJf9PbRcFzxqOvfWy
	QtVfKGiM14v43UolHSoCgSkOAMTJX9LlUSr6MOdcItyM5KoIY6r262Vvzm6Ky+Xd/SfM9uN7vyfXh
	weZ7IQuLY4cOaAJSVOXw9n0u/+l5nriAVWR8TwaTqfNgAwjIo0iI1YNU86HYrzOMd+Jk5n3PoardP
	1Ad+gPADRT0WWYA/HhMyz6vgr6WRfqwpNhtEUO3TxnsC9AmPJs4TSVMzlsfkprE0o1ECGNNJNuejt
	FAhferG1sNh+C4CcXT4XnU4a6W/b5y2zvlmW4vBsCU9rzUWwN4KT6dlbcq2jHAJEu2ixfoIoSNrgo
	JztcMdpg==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJRjN-00000005b7X-1M3I
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 08:31:31 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so260417b3a.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571487; x=1793176287; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=G/RBfF3POz5+8CaJzF0JngkL5IMR0GZ6clIlCpy7GEPoBsJvnVK8md93cutbrtQKAe
         wK15WsQXEiPiSxbt/rdZbRAy1/FuDxwBw6BQpEzKqo3ICoPDQwyDc+SyCQvXzYpJ5fDz
         /4fEcJfZ63pHmjpJm592Vo1SrWKyyDfTWT4R0qiVmmd1I3FmKatsFJpf0OC5RxkYNc3w
         lkmsVY70sB304tLhoTlvSk0QLgCrOAyLvYPdiuHiBEBV9EX+hqcV1HMX9O5Sz37tfd3m
         QmJMEjM1/hsGbNGaeoy4LAKUeKT2i6rFq54032DPmTHDJlULeacOBzutg/NuPpCFJSwp
         ouLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571487; x=1793176287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=qKSv7GN0I6xSL9unUvAeEIpqkzDFEyr07553/EyzFfuuNBYflMX+pXsqMk7hQd5k2x
         GV6c6tm9LNIrMD0jVFDPA/+5z82cGfWmNxT3GtPZroIYs9I0j/HaSlWovosvoYyhwlZ7
         frHmIegUwwdK9kRZMiDwDm8OV6BtIUeEa16pLOoywHcXgu8RqFqiRVSelB6IyVGNU1cJ
         f3kBIDQJMPR5a21HeR9nq5mKbMgiirmhiNsheSZlWdd0clvtQK//GQ3tNIsx0wCskx19
         HzeMiPcHSolNm9FHPksJAzl1jYultk311ps86EqwzfaV3A2W7sVixvjtwEEcqis32bo9
         LoDA==
X-Forwarded-Encrypted: i=1; AKwUvBwq4EiA8vwtPNyRLUr9n/FPRXQo9kwF7R7uqQkfRPjT2Ub8uWw4YLqKxpSN0T6cIiBRDY/l9g==@lists.infradead.org
X-Gm-Message-State: AFq9FYIc09ij/a1S2lJzK2gDAPnQsSw5oY8nfH+wbUwt3b2j8/G+hpBL
	cCju+gqcDogl+QnAoyTRLtDhG+Cc29SXJCNa4zGHchySD8ZqFjf/vyFR
X-Gm-Gg: AYBFou0jIvuK7emPEu0mkntUfoQM/nrJRovEXP8u7/Xv9/+yeEJOS2EA2Iy0rJR9FyN
	hMShcZF3ADTrluRitYwFZkvj3/Fvr74VM/XDQdI8mcRyLZvmLW0f+wwRJe/zfLIU1ynfvDQQYk2
	JYP71BottvYcYDIImtdvHEUc+AehOTdtxgF+xMwrbu8t5V/Vhfsr3vKapnJlY2Pm+53fQcbmZon
	IiSsk6mHaJoYDT795fH+jePjedDf1VEqgaRHNHZsrd447Ku6GcSDhR9uu5P6ng26PDsYEGRhK9P
	RjEBrd3Fw5g+JI+49JIR4srl2UTRT46tbB9X5UI+WMru+JzOhlkun/0pFg8iBcTbnMlgoAAvx1S
	WCHjWARJz7GdWFW53TDjGhHkx+KOx2GEWEW1GspMn+TEc1q4OglSn5jJBthCwSLY37QaBr0tlVJ
	T/SVhIdYldCqqQjSmVM+h5SsUBmtEKDd+Zdc8L4lmZR6fuNnwD/MGsD3CnlB9FuNlONnbdqM3Zw
	47Tv4CNd21c5RP30pFwDFDlMVsLS/lD21DsJHSpziFrLqpi3qmdHICqTe6GrgdmA9GIUJhHhxrF
	PuwhEUpkl540KQ==
X-Received: by 2002:a05:6a00:2e1e:b0:8a0:4d37:660d with SMTP id d2e1a72fcca58-8a07bf67824mr2764848b3a.2.1792571486193;
        Wed, 21 Oct 2026 01:31:26 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:31:25 -0700 (PDT)
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
Subject: [PATCH v9 4/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Wed, 21 Oct 2026 16:30:07 +0800
Message-ID: <20261021083011.2170525-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_093129_615346_F94267CE 
X-CRM114-Status: GOOD (  12.91  )
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


