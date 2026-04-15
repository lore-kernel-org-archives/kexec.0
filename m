Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09262F531FF
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 03:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U/1YeftxyXxiZyNoCcSkEe4v5kVzE3kFLwi3F22KFhI=; b=EBkCikP4+JunCTqEtOK/5kv3Si
	QxGxtMNl1/HAjSHnZnSxCguxI9ucfe8SZ64gJNGO/yei5wmp5y7Q8vNpL2R5Do3WDNZGH9WthsOq9
	t0rgTns+c6Z2Z5YtaWaBLYMJfeixPjV7JGezrVVri0sa3Y58crj6WMFR3BMp46vIqdnv/h5y8aqdk
	05xAE1b0qTTKX3s7svMrdFM1kif5/SnO3KLKz5vryOP5KmRydUcfNUywZUh44KYP+pr+6nvGynAkZ
	upP83HsY5oKNMwdE0z6E1S9DVW3+ecm4AWcAPkrrcr5uLWz/I2bCdjABCo4dAFXDL5FAjsufg6Z6C
	b4e2ueFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCqvk-00000000WMB-2fzA;
	Wed, 15 Apr 2026 03:28:44 +0000
Received: from out-185.mta0.migadu.com ([91.218.175.185])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCqvh-00000000WLC-1IOP
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 03:28:43 +0000
Date: Wed, 15 Apr 2026 11:29:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776223710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=U/1YeftxyXxiZyNoCcSkEe4v5kVzE3kFLwi3F22KFhI=;
	b=nE42GBVZWi2OOY9ks/Aqvn3GMtyAK/fdHmwhNE9FG71goOfE7HVM114JPMlCEftAno4ke/
	W2vp9xJuuNws2Hg9syDyjmJcW2kwFFYoWFzaD3UVqEDqbxJfc7c777zHqCD+c/WecyDSxj
	y+nGrVZNswkYAp1xk6aAnUdmELjRHbo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dave Young <ruirui.yang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update kdump reviewer email address
Message-ID: <ad8GFhh3SI1wb7IC@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_202842_064834_2DBC0FAE 
X-CRM114-Status: UNSURE (   9.59  )
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

Use my personal email address due to the Red Hat work will stop soon 

Signed-off-by: Dave Young <ruirui.yang@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..473340e09175 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13796,7 +13796,7 @@ KDUMP
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Baoquan He <bhe@redhat.com>
 R:	Vivek Goyal <vgoyal@redhat.com>
-R:	Dave Young <dyoung@redhat.com>
+R:	Dave Young <ruirui.yang@linux.dev>
 L:	kexec@lists.infradead.org
 S:	Maintained
 W:	http://lse.sourceforge.net/kdump/
-- 
2.51.1


