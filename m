Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D07C77B7E
	for <kexec@archiver.kernel.org>; Sat, 27 May 2023 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fo3U5A8Uhg3KHjzC/SDlncwPU62ziI8qz3JWcCxNa14=; b=mB8hGB1mCs0kfl
	2+83+axrfgbjZAHmUq/wiXeuEVSYEicydkdaWTBQuJyOnrVp/vEvOr7ODzri44nksqv3nW7m+D7YP
	8xj+D+CHOsrf/3D8XZbT/vNQk+l1ZsiEsexMsxIGt16Q1Lm94S/hT5zjVaKPP3NC7havV3eNme0CE
	E8oRuDLLkFBTVuHtXoPvpIw5yNAO0EqeUSTWfhyZ7w55lDzxsZFVSLyFN1NOV9q4Spmqa67MNAZpk
	hoIjq/S6LpxxriF8kWhED8t0S+mxsGdLX80v6qar74SA8c02sXSqd7pPCWY/TZq/IWVkZsb2ra0Ka
	GEeGiAz5+aMTS+EjT+7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9O-005in1-1K;
	Sat, 27 May 2023 12:36:02 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9J-005ijB-0P
	for kexec@lists.infradead.org;
	Sat, 27 May 2023 12:35:58 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QT1Nz3J4hz18LRM;
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
Subject: [PATCH 3/6] kexec: clear crashk_res if all its memory has been released
Date: Sat, 27 May 2023 20:34:36 +0800
Message-ID: <20230527123439.772-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230527123439.772-1-thunder.leizhen@huawei.com>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_053557_352782_2CBDD664 
X-CRM114-Status: UNSURE (   9.20  )
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

If the resource of crashk_res has been released, it is better to clear
crashk_res.start and crashk_res.end. Because 'end = start - 1' is not
reasonable, and in some places the test is based on crashk_res.end, not
resource_size(&crashk_res).

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d1ab139dd49035e..bcc86a250ab3bf9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1137,15 +1137,18 @@ int crash_shrink_memory(unsigned long new_size)
 	end = start + new_size;
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
-	if (start == end)
-		release_resource(&crashk_res);
-
 	ram_res->start = end;
 	ram_res->end = crashk_res.end;
 	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
 	ram_res->name = "System RAM";
 
-	crashk_res.end = end - 1;
+	if (start == end) {
+		release_resource(&crashk_res);
+		crashk_res.start = 0;
+		crashk_res.end = 0;
+	} else {
+		crashk_res.end = end - 1;
+	}
 
 	insert_resource(&iomem_resource, ram_res);
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
