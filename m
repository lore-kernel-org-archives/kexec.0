Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30125606A319
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M3vQvzwR;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=KtzyollR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BHg4NXSW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fKpfFiVoVVnNbFsiCGN8s68JTp1We4GBLmYun2RkI28=; b=M3vQvzwRgVcyLUpVfkJTtqJfnv
	AEUyftJ1NpyLcJ3YoEXlqx9rl7qwIsuA445/qi7RpJICtjH7t2pJCgkjullZkymHGXhZtz8cOrOMz
	WRcZQLDZKgoMysErnu2RK23u0LctR5elj8Ud49FasUMiyp7/nenzm5Z/rMeZI1PK8s49sVFR3E7TT
	p9z7i37WrSRjkxC8qAk7rj6qAiUh/TwCQwVxTDzT4GEAbSvSshIW7neJikRKGDeIPLD2GTvn76z/R
	HGO0iSoCVlVpCOp+mjR4hLtgMS/kV1UsFdtRPAj1NOVVuq1xu3Ij0XJcDY1etKsd061qW0IWSucdk
	J+7YPnTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRjg-0000000BMqV-14mA;
	Wed, 21 Oct 2026 08:31:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRjf-0000000BMoZ-0OWL
	for kexec@bombadil.infradead.org;
	Wed, 21 Oct 2026 08:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fKpfFiVoVVnNbFsiCGN8s68JTp1We4GBLmYun2RkI28=; b=KtzyollRiY9puZmu0jrJCuKw7R
	LgdwfbLKqeMjsSHhknoGKfoMuj4+sb8KiEKib1I9BZS+GU9B4XzMnPyF6KA/1J/E+t+fDUhSzwMnt
	KZUy6j8c6xZRAQyHl4PBFIDBMhx3TmJSRF4T52J9S0WCkIL9YJtE2tprzquKG8IDea1lbTg4FTQyF
	f+LnjFIj9yf1E6bO9WMjMWcOkaGbp3z1AqC4F54PW49iRfADv15m5gzq7lHimV8y6NC4HbsdKzO/k
	hOEV06gUtNy5LZZnyJfBJhUu43g6CTXg0GIqI5W/OMCcZy0Xmo05HSNJgzhsLEH1QzlGpS1OdARY4
	FdDwHCKQ==;
Received: from mail-pz2-x04.google.com ([2607:f8b0:4864:3b::4])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJRjb-00000005bAJ-26R8
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 08:31:45 +0000
Received: by mail-pz2-x04.google.com with SMTP id 41be03b00d2f7-ccc451ef3a7so38757a12.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571502; x=1793176302; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKpfFiVoVVnNbFsiCGN8s68JTp1We4GBLmYun2RkI28=;
        b=BHg4NXSWd3Q6U6+eNuHq04m0S7bzCh1s9TfOZKxj5COItQbMkgdg1qtVrO+CM7acA7
         K9D0g2xFpV4S2gstWu7nESUQ/FV0ka1dC6gTez8+gtsS3XbsUgoqQu6UmVAgBneLI+Tg
         AIifcorR8ADorW4/9om6Hzl7Pbq6663bupn9PYsuoZornD9+vqZ+xEtlxuqD1Nl142uR
         +nZr4epNclhlYODp7JTyMHwpbRs4P+JRmpETPbjpNqzVV5B17Fpia7gpN7eHTecH7w3n
         ViORMTy2u22arGTYCCmkPiYWyT0beKr8fVI6JAQ4YQi9Tfw/vgf0FQOonC4Bx1zaHRzp
         0aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571502; x=1793176302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKpfFiVoVVnNbFsiCGN8s68JTp1We4GBLmYun2RkI28=;
        b=uF5AfPBCu0iqrWrtuJhsjPkC6vUW38v36Q+RHasOQoS75Cvp22ITyMe8uk6+bXgAbr
         nJ3RGf0P5lSlW63XX11O7vf8ZQbFGBZm8jAITaK+cbY4dmw+WcR3pCRHS2l9P6wlW5sD
         5KUcMHOmdj9Q13mh7yII9ZTL0Tk88Y7bt8iGXavpXAPmOj1jhWgyhuq7R8COebKBh+Wz
         zDRBo3FK+haXggYvPllrN301WOGe6eAksSmdHYjpYGfo0CHjjINfD3bSINwAFPnaXjoQ
         ohe2ymF4UJyiOQwT+0enPecX5C2GAzTWM5jPbqZsvFAei/wEsiYTKkVmgPo2Kt7VjSqp
         VDKA==
