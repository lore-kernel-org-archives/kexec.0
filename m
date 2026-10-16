Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF06DCCA463
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 03:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=; b=Y4jLkXJ7UsS1MMSu0CAsrPJT3L
	dXJC5mBKE+JZSRn/ECqSx2pRR1STRgd96n9kuVf6nD+D/Q90NqwS+PN17t9xgGDvJwmURqCTpCE9J
	+l9ns8UBtG+4jhCkQyX3FkD61EDlId/Gm3odtLHh0HrML5bVnfBDhPwvVy4A3GlZCEvknOzKS+3SF
	9x7xbHvCp/LUJANfe+2jxa2ZS96fz27E1K8R8tmmVkbjWUaUiMHbfeNxbJtXJ2ZuCFwDgfrNeDfFB
	x/WOLOTmwGtCOS6/do0C+K0z26vCG13RkiJfMG6FYB379IlQHom5VKAxLYG1FHUu+gJvfEWRetCzF
	FjLFsOkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYLG-00000001oJ6-38Iw;
	Fri, 16 Oct 2026 03:10:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYLE-00000001oG1-28nd
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 03:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=; b=hyBcozn9X/BQlBn4StsaFjPwts
	r3tsKolmOUHAM2bAwO+Fczu2KFbaOeubX81Gl3a6w3HxBXUF3fOHBy4pm0I0265e4phQO4LlNKxJG
	xn4Ox3UQvJRT6grVfMAmy9JyqGgv8jXxGn4m8M+0KiILm2nkAMA2wuh0zVefGcQD0nGL/5A74hvxY
	1cb72NEBctENo/xdBa1KrKRYgZ+9pTMGUYLscbVF2Ldn0M5pjPu9WdCUVeZwYeKtfggJFCcj9HlTw
	dTnDiO5KaR9DM4BQXtVXltrbLp1s1DiY6cPjInmzXgMCOgKa5mUChuQrhc52kNZXbI04q/I6iyftA
	955Q9POQ==;
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHYL0-0000000125D-1mvw
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 03:10:42 +0000
Received: by mail-pj2-x0a.google.com with SMTP id 98e67ed59e1d1-3a0aa5e2b20so1652534a91.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120228; x=1792725028; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=;
        b=YGDVNodgojRWZzg3Rz8lGmdJgbdWJdBhPX/lRsH0b5aNYUFNgn9jZaCZLSz7QVSIN2
         5rjgxTiyH7cm4bk1lJRKazckvsZeHWV3p9l2Ahrqrs0GsxBHMp7feqjuTM63qANt7Pxl
         vZt/R8LwZKP814iEX1YF5Zmjf5yAKb/dxYuVrmRCyFm4CQeZxLTxorOylEjGvEfrPO/5
         Yo+gl2zh4Mbcn0ktboJiPRNEGBXR3TQgOSutZVckl++iHUqIBJTur8T24Y9NDcxNqBt3
         5vzbB4ELsOk5OHwJRfXEw+OtBT3uJ5b8WkpmUCarBEG0VCof6QlGRsgxWGdRMN8wDqDV
         lauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120228; x=1792725028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=;
        b=FlTcrPR4mbd5qCjAV26yQHAr6qb2z6Ox4S120JiIbIg2Kbi2eLZwDpoHhsUgbktyYL
         mq15/hCr4pVYLuq8EyAlIb9Ll0nMzPBXwiphnLiE7B8TnynQYjj0GJHd0hnIYkKgVXcP
         jdWeI8gK6Itw/EY8crlv4Om3V7QwhoY9g0PSHRWtvMNytO+3wNVCDLt6ocSXfxfmu609
         jnlDi58JpLcvaSVDqFjl0X/YACe/Ym5HZ2qB25Fsm9PVTepTCLwi0SEOjWj48LW34lGb
         1ZD6nhETJkCyu5TIXwvSveLStSdlcT9AGC/JZAZIJViPCVvUrnpe75/KXraJI4c/Q3yO
         aiAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqJOYqaIwuk74TyLhyxwkFSyy5ddlpJzwp+U1miNvip07kP8cw/rbGdyb0gVj+Aa5eyWaG5A==@lists.infradead.org
X-Gm-Message-State: AFq9FYL+dLVj3pPTLcXj6S52gL9gbdGDdaGDCuz19L5t1/+zSk0hzs04
	D2uZ7m7at/EAVYak/ZZWvJ3EhNliQVuG7vWwAseCZ2WbXsXIkrCe2vVX
X-Gm-Gg: AYBFou3jqtJaOpgyUAqAd80AE3BKmCP0esF7V18O4u1vbFwsoA5t+hJ9/gqSQJcAiuE
	lJDbF29OMswfNm/XB/DWnPvBJY85Rs9ypVCrqBzcTCDBZZr9+9aBm9HEEpJy0/ngpJ5Z5hF6hZ6
	bMlIF+fsYCvGEoxWteCxKu+ZOeTeLBBoBjJ42R3SxkuCpIviF1ieyypFaCRX4ECNv+IyiBh8uyQ
	lYSdg8RVjRj/WDe5RzqAzAbzqA68Tl+feoVOcib9oilJc+IF8ncsEF8FU7SzvbnyMUKPClvF2mR
	SPlrXSkuN0HqCigNmT/37obxpurI0hhJnO8I/XlXKAHZ+qWKmEgaLU2wVts63UJ4geSYX0bFWl6
	WBHjP8/4V0GoNT/HVG2f8n4qC3oujT8gSkkL/ZfDRkrjlnQiWjazwB5Fcfx2GqeSBeoTy8k1TFJ
	FOH/g1MmVdgX90jZOL21zTeqMRkXgjWp5XmoToU/AMod7L288i8+1ZGqEKqoqGK+fX7TqJqrSFB
	rj4FXjIfywpwDeb1uTU+A==
X-Received: by 2002:a17:90b:2d86:b0:3a7:d2b5:2e99 with SMTP id 98e67ed59e1d1-3ab3a60d1eamr16967413a91.20.1792120228159;
        Thu, 15 Oct 2026 20:10:28 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3cc73c7sm370085a91.4.2026.10.15.20.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:10:27 -0700 (PDT)
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
Subject: [PATCH v8 6/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Fri, 16 Oct 2026 11:08:53 +0800
Message-ID: <20261016030855.4062882-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016030855.4062882-1-chenwandun1@gmail.com>
References: <20261016030855.4062882-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_041041_100238_88884C40 
X-CRM114-Status: GOOD (  12.94  )
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


