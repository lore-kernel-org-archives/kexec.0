Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29885C7EE31
	for <kexec@archiver.kernel.org>; Sat, 27 May 2023 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+2B2R/0yQKbkuBx5ZnPe6XWAzVGm4KMIpz9yBxwSG6o=; b=Wh48O6SWgnKRH3
	W7o5lXSno08//jVuiwXBBIaiXhJyfWscjyFrSzELGDLzNNiwT478Y/VqD3v7TPXWyTKvcdf40StXk
	XrNfuzfL8ddNc1RredeFJouWSFpckPN2VFdPyE44qexq/F/iho+WSMQXd0dYp5mY/bkSKW8rCFfvq
	ud2oe67Z6BbJgA0PTxYbo+R1yt+yb4gWQzMdLipG4M++8IwPM7I8BDksCV/Ek1D+HAP9D/NyaFJLl
	zv+FR2T9twydLyzHj5BQh8shwvyahhjqT5AsFIQHqY+jpYSKBy+7RxgPYCWI3UVaTFq87Hhvz2yEQ
	pxS9EjYRS9J1xgNOlCmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9N-005imN-2l;
	Sat, 27 May 2023 12:36:01 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2t9I-005ijL-2a
	for kexec@lists.infradead.org;
	Sat, 27 May 2023 12:35:58 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QT1V75096zTkf3;
	Sat, 27 May 2023 20:35:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:47 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Michael Holzheu
	<holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 2/6] kexec: delete a useless check in crash_shrink_memory()
Date: Sat, 27 May 2023 20:34:35 +0800
Message-ID: <20230527123439.772-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230527123439.772-1-thunder.leizhen@huawei.com>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_053557_509147_CE159864 
X-CRM114-Status: UNSURE (   9.57  )
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

The check '(crashk_res.parent != NULL)' is added by
commit e05bd3367bd3 ("kexec: fix Oops in crash_shrink_memory()"), but it's
stale now. Because if 'crashk_res' is not reserved, it will be zero in
size and will be intercepted by the above 'if (new_size >= old_size)'.

Ago:
	if (new_size >= end - start + 1)

Now:
	old_size = (end == 0) ? 0 : end - start + 1;
	if (new_size >= old_size)

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 22acee18195a591..d1ab139dd49035e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1137,7 +1137,7 @@ int crash_shrink_memory(unsigned long new_size)
 	end = start + new_size;
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
-	if ((start == end) && (crashk_res.parent != NULL))
+	if (start == end)
 		release_resource(&crashk_res);
 
 	ram_res->start = end;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
