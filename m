Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65196C4828E
	for <kexec@archiver.kernel.org>; Fri,  2 Feb 2024 08:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GH2B4k1U4ZQDW24oB80bz9Q2o1f8ELnWr7TQYQRRQy4=; b=d1qjDUecBn8Wjq
	IZew++t641iJ0tmqXJSS/CIrsSWM1IGnPgs6dsXxMd07wef86qE32UtrRYamE1kL/RhTvIpEjFBZ/
	SnXcRceNS0Oyaplw/vS1JaDGVve9KVTKJyiwmQaTEE0ZELw2ssAs/9qpL6aQVIWZpg8LQGHc5plpg
	3UQ+Xmr6K+3js5mgXScraOgqEVrhNhGbv3T1Ijeh+v1K+7K1MVqxrW/4X/Fn4Ubyn3+9hgSM4atGl
	+SE+N/Qa0jjC/cBYDsGDOLqTNRk8AVLskmjrc8jKOiplSQWASbTLsaEy78W/Lt29hNozGVEtfoeW5
	wae/gIICQcBnmmZ29JrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVpKv-0000000AqxM-38PS;
	Fri, 02 Feb 2024 08:55:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVpKs-0000000Aqup-45N7
	for kexec@lists.infradead.org;
	Fri, 02 Feb 2024 08:55:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4316FCE220C
	for <kexec@lists.infradead.org>; Fri,  2 Feb 2024 08:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B8EC43390
	for <kexec@lists.infradead.org>; Fri,  2 Feb 2024 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706864144;
	bh=Lg6rmgyrDl0ReyNRPMOaZqLQEzjMHq3MFycVlLnqv/k=;
	h=From:Date:Subject:To:Cc:From;
	b=T3U8guCQ1/pEw5LbwnwI/T4LwBa0izAei1v9hUkOXWpjsY8iruixKxlrsuxX0CXmO
	 xLFrI5135MfgDSxbVSBQmpt4OT+A5OwN0kNYogbH8BR3BE2urApquwJDX2cOVkQ7kJ
	 E3jdsXO8LhyVlHP6tUG5Ofj4moo8El3Vyik8gElqAm/30tr9pFIh3zGItnx6N/+j7O
	 qsAdtDayVyE1H2upVS813BCanODJ2MEdNTjbKA6hDYlJGbTJsmIYHeR+Vrufkh5ouX
	 DUUHaMP4JHlXJ7uGxyQjxt0FnCdJEHnwgnQg+hzDZuyvtc1GctyF3w/HHHXNwdbXsB
	 OoPmnAFqobheA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 02 Feb 2024 09:55:41 +0100
Subject: [PATCH kexec-tools] workflow: update to use checkout@v4
MIME-Version: 1.0
Message-Id: <20240202-checkout-v4-v1-1-43e56cab30c8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAyuvGUC/x2MQQqAIBQFrxJ/3QczIekq0SLsVZ8iQyuE6O5Jm
 4FZzDwUEQSR2uKhgFui+D1LVRbklmGfwTJmJ620URnsFrjVXyffhhttLWxda2MV5eIImCT9t45
 WJDg+vd8i9e/7AZ7fvnxqAAAA
To: kexec@lists.infradead.org
Cc: 
X-Mailer: b4 0.12.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_005547_366690_4E4F2708 
X-CRM114-Status: UNSURE (   8.82  )
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

Update to use checkout@v4.

This addresses the following warning that appears in GitHub runs:

"Node.js 16 actions are deprecated. Please update the following actions
 to use Node.js 20: actions/checkout@v3. For more information
 see: https://github.blog/changelog/2023-09-22-github-actions-transitioning-from-node-16-to-node-20/.

Link: https://github.com/horms/kexec-tools/actions/runs/7753454923
Signed-off-by: Simon Horman <horms@kernel.org>
---
 .github/workflows/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index d0007f14b274..46edde66e384 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -28,7 +28,7 @@ jobs:
             libxen: libxen
     steps:
     - name: Checkout
-      uses: actions/checkout@v3
+      uses: actions/checkout@v4
 
     - name: Set Environment
       env:


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
