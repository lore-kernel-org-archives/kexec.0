Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2D3C98302
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7DrDy5k1cF63oZDGZmuZpMhR9CRSHaszqjBOE8wOFU=; b=MYbYbUyxaJ11QChOkBMI/HFwwV
	yci2dd7RNv5cWMALlgBKBocQrMUcG96LbcCrVz6S++thCDIZ28DWg+4FoJd019NuDUEVkUaj64GTL
	Vo+piMt0Tz4x5UdPfHH2UwD1/6emsx5n+BLqwO3wfeWOKSuE6zYMR478llrsgbzEdcjE56m1qDOvH
	EQqIBkOTiKKVWS8VZdz37HynyWGfp7BUC97EtU0Erv4YwNf+Jl9HEXHth3htujx+GD3vrZkR7cNf9
	OL7Jpx1RQ/Am2iGELvK5sPUMkF8Pf1IZMag9p6ZqWbg9uTH8ydyX/TFagKv7RC+4cVp+mS3FGizIc
	Oq6Pyt1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w7D-00000004jYJ-3wS5;
	Tue, 22 Sep 2026 08:44:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w70-00000004jHS-3yS7
	for kexec@bombadil.infradead.org;
	Tue, 22 Sep 2026 08:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=S7DrDy5k1cF63oZDGZmuZpMhR9CRSHaszqjBOE8wOFU=; b=P16suBol6PRDUXKkHWWtzA0CKY
	/Ln1sOgnfC2jQS51VafirdnudbH70kp8gK6XkH5vfN6VlQUMcEyQJ0IXZHCGoumx58mhGC5FYSHUd
	pJ8WDf9+n7uVqaQZ5a4IPFA9GAbKIfks9yjHhsj6DyQDjP1LswJIpkajaWMLkUHzegH/V8T0lTO5Z
	qPaW3BayuIgoItBmoEM3CSQb4xNDVoApkGKgSnHw9tvLRXfLRHb5mXk9FNCnk2Az8AQc1fHOCMcV4
	5wwePtOGDQ7gdbJQ4ZW1eaXs2JQaMDOCl9vK8mrYk+w4tJhVlgSBTtF8+F22q2j9/qzWrApWmJ7Nr
	6IVVKAEA==;
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8w6x-0000000DHht-31kw
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 08:44:25 +0000
Received: by mail-pj2-x07.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so1798365a91.0
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066662; x=1790671462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7DrDy5k1cF63oZDGZmuZpMhR9CRSHaszqjBOE8wOFU=;
        b=D2HAiUEUzd7tnzW2uBKe/LKJhmb4Qo/nFe/1xPm61RVkjLKytrePPzCUZoMLEriVlL
         IRApJKLTuBYQoXSanaEJF49RkF8BIGpnoItP+QoewwuZYiLWRQJ4+UYfhMLOkbWquwhd
         VH298OY+RDYPNnXpNAxbBVXlWXmJSE+86z1QuwNGid4OkdYu2tqVINwk/3g8TjSMose4
         kFaIFYxXoFuxq9DOmYxb8GesBGE/Lbc3ujufAQ8ng6YjCJXzFP4HSpSp0xaJ5yuK5lqd
         OHjLu+ArgEsizFkt8OVnsHMMfqyCZLPFVQJOmWrcsLeXYxyPwutB0ThdVyBJRD0LpB9h
         Mrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066662; x=1790671462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7DrDy5k1cF63oZDGZmuZpMhR9CRSHaszqjBOE8wOFU=;
        b=R/IyJQrEDaok/v+fgxX15tZE0XJXnJikPFPo130qMBB9fnrSsS4NTOYH2Fhbl1SIiF
         u6fO3fJGcd2QJf4fWUPot84x7FNwljn/L88YvkV07oz6qq0lkQfu/54G7kmBTpIMWOeO
         b02q/3dH43JXVqceKzYooApIjeLaN3TKPwPEaIlgTmoqMom09Miesb1rw5pUbE4XWYSH
         aV+UJ/s3gISiB4VdRYf2WtW/Q+6wDSose0pv4FWEnvUio3XXkr1cHVXDT4iRIwcpa0iE
         cd8DBbQejF6rJOB8RnO2/T1KnjUooVvX8SbJuEpiQz0EbtaVGoWUPOr+w1iJRKtjDu4+
         uOEg==
X-Forwarded-Encrypted: i=1; AKwUvBxkpEt8YYvVDbSRt7ju3C7mnxwxF2mObMcTWT5dLHCJgjBk+sVXKnNzz5JSNzUa3/nyK7ZeKA==@lists.infradead.org
X-Gm-Message-State: AFuF++le+Mgv1too+GxFHYChSQGOrlczYCJpZ6RGSeSsqZWLk7skaCir
	ruXWfR3PAQRvfGLBLKMbhJKC+7exOvSF6qPYBb4HlkmaMUVVsCIUPclv
X-Gm-Gg: AYBFou1Rk/kEIBcTtg45mI+56tP2/Y1xxhvkF1SdbVYI9rCNv1WN7Yjj27a7bOJK2cO
	CfSwKZ0Vq63IWNmeQH18HE83BkPngFKaINFkWA2gZX+2wj+64+xfWB1sWrPcbC6OpdA1PG8i6Wg
	p7nLpWtY6jFHK2IzlYgyCUpS5JmL4ip+sszmqjlmBqAqhBDYqXfY4yl35tIFc2HHk8VDHqcorU5
	4BX9QBBlUD4A+TCvYtqGYKXXiKk751ekfLi0Tax0qv0RCQQXXg2QM7GKBa2VqinMj2dJTu/mJ0f
	oZh+D2hyFqsw/hsvxmHaUDSGLgNlRH/xDmcSzzpmFGgR9LbqeyMyhth9bZMYSM4px5+4AOO4mfT
	osXNckTVxY8bS4C0v0gtAFTiCjVxRBizMYmqLkzUwUCyOT4SrYKKbjCFDlhSz90G8k2QOCInK3x
	HFmSiudTeaqBcUENzE5I1u/yhnneMuKy3hj3CIrJabN2Y2TG5oqobKyYEWTMR/lJrlQbmdKVEbf
	RMRzCmGX2s=
X-Received: by 2002:a17:90b:2ccb:b0:39e:6a81:c921 with SMTP id 98e67ed59e1d1-3a0731e1df7mr452432a91.20.1790066661956;
        Tue, 22 Sep 2026 01:44:21 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:44:21 -0700 (PDT)
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
Subject: [PATCH v7 6/9] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Tue, 22 Sep 2026 16:42:53 +0800
Message-ID: <20260922084256.1515554-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_094423_953309_9880D86A 
X-CRM114-Status: GOOD (  12.95  )
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


