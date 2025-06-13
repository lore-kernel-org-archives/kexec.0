Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B43C71136
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d0qqknzGjb4g9HbuHxIrhCrYPP4CQh8vMt2dY0VjZak=; b=PdwVrQCTthoJDIK0bXn/oMe1OE
	4G7feaU28Px2w3MrYwhya+quxF/gbWphGjNkIJ/nA09Alm9ee9PDfH1gRsp3ASKaS/wKNPrlIL/IF
	OJHV9vIMJhSwNQn1+1CO2lyLdE4xa+7CMrPmaph9udohN1HorStshNZN1/D8uLNXGkr74FAhMJnhM
	0U5S/RQLM0VMGoCBCrBNPvoEMyhM0w9k7/yQZcAPUM2mcqj4/T5n7w+Q6wi/XMwBN7MrytkavuNdT
	1xSMiHFYoPcTQwm08WIGEprG1ArZq/RzMFgOb8FkhHmopU/T8j6raIZOPOs89KpPCA0FCxXKF13V9
	cmvq0VfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ4KZ-0000000GTgB-1fbz;
	Fri, 13 Jun 2025 13:20:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ4Jz-0000000GTZM-3tSS
	for kexec@lists.infradead.org;
	Fri, 13 Jun 2025 13:19:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E3A1629DD;
	Fri, 13 Jun 2025 13:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52659C4CEE3;
	Fri, 13 Jun 2025 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749820790;
	bh=QL2aWl2xPGVWIPtgmBn1Yjy9CR98m5Xhk0v5CSpRdcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LCzD0KgYLwTP5iR/0RIE1JgR1qHs/q9lINdhEffI3GAwMfcuWsVi6NLmMfSWTacfG
	 hkXXvVsq6tze++Pctn5wGOQuYi2AjOn395ZNBy3gFS6fAOx2+FH4ZHbaIRhJzNskOh
	 lwxwOqcSdNksRe/etPrUD4NGrvtxfKAW4qoojdWUzQzrAqYQYc6FemnbYYe/UUGQiJ
	 m0EjEUB80KiFR3zznNaQ4h7OiNYlDUyhGdj+hQBlCrjBV6xjlA+Yt+arN68m82k5Gj
	 v1t1AQ+ka8g0S5rB1VBCQThasqAiJjf42ruCrKRNCFzkllkMldxQlGubS4WdbxkvcW
	 34czo/Cdv4+KQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] MAINTAINERS: add linux-mm@ list to Kexec Handover
Date: Fri, 13 Jun 2025 15:19:14 +0200
Message-ID: <20250613131917.4488-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Pratyush Yadav <ptyadav@amazon.de>

Along with kexec, KHO also has parts dealing with memory management,
like page/folio initialization, memblock, and preserving/unpreserving
memory for next kernel. Copy linux-mm@ to KHO patches so the right set
of eyes can look at changes to those parts.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 99fbde0077927..7a0bc21d906bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13346,6 +13346,7 @@ M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Changyuan Lyu <changyuanl@google.com>
 L:	kexec@lists.infradead.org
+L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
-- 
2.47.1


