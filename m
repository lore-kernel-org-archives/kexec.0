Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40911CEE347
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JgiFawHTV8sjMcTxgYzGBKzIQAziP/HDriKppK8XrKA=; b=aEgT+dO40KI+St6x7//M1BPqCF
	15hUPk1q4uhzQHVjnfdTDl3AL3bT28sk7ug2xQ3SBl3VkJ4haCdxvl9nWhuxvffLFcD5I04XD973V
	AZIWyHUtwfnRGBONayEUiu0yqN/UYHB0RkA+d9iUvWUaEtyeMytDQ7tq+aCrUbeffITvmrRTjfwDi
	XUCFeX2TaN3gtj3jlz8UYC61HMUpqem8UCRyK1AaX4dU569Fx0ugzmseN/VWMBZT8ouia3xj/Oc50
	KrhX6KuEeWqRW3pJ50P5bjKa+FWXcVxmymkAfW4UjtwIvoyK77E+N/Kjh+XVBcH7W7I4z0YO7ZNcM
	AHQ90weQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQHW-00000000v1w-2683;
	Tue, 18 Nov 2025 18:18:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQHT-00000000v1X-3rW7
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 18:18:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2D6D4416DB;
	Tue, 18 Nov 2025 18:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15735C4CEF1;
	Tue, 18 Nov 2025 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763489898;
	bh=FWLUqOdMeWCRKRBg/ecVB9LXW/vLiI6Nwu+aIyQipT8=;
	h=From:To:Cc:Subject:Date:From;
	b=hIjpsigbCNnQYXYNp8d9ZiAyOO1Zwgsu9A+V1gdsHGNJLBYjlzdFAmsJyyIxCkIrc
	 dyQx6yhhm3emDdwE8Zq+dJcSTcIJNvIGvlLMTjtw/BURzonlJqWGAoAEsXRLJC0ZYL
	 dIh5QFwCOWleYdyi9USWnzQ94WEHzrewk/ggEEpK+4MTLdNpb6+VnEHGVd3DlyYsIA
	 kXrRhIXQRXWPSEQa1gsGhn+lYj20u5z3jAcXU7WlsbQPltws8ptQp8VOoXjADjRtVS
	 Dg8mUZrezNJApRZ0WpIOptUq95rvLeQPsPIP7d/CYSsHORCkQBD3VJ7OCehG1xyQ8G
	 +gwgNphc5NjHA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: free already restored pages when kho_restore_vmalloc() fails
Date: Tue, 18 Nov 2025 19:18:10 +0100
Message-ID: <20251118181811.47336-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_101820_002687_ABCA6675 
X-CRM114-Status: GOOD (  11.01  )
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

When kho_restore_vmalloc() fails, it frees up the pages array, but not
the pages it contains. These are the pages that were successfully
restored using kho_restore_pages(). If the failure happens when
restoring the pages, the ones successfully restored are leaked. If the
failure happens when allocating the vm_area or when mapping the pages,
all the pages of the preserved vmalloc buffer are leaked.

Free all of the successfully restored pages before returning error.

Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 224bdf5becb68..515339fa526e0 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1088,11 +1088,11 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 			phys_addr_t phys = chunk->phys[i];
 
 			if (idx + contig_pages > total_pages)
-				goto err_free_pages_array;
+				goto err_free_pages;
 
 			page = kho_restore_pages(phys, contig_pages);
 			if (!page)
-				goto err_free_pages_array;
+				goto err_free_pages;
 
 			for (int j = 0; j < contig_pages; j++)
 				pages[idx++] = page;
@@ -1102,20 +1102,20 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 
 		page = kho_restore_pages(virt_to_phys(chunk), 1);
 		if (!page)
-			goto err_free_pages_array;
+			goto err_free_pages;
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 		__free_page(page);
 	}
 
 	if (idx != total_pages)
-		goto err_free_pages_array;
+		goto err_free_pages;
 
 	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
 				  vm_flags, VMALLOC_START, VMALLOC_END,
 				  NUMA_NO_NODE, GFP_KERNEL,
 				  __builtin_return_address(0));
 	if (!area)
-		goto err_free_pages_array;
+		goto err_free_pages;
 
 	addr = (unsigned long)area->addr;
 	size = get_vm_area_size(area);
@@ -1130,7 +1130,10 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 
 err_free_vm_area:
 	free_vm_area(area);
-err_free_pages_array:
+err_free_pages:
+	for (int i = 0; i < idx; i++)
+		__free_page(pages[i]);
+
 	kvfree(pages);
 	return NULL;
 }

base-commit: f0bfdc2b69f5c600b88ee484c01b213712c63d94
prerequisite-patch-id: f54df1de9bdcb4fe396940cdcc578f5adcc9397c
-- 
2.47.3


