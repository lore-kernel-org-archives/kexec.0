Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69D6D41D74
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XZgdrwHTqEPsqlq92hjVC8yJ61nB++FpNZyUSYNf7fg=; b=yUcgJ1LJovei7uVKlCZieIBz94
	fBgc87XR9lv5MxwDwxA13HNer4cIYzWyYpkl70xCxlP3Ih4tCAOJyBiwnE1ig6VtiTmuXC+TCZauh
	h+8gtHTnKf21NynwRQ4/fygJVYw8YX6JYYEBr9uIbC3durmlpe9Ewhx9PUZzEuUAar66CQjK+wVuj
	daBn5h94en71umkX9bOUlPQF8/Ogo3E0TO1/XLFnzrTmmLOL57l9xWS1ew8yg9KOaOOjnz8L7CjIY
	JhiJ+ZRtCwHrvYkt+OHccvIgBcVuIApFB31JA3FlshjEhiYmjY3cFSuKfiCFuJY9YtPn9hoCqxy3w
	2CawzOlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV4d7-00000003LFM-1u34;
	Mon, 15 Dec 2025 09:12:33 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV4d4-00000003LEf-0eqH
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 09:12:31 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XZgdrwHTqEPsqlq92hjVC8yJ61nB++FpNZyUSYNf7fg=;
	b=D8cp+M3NyiQpEkSRe34dtr+w+at5oG1dxRCu5nksZG0eiQsMj6rLuBX/myEbBFEMFnibMjydy
	gz8Kbz+GUS2366nux0RPO5ZhvPrSIaQtRLIqtkPLU1JzUTtL2E9eWUw5+nHO+CjIpk/OlJ1bgai
	EabVkous1xOcVICxNJqB4vk=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dVDmR6YMnz1prMW;
	Mon, 15 Dec 2025 17:10:15 +0800 (CST)
Received: from kwepemk100009.china.huawei.com (unknown [7.202.194.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B21C118048A;
	Mon, 15 Dec 2025 17:12:16 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk100009.china.huawei.com
 (7.202.194.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Dec
 2025 17:12:16 +0800
From: l00580197 <longwei27@huawei.com>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>
CC: Pratyush Yadav <pratyush@kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH] Remove duplicate header file references
Date: Mon, 15 Dec 2025 17:11:50 +0800
Message-ID: <20251215091150.4094334-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100009.china.huawei.com (7.202.194.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_011230_709303_9D462FD1 
X-CRM114-Status: UNSURE (   6.86  )
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

From: Long Wei <longwei27@huawei.com>

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

