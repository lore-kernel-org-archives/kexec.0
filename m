Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851DEC54E68
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=A0RX+oLED/jgea9ICIfPKKRH5eOXOVWdxhTxdMj3BSI=; b=OUyiF5yrok92Gs
	etysChvULs0e/g1OmC5TWianOCsLxxPQYvqP8t2Vmlx+1c2tIYetZfyibnFygxORxmi3jbZBo4shm
	RKwFLo9FWfnt6Mj7drnAUg4uLfRUcvGUMVGhGZfsedwCskamZl6CJRzOVSQS2xEJVlSFSbcozUOfw
	zMK5zqH87DVcdJfYmVkIvuOWpAmUfxePwQThP1//67iLhfYePgE/t1qIPem4Pa2iNQ5DuDFqOrDnn
	8B3pLXiv2esK7pZErhTu6b3+LMsL4xMXF9/SBGXmjXg3RZDfFVa0xOPN5hC1vLGzEFD+/qVvTosyE
	HnQkN1DwKBMx2mR6C/WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnGiN-00000002pwU-2vPb;
	Thu, 21 Mar 2024 11:36:07 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnGiJ-00000002pul-1FsE
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 11:36:05 +0000
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V0jyQ6QcWztQWf;
	Thu, 21 Mar 2024 19:33:34 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (unknown [7.185.36.180])
	by mail.maildlp.com (Postfix) with ESMTPS id 70D22140FEA;
	Thu, 21 Mar 2024 19:35:52 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemm500019.china.huawei.com
 (7.185.36.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Mar
 2024 19:35:51 +0800
From: chenhaixiang <chenhaixiang3@huawei.com>
To: <kexec@lists.infradead.org>
CC: <louhongxiang@huawei.com>, <fangchuangchuang@huawei.com>,
	<wangbin224@huawei.com>, <bhe@redhat.com>, <chenhaixiang3@huawei.com>
Subject: [PATCH] crashdump-x86.c:Add a check for the crash kernel range in exclude_region()
Date: Thu, 21 Mar 2024 19:33:17 +0800
Message-ID: <20240321113317.1231648-1-chenhaixiang3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_043603_545767_9888E5C2 
X-CRM114-Status: UNSURE (   9.04  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In some cases, such as start < mstart < mend < end when exclude_region(),
this results in crash_memory_range[i].end becoming less than
crash_memory_range[i].start, leading to incorrect address ranges.
Adding a range check should be necessary.

Signed-off-by: chenhaixiang chenhaixiang3@huawei.com
---
 kexec/arch/i386/crashdump-x86.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index a01031e..30e9a41 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -447,6 +447,14 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
 			else
 				crash_memory_range[i].start = end + 1;
 		}
+		if (crash_memory_range[i].end < crash_memory_range[i].start) {
+			/* Crash memory range is unreasonable. */
+			fprintf(stderr, "Error: Crash memory range is unreasonable.\n");
+			dbgprintf("exclude_region: crash_memory_range[%d]\n"
+				"start = %016llx,end =  %016llx\n",
+				i, crash_memory_range[i].start, crash_memory_range[i].end);
+                        return -1;
+		}
 	}
 	/* Insert split memory region, if any. */
 	if (tidx >= 0) {
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
