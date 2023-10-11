Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6487BCD6E4B
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VnlHrh5c5+IRIIvb7AM/hOe5rdz1gVFIsVj091Ztrno=; b=WN4TNxh0Tt/sx3
	GAlex+a1ZGml97k486bS63Ayt9IeO03jF6XGoAfPQKEF1uxyE4p621HqJt/F743DzrcV3vW4PuhCk
	gKXNd5zPNgvZUe++O1S1RXJlAlwCUNQcudMYeh/kPUO1QWPjhp/vPuNiG5GcuqEcgvWPBdLAiKzoy
	DfraovfXgK/U/NW9N1wsDHca6HMXRXZ+/6cjE/IB3ksYXMwtE7TSUriqz1BtPkqE1COTisS1/VSqB
	jfd3mfIS1nmcdqHdVmesOwbrIfiivy5YyBVq3EmxPDt/UDQp7ACbIhY+stHGkS2Q7vSiSXFef2ovz
	gOxgtgN2BrTC7HnHl+gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqV4N-00FHlW-32;
	Wed, 11 Oct 2023 08:59:55 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqV4K-00FHky-0K
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 08:59:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 54382CE20D3
	for <kexec@lists.infradead.org>; Wed, 11 Oct 2023 08:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195DAC433C8
	for <kexec@lists.infradead.org>; Wed, 11 Oct 2023 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697014789;
	bh=LlCsu+vRh2cMyGsSaQr/+PafwrZgzVy+1/t2Pf6/LLM=;
	h=From:To:Subject:Date:From;
	b=p6bCmx4EGunUPjBih/4wCUovUckq3KRdCkH3t01FVlfBA9YVbLlilqUVci1j+RnoY
	 rNzVxz/a26N2zMKcEDnWGypDnhDptjSioSUL8K7Fmj1HW6DSIDgkutHfbXcPC3fdhK
	 gWK98nHK+HhtiDcA7/+ZXkrR8VGB7aIPa8bYluTrXuLtc2e83xm/XSE5Q2Mc3GJ/8B
	 SHzL14HZ/7YKlgivbWlKGBRfqD2t49ZcQln0UibrD+yHRCSlNd7V96naeOCb36+AMK
	 5+DLrsXC+ZFEdDJhY40w3gf/1MAeVt58X8C4HvMnngo97lVo5L/JVEgwaJ+wlUNyWa
	 6CQ0uHcpXR7rw==
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [PATCH kexec-tools] workflow: update to Ubuntu 22.04
Date: Wed, 11 Oct 2023 10:59:33 +0200
Message-Id: <20231011085933.212360-1-horms@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_015952_309269_6FEBB821 
X-CRM114-Status: UNSURE (   8.77  )
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

Bump workflow to use latest LTS release.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 .github/workflows/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 4c6e9d730488..d0007f14b274 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -5,7 +5,7 @@ on: push
 jobs:
   build:
     name: Build
-    runs-on: ubuntu-20.04
+    runs-on: ubuntu-22.04
     strategy:
       matrix:
         arch:
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
