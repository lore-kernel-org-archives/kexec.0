Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE35CA1004
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VEO5RHfAC6B/kxMy3bvuUJCWMXXLQK0VYO57eq/bGP4=; b=c6RXSTSn24XKuFGYaIcv1ZAl71
	h45IF7advNUY5IkUaDQCyc1841FaAaiFBSa08YxMTAWnBhUXAFYBjbB+sUIreJT6PlaTrqemWqx75
	Y4pSqybyScSgCEs7HwgfYoWK8mvIOJKkzcmGBS307dHKAVkY2jHvQ1e5pBzxxyUv53m7ySKUZQbla
	HQYmEUh0L8Dr5W+EFsaGxi7P2Brz29sg0OPk7Bui8OzSfluhwEu59lSmn9KCPuLrQ8HeFWLyqPYk5
	SxZqpvT2Z8cz0jDsxphLZUW5WHb9rcyqzvJZVEHD2s3pGjOwbe5NNObwsV2XVXRZgg4o4AeRn7dWe
	nS/OrTaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwDF-00000005Ik4-3UZL;
	Fri, 29 Aug 2025 10:20:05 +0000
Received: from out-180.mta1.migadu.com ([95.215.58.180])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urvBB-00000005625-2xI3
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:13:54 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756458709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEO5RHfAC6B/kxMy3bvuUJCWMXXLQK0VYO57eq/bGP4=;
	b=oXgU0OFY0ODREUbOth7BUK3f1T2Bp0x/UDyLxNrUCjbEE3ZBgU70CV5z9wEaSGQ1uNYAgm
	0joVkHTfx33mcIy04VRizNizvorv23AXfAPhq/tu+7v9awQlom51IapnJxC5VgrD7MtOqm
	hOk+5SrekvaWDJ4PEwzarxJXe7Djgmc=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinios.cn>
Subject: [PATCH 2/7] LoongArch: Fix comments
Date: Fri, 29 Aug 2025 17:10:35 +0800
Message-Id: <20250829091040.35827-3-youling.tang@linux.dev>
In-Reply-To: <20250829091040.35827-1-youling.tang@linux.dev>
References: <20250829091040.35827-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_021353_886066_91C579E6 
X-CRM114-Status: UNSURE (   8.16  )
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

loongarch_load_other_segments() mainly loads initrd and cmdline. Fix this
annotation.

Signed-off-by: Youling Tang <tangyouling@kylinios.cn>
---
 kexec/arch/loongarch/kexec-pei-loongarch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
index 1a11103..f0e0d09 100644
--- a/kexec/arch/loongarch/kexec-pei-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -102,10 +102,10 @@ int pei_loongarch_load(int argc, char **argv, const char *buf,
 	/* Load the kernel */
 	add_segment(info, buf, len, kernel_segment, loongarch_mem.image_size);
 
-	/* Prepare and load dtb and initrd data */
+	/* Prepare and load initrd and cmdline data */
 	result = loongarch_load_other_segments(info, hole_min);
 	if (result) {
-		fprintf(stderr, "kexec: Load dtb and initrd segments failed.\n");
+		fprintf(stderr, "kexec: Load initrd and cmdline segments failed.\n");
 		goto exit;
 	}
 
-- 
2.34.1


