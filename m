Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B722AC5AC67
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knTPycIW4JC9RtVxI7lTQdVb1SJbys3U0akygREf/j8=; b=AfPYps281ZtlK3lIjFSL2echr9
	5YQvH1KK8iZvVk5GbFwep5AlMgnPGYAbWfz+LvFX5Yo4vfcPiPNOk5NdmEkd1tCX9ZO5fjly1bdFO
	rROyjndSbhXgW6lNmVY+pRFE9/5qHt5mpjUf9iJs+FKwkJq1DBdnRcjo0ZUb9i1y0NVjdtWADPUHo
	8Rlv9OtRz4Bf19Ze8TExQUTo2yoAUNz9kS3AXiOIgZH1Bcb0QA3Jfek+yuh4/Jw25ZGoaA+UwEjON
	7v6688Xzorvrh3Cz47LojueSMTIpDAmQiHKZnQJfYczBa8LnZdCUcDjKwjouoSHKA260xb8R7tQDN
	e3OuQBHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruWB-00000005Pe3-2cuG;
	Thu, 06 Aug 2026 09:36:03 +0000
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruW8-00000005PZr-1ibf
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 09:36:02 +0000
Received: by mail-pz2-x01.google.com with SMTP id 41be03b00d2f7-ca034c989e2so1034755a12.0
        for <kexec@lists.infradead.org>; Thu, 06 Aug 2026 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008960; x=1786613760; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knTPycIW4JC9RtVxI7lTQdVb1SJbys3U0akygREf/j8=;
        b=Hla95+PRB/DtR20VwiFZ+IK4cGoyUwLht4Em59kjP2LDaq6hcKBOHT2WgSb3X5qp5t
         o+bJcl+gBxNkuYVmVGTaDuBrSVZ97H2FDtz+baEGr34IQ9Pc6DhmPscuP8l9JT9UbVxn
         TfQ3zQjtXe58EBFi4grZPLyNtZ+OaSocywF6oNqfCLkzXGMTH8facwOu7pLlYLRDOcpO
         4a7iEbblaKUACCF10RLJO0M8wThBzPuEFAT1JDLGKtJeIVC0MuRdXY6i1YuYp+u2DMdd
         chz2v2M/tvRNArxVVbezzD/YHOJydzEQqBexUynJIgFAIYvSKcwtdHu82cstjuQVJCb7
         tlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008960; x=1786613760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=knTPycIW4JC9RtVxI7lTQdVb1SJbys3U0akygREf/j8=;
        b=mdWVn20v23FwELx1VWM+GnNNm0yw79pyV8fV0qKkdtJK0Mod/21pj0HywNYmoHSc4p
         EHg3kBCe+Q5eADNX1EBE+rq0F+2F9JC1J4XbzXbSlDqNZddW1TKLsVS/UXOrFv9bpguz
         i0VpafFk8DKNL+9EwfQRXe7NtU0uxg2GK+7FF1pA82rtZf0040VxFN8lZNZZP2oRN7BZ
         XvkQJB+RZitTlUfJ+6tJYxYppfyYkhieMxeS3DtD5p1eiSZ5BGt0Atda8H+rNDMBr45j
         a1rMsz18s4MGSSP/qCacIo2/88BD0SrzM+2w6Z6rCdpk5KbhJY9E2k8J8ftpqJt5qQKQ
         hcWw==
X-Forwarded-Encrypted: i=1; AHgh+RqXv3EwZiyhnrgM4+ncK9wNqCHYcA5JR0gfskElXozWGlnKRDfMGZBG8CVZarge1YLmcjfxCg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzP6/TwrYyhyujhDULvVv1AF6Q9Le6AwvSa2kIJbzVHDdQOnDCU
	T/z5nzqGKKKPrDAPCtjalzeEbqBtEZMmYwWQdwaW+8Zj2wU40XUr1xrx
X-Gm-Gg: AR+sD11W8dqMmwxxuzriqFDf258Fw5TnuWay6Plkf665JksIeCN+PPr3OLxH3odXnQZ
	4AO5CUa7JuRAXl1KP1zHmi0YaTcjE0Levd/zc9M3nEo3Nr4yEtHMeDCTxr3acLtd7rIXhvUyFns
	dgDipkJlwPAEC3ClqgIAOl9Xfg+/fTTPawCJbKnqp7RI/vbI2jRcw2KX8YhKkwmISCLkD8Je+AQ
	DKDbM9OvhVpaiF1vjJ8pmR3mkWUdQRzyWj4WbTM+kneb7OP4OTQPb9l3xVMYeoAiUTyK90PwT5C
	OmWfSjb6AjhChWyrlglt8P63Uv+EPvVajAxOkViJpE0OMYh6VYpbArsBnG/AUeN/XbCdfFUE0kf
	ISg7ausJYFG9lSvnF/jaur3tgyElXs3eGaykMQei2Ds7jwE0ZvMFbAITRIFXieAluHTjeeY6KoT
	hEu3DzNE6yiPzGc5oQKuAPc+EAGtBOmmPSL4AXSBkIFFqnhz1pBAdOlBBWVfAzayPXny/fRMp48
	Ms=
X-Received: by 2002:a05:6a00:2d8f:b0:848:7552:3d86 with SMTP id d2e1a72fcca58-84f2e009be7mr14478703b3a.23.1786008959699;
        Thu, 06 Aug 2026 02:35:59 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:35:59 -0700 (PDT)
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
Subject: [PATCH v5 2/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Thu,  6 Aug 2026 17:35:13 +0800
Message-ID: <20260806093519.2907771-3-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
References: <20260806093519.2907771-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_023600_450303_82907263 
X-CRM114-Status: GOOD (  12.62  )
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
regions are later marked MEMBLOCK_NODUMP;the filtering itself happens
in memblock, keeping the arch kdump code independent of the DT API.

Most reserved regions are owned by devices and do not contain data
useful for kernel crash analysis, so dumpable default to false.
Reusable CMA regions are different: their pages are handed back to the
buddy allocator and may contain key data for crash analysis, so set
dumpable to true in rmem_cma_setup().

The dumpable flag is also used to check /memreserve/ entries for overlap
with other dumpable regions.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e8b20b29fa68..55a67cee41ea 100644
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
index f754079a287d..63ff134dadd4 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -565,6 +565,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0


