Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A49D5B87C
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 06:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EeUCktEk7tKcuhscgHtGmG1MIpsx+ua5mmBnZ9Rv1gA=; b=aiXqm8VSrsyQQOknzIqHuKIKie
	V6NWeIEWtKK2rfXFOhgyN6di0Q75RYQHX3tHGOsLI2GQeE5qfpYrQuhrmgOL1VHdmwWIoNEcPHnE4
	dC1FUgrpkUfeKJ1j43N2ZjrY/lbwotR5X2TjAkLWvNdN3zuJNLT7yOzlCTdTQSPJ8U50X7H/+fXRu
	vhjKSxHg5kNLPL9Z0fK6ZfyAC9o7q7w3rLr+SlnOfi652IHfG87f5XzNkXzHsj6EhwaIUklEXIkqz
	hhkpCduQjj9iz6nBYjykH4wwNWcX6oRvv/jRphCWHcoRVj3Wnom7ZqPt8fg+LrmPdILIc9X9PWw33
	YE9od0Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVOot-00000004nbG-42WT;
	Tue, 16 Dec 2025 06:46:03 +0000
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVOoo-00000004nai-32Xj
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 06:46:00 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EeUCktEk7tKcuhscgHtGmG1MIpsx+ua5mmBnZ9Rv1gA=;
	b=NXgMllGaL1TKTZ8uCvN2uRDDsx2iCirRKHs/ksSTjTmysbZse6exWdUiEAP1zGEBQG9L3B2dC
	Xy5mq5tYLbJCVCDPIrndcjL+EX59eh+yLGAVkf2AsC1tHAyPB/ANCiw2TYZhvp2CWj3wWi8MzPN
	/4nge9PfgLGh6k8rJVvih18=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dVnRr01Dnz1K96V;
	Tue, 16 Dec 2025 14:42:47 +0800 (CST)
Received: from kwepemk100009.china.huawei.com (unknown [7.202.194.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E49E7140203;
	Tue, 16 Dec 2025 14:45:47 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk100009.china.huawei.com
 (7.202.194.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Dec
 2025 14:45:47 +0800
From: l00580197 <longwei27@huawei.com>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>
CC: Pratyush Yadav <pratyush@kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH v2] kho: Remove duplicate header file references
Date: Tue, 16 Dec 2025 14:45:20 +0800
Message-ID: <20251216064520.1529635-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215091150.4094334-1-longwei27@huawei.com>
References: <20251215091150.4094334-1-longwei27@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100009.china.huawei.com (7.202.194.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_224559_548796_CF268C31 
X-CRM114-Status: UNSURE (   7.80  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Long Wei <longwei27@huawei.com>

Changes in v2:
- Fixed the malformed commit message header (removed duplicate 'From:' line).
- Added module prefix 'kho:' to the subject.

kexec_handover_internal.h is included twice in kexec_handover.c.
Remove the redundant first inclusion to eliminate the duplication.

Signed-off-by: Long Wei <longwei27@huawei.com>
---
 kernel/liveupdate/kexec_handover.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..1962b6052840 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -24,7 +24,6 @@

 #include <asm/early_ioremap.h>

-#include "kexec_handover_internal.h"
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
--
2.43.0

