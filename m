Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED4DD15D80
	for <kexec@archiver.kernel.org>; Mon, 21 Oct 2024 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=v6Ng2YGqoEmFUL8G2t1ZRIq+T/5tKuQLVdIOzZFVEx4=; b=qJdz366ZO/WPd7
	oD69ASKa781T3NyRj++H7lxO8YgRF4IwpR/vkRS6FRUoiDYDqC0nhPj/Cm++FYumE+Z9OOq5BPus/
	Dj4yYivBHOdYw+alWzvBMY3YdvTahtG+CelWW0uxaYbUWmLVb5FNIr5r+6eQeomkPbssrzyBWE0nP
	UbB9XhBZHK4v25X87yGrTZhMnfRyD5k6HQ97vySj1PvmR718ldN+spvRQTaKooADm7SZFQ34lZ3Ct
	5kBr5YEu0tz9e8167I22Gjsc3efPUKIqXvf0t0RPzPTxb8o++1skPmWDups80ebQjEwcAjxhuJSMI
	8pEW0dK9jq8p2uE8eKcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2r5W-000000079Es-1UHJ;
	Mon, 21 Oct 2024 12:00:42 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2r5Q-000000079Bh-13Ei
	for kexec@lists.infradead.org;
	Mon, 21 Oct 2024 12:00:40 +0000
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXDNP4nJSzpXC6;
	Mon, 21 Oct 2024 19:58:29 +0800 (CST)
Received: from kwepemj100014.china.huawei.com (unknown [7.202.194.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A07B14022E;
	Mon, 21 Oct 2024 20:00:27 +0800 (CST)
Received: from huawei.com (10.174.177.95) by kwepemj100014.china.huawei.com
 (7.202.194.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 21 Oct
 2024 20:00:26 +0800
From: Chen Haixiang <chenhaixiang3@huawei.com>
To: <kexec@lists.infradead.org>
CC: <horms@kernel.org>, <louhongxiang@huawei.com>, <wangbin224@huawei.com>,
	<yangyanchao6@huawei.com>, <chenhaixiang3@huawei.com>
Subject: [PATCH v2] Before adding to usablemem_rgns, check if the memory range is already included.
Date: Mon, 21 Oct 2024 20:00:25 +0800
Message-ID: <20241021120025.1430-1-chenhaixiang3@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.95]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemj100014.china.huawei.com (7.202.194.8)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_050037_860635_2A44F167 
X-CRM114-Status: GOOD (  12.35  )
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

When kexec_iomem_for_each_line() reads from /proc/iomem,
concurrent modifications to /proc/iomem may lead to
usablemem_rgns recording duplicate Crash kernel segments.
This can result in the number of retrieved Crash kernel
segments exceeding CRASH_MAX_RESERVED_RANGES, triggering
a realloc of the crash_reserved_mem in usablemem_rgns,
which could crash the process. We should ensure that each
range added to usablemem_rgns is unique to prevent these issues.

Reviewed-by: Louhongxiang <louhongxiang@huawei.com>
Reviewed-by: wangbin <wangbin224@huawei.com>
Reviewed-by: yangyanchao <yangyanchao6@huawei.com>
Signed-off-by: chenhaixiang <chenhaixiang3@huawei.com>
---
 kexec/arch/arm64/crashdump-arm64.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 3098315..f23b2bf 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -63,10 +63,22 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 				char *str, unsigned long long base,
 				unsigned long long length)
 {
-	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
+	int i;
+
+	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
+		/*
+		 * Checks whether the area exists in crash_reserved_mem.
+		 */
+		for (i = 0; i < usablemem_rgns.max_size; i++) {
+			if (usablemem_rgns.ranges[i].start == base) {
+				fprintf(stderr, "Warning, the range already exists in usablemem_rgns, base=%lx, length=%lx\n",
+						base, length);
+				return 0;
+			}
+		}
 		return mem_regions_alloc_and_add(&usablemem_rgns,
 						base, length, RANGE_RAM);
-	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
+	} else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
 		return mem_regions_alloc_and_add(&system_memory_rgns,
 						base, length, RANGE_RAM);
 	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0) {
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