X-Forwarded-Encrypted: i=1; AKwUvBwsm8dYMNOebJd+USuvYfIaya8FwpXCL3/+TTohwcTkM4meVEKCSpiHP7krRzO7oKRZ6o0JWg==@lists.infradead.org
X-Gm-Message-State: AFq9FYK1ZaaC2+blPEtWFHZPREvOYkq8A2giKlR2dAWY0wWIl/StDGOo
	8gREUD2sc7ltbrkQXX86ilyyhqUTB656j/tdBp+JT4w0UoMWQwDBCAIT
X-Gm-Gg: AYBFou36S3Dz+ms0j9ybPRR7HE9mgdX/oM+7kvnffQ5WexY24eg0tsTVyl0pi55b2h6
	q8R1kD9qZspQJpREFwajOoQpFgONJKmSaoalCR7j0ChdmGSqdcK0s4XH+89UGysEB/RlfuybW3h
	TL2DK98lyOKY1We702jAOPsXNzD5U8YJdRLQbeJMsX3XM8QdlMxamSJc7ydgO4wL3cI7HhOwaLx
	oTNWEMkj+B4dRiNFfiEbNbSrxwzPkkIH2N0aBmR1QJDNbB/vYak0dCgB+58DPqfjU4cxizaT/KJ
	wGYoJqLTqQITYoRbVIuCe81drHi170a7CCuRhamJHR4A8WVv6/aDmFnv/yQMilaIO6efwcJSp5u
	YlOAkoJEIro37ekmpkEwFGf7/uctSPHmnbRlgt7d4zr1w0KD1Y8Cwx7gvlS5S5dqYX/JoACGwMZ
	eH1Lsn1dDhvQUr0nr0tN4wstAwbQ8mmfTYtXyzuiNbLWa1BXypcSoOmfyBCOriTebIZJObngU9j
	ypw7vlV6SnQ9QDYYQD7cPw3G9C3eE+dQJ8Rpta8kp47TsWvGpkr9wDHq6HK63uxYOy53XGNlXKq
	kWIO+OZwsyB5zQ==
X-Received: by 2002:a05:6a00:2d12:b0:882:e366:d99f with SMTP id d2e1a72fcca58-8a089d871famr1118755b3a.51.1792571501524;
        Wed, 21 Oct 2026 01:31:41 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:31:39 -0700 (PDT)
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
Subject: [PATCH v9 5/8] memblock: introduce MEMBLOCK_NODUMP flag
Date: Wed, 21 Oct 2026 16:30:08 +0800
Message-ID: <20261021083011.2170525-6-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_093144_052327_A33C21C8 
X-CRM114-Status: GOOD (  14.23  )
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

Add MEMBLOCK_NODUMP to mark regions that should be excluded from
kdump vmcores.

The flag is meant for reserved memory that carries no data useful for
crash analysis. Reusable reserved regions such as CMA may hold useful
data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
patches wire this up for /reserved-memory entries.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 40e6e0aa2f8d..67dbcfda6f49 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
  * know is good to use. It is the only memory that allocations may happen from
  * in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
+ * for crash analysis (e.g. firmware carveouts).
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +65,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_NOPRSRV	= 0x40,	/* memory with no KHO preservations */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
 };
 
 /**
@@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_noprsrv(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size);
+int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 
@@ -305,6 +309,11 @@ static inline bool memblock_is_kho_noprsrv(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_NOPRSRV;
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
index a450092a80fb..ab1432241432 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1221,6 +1221,21 @@ __init int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_NOPRSRV);
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
@@ -2854,6 +2869,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_NOPRSRV)] = "KHO_NOPRSRV",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0


