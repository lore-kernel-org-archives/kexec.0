Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9404ACAC599
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rQrOdHp8LwGyLO308onAtNLaIXqbfbyJpYOM7+7Rvow=; b=KyzLYdwH1iiOy/GcWAl+GaXwZw
	T3KPyl9Y5zNzGI1ZouuH7RSl94jSSUQkgWZh8lnsx/rgPYy8Da70V0/iQJCuUJ6vTbFKM5vtRn1oH
	b8LqwaLx9FU5xkouhrT/56V56/ppb6WuvTY1OitGzSLRT9CIOVNaMjCLV//nvvwUKa06HjMNF97eB
	k8SKDixqXN7Qwk+zcYW5azFdDpAN4b4odidgm3IyZGfbscJYxVyki9kzeLR1WGwz1VjOnLfJYFcze
	SgE9Tsk3gHGsH7zStagxUh71oASTLwZDDndwGrlU50xdHbA2FETL4yDLjlbbwbxz2fLDiFL1ppt+w
	OuXFuXUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxg-00000006D2j-16cq;
	Tue, 16 Sep 2025 01:58:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxf-00000006D1W-0Vtp
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rQrOdHp8LwGyLO308onAtNLaIXqbfbyJpYOM7+7Rvow=; b=aoBcD3tMKx+SEUHpDsWtaFEZpj
	ImoW1xTHEo6Z1ehMjb2zo5ijI41OiLnCQpZJcpgm3E8ULquaI+JoRDj64BUohST7HxWLkkq0MjN5L
	R+0Zfex9ei368sXg/eeiI2YpJoRME37uAjUgEhYNjawFAfe3+/gHFKBL8U6rLKJGVqfM6IK7S7Mkc
	lmZ98qLIgU98JUCCtvKTA5WJ6x6s8k4pak6Lhy0cn9Ji9zWcquhyKcijGgmmMGxVIVwJa5kaNOOm/
	96bnTbKoE0KUzmNCVDyiLlbyPm6wRyGwsdGNRtXTvQ2USvOcNSVxHIHfSZdhub19GHsOi4KsdEJrL
	qRHrGw/A==;
Received: from out-182.mta0.migadu.com ([91.218.175.182])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxY-000000077yp-1b8C
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:58:25 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQrOdHp8LwGyLO308onAtNLaIXqbfbyJpYOM7+7Rvow=;
	b=FagSjCGgUncFDUM297kkF3jcCs6APl0FWQRN1Nh5l7NIe3Ov1Sen5iuM++wa63jNTd49IL
	yN9y7v8N5ffW9Z62FVv/9Fyyf/0975BYi04fSjhxWpP+wH2hCf4mxGFxU+gVz4zBu1AwAM
	UvsUuEGVqRu9aYrTcGbO3D7RHtP78+s=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 03/10] LoongArch: Terminate the cmdline string using '\0'
Date: Tue, 16 Sep 2025 09:46:48 +0800
Message-Id: <20250916014655.841632-4-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025823_326004_9194136C 
X-CRM114-Status: UNSURE (   8.50  )
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

From: Youling Tang <tangyouling@kylinos.cn>

Terminate the cmdline string using '\0' instead of 0, improve code readability.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/kexec-loongarch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index ea0c316..c335e0b 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -334,7 +334,7 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
 		}
 	}
 
-	cmdline[sizeof(cmdline) - 1] = 0;
+	cmdline[sizeof(cmdline) - 1] = '\0';
 	add_buffer(info, cmdline, sizeof(cmdline), sizeof(cmdline),
 		sizeof(void *), _ALIGN_UP(hole_min, getpagesize()),
 		hole_max, 1);
-- 
2.34.1


