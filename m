Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A554DCCA461
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cKx/t/+TAF4YjXU23LNleHFcUmfPDixkfS6sn57a3s0=; b=Mj58SwrRS1XfagRx5DvZZL/rOz
	gh3RvzemMcvAcheJMA8Z22qKSIjQbQFAmC7u6G9/dAr9acO7yPktDSN2vFm9gR4HRL7/McOco51lO
	NLD4nK9O7Y2M2ALNLX+iKeG4PNQRwoIlTADRGh1SV/r4LWBNTcYUaAQpwVCVGKt30j7dqrC4K2Dzh
	z0PVZamSIwr7fDap6gPb06tWGlgdXmonHqb4PpCy/FRlIC1J8Uk7zkLZGBrsUDDeRGY8Hhwj6Tp9f
	0E6514SUDmTmlWtxP62uYxFZdHO9W1h6PKyGq1uosZPV/NVWKKlyiepANhz5E37wuXrfhBQlNe1Uw
	Lw18hNGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMiU-00000000Qq2-2uEw;
	Thu, 15 Oct 2026 14:45:58 +0000
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.34.181.151])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMiQ-00000000QnM-0HEX
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 14:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792075554; x=1823611554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cKx/t/+TAF4YjXU23LNleHFcUmfPDixkfS6sn57a3s0=;
  b=RBZ1agznxUEZKPKAzPYVD+hx0c4SBnla7gpfMWu6ku0JpsnrNQJpI+Y5
   6N1vGfuBVAlUqGieHvX0ckrxUuUFK1g1tdheIMemtCTTY1bOzcqY/XCqg
   GofCJIqsS8d6FMGz3wa1U1MMDBc89FP1eis+7HnY7qWY5QQm8wDvU2B6a
   OOM6vVhDxAaF9C/d+ThZfd87jHiNdv3ntSp4kgUcQnXzy7v/fGE9a7aim
   U/PTyI9mIY5pQvHWy7M62bUT+2yuxJyuOMajpHzBEFuLWRvgT/PQuvUn0
   cLSskWKL3M7AE8grqloG4+GcEmmuwomGHrVGaZWbZ/kEH360so8OYFcm9
   g==;
X-CSE-ConnectionGUID: Q2rGLVgxSuutHEjcu3mgnA==
X-CSE-MsgGUID: neHvo1RPTZ6dKD9HRCQEIw==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31336690"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:45:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1486]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.90:2525] with esmtp (Farcaster)
 id d05f5ffc-4038-4a23-9a53-19cce5f690fb; Thu, 15 Oct 2026 14:45:46 +0000 (UTC)
X-Farcaster-Flow-ID: d05f5ffc-4038-4a23-9a53-19cce5f690fb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 14:45:46 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 14:45:44 +0000
From: Federico Parola <fparola@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH 6.18.y 2/2] kho: free phys_bits bitmaps using free_page() in __kho_abort()
Date: Thu, 15 Oct 2026 14:45:29 +0000
Message-ID: <20261015144529.76911-3-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015144529.76911-1-fparola@amazon.de>
References: <20261015144529.76911-1-fparola@amazon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.13.236.104]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_074554_270567_F5FE7D19 
X-CRM114-Status: GOOD (  12.41  )
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
allocator") switched the allocation of preserved memory bitmaps to
get_zeroed_page(), but __kho_abort() still releases them with kfree().
kfree() on a buddy page that is not a large kmalloc allocation hits the
WARN_ON_ONCE() in free_large_kmalloc() and returns without freeing it,
so every aborted finalization leaks all bitmap pages.

Free the bitmaps with free_page() instead.

This is a stable-only patch. Upstream fixed it as a side effect of
commit 99cd2ffac697 ("kho: don't unpreserve memory during abort"), which
removes the tracking teardown from __kho_abort() altogether. That change
builds on commit 36f8f7ef7fd2 ("kho: add interfaces to unpreserve
folios, page ranges, and vmalloc") and commit 70f9133096c8 ("kho: drop
notifiers"). In 6.18.y, KHO users still preserve memory from the
KEXEC_KHO_FINALIZE notifier and have no interface to unpreserve it, so
the teardown on abort is the only way their preservations get dropped.
Backporting that commit would make preservations outlive every abort,
so keep the teardown and fix only the mismatched free.

Fixes: fa759cd75bce ("kho: allocate metadata directly from the buddy allocator")
Signed-off-by: Federico Parola <fparola@amazon.de>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 9fe5d14f1ec54..9691f6bc2fba7 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1054,7 +1054,7 @@ static int __kho_abort(void)
 		unsigned long phys;
 
 		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
+			free_page((unsigned long)bits);
 
 		xa_destroy(&physxa->phys_bits);
 		kfree(physxa);
-- 
2.47.3


