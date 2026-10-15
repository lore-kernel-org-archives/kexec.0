Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFC3CC6B34
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mno5u7ZzRZU/+mTenUA2QzGfL90+kMbsdzEVFvrdQKc=; b=Ak24/cd1uQbG81fzOLUlKrs69h
	rNNC81CkqdrSBBB/WHMD6GXgyDR7qjztFjqDITqOz8hVnFoVRoNjcU+pvPV5TMe5Jh5t6GF/U14FS
	jYeAEzHF7H6XtZZLJWXfut55CLqsSrZZKEiQS7TEhlpMaMnP+QxeJm4Pfl/Lh8lvG7GEc59r8RQTm
	bnXUP98ya9S6TUBEvdro3DF4I6Y5EmWKoxO+iMdTZ+gdfsKxMKPKSkUME9ZV1A9z1RQr1ils4u6ef
	0XHkEoxJj9ogEcT2iP20mgiE6vtBMYyg979bcieOfXf5kku3wbZslPadJGF70XONb3Wxqyl5ir6im
	BW/bQzPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMiQ-00000000Qny-2P7N;
	Thu, 15 Oct 2026 14:45:54 +0000
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.13.214.179])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMiM-00000000Qm9-2EPF
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 14:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792075550; x=1823611550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mno5u7ZzRZU/+mTenUA2QzGfL90+kMbsdzEVFvrdQKc=;
  b=JuJRyiy2LgK/B3oqBMc4AcjQZf/MDnKXF3AIksd9BoEKYVgEzMgjkSG+
   SzWWYvDXhBWEKiIxW6TP86KOzNtkUsHITwL38qZwUyUbv/sWNj7z/Rtan
   RLbJ+HUx/kMrZXgeZxpHUiq1xx7cFzrPUj9cVsh6PMEsGQYzMDi5tzqUN
   VwI2s9rAM/d3JnQO32jr4CFOnCgvJy747fAswPcz9aVbL7K0YjBZaQTNd
   OoCo0E3L9soMfO84WVQG5Mc4Hhl274CS10RFs+oRgMYhnxZ2kwFvoqLRn
   nULpOePRbXFN5WW3I/soIJ/n1CBVXGB0CqoYIDnmGp+Pj2Buppi6UCTmG
   w==;
X-CSE-ConnectionGUID: TQuNEdILSB+qoRk8DsfdOg==
X-CSE-MsgGUID: AMc/D2JPQk2nJkK7XniR7A==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31325232"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:45:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25214]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.1:2525] with esmtp (Farcaster)
 id 42897119-f455-4005-98a6-06b7136192d6; Thu, 15 Oct 2026 14:45:43 +0000 (UTC)
X-Farcaster-Flow-ID: 42897119-f455-4005-98a6-06b7136192d6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 14:45:43 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 14:45:41 +0000
From: Federico Parola <fparola@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH 6.18.y 0/2] kho: free buddy-allocated metadata with free_page()
Date: Thu, 15 Oct 2026 14:45:27 +0000
Message-ID: <20261015144529.76911-1-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.13.236.104]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_074550_642376_A279BC93 
X-CRM114-Status: GOOD (  10.37  )
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

Commit fa759cd75bce ("kho: allocate metadata directly from the buddy
allocator"), merged in 6.18, moved the KHO serialization chunks and the
preserved memory bitmaps from kzalloc() to get_zeroed_page(). Two places
still release them with kfree(): kho_mem_ser_free() for the chunks and
__kho_abort() for the bitmaps. kfree() on such a page hits the
WARN_ON_ONCE() in free_large_kmalloc() and returns without freeing it,
so each aborted or failed KHO finalization leaks the metadata pages.

Patch 1 is a clean backport of the upstream fix for the chunks.

Patch 2 fixes the bitmaps and has no upstream counterpart. Upstream
removed the tracking teardown from __kho_abort() in commit 99cd2ffac697
("kho: don't unpreserve memory during abort"), which relies on the
unpreserve interfaces and the notifier removal that came with 6.19. In
6.18.y, KHO users still preserve memory from the KEXEC_KHO_FINALIZE
notifier, and the teardown on abort is the only thing that drops those
preservations. I kept it and changed only the free; patch 2 has the
details.

Federico Parola (1):
  kho: free phys_bits bitmaps using free_page() in __kho_abort()

Pratyush Yadav (1):
  kho: free chunks using free_page() instead of kfree()

 kernel/kexec_handover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.3


