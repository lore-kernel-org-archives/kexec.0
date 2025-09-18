Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59699CAC59A
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4iHmfrOjVqxS1nY8KBbXzE3KCvY6iS5HCykfgrG+OMA=; b=ULYOxvet6oolFNLoGVDEzcFrty
	plTMw21eWiSUYwZTMMFkWg80X09kVwJthYM2cy2W+u07q4rwz9Xb5GHjP3wksw9rN16dmk5y9bTuC
	eVzMj+ioEbHdXDJdmgqraqEWEFi5uDVdzSEe3DqUKpBk0MQ1AZtJ6oX0hAuotgaokPtRqbjSoZLNd
	lbdeJElK4H9ggyjHHvKRGbjQuhdbWmlHOr2iDWJklk/mnvejbC4cug/ewSYoYiK3YMGLZpPU1sNJv
	aKW4ZA8ERlnXMiQcZfrCrkhv4Vn5zN1uJLSdEnzDaMC74dUARNhzx71xjPR4O/+xbbdMh+glODe43
	RPOEI1xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzI5R-00000000ijx-2H8R;
	Thu, 18 Sep 2025 17:06:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzI5P-00000000iiy-1lxG
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 17:06:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 87F234329D;
	Thu, 18 Sep 2025 17:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2EC4CEE7;
	Thu, 18 Sep 2025 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758215181;
	bh=HucGv7/mPLt2Tx4zSzeFM4REnUTmnwAtJbV9JCXao8E=;
	h=From:To:Cc:Subject:Date:From;
	b=kddnwzKmWI6C4Iu4GwObwD7eXUpHqQYaFf7UiiYU4177NZNU04zwGvlNXcj+sq5X3
	 uA7hgyoOmSazGv3banrkOt/qWABfc7CLpjL/7U347ksm1J7Ud28eJBOwjRf5eatN9y
	 7wJaZCFymw0VBIn/f+SyZFIIc/MTsxN41PtvW9iY9H8LEgkHjxdkGcj66K6IPyjLRx
	 HbWRLZlb1MIzKWrSWDZnw2deKMmyfjgXNMNH+rIKt8LBbyJYTnPiKcii6GrH6/qAJE
	 SP18i3039/LM6CD6gCk+g1VHd6vYur7zsOcnTX1m8ZszHjw5f4D9Not7u7Z3sFRbR9
	 D75747c3a/Rqg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH] kho: only fill kimage if KHO is finalized
Date: Thu, 18 Sep 2025 19:06:15 +0200
Message-ID: <20250918170617.91413-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_100623_481392_43C5455D 
X-CRM114-Status: GOOD (  17.67  )
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

kho_fill_kimage() only checks for KHO being enabled before filling in
the FDT to the image. KHO being enabled does not mean that the kernel
has data to hand over. That happens when KHO is finalized.

When a kexec is done with KHO enabled but not finalized, the FDT page is
allocated but not initialized. FDT initialization happens after
finalize. This means the KHO segment is filled in but the FDT contains
garbage data.

This leads to the below error messages in the next kernel:

    [    0.000000] KHO: setup: handover FDT (0x10116b000) is invalid: -9
    [    0.000000] KHO: disabling KHO revival: -22

There is no problem in practice, and the next kernel boots and works
fine. But this still leads to misleading error messages and garbage
being handed over.

Only fill in KHO segment when KHO is finalized. When KHO is not enabled,
the debugfs interface is not created and there is no way to finalize it
anyway. So the check for kho_enable is not needed, and kho_out.finalize
alone is enough.

Fixes: 3bdecc3c93f9f ("kexec: add KHO support to kexec file loads")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 8079fc4b9189..5ff959a90165 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1242,7 +1242,7 @@ int kho_fill_kimage(struct kimage *image)
 	int err = 0;
 	struct kexec_buf scratch;
 
-	if (!kho_enable)
+	if (!kho_out.finalized)
 		return 0;
 
 	image->kho.fdt = page_to_phys(kho_out.ser.fdt);
-- 
2.47.3


