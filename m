Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB1DCCFA03
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X8b6TjRMt+dyAXz7YM2WBrHqiTyR0VEpvl9wTYXPD+M=; b=ZXREYp+Ds4NRmspuprQcMxrlqs
	jNTQss5LyXNflHgs/uR04KOPjIMPBRshwpl18kvHUzioElarG+m6B9nAU2kZjDWysAT/86P4XKlC/
	q4uG3vU7iYpsG3ySW38hihTCAJqWNVJ6pRAGwZ37vt1DVeI/hc1a8rCLvp+5I7+liYt4Uzg7clVBO
	02kNBlk312cMSTJrWSCQYshXSBPV8uvjtdaYAus711qCWUL4UwWWeB4gT+E7jIJaDGdJ0w6f86vEp
	6miN66naSgD6LOqfYH6/Hd7vThIV1n8Bf/Pyo3Na1G67WFB43BkZiZWjbauMX0GQaFK+n/MiWOtV/
	Z++57A3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFytC-0000000AS0x-2oce;
	Mon, 03 Nov 2025 18:02:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFytA-0000000ARzw-0cQF
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 18:02:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6ADA143D2E;
	Mon,  3 Nov 2025 18:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FBBC16AAE;
	Mon,  3 Nov 2025 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192963;
	bh=BW3nIFF3ejh4ARubY8O9vgvGP+ux/Zl54hpiB5TaeKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP85rxHj43C1QmClK8ydP/bgZqswAFc42oKCQ54TrICWgUj7GK2OkmKpGHZLFDuuv
	 14CnmrqrWsbN0Tc2NEsq4z4VD1Smh+jmRndB98xJzaJ6Hrqaq3a2QBhNTBQC0vbi2d
	 9KCzSphtvVWw5jHiwPGcYSxyw9awUJOT/B9B4ruG98mvH8AW6c03H7qnUZGiPc+YsJ
	 K5Uw1ebrjxDlVFP5DYUcL5niMxwv5foGeTmX3JjUh+7YKh06RG1SbV75BqgHSvdX7P
	 o2JO+UpEXblcyaVwJdlve7y55XjhQER/XqgbzXiSDlx9hmbknSJSiEh7O/750ReEi7
	 +rrOUX2DFlXIQ==
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
Subject: [PATCH 1/2] kho: fix unpreservation of higher-order vmalloc preservations
Date: Mon,  3 Nov 2025 19:02:31 +0100
Message-ID: <20251103180235.71409-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103180235.71409-1-pratyush@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_100244_203223_3AC66B6F 
X-CRM114-Status: GOOD (  15.03  )
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

kho_vmalloc_unpreserve_chunk() calls __kho_unpreserve() with end_pfn as
pfn + 1. This happens to work for 0-order pages, but leaks higher order
pages.

For example, say order 2 pages back the allocation. During preservation,
they get preserved in the order 2 bitmaps, but
kho_vmalloc_unpreserve_chunk() would try to unpreserve them from the
order 0 bitmaps, which should not have these bits set anyway, leaving
the order 2 bitmaps untouched. This results in the pages being carried
over to the next kernel. Nothing will free those pages in the next boot,
leaking them.

Fix this by taking the order into account when calculating the end PFN
for __kho_unpreserve().

Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    When Pasha's patch [0] to add kho_unpreserve_pages() is merged, maybe it
    would be a better idea to use kho_unpreserve_pages() here? But that is
    something for later I suppose.
    
    [0] https://lore.kernel.org/linux-mm/20251101142325.1326536-4-pasha.tatashin@soleen.com/

 kernel/kexec_handover.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index cc5aaa738bc50..c2bcbb10918ce 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -862,7 +862,8 @@ static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur
 	return NULL;
 }
 
-static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
+static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
+					 unsigned short order)
 {
 	struct kho_mem_track *track = &kho_out.ser.track;
 	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
@@ -871,7 +872,7 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
 
 	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
 		pfn = PHYS_PFN(chunk->phys[i]);
-		__kho_unpreserve(track, pfn, pfn + 1);
+		__kho_unpreserve(track, pfn, pfn + (1 << order));
 	}
 }
 
@@ -882,7 +883,7 @@ static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
 	while (chunk) {
 		struct kho_vmalloc_chunk *tmp = chunk;
 
-		kho_vmalloc_unpreserve_chunk(chunk);
+		kho_vmalloc_unpreserve_chunk(chunk, kho_vmalloc->order);
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 		free_page((unsigned long)tmp);
-- 
2.47.3


