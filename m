Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56B606A321
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oG7oTj9Q;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=G/+d2qqE;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6z4DySM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dYWYab/i6KswA9jBoR7n0gUVHNmGP1kEM/igKErB1/4=; b=oG7oTj9QKvqFk5
	ZTyT0JX1Qjug+Lei6iUayrAnlToVxaJwKdJpRJUgDojFgphuh89eWZ8GCvgtAsuS0sWstIOPH0aLW
	/3MbbZJaQa7YjQ/anCHhvFdiSV9bxAEeUisS4Gdqv6mk4pA/PoSIlf1R04RPitGGO2+faMYoouvoR
	vqvVKx2O6jB24+iMou9PJdUSZqgPeswQ8A5XT681lNwLUT78IqSIPWdQqSlqKNPtnOyRLX98sqUGs
	BrA8MaAFtLeXq8Mudfk0p9I9/qMUJV8G8lFEttyTUOo3AM1GClMf/VJE0yM1k3YGnQ1bSPCz9JQ5Z
	pkEVbBjs179mqhkG3agg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrx2-0000000FMvv-1f4m;
	Fri, 27 Nov 2026 09:09:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrx1-0000000FMuj-0Ajr
	for kexec@bombadil.infradead.org;
	Fri, 27 Nov 2026 09:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dYWYab/i6KswA9jBoR7n0gUVHNmGP1kEM/igKErB1/4=; b=G/+d2qqELh8wBs6UkoINL2Nw3j
	w3Gg0A9Q0Zyt4udk386KAtLL7QhjN4aKvBMGh+21K6ChR++s3sNRncAZ0mGw3ZgUIJAeW4DyJACT1
	e5kd6GnxKnRT7DAmYHPe0CtWcFjB64dgj1OE9gtl7XX1Iukt1iGCOx6xC5ZAKYv5IizhrwX/JwOO/
	pg8gmfEkFaYnnuGOrxN+mRSWkrpS7xOnmhRMx1X7wrzj0GtsYDj72lTYeSM7b8pKNft/FyC3G9oV3
	8d9MJNdUXTcLTCFzcFCIAYz90Q09R2ezj9mVRaS8TX4iktNUmQoZye9KSJhqx2mvASu6YaxDxmEvM
	eIZyczaw==;
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrwy-00000007UcI-1DYf
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 09:09:02 +0000
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-3b094d5f1b4so1403142a91.0
        for <kexec@lists.infradead.org>; Fri, 27 Nov 2026 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770538; x=1796375338; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYWYab/i6KswA9jBoR7n0gUVHNmGP1kEM/igKErB1/4=;
        b=y6z4DySM5L4QXnUppOf9Wy6MzkYo9/VtzXYBQzpGDu3eAklQNiC7aAXUhXvMfY3u/c
         5558LqxqSQj8RFWY1w+2F0T8ltALZWVvn1AspkuTtU/Cdl2DBJzFj0zFcr0ItH+RX7Xa
         EZZa5HNB550CN6dtsHwwMEhsOuK+0RbsVUfAYlRZPb9qyd0sHCGBrc3ugNr2BMIkZ3+2
         c0ykFpwyVpG/TpbWr45YREw+nU4yiZ8guK7CtRcIvD6egc41pTiyetBNA2hkEZUZr+j5
         NR+H0rWKCSAGWPnYj8ZI4SEzgZlhMPWP6SYujYG8aIdVhCGMoGBZ1A+XHFdYhrlWL4w5
         Ue/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770538; x=1796375338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dYWYab/i6KswA9jBoR7n0gUVHNmGP1kEM/igKErB1/4=;
        b=RMmok3DPuRrnuI2J+oaKP8kV2ETGYBLNeFhZ0gx8CjvGMw/3jP0fXm373IeZYb+WgV
         P4M4IGha+cY4P9kqF8wC67s6YKJMTe611hyPhfv48AiT/IYyEVC7kwxI9HVGj+RtbmmV
         lzY0uFFGJcqHOJtxzzq9tUqn373vJ8FMf6tKgrjXkaCJT0GBIGxf5WwZcGSb5HKr+Tyj
         ZZBZzq/sVIPB9gHC09oMRdNaBlOvkROc/FbFlCOaIOGr0Yl6uwfogneCBnDd7YCU22wE
         7yNzDSwe7HcmljKWxsRyJl4pIoXtDPTgKctDEd+5h86TTn35daL4YXcGJ34OiQRvAI7I
         PBAw==
