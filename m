Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764D7CD4F25
	for <kexec@archiver.kernel.org>; Sat, 16 May 2026 08:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QjaYcWriodSEoCqMrJuw9IVAugpAkEJ1mwDWlGPZRAU=; b=4HsBCrbaxF89q0ZOtoNocDiAvx
	gZwBzfSqF0DnvnP7VkSOBAydIMjjJdW5QV3hOhw5yrSQqlRVnH6mD/xnDixcC8ibicNWoFvl4s/Fx
	EpTHdxiOfcnl+jRGmzQdNFUWOkTW3vP0c/T+8BXOJlDTXNScCBxHqF0y0OsbKkJ9lVN1aVZO7nS1S
	rqL+Buss7tS96t2Z+ksD+1wp79jcmHZH5h8fWRVaaqqA3XJjJ1yBm1y/9PxES/HkkmafSwIwLkF29
	A2qzS5TvWkIsnaboC15jdtl9bIC+sglKR+9vXNridWGp9ADKwxe295MNr3W3eSZprH998hbg8hxeG
	S00noJLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOAq7-0000000ASJx-3CnF;
	Sat, 16 May 2026 08:57:43 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOAq4-0000000ASI5-2E17
	for kexec@lists.infradead.org;
	Sat, 16 May 2026 08:57:42 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QjaYcWriodSEoCqMrJuw9IVAugpAkEJ1mwDWlGPZRAU=;
	b=5/kOT0xAo529umWuyJH8mRArjYelYi7J9WS81w7UxBT1GyZTNORqp9XxgOreuzPTSd63gCqH4
	gbCcJueaO/eCPaDuItwK569uuJ1yjOz2XjGX3mAxrDPZSqlbQcyL0pzJD+c0V43fi7WctaMeWNq
	XEmeluWL9DGz/94Z1F3SW08=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gHd7H1JjYz12LDl;
	Sat, 16 May 2026 16:50:19 +0800 (CST)
Received: from kwepemk100009.china.huawei.com (unknown [7.202.194.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A3C12203AC;
	Sat, 16 May 2026 16:57:22 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk100009.china.huawei.com
 (7.202.194.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 16 May
 2026 16:57:21 +0800
From: longwei <longwei27@huawei.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport
	<rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf
	<graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<hewenliang4@huawei.com>, LongWei <longwei27@huawei.com>
Subject: [PATCH] kho: docs: fix typo in ABI documentation
Date: Sat, 16 May 2026 16:56:53 +0800
Message-ID: <20260516085653.2193872-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100009.china.huawei.com (7.202.194.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_015741_068893_45F67942 
X-CRM114-Status: UNSURE (   7.65  )
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

From: LongWei <longwei27@huawei.com>

Replace "Indentifies" with "Identifies".

Signed-off-by: Long Wei <longwei27@huawei.com>
---
 include/linux/kho/abi/kexec_handover.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 7e847a2339b0..7682a94871f5 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -64,7 +64,7 @@
  *   Root KHO Node (/):
  *     - compatible: "kho-v3"
  *
- *       Indentifies the overall KHO ABI version.
+ *       Identifies the overall KHO ABI version.
  *
  *     - preserved-memory-map: u64
  *
-- 
2.43.0


