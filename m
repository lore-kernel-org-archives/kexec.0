Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB79C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 07:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Grclqvhv7nIlB4Htu6FP2QRzAU/Ix2vbgSwcdXfpMs=; b=z8AMAnEmbB1/LEkJ4qWF6UXj+b
	pSkvAq9lP5RFtNZ6nuEdyB1SXbuUJkMFUwJ07Umnd1dGjU2VIkhsmLQ3gd7jXNYeq8gur4zJTtLe1
	LNsqomHdnZGGoAKNxFxO1nsHEX3ZenkUd0FaA/fBIJMNus7jmNDhSyl3ZQSlJEVZu6ZsSQ2SFjuQ2
	ZmltgTWvDpEBIDkF2Ext2MMPR/YhMriAS7P8C8RlLI2cUUwhdLu9nlH/U9hXDOE49vUFjhDOHmA7T
	Jel6ifSaUGXs3ntatc0Ybca+ZY4CLsjADLdEKaQCM6d9F40leqs9Hcptm+/hr4LMfOe8XllMXcUEg
	D0papJXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTCY-0000000G9hh-1gwb;
	Tue, 30 Jun 2026 07:48:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTCW-0000000G9eP-1GJw
	for kexec@bombadil.infradead.org;
	Tue, 30 Jun 2026 07:48:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1Grclqvhv7nIlB4Htu6FP2QRzAU/Ix2vbgSwcdXfpMs=; b=lGVgWbaDT54EEM5x0YmsTJLUyc
	Fe5bO/6ZkBVwg3FEhahwwXXu58rwp+RSHBUZUYHdPpP2pwW8ndAdxEk4hTBd61f+/+uOauw6rNj8q
	C0hYT51ESAdAxJ/K7BnGS8ecMNJPe4u/HZwkLCPKzq8Y5jqxnLKoW7SOVp1p06RBa6myd7U5GHVnN
	kvuS/vbu7K7vgCRAcfDiPXyqWrRUcKLQceJaHbfeddnAOQtrBt+KMcxpzJbpjM7TRkuPZcQap/XRg
	rg9EBvsPGad8KFOZ/9bG39de+G3ZIkuKfwgH2Qvl88upzKh5IP1wSMfXoeVQDhf6Y3e12gMiqRJPA
	H8pQYxQQ==;
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1weTCM-00000001ckB-1eTL
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 07:48:11 +0000
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-3804fd3cf71so336679a91.0
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805680; x=1783410480; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Grclqvhv7nIlB4Htu6FP2QRzAU/Ix2vbgSwcdXfpMs=;
        b=tDgvbreL5uZHFaW8Ee2saSNxrZDjFTFlwpxl+LEw8rno2QmckUjsE22Du70o0WslQa
         PfmbIeJQtt2DmlOOIslTtQ0tw8PlmpVE0jzEe25iiNpWVucUQiGGmkdXX1LkGirnWUaG
         55TmM2oJGaenrT3yLPitJ/unPFN7bSLKgzdsWG4dOljmvFtH24CGaWdWSFoueYSCYY0M
         pECVxI9Cnwr0JOqP2TbZ5Qc/mDmw2KEPdN1UfP3WfJxIAgsXKvL8/sA3rLTVMQlp37QO
         neWnofa4IE19hZamRspZ4ywPO+aUR5ziCozQiaOq8LpPndqTk397t23HZhxu9AhnkoJW
         QjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805680; x=1783410480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Grclqvhv7nIlB4Htu6FP2QRzAU/Ix2vbgSwcdXfpMs=;
        b=VqM8EoVHPG0ouFZrt/OOFv5orjf5+YasGg7EMOpkwyu06azAUuakKBelzrmyTuubrB
         PVSvJ4dznPjVu7gF+8sWygQljMOrKKJPGPGiHwJNIm4c5j8RIU1h15CtNdzaOGppeciJ
         J/MwhiF//qbnMYDGrO5Rw9tJqS7k/RGxk4/Axbbjp6D7ayVK/Ue+DlyMSEoa3DZVaNkd
         Tf34aEK20+r9zCE9DsC+vzwp9i/N27PVDaKYXd4jQ7/lEmxD+8ttk4IwNWd5vauJeiq6
         plsKeRMfmHQac6RL+K1VHwHFpjw0Ry+xpoeVHdB5E+0TvHwUg5TuskYWWAsJpHlQTk2q
         Gr/A==
X-Forwarded-Encrypted: i=1; AHgh+RpcPDdLS4k6mKKvEcaWXoeZXYA31MoTZ04BTYUPW4/wTvrw7fDXLW/FzvrvZR/6yha5ARhaJQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywxkag9FedgyYlillzZVtDTBiec0nWy9x7ggdlU5V6qyhpC93xK
	7EzBhZLRojd8RaJflw1ZThn5HFp39yhjtG1ttm4AnrgB7p8neT/yCHnP
X-Gm-Gg: AfdE7cn06n/0GIjA68opejW4SkcxPWLRMPnGT6Aj2ddfmQHVMNyLYlAwCDLY6orzUQ3
	w7AUD/NnUfDPN9Jy6ooqHBnisQJPS7u/QHDASczr/HIXgNpqQoPBQMO0ON/lDeO4pwd+a14oXr+
	wWzPS951ic1drYiyzbqGGo2PK4i3Gb88eG3mdwdSF90c2ebNNU70bjbNvieQ0O2KxU+c7i0gwu4
	AliTDsuyaxQkfSZYVPMH25EVVsG0zE66ja8Rh0THkTrVQF4Ay0bAM42uMfKdEm67R/AyJn7aYgU
	Rm+wGWui9f/dH/q5S0fppFchYmHjZ0feE1dkkwaOVe8sAqkfoIBxsuL2ysOem5eNKHknH4Cpo8y
	Zp2IcXw2NpnFQwFd/E++Y+6Hr8cfQQwiGgfqzUeXIJLWOfpzvOhY6JHnN49mcF7aULOLrohFMgK
	psDr8c/aShIFY9Cp1MH7dtOSO5EA==
X-Received: by 2002:a17:90b:3c8e:b0:37f:9ce0:af34 with SMTP id 98e67ed59e1d1-38052826ad9mr1631272a91.31.1782805679897;
        Tue, 30 Jun 2026 00:47:59 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:47:59 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 03/10] of: reserved_mem: skip late scan when no regions are reserved
Date: Tue, 30 Jun 2026 15:47:07 +0800
Message-ID: <20260630074715.4126796-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_084805_615161_3DCB6A0B 
X-CRM114-Status: GOOD (  11.88  )
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

When total_reserved_mem_cnt is 0, there is no /reserved-memory node
so fdt_scan_reserved_mem_late() have nothing to do, so return -ENODEV
directly from alloc_reserved_mem_array() in this case.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 42649dc3613f..e1bd35115cc1 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -76,7 +76,7 @@ static int __init alloc_reserved_mem_array(void)
 	int ret;
 
 	if (!total_reserved_mem_cnt)
-		return 0;
+		return -ENODEV;
 
 	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
 	if (alloc_size == SIZE_MAX) {
-- 
2.43.0


