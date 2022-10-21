Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D4C4332F
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SOVd6sg0MjPV+Thwq49KItnx6XSNieQWMDZt6Tf7Kzc=; b=wFoAd0vAMgd2Ek
	GuBdT1mHqK3jWBfWbq4XeOoPj/7AfIBaEb9lYjtzawPSONqVlrJKD5ZhBqvNkeru2baS7Xl+ioGcU
	Z1Kpz5GqLaYEk5IbWZq32aPNP3zohGe9DWFo6/cPxRjsm3JIlRu1leCzgFlSlmmZmAdppqLwPjv43
	+eDYO5TroRgjUpZTCQyGrcRP6VobuEuIeLR/u6NUSaJhUmmX0mnXoC1v+CXyDGukDtG28Wpu4p5R4
	4w1t3b0W1y+X/MYCDO7y9yj8tj1C44ZwiNKwaKBzO9QMxgj1ryTtLl/+80KiR26E9U8M+8ACJGjL2
	zRWBhTLEtZGhAkAiz5kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oltwu-008gNU-J3; Fri, 21 Oct 2022 15:28:40 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oltws-008gMN-3T
	for kexec@lists.infradead.org; Fri, 21 Oct 2022 15:28:39 +0000
Received: from madeliefje.horms.nl (86-88-72-229.fixed.kpn.net [86.88.72.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id C33AF2013C;
	Fri, 21 Oct 2022 15:28:04 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 751FA4555; Fri, 21 Oct 2022 17:28:04 +0200 (CEST)
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>
Subject: [PATCH] workflow: update to checkout@v3
Date: Fri, 21 Oct 2022 17:27:57 +0200
Message-Id: <20221021152757.125332-1-horms@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_082838_311178_C71E5A8B 
X-CRM114-Status: UNSURE (   9.78  )
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

Use to checkout@v3 instead of checkout@v2
as the latter uses Node.js 12 actions which are deprecated.

https://github.blog/changelog/2022-09-22-github-actions-all-actions-will-begin-running-on-node16-instead-of-node12/

Signed-off-by: Simon Horman <horms@kernel.org>
---
 .github/workflows/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 2731282d9521..efa17edc77bf 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -30,7 +30,7 @@ jobs:
             libxen: libxen
     steps:
     - name: Checkout
-      uses: actions/checkout@v2
+      uses: actions/checkout@v3
 
     - name: Set Environment
       env:
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
