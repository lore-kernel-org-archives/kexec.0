Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD25CCF9F8
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Pei6vbmGLhErGC3eN8KTGQTS7SSeKvTLHuMiLPn2HO0=; b=KRF/F2yDcGROyhm4d5feeDWiGp
	fQwbiMVmMRypW3URQcW3R5WJr8uojXI5QRcO7CJrbmhjep9IAeVK7PwwtQ5emXJlW9YyMvEJin1Px
	ZFpK52jL1VUX+z1wEKoXWZWlbRh9ivh3Y78jYSM2YFEI/FkZPtrXIxl5Z5pRyAn/J2vSuuNWwmN/W
	3wb0q87MQPSNQOGvLB7JMx53spuDYfR4mgd08RWkPr4c8Rgt3oNuy4sywKT5CZh92PRtfodGPN0yj
	lhE01TcT0n0MFbu8ymAgf6CAGJRbmmhtkjQ9yAuVXNO5fx3nq1pa6WKTPTqWAt3HKLupaIejvFXko
	bP13lMKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFytB-0000000AS0I-0ern;
	Mon, 03 Nov 2025 18:02:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFyt8-0000000ARzi-29h8
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 18:02:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D433B41E48;
	Mon,  3 Nov 2025 18:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE5C4CEE7;
	Mon,  3 Nov 2025 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192961;
	bh=eG5n+gndF8e0beK2oqNvA+G9a2E4qmKoofNCVIki7n4=;
	h=From:To:Cc:Subject:Date:From;
	b=cJ/rnIsGFyt798HOUhwVpAhp5rwBCX7jIcMn8RxznG/cDU4jT+533agy4CoUEXWMC
	 qP8kyYGV4derqCSEXkw56mboX+61rvDl58m3aUTlbh6uu2rctWhg80uaIndVzvS7VL
	 jMRXtocc8Zn3SKwXsXOP2JWtD20jLWMCQyITPrqWpE9DsgEXVou0q20yjllsvZ56iX
	 VKe8wRq6PWssnv+WWmI9ZE5iVyx9KD8rbOUUCqalmWI7BzYqK8uO6EpcnpSkt6GyLx
	 sun/Jx3GFdow/+wsHZ/QQ6nYRsyE0Y6IM6srZ8nD+Vk2XLpjhc73omoji3gg7yn+z8
	 qP1hoheL45Zuw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kho: misc fixes
Date: Mon,  3 Nov 2025 19:02:30 +0100
Message-ID: <20251103180235.71409-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_100242_568605_F1DF8DA2 
X-CRM114-Status: UNSURE (   7.94  )
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

This series has a couple of misc fixes for KHO I discovered during code
review and testing.

The series is based on top of [0] which has another fix for the function
touched by patch 1. I spotted these two after sending the patch. If that
one needs a reroll, I can combine the three into a series.

[0] https://lore.kernel.org/linux-mm/20251103110159.8399-1-pratyush@kernel.org/

Pratyush Yadav (2):
  kho: fix unpreservation of higher-order vmalloc preservations
  kho: warn and exit when unpreserved page wasn't preserved

 kernel/kexec_handover.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)


base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
prerequisite-patch-id: fce7dcea45c85bac06a559d06f038e9c0cb38b17
-- 
2.47.3


