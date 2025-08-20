Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6616CA0EFC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 05:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cRynx6jaHBNziqdWwYMx6lpx2wd+0zdA8DgB67CZ52I=; b=ls8XEitRR/dcCFaZ98UBqVMMwB
	v+DihiURgWJgRn161zAC+DkGRldmYyGe5chuH/nvMZnmOuFpy4sadSrzFD8qOhF/WqjCU1w9pSebd
	TIE3C2spxM2i64rl2hAcwZ8hYZw6muG5y5dTU3KrANdLrPXdsK0sTto80U54d/TOAkYYmIFYYxDgC
	vABfKsGPpvHNcTpKFv4M36hF0ABQTpZU7XG6gKnPrQtWlewb5c4R1+yjS9i+jD8pc51wq2wyN6g2j
	YRmEW5N8ZOq4WWSD962wqsTwXclfu9uEwXSn/h/EuekmivDUCgZzGIwwxYAp2Eiz4pobazfMxrKqe
	uj+XEjgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobqA-0000000CSeP-3ZvK;
	Wed, 20 Aug 2025 05:58:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobpX-0000000CSY0-2VVo
	for kexec@bombadil.infradead.org;
	Wed, 20 Aug 2025 05:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cRynx6jaHBNziqdWwYMx6lpx2wd+0zdA8DgB67CZ52I=; b=F31QkguiR4NZm1nKOiv7EcMuAB
	aPrpvF4ALgkdvTH+io6vxwrmBmDHsk3gTtXD1PkBJFv5yhyp6EijvvK+SYk9wORSrRbdvYuRsBpRG
	zNr3PUUFLL1lMxbHr5K6M6QqN1KZMUprPzfyw17qnkQIIODGtmjv2kdGYpnhPgJmLxD0qMBYRgzMq
	ysct60b1FwtT97wMux3ehEqAZkr3lZPbYsuSE/a0H3MmNZoC+913plaWhX3igFnebODhpQNSKt1sz
	fL5Wyr4lh5p08eiBrGP/wWpyRLJa+ZC3vMcjSIVfOKpfyWN6v/jgnLV6NFdM7j7fMWxcQe005VzR7
	91ORqIGA==;
Received: from out-174.mta1.migadu.com ([2001:41d0:203:375::ae])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobpU-00000000Blu-2QR3
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 05:57:50 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755669461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRynx6jaHBNziqdWwYMx6lpx2wd+0zdA8DgB67CZ52I=;
	b=ZGfbgEJ9PJrpkrn+SPytCPRo0OZ5Nlnlm+sI5fekbXIkZjiInD+QN+yH9I9MKdf72pSFis
	eBKau8BS29jkoPYVSTx/XJ5/RtoTcBGA6Hs6iz7FMKPGD/lUhvVzNjYM5H2Ac2ki1XxeFI
	COFKubd3VtnCyZLXDQX03KNd4ZddSrc=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 5/5] LoongArch: Enable CONFIG_KEXEC_FILE
Date: Wed, 20 Aug 2025 13:57:00 +0800
Message-Id: <20250820055700.24344-6-youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-1-youling.tang@linux.dev>
References: <20250820055700.24344-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_065748_879475_214F483E 
X-CRM114-Status: UNSURE (   7.04  )
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

This patch enables config KEXEC_FILE by default in the
loongson3_defconfig, so that user-space tools like kexec-tools
can use the same as the default interface for kexec/kdump
on LoongArch.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 34eaee0384c9..6cfea2f37cc0 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -45,6 +45,7 @@ CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
 CONFIG_KEXEC=y
+CONFIG_KEXEC_FILE=y
 CONFIG_CRASH_DUMP=y
 CONFIG_LOONGARCH=y
 CONFIG_64BIT=y
-- 
2.43.0


