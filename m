Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D427C7EE32
	for <kexec@archiver.kernel.org>; Sat, 27 May 2023 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KkAQw6rHnvqvn/XlOLYZBLipYXVE/CMxToDBr6yBbYE=; b=SX5D+XMUXDJtWA
	c5jHxbXozIgq6a+O5/OihFV00moBeim3+GbzreZ59srVkTM0iZswnsSFpH751QU8vBagDyuDlhuPQ
	H5hlL3T858GqKi7wB/GCwHAfeWIPdLgIi9KnBwrB1foYQsPLWIVEU+rk17TNZZp2dH6q3ZI5xcnLT
	EHfZPd9mZSWJ9+UQXk4R/k9qCqC8joOrxfcW2yMFDJLoj33NmiVDRC3U7+uSFqLcduvtPjdLWM0vH
	R4EQrrrFCLzmWV13BjdNawOfWPlDBJLldTOxzk9rOvNwvNUlpEwl4Ij+a0updFNsXe2hSpQKWNi1D
	MnhOMp1/wuIDKLGqOqXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9P-005in8-0D;
	Sat, 27 May 2023 12:36:03 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9K-005ije-0A
	for kexec@lists.infradead.org;
	Sat, 27 May 2023 12:36:00 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QT1Qr2ln2zLpvQ;
	Sat, 27 May 2023 20:32:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:49 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Michael Holzheu
	<holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
Date: Sat, 27 May 2023 20:34:38 +0800
Message-ID: <20230527123439.772-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230527123439.772-1-thunder.leizhen@huawei.com>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_053558_505812_5A2F6695 
X-CRM114-Status: GOOD (  11.78  )
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

No functional change, in preparation for the next patch so that it is
easier to review.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 50 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 69fe92141b0b62d..e82bc6d6634136a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1105,11 +1105,37 @@ ssize_t crash_get_memory_size(void)
 	return size;
 }
 
+int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
+{
+	struct resource *ram_res;
+
+	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
+	if (!ram_res)
+		return -ENOMEM;
+
+	ram_res->start = old_res->start + new_size;
+	ram_res->end   = old_res->end;
+	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
+	ram_res->name  = "System RAM";
+
+	if (!new_size) {
+		release_resource(old_res);
+		old_res->start = 0;
+		old_res->end   = 0;
+	} else {
+		crashk_res.end = ram_res->start - 1;
+	}
+
+	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
+	insert_resource(&iomem_resource, ram_res);
+
+	return 0;
+}
+
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
 	unsigned long old_size;
-	struct resource *ram_res;
 
 	if (!kexec_trylock())
 		return -EBUSY;
@@ -1125,27 +1151,7 @@ int crash_shrink_memory(unsigned long new_size)
 		goto unlock;
 	}
 
-	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
-	if (!ram_res) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-
-	ram_res->start = crashk_res.start + new_size;
-	ram_res->end = crashk_res.end;
-	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
-	ram_res->name = "System RAM";
-
-	if (!new_size) {
-		release_resource(&crashk_res);
-		crashk_res.start = 0;
-		crashk_res.end = 0;
-	} else {
-		crashk_res.end = ram_res->start - 1;
-	}
-
-	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
-	insert_resource(&iomem_resource, ram_res);
+	ret = __crash_shrink_memory(&crashk_res, new_size);
 
 unlock:
 	kexec_unlock();
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
