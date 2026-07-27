Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8C8C53209
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aFYOBMXp5dKkeO47Qf8glP6qHC1ahmcBq2ODbRBzDG0=; b=Co5cOQ+lmcbgNsb+7MddfZOyET
	EEavnZ4Q7/tw09HaCiCeF/M+k+DtX9hBgh7LHxW/S4n3LEuj/16KdU9V25PnolbR+f2w0KGbV9Flk
	y617oy27BQCfqWq/o735KYxKE7r/IvYEGiAtox2jXZjhyZjToPIcyCi/zGmZIbcaRLpZm38c++qNT
	3+A9zY0PS50rmoaJWkITWi7e/QLhwzuygjOsbEdRrnC7lU1mcctlx5rQp5uZF1BM3eEP8ZDW5xvdK
	pRxfQejMtgVLCgQVMFZUo+9sd+pVqOVyI0GLK+Z+5tDkOj9wyYYIcgZlHwDCiLku/df/K2XTFzHbj
	6vRJ5TYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMqz-000000037QT-24Uv;
	Mon, 27 Jul 2026 15:02:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMqy-000000037Pm-0w5c
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 15:02:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F7C1600AA;
	Mon, 27 Jul 2026 15:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E271F000E9;
	Mon, 27 Jul 2026 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164571;
	bh=aFYOBMXp5dKkeO47Qf8glP6qHC1ahmcBq2ODbRBzDG0=;
	h=From:To:Cc:Subject:Date;
	b=gmTYl/c+0ipQFd8NpHTkjpGs4Q/3jQRywWu+9wuxAhCoeM3efP0QblqxX3Af9lGHc
	 Nz2Z0plLNymVkhgTMkuRmp4F2lcLA57ghdR9RPQTw/rI3fEcNsoA3j4Io3hADdCZGL
	 mmUj2tD9ObqEv1R2brKr49durZgrC8VeKVi5e8kyRCt8TQ5Gjnv7Ug48Vn8CgZfewn
	 mxXmgO0bwMZ1SBTljY0/b7avVfA7xXqkM87bkOwsT3NoJ5ZsIdhUmDveKwowaC8VX+
	 NwpmMI6LpHZ+hk2RZgvGv+E4jiZltvM4rqpX1blqfHXzIrkJS4mWWn0H9FXPDSTwvn
	 uInTh38P1hm6Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kho: fix size calculation in kho_preserved_memory_reserve()
Date: Mon, 27 Jul 2026 17:02:39 +0200
Message-ID: <20260727150240.889555-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

kho_preserved_memory_reserve() calculates the size of a preservation by
doing 1 << (order + PAGE_SHIFT). Since the '1' is a 32-bit integer, it
can only be shifted by 31. That is, it will only work for preservations
up to 2 GiB. Larger preservations will trigger undefined behaviour.

While preservations larger than 2 GiB can't be obtained via folios
currently, they can be obtained via kho_preserve_pages().

For example, memblock reserve_mem uses kho_preserve_pages().
Reservations larger than 2 GiB are valid and will trigger this bug if
properly aligned.

Fix it by using 1UL for shifting.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

---
Stable backport note: This patch fixes kho_preserved_memory_reserve(),
which was added by 3f2ad90060f6 ("kho: adopt radix tree for preserved
memory tracking") in v7.1. The bug in older kernels was in
deserialize_bitmap(), which was added by fc33e4b44b27 ("kexec: enable
KHO support for memory preservation") in v6.16.
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 175c08a6e41e..6fad9152387a 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -501,7 +501,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	struct page *page;
 	u64 sz;
 
-	sz = 1 << (order + PAGE_SHIFT);
+	sz = 1UL << (order + PAGE_SHIFT);
 	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */

base-commit: 5c4a03afcb21783987ffc64562b76ddd5a21b12b
-- 
2.55.0.229.g6434b31f56-goog


