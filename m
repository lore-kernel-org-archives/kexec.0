Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C9CCA0FF7
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eq6K/qwN9vskb6FY6itdAmiKN8WPoS7nJEq6IWJSVds=; b=BSh5Swk/nWzIbJIvfzscxD5XIw
	86w09gT08/6oTxLvbP1ifaWJHcc9GgXCWP6Uv4mRexsBp6xlCxtSaCVX1oYBgcBaKJJHVXvzXD8gI
	maiaAL326V498/wpHy/v7aAQeBx19cws9obsKld+s4NImMi48MTo3HG1kMabDXo5naKMIEppSfx5v
	0ESNCMvkqrctA6ijxKVdBSfOmrIKk3GPNxzMKta66FduxrypApJo8iyR6O078P/sakdZrcnL49Zea
	+awXYYYdCEeLAYOdYm8/npdGdFQsceR18azjL/WCGUX8NR+Y78iEtv9Fshxy+n95lzWNBea/Seecy
	s5uve4dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwDC-00000005Ifd-24C7;
	Fri, 29 Aug 2025 10:20:02 +0000
Received: from out-170.mta1.migadu.com ([2001:41d0:203:375::aa])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urv9H-00000005629-0fd8
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:11:56 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756458711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eq6K/qwN9vskb6FY6itdAmiKN8WPoS7nJEq6IWJSVds=;
	b=aLApURBUUuZsibf0lmhl/+iG+WDczlRGdwTdvrRRX0Hrvixi5CF/pO/MOwXXIphXUzOIYZ
	WAKXOfY8gmxmet7I6qVtl3GR/wneMazxJgcicJDlA3zUlEa2y0YN30xJwkBtQ1Aho9f4BI
	R1+40PoMCENjIxW+61kyH+lB69qxUlA=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinios.cn>
Subject: [PATCH 3/7] LoongArch: Terminate the cmdline string using '\0'
Date: Fri, 29 Aug 2025 17:10:36 +0800
Message-Id: <20250829091040.35827-4-youling.tang@linux.dev>
In-Reply-To: <20250829091040.35827-1-youling.tang@linux.dev>
References: <20250829091040.35827-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_021155_603765_72B21EC9 
X-CRM114-Status: UNSURE (   8.38  )
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

From: Youling Tang <tangyouling@kylinios.cn>

Terminate the cmdline string using '\0' instead of 0, improve code readability.

Signed-off-by: Youling Tang <tangyouling@kylinios.cn>
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


