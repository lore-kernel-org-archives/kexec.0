Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B56CCA464
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=; b=jBMpMReHqdu3yJPcGGbIISpStw
	vALlps9OltLTzyA4UGWd95CpQQGlC4jYtus0v3Z49k2afJfAyWeyMhyZTiT3KzLntJTEefJMpG+hq
	g7sFlPUeLrNqX/iuztSS+hWTmPUWAW3x82+aX3VU+uZqeI+SKAiklkV+xOjPg0eqw7Qi2u1JngziO
	9We0yN5gkLEuTJNFlymnzTXUrXNlv3Bi3Elv8wT5fjVYxxfw9j2PbmXRcQVbuPLI7TwGcgXr4qsoY
	DQzrU6iqihRla1yv5QbGykqQzfBfk56P/aiekTJzWB3i1JqDQQrX7fsfzlWSRa7V3NnTnhOZWjMNJ
	EMM+9vJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbFw-000000025vB-2sON;
	Fri, 16 Oct 2026 06:17:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbFu-000000025sW-1cbo
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 06:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=; b=D8wzhTorlg4F8agI0L19Vfp9LT
	o6XZ4+Jw2DwMUjJ+I2lBU3b2OohHAHZQ/zO2A0G5SIE3J+wu/2rG+2toBK6qv5zO5hNfwU64Tq4vd
	7sF1WzpaXYF8jsgkpVsAfR+uvoPdfG4LPr5aosOUeLKToIa790qG5bxnfMxHjnVnvzFbOyImKiZUF
	WpVTA3AjEJbZBLhU2BJENGDJJB5AuVE7gOT7c8BM43+XbghzIIn8bO/fLL4HoEbCO2qZA/uTlN9PK
	uKL7wG3QqrFOXJC+HDffeWcVg9PrV8OmQ+EkyPRtDfHmMGuOagtqcYNKaNLT85Bi2FnLRyQkloe45
	LgUFRjQw==;
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHbFq-000000019oI-3z4G
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:17:25 +0000
Received: by mail-pj2-x07.google.com with SMTP id d9443c01a7336-2e934c6c1c8so7760065ad.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131441; x=1792736241; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=;
        b=Cjx2NQscwvQbQHj2sCAZMsDA2kMIFvCjTuhiHgWwr86jsbxyXlJnH5r8ExBIHiLNEo
         QtyfDo0jIgW7YWSlWampYMbIMxllSE3weKqkm6AGMnYFqMEAe6Uw+54BHAqLO9VRaEAs
         ba4MoaYr1zpimPASjPn3fYBZj/xm3i4r6xapM1rvQe1RCvb2u80Vu7t6aCBlrVPQcYgF
         //e76eYTzP0vGXX5EqKC4JZU7GZhzqnR9OrgZpNs6mr4DZ0A0YNi4Vl40scwHup0kfD6
         2XfP/rOU3GbWC4nfaJyk0qHgLXVSx8hpkoSkJF3eGgQDaGm2anHX0EEuvHMS/CxrgYJ9
         /QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131441; x=1792736241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=;
        b=Sm0q1TS9ZyxoDL97OG35t5klhaUGd0gFsvbGw+l1DfaLIfYzHPiIeHt4VEKMoGGQnl
         Ue+GYUgt0coz93qWZRk69Cva/8VoY/R8y7XOgz3tTZRzpYt4OFweD27sYlpdtzXPYdjD
         zXNBIdSjAQHwPRbc0eRG8qU4yRAE0GbovOy9OUMJ/Rw+xLE4MuZaOlz7JaEKdjWz9HaV
         ZKm/E3I8bGzvMoKKJ0QyQOsCcvp0QxbMs2IG6p+TVnCepof/8u3tUhRRtvU/QapQWsJx
         C4xYZcWGGRBGTJpkSzkKqSNiRPwuHWEITyjBIIpglaQp5d+yNOMGf27863h6ULLlfehV
         gXrQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9WrN6MSIcuUH2ocZPeoDkBQ7bmG8blxPXubFimztZ4hRXzCGD02zzRkKFbrYrHUjSjr2g/w==@lists.infradead.org
X-Gm-Message-State: AFq9FYJGXFQgBdPisp4DwGuSL8aoJzgwA/fy2BPq5Bqs9Hvhhq00o6ac
	9bozDpN0MLqckS1WKyQ7Oo8SAcqzBY1eqL5qXozbS4dIH5Y7uhmd1MHJ
X-Gm-Gg: AYBFou0X3n0mKX5Qq3tJmrE8gZeia7GtiwsBqB1S5nIQ5i6pIWflZNdY4g6N7utdxQj
	oNpLAu1PoXpNZrSbAT+BRfD7zY0VOx631b6uTvR1tVqaZvfo0DHFS/hsSjQdlbA+66xClad+WsO
	YSaQaisggXd1uhju/h3nYReWmaXoea0YDZW2jXvSU7u+e5dnfM2c1TTb8z9y8t6Z8k1niQX5FEB
	CT0+GOm2V2ao+k56rlNmPcjEekpTyewHYvMEymXYhEcd21y8lk6HOmZmOsYZC1vgGllloXwGJhQ
	Jg9uPFo/3lEKqQvNL5Q4zVEpPx3d3QJVlvVR8rFJjF33BVNQeXXyccMtyrOxx6tgA6eTVKAjvtR
	lEc1h/A84n2SNYX7ako7KXr3AvSgGEknKr8kscdNu31eqqCgLJLSZZiEYxdYHLIJLSzFnY6wUAk
	cpUoX9mbKbdoBQLGtqGqAMcvvFv7Nioaoa82UJT+phPh4tswTYvihhUR3csHVjuqCFT5RgioN+G
	hBIdH1N0BU34yPGq/I77w==
X-Received: by 2002:a05:6a21:1f8a:b0:3de:14ad:ae8a with SMTP id adf61e73a8af0-3e1d04198a7mr7196697637.16.1792131440647;
        Thu, 15 Oct 2026 23:17:20 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:17:20 -0700 (PDT)
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
Subject: [RESEND PATCH v8 6/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Fri, 16 Oct 2026 14:15:47 +0800
Message-ID: <20261016061549.4181390-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016061549.4181390-1-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_071723_250765_32D6EBDD 
X-CRM114-Status: GOOD (  12.83  )
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
index 49da515859f2..99c0f3ccc297 100644
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
index 90937dc7c627..d7bfc38ac762 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -567,6 +567,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0


