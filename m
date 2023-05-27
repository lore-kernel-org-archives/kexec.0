Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF3CC7EE2F
	for <kexec@archiver.kernel.org>; Sat, 27 May 2023 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ikVBRFt+XRr6Xb2MfBlgVjEO6G1a+cU/A3ZZmk4GPhQ=; b=486NKFpFcjTXkj
	X+YMdp1eJr65e3mmUWy8jvlC/NNAu6GQcN8LBHtFYctYlY2h17nUWlMxo9pMf7ds9TtJ2O23AKNFD
	F+cm3y6YmwgUfc5bwMaW0h4KIyjhy8KE2GqTfAvE6RVYtesgcHmgi5z6MnWUC7CuWObn9JL8MTBXY
	2BBgwks5n9cQVh1EWPkbOprpdprdARZuhUYkNQp4xyWMHGhePwmuo7IUOJkAYawSXFsixAYiNPuQL
	NiEXPEfzjyuG+x7X9NJc3G9Lz1q9lHhFvYP/VEMLN75JpCV+P/lLEyDON0+JxdI7G1rUcZbEL1lK7
	fQcPTtWk9LVNwDMV6oxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9Q-005io9-2a;
	Sat, 27 May 2023 12:36:04 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9K-005ijc-1s
	for kexec@lists.infradead.org;
	Sat, 27 May 2023 12:36:00 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QT1Qr6x5XzLpvb;
	Sat, 27 May 2023 20:32:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:50 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Michael Holzheu
	<holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 6/6] kexec: enable kexec_crash_size to support two crash kernel regions
Date: Sat, 27 May 2023 20:34:39 +0800
Message-ID: <20230527123439.772-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230527123439.772-1-thunder.leizhen@huawei.com>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_053559_641277_62279C56 
X-CRM114-Status: GOOD (  14.76  )
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

The crashk_low_res should be considered by /sys/kernel/kexec_crash_size
to support two crash kernel regions. Since crashk_res manages the memory
with high address and crashk_low_res manages the memory with low address,
crashk_low_res is shrunken only when all crashk_res is shrunken. And
because when there is only one crash kernel region, crashk_res is always
used. Therefore, if all crashk_res is shrunken and crashk_low_res still
exists, swap them.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e82bc6d6634136a..c1d50f6566300d9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1091,6 +1091,11 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 	}
 }
 
+static inline resource_size_t crash_resource_size(const struct resource *res)
+{
+	return !res->end ? 0 : resource_size(res);
+}
+
 ssize_t crash_get_memory_size(void)
 {
 	ssize_t size = 0;
@@ -1098,8 +1103,8 @@ ssize_t crash_get_memory_size(void)
 	if (!kexec_trylock())
 		return -EBUSY;
 
-	if (crashk_res.end != crashk_res.start)
-		size = resource_size(&crashk_res);
+	size += crash_resource_size(&crashk_res);
+	size += crash_resource_size(&crashk_low_res);
 
 	kexec_unlock();
 	return size;
@@ -1135,7 +1140,7 @@ int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
-	unsigned long old_size;
+	unsigned long old_size, low_size;
 
 	if (!kexec_trylock())
 		return -EBUSY;
@@ -1144,14 +1149,42 @@ int crash_shrink_memory(unsigned long new_size)
 		ret = -ENOENT;
 		goto unlock;
 	}
-	old_size = !crashk_res.end ? 0 : resource_size(&crashk_res);
+
+	low_size = crash_resource_size(&crashk_low_res);
+	old_size = crash_resource_size(&crashk_res) + low_size;
 	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
 	}
 
-	ret = __crash_shrink_memory(&crashk_res, new_size);
+	/*
+	 * (low_size > new_size) implies that low_size is greater than zero.
+	 * This also means that if low_size is zero, the else branch is taken.
+	 *
+	 * If low_size is greater than 0, (low_size > new_size) indicates that
+	 * crashk_low_res also needs to be shrunken. Otherwise, only crashk_res
+	 * needs to be shrunken.
+	 */
+	if (low_size > new_size) {
+		ret = __crash_shrink_memory(&crashk_res, 0);
+		if (ret)
+			goto unlock;
+
+		ret = __crash_shrink_memory(&crashk_low_res, new_size);
+	} else {
+		ret = __crash_shrink_memory(&crashk_res, new_size - low_size);
+	}
+
+	/* Swap crashk_res and crashk_low_res if needed */
+	if (!crashk_res.end && crashk_low_res.end) {
+		crashk_res.start = crashk_low_res.start;
+		crashk_res.end   = crashk_low_res.end;
+		release_resource(&crashk_low_res);
+		crashk_low_res.start = 0;
+		crashk_low_res.end   = 0;
+		insert_resource(&iomem_resource, &crashk_res);
+	}
 
 unlock:
 	kexec_unlock();
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
