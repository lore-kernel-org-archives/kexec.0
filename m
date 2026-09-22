Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDB6C982F1
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JU/OT6l28quZrPrYfN7XUOSpOrASPsDzS2PQ3ztfmsA=; b=3KgD1osqNGQLciJvTkAHrqEus4
	inoK+K6Tzee879c6ccwjURdnZ76zAZ9Fm9IE8yFDTOic1mA7i3PkgcfEUsrh6tolh92yxf6p1rxhn
	3kM79EjT5dxmBk/UO4az2hEJV/SgNBqQmn3SgTwqHnO+JK4Ok2BsP8UBRJjN9v7DdBdaLmLVsK18S
	lCnPevWKLikxBtIRh+TEf5kRCoksA6nFRYmMMOF4wnvbU6V6qOaqZ/zSGLFkCfCVjOT8F4tD8CVmS
	ul9g5oDqrm23DX5dES8FRgYeO2XgUbhEUyk/Fq+iiCOZTfmGmPA8/k++ORtoh6L4bQnK+C2sEJhlU
	RR0x3X9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w7e-00000004k2S-22IG;
	Tue, 22 Sep 2026 08:45:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w7J-00000004jeR-1kSx
	for kexec@bombadil.infradead.org;
	Tue, 22 Sep 2026 08:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JU/OT6l28quZrPrYfN7XUOSpOrASPsDzS2PQ3ztfmsA=; b=psKyF6Vt+UhBzV3lYLOwiWN+QA
	Wl9Zi8gkpN8/TROA0TJcj1BHaVrTNiiXNVbc+CEgaU/+8yOyHInukhhCpE7Ugx/POUqAfT6lrnL7N
	vQOfuToeii9kj3Lmg56pi3+iAw9SfK3UsecfxpWpZ6w8NdLcmruYGwsfAG9VBuYeii4kA9ETdslth
	mswpj+v4LLe2EayuOsjgHZ75alYLS5aijNeVqCkPjnYMdApPTiSBFZifOdPVNVMY6hGoJ+QWPHLxJ
	Dv0F8OZGhJqZ6ANFGlDg/K2QVFV6r37Vb9qFjQwFTbOyH6ozGq4QtN4NFXQskRnHQOAzmOuU27F00
	64v22cNA==;
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8w7C-0000000DHnG-0ONT
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 08:44:43 +0000
Received: by mail-pj2-x00.google.com with SMTP id 98e67ed59e1d1-39e37c430bbso1830858a91.1
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066676; x=1790671476; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JU/OT6l28quZrPrYfN7XUOSpOrASPsDzS2PQ3ztfmsA=;
        b=ImX/9cmIbPL16ZAQxdQV/uH6ZRi33XZ6MjFYymvGyNtM08xpLe+sGYfclz1S69/Ub7
         SC0GKIkq5Owu0Lky+GhBUPMlJ3kvlGJL9tjnltTRWkltZe/FIzx/bp3PTt18VsAndhDf
         PxaRExNtYR/oxvpJNgsS/xsKHw6U7z1iro+tw6C1E9irY3RrMQ7hLAcsdQGy1ptELDw+
         90xSViA/1g4lsKV58pNLICq4iYYDLfSmiSttjoP6OO4AjBJFapG6jNkz36SsZWlBFd4K
         GNCtb9HaYYQ9v4P2hponU3ZdkGd89hCZV40FedWSPCiCzz+8zh95Y4vGu7s7uynmua7N
         6XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066676; x=1790671476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JU/OT6l28quZrPrYfN7XUOSpOrASPsDzS2PQ3ztfmsA=;
        b=URrMXuu0r8QhI6QPLotFFFiSDjq5ylGT1UTze1a5cy7+j/pu3HrczksadvJLsIhxF4
         sazTjlazLIAVJ8r2dLFTmLLuwjBjS7uftwN/TUbuR/iPbtRbRbx3sGvNxbbQneaa+Yzk
         dsvFJogpDw5sEW7N/4mA0sqAorSKGE0UPCY93RnxdsjcD6lM7pw52+2VSfOTs1o3aB+Y
         buHwLxUZBqX8v24YCdEC9eBkKvjTg0/0PpQyYv11ue3kEBjrAbUDsDFifSAvOAbnQBtV
         eei4HqrjD3nRpZwvCNpfe/POyXKl4C88qKm/F8I2PBKg1wCXYzP5qMEPCpHbuUS4Ea2f
         zCzQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7JW+bGto14BdkgBVwPEWhPqRLnno1n2BFZD/EqS0kse15v5IY9Qu4C9eDUIb/90Vh6XBKJw==@lists.infradead.org
X-Gm-Message-State: AFuF++lKiZf3v3GLPneXmm7HdcJjnifcOh6v3oOAmLJPN4wL8K4KgckW
	oXqj+K7l+cij6Bd12su6me7hJWE9LYCZLTXOSB//mjiR7z/mNnt7QFbp
X-Gm-Gg: AYBFou1S5so0wssplKB6cAbZ7azY/O1ZIAu4g1hycetcbcKQGmzryMOJntJzmFnY+6o
	yxC4xnbIgZgGKtwWHFdRHPo08pg1xzRmsXM9kk7hFbb+6PpktsN6l2hwqSxZVVlI75BBAL9gji7
	qlIbNyxtx+MitX4suZ5NMoyliwgnS5/vMS1QS8RpefczCvXdT4Q1jET1dLAKHTOIKMPWU7fTNll
	RqL2G9ahJxJZmqM/2jn48klES7dckHFl9gF0O0o7GgQaQzMNXvY/IYN6PYSbZiMbuB4/gGIsXsR
	iKhAK0+hEKXiYuzDwMdXpYwqsEDK8fDPnygqtiLr3c0mg4EDQNAAtlpmc7upvrz0TjcMgKUX2gj
	SRhlcW7s6slVOAICb0E3kNHvXKkMDB2In7cPVmeFRYZSHCCr/pDjafi2YRW0aHeCzSotqaHiQik
	rNVohP+UjFWoFkVQC4NMu89XzTmtRL0vdFQKT8D/AhoQ60xGLW0JXYROW5WcwX6VD5eCVdZtLUl
	+zL8bK1kGE=
X-Received: by 2002:a17:90b:5408:b0:39e:6a81:f34d with SMTP id 98e67ed59e1d1-3a07320077dmr483552a91.39.1790066676289;
        Tue, 22 Sep 2026 01:44:36 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:44:34 -0700 (PDT)
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
Subject: [PATCH v7 7/9] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Tue, 22 Sep 2026 16:42:54 +0800
Message-ID: <20260922084256.1515554-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_094440_677148_0B74DB03 
X-CRM114-Status: GOOD (  13.36  )
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

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
pay the cost of splitting memblock.memory entries at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a64afc3ded3d..286fd4db6312 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1285,6 +1285,7 @@ void __init unflatten_device_tree(void)
 
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
+	fdt_mark_reserve_mem_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..505735732c13 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+void __init fdt_mark_reserve_mem_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8c9d6395d6a3..f29a07e8fb23 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -677,6 +677,21 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	reserved_mem_count++;
 }
 
+void __init fdt_mark_reserve_mem_nodump(void)
+{
+	struct reserved_mem *rmem;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		rmem = &reserved_mem[i];
+		if (rmem->size && !rmem->dumpable)
+			memblock_mark_nodump(rmem->base, rmem->size);
+	}
+}
+
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
-- 
2.43.0