X-Forwarded-Encrypted: i=1; AL+hErGeQoLudRoZz6Q1Y5vS61oXJkpNZbKr72HCJof11nXLqG/13XJei6eYZVUn2V15T/PkD2fr/w==@lists.infradead.org
X-Gm-Message-State: APuU4Z+Qsy/XSsdEEwdQnGkdhXiZBJ3iVkRv0cEd+4vBTKrFPSV8GIkW
	7xCc+AlaOj1BO4x44F2aM0hPsDzq2e08OnMxwfL5S0B/hF9/SMib7J2B
X-Gm-Gg: AZFdTZevafQed1uyx7j6sK/cJeXDWYKgafPwbmXq7oo8KDrvg8Worzb6vuaDNP6PuKg
	CrGLGm4lrO1a9l9WIHOhQp+z+dCyU8qnJD499T4h/5wMy5XGhbN9hq6ukYsn3YkvW3aYpgWOnZp
	hEeRXmv9lq6zcjmVewN+ESDY6hwiP9rlmI/4LhGNsoQKPK2cAmH7oY+1IUgSMSZrkyf13n/AhqL
	RTUK1Q+HE4lpgoJf3H6zvGiDycquNzMJbHcr3Wggje4zeV1kjZ54uoa8axm7bx8VuOVF1E6pq05
	WObP9is2lCNZUXlUXRn6IfUn7oKRGZavU+EjB7H9dXEsQb1qkXILjb964LirHTfyKDBpzq3HTa9
	SxJezpRuwJJPQ2H601MZlsYWmzWwJYoly3eqbBgAEdmN2BdMxBp3IRd6CvU08hKbr6sNlhJCGOk
	cUg8LHDQoWeKhljlAdR1CLLsygQ4Cs8VIy4FSXU3IleynkoTvxD/mgjn5VrKeaYQyKq6nTpe0t7
	jLpELdNAK3ud2fBOMSJ22UYvACkNmkyqiUthB0JIHxbrcEQrObYtlVcXKzDop01CwUl7S6jNeTP
	+K43FuAeiLGuqyH44iit1QNOoJhHVqAXEo0fVrtQd3U=
X-Received: by 2002:a17:90b:3d92:b0:3b0:91ce:672e with SMTP id 98e67ed59e1d1-3b41c8dc8a3mr20396792a91.17.1795770538277;
        Fri, 27 Nov 2026 01:08:58 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:08:57 -0800 (PST)
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
Subject: [PATCH v10 6/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Fri, 27 Nov 2026 17:07:21 +0800
Message-ID: <20261127090723.741253-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_090900_293790_DA5F8E1D 
X-CRM114-Status: GOOD (  12.54  )
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wandun Chen <chenwandun@lixiang.com>

Add a 'dumpable' flag to struct reserved_mem to decide whether a
reserved area should be included in the kdump vmcore. Non-dumpable
regions are later marked MEMBLOCK_NODUMP; the filtering itself happens
in memblock, keeping the arch kdump code independent of the DT API.

Most reserved regions are owned by devices and do not contain data
useful for kernel crash analysis, so dumpable default to false.
Reusable CMA regions are different: their pages are handed back to the
buddy allocator and may contain key data for crash analysis, so set
dumpable to true in rmem_cma_setup().

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 7a940d1815b6..caac366bcb66 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				dumpable;
 };
 
 struct reserved_mem_ops {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 865d7cd2f0e1..ff92dfb09649 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -555,6 +555,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0


