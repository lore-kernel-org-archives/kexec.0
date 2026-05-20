Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ACBCD4F54
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yF4iEePz0efKjWWczqPvkzIUeB6xqHtDsvairyfmeUg=; b=dTlRM6Lhwz69cOQNxSiIPR624C
	Ak34PggsoXJ7FuBaSPOalTpfyIZILFkMYxVGlIglxwtGakKXvQ6u8c2iYdF9W/cC5UyJxRE1nYrye
	bOozBy/hBaU99h3aLpORbwFethdh6QZQsBavgjc3/Bb0Ce213+6rCdGyACB6ieR4MskqBnO3xptbr
	qz7CR7NA4JIto5WXZHdCo7Gq9mp9KDCUAtRSqZttZfXyP9lWaVV/xJHq+ymshz9PxcJBVl83fDrLz
	ejZ9Kvjt1iou+yab7MUVv1WZgjL1SOCM1OjUkRdqsxFAZkxz89/LRF+9EnEiLWZxghZ9JgSMB6/iB
	oUQfJ71w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd6W-000000047eq-2gYV;
	Wed, 20 May 2026 09:20:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd6K-000000047Mj-2Imu
	for kexec@bombadil.infradead.org;
	Wed, 20 May 2026 09:20:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yF4iEePz0efKjWWczqPvkzIUeB6xqHtDsvairyfmeUg=; b=g7Onznvcs0XhzERHUBYQ5fneOI
	Kci/WuD4GoqOEDksbr6f9weov2DXXKGpp7pfJCpqzuXddRJ2ReK0n501uPiXDcY8QMfNfz73sHmr4
	XGdMBMY72xbK1Bku5RLInnB0Fv5W9UrjxNNJtweTNM1fllz3f5zxf/WbstH94DrwJV70EesJgXGCx
	CA0ORTLikzX5zJWdLk6uTN9YdSUi4keiS6koGPcqhvuIvc2vZMCnFzEAB5bqowTc7tHnSlz2Ng7//
	1yH9fwOCZ7JrveVPPgyccxaoieUwaT6ZWU4CefWx7+cAwTvZJcrVwR1DHcs8jRgPckxlObUu6WqZu
	ml8JpfKw==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd6G-00000006xPZ-49mC
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 09:20:27 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-83d5bbef760so1952784b3a.1
        for <kexec@lists.infradead.org>; Wed, 20 May 2026 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268823; x=1779873623; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF4iEePz0efKjWWczqPvkzIUeB6xqHtDsvairyfmeUg=;
        b=aatzxvewVTZFD6z/0FjgUJlHl0hc782ArKybEwJhH75negObd/2TaWh+JUvNhNX/cv
         4Jv0JbE2bbrs73srqlxtZgud9lSSyVuiksd7MTpafngRc05UR4hzQCutjU++nP8zKJrP
         sD7aOZTzqpilHsAKY2NNvrRhgd3PXTdeJvmc6HpnXSrci+z1Vdphhuw9ufrSXkaqd0UL
         sQp0LBdkrNwcEfvvl/WNHIo7mz/qw+T1NCrC+kH7yU9sSctRFIpiV+uM7gtdeAN0GCRM
         gFRfZG6uxuEAsSCvdxHCiIL8qmaP41feDK0y8ur2S1YMYVzDRuTN6PGuEVrmViqeMtr1
         4eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268823; x=1779873623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yF4iEePz0efKjWWczqPvkzIUeB6xqHtDsvairyfmeUg=;
        b=jszVU5XIFIrLZsG0Dd4SvYAxn4elkSWqzRJw4sTJTtnoArcbP+ADQmpZQvcBSm4JEm
         XnHsy8r3sO0HKiCDEZKIthD7JF04XBhu05+nGxaVn7CVyRmYL4VhV/rcn27emNlcseZ5
         fznzD/XvyfyLtId5ty/KrX2xsoYvRUMs2iyQHvQ8ytUInp427iJPOOZWLnyTU5H6uHN7
         0t7iAhQ8xD+5fwyrguookn5K4PXZQRpozK3JferDpcpV3+zMICgQdiQAtShHT8VGNC3w
         Pq1o4lXcrGlELB+OQgjmw/uaoCEX1XWUzH6vLfrFz5W0sMbERVux1fv/yffCtNfdvoU3
         83fQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UXqR0BCgEYOtaQz4zhOkf80Oox0g7zY28jxsFrWle/PH5cr08KAnDOqD/FwHsWwajM5FQWw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzfbS900GEkaqOzZkWQ3H6FwHzAbLfUHylVKXo+YS9nmWJDVRVt
	zbTLnToSGa4rS2Nt71T4PPcrSXFWMpMN0wDiktIBlCH6dNEI0LbGLfO7
X-Gm-Gg: Acq92OFOKXDpcDpqCCpY+sJAbBuoG90gjKow1R3/Zdt+rtjJpx6d00rtzXDE7/4IV2Q
	cFO46Pt5Perin+rsIiCKj/XkZUq7kMo8MFG6SsmfxM87QWPR6x2Iv5GuUMkm5I6belBmb4Un5by
	eexKX8JI44cDlhpBXhmN50YOy3s/k27dz2kZOIq6xhI5lwhR2SpXcRrSQOqUyFHCyIgBWEwaAvK
	RdJnrQ9yBDqUPFhzPovAPNPSSQjUYxmZzp7XWf5+IYnsFZ0TQbI7yMgBmxwXCcz6bCZxvAoLQVh
	5PInWmbcqtJuQds7XTxXn9/+WIvvwUsRrNSYQ6S92SBmv8sqNX2s1mMrrcqaqoyGeJmxCY/PksR
	a8b8p4gxJf4jKUnXvzpoSyNOlZYQgyK6597aUHBSJTwNXDx7zoqO/Q3tEVtfXryanLxaM6kTUyl
	N29Ev7UeSKrOVx6e271xdTNvvnIbHr/CEB099qWQ==
X-Received: by 2002:a05:6a00:2e9f:b0:82f:6e7:152d with SMTP id d2e1a72fcca58-83f33c391cfmr24600140b3a.21.1779268822961;
        Wed, 20 May 2026 02:20:22 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:20:22 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leitao@debian.org,
	kees@kernel.org,
	coxu@redhat.com,
	tangyouling@kylinos.cn,
	songshuaishuai@tinylab.org
Subject: [PATCH v2 8/8] loongarch: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Wed, 20 May 2026 17:18:44 +0800
Message-ID: <20260520091844.592753-9-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_102025_259815_A8AD5E41 
X-CRM114-Status: GOOD (  10.60  )
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

From: Wandun Chen <chenwandun1@gmail.com>

From: Wandun Chen <chenwandun@lixiang.com>

Apply the same non-dumpable reserved memory filtering to LoongArch
kdump as was done for arm64. Use of_reserved_mem_kdump_exclude() to
drop flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 arch/loongarch/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5584b798ba46..c5cead362d2d 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -67,6 +68,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -91,6 +93,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_kdump_exclude(cmem);
+	if (ret < 0)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0


