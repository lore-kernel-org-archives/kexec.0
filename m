Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC66C7EE37
	for <kexec@archiver.kernel.org>; Sat, 27 May 2023 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zij9UW8CaM7T9eSxBbq/JyfIHmsxov9Qof+or7HTQh4=; b=xgHknL+g8O20p7
	YzwZUe7sAgz2usxq8BC2341WR29xxfNeZJ7CC4ax6O9ypJSl4EnMAuURH5inuUpdZsbcX1iuby2/e
	LbrIMuqFSUy1BbJZSTtR4/yEVUeYH7PijrzdJ4Wh2x6i6oIDvIxMqzP2MyTPKvtpPiNH7OF87FVnX
	/xb1sXeig40rXE0Gut38NWfJzb31Y802b/sxvlh2s4+JHj3k488T0j/QvJWWiztmLhNoHB60HJQQX
	0XltqGQNJ2u0zp5xQKQq7WYLWnlPuR7SI6i7Mr4h4Ji2NGjQT+3R+v3mRPcaJPeys73omOxHELPDq
	vpxZu2Lx51wj//YFZ5Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9R-005ioZ-0y;
	Sat, 27 May 2023 12:36:05 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9L-005ijN-2F
	for kexec@lists.infradead.org;
	Sat, 27 May 2023 12:36:01 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QT1Nz25QszqScm;
	Sat, 27 May 2023 20:31:15 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:48 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Michael Holzheu
	<holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 4/6] kexec: improve the readability of crash_shrink_memory()
Date: Sat, 27 May 2023 20:34:37 +0800
Message-ID: <20230527123439.772-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230527123439.772-1-thunder.leizhen@huawei.com>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_053559_919859_E6459859 
X-CRM114-Status: GOOD (  12.82  )
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

The major adjustments are:
1. end = start + new_size.
   The 'end' here is not an accurate representation, because it is not the
   new end of crashk_res, but the start of ram_res, difference 1. So
   eliminate it and replace it with ram_res->start.
2. Use 'ram_res->start' and 'ram_res->end' as arguments to
   crash_free_reserved_phys_range() to indicate that the memory covered by
   'ram_res' is released from the crashk. And keep it close to
   insert_resource().
3. Replace 'if (start == end)' with 'if (!new_size)', clear indication that
   all crashk memory will be shrunken.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index bcc86a250ab3bf9..69fe92141b0b62d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1108,7 +1108,6 @@ ssize_t crash_get_memory_size(void)
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
-	unsigned long start, end;
 	unsigned long old_size;
 	struct resource *ram_res;
 
@@ -1119,9 +1118,7 @@ int crash_shrink_memory(unsigned long new_size)
 		ret = -ENOENT;
 		goto unlock;
 	}
-	start = crashk_res.start;
-	end = crashk_res.end;
-	old_size = (end == 0) ? 0 : end - start + 1;
+	old_size = !crashk_res.end ? 0 : resource_size(&crashk_res);
 	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
@@ -1134,22 +1131,20 @@ int crash_shrink_memory(unsigned long new_size)
 		goto unlock;
 	}
 
-	end = start + new_size;
-	crash_free_reserved_phys_range(end, crashk_res.end);
-
-	ram_res->start = end;
+	ram_res->start = crashk_res.start + new_size;
 	ram_res->end = crashk_res.end;
 	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
 	ram_res->name = "System RAM";
 
-	if (start == end) {
+	if (!new_size) {
 		release_resource(&crashk_res);
 		crashk_res.start = 0;
 		crashk_res.end = 0;
 	} else {
-		crashk_res.end = end - 1;
+		crashk_res.end = ram_res->start - 1;
 	}
 
+	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
 	insert_resource(&iomem_resource, ram_res);
 
 unlock:
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
