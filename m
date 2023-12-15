Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16592C4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=h3ytx2v4J7LzJ8wEG/PG0ZznGAAURjUT/6M7hB+Esas=; b=VwClMspCc3IzLZ
	C2WlA8ufE4ywsfzaJLb73uJl32yXfexWLnG90aF6EsirDUMSsX6wVBwTU79UBhAZeLjKfBuX5UYNY
	KGoPmaiJ7BmE1d/hr2JftxLsSXIH5x6UNxby0VzQz941cu6IIRS9Ppa/F4oVAb9NlfRqG/+ICPGH2
	Fx6wWfKW6ZnYZk0cPzji6AEJEBZy3u70vDvo+Bl03Jfve/npgZmgnocVcGl8ralakMQhzuLHrcDmg
	HAFQHkVopCNL9qkmoJgHZ8Lyx8en38f7J1hOqTk8jrpYauB+COwv2KibwKyQvLNu/74aSfdZ1guk9
	g8+jzKHCBxZqJf6rJRxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3yT-002Xls-0y;
	Fri, 15 Dec 2023 08:55:13 +0000
Received: from wxsgout04.xfusion.com ([36.139.87.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3yO-002XiJ-2D
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 08:55:11 +0000
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Ss2y23c1MzB2Nhg;
	Fri, 15 Dec 2023 16:51:22 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 15 Dec
 2023 16:54:52 +0800
Date: Fri, 15 Dec 2023 16:54:51 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
	<dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] crash_core: remove duplicated including of kexec.h
Message-ID: <202312151654+0800-wangjinchao@xfusion.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_005509_033223_E4DACC2F 
X-CRM114-Status: UNSURE (   5.58  )
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

remove second include of linux/kexec.h

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/crash_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..d72985222b16 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
