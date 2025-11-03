Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FFFCCFA05
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xWMY2o/E6UUoBWEdth9HC7Z4P93bqA/6qPGz/knPr7E=; b=rHp03v5LrFYQ4wz/Bzynes20h5
	nqGszIUaealPJFmGlfIwEKXdLvZYPZGmmaRlTA4mlCJ8bjHktwGGvRr6hTbzjmGvVfVvhoJrAq9fp
	08jLXwFeXzRGdpp5xkQOlalRVD2EV4oGH9gmZzmwxY/Q1tx2Mn6TT0dPU6hTu+m28omAu77GJIVH+
	Y6pl1bAe1aPvrcwzaroA77tw8+ixHX00tu/2S6IwnydiFa/cKMx5NX3SrgN0myAbdHvU/mGS4dl/9
	sZwt7b8y8nBOa1UddXdH7PzDTHxkfQt7IDykVvy/HtR2Wjle85VL+JLyIUR44RuX1TNUJesz/N5A+
	3Y5pXaZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFsKD-00000009gwf-1RS2;
	Mon, 03 Nov 2025 11:02:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFsK9-00000009gvK-07hG
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 11:02:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DFC5041AE6;
	Mon,  3 Nov 2025 11:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742AAC4CEE7;
	Mon,  3 Nov 2025 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762167727;
	bh=dBEGE7Q2FKfgjAlIXnLQQ3kv27gx1kpdPQtSwVZaBLg=;
	h=From:To:Cc:Subject:Date:From;
	b=Zq8xyZaPRCiSAPW57VhpsgAiTBwBqP6XkDgxOvn5vZzA1sYnqgh0RK5mD5wnjGYGK
	 Hu0MC0hbd6ILJ24QPsYjK8AvwJlo6q3ygStghGvD32c6OmXG8C5HjncIMB9PZpxato
	 J4d2LnumJHSpZbzkzdQ0c+4R7sixgMQU/dRonIMHaL5Em2sFwnlppVzwgrIZhsXuG3
	 Og0dec424Y3aGwlYl0f+1ns2Q6LnPqADoaWiu6OjG0zo0fVswYDtBIWirBCBfuYtW2
	 Ex22L8WzhNXm3fHjLOWEViWi8YdGBaF1JvcxixiNfx8swlRvyHsquMloLFfUCHjitS
	 seAV/qWGeefQg==
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
Subject: [PATCH] kho: fix out-of-bounds access of vmalloc chunk
Date: Mon,  3 Nov 2025 12:01:57 +0100
Message-ID: <20251103110159.8399-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_030209_083876_4E32C43A 
X-CRM114-Status: GOOD (  13.22  )
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

The list of pages in a vmalloc chunk is NULL-terminated. So when looping
through the pages in a vmalloc chunk, both kho_restore_vmalloc() and
kho_vmalloc_unpreserve_chunk() rightly make sure to stop when
encountering a NULL page. But when the chunk is full, the loops do not
stop and go past the bounds of chunk->phys, resulting in out-of-bounds
memory access, and possibly the restoration or unpreservation of an
invalid page.

Fix this by making sure the processing of chunk stops at the end of the
array.

Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    Commit 89a3ecca49ee8 ("kho: make sure page being restored is actually
    from KHO") was quite helpful in catching this since kho_restore_page()
    errored out due to missing magic number, instead of "restoring" a random
    page and causing errors at other random places.

 kernel/kexec_handover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76f0940fb4856..cc5aaa738bc50 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -869,7 +869,7 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
 
 	__kho_unpreserve(track, pfn, pfn + 1);
 
-	for (int i = 0; chunk->phys[i]; i++) {
+	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
 		pfn = PHYS_PFN(chunk->phys[i]);
 		__kho_unpreserve(track, pfn, pfn + 1);
 	}
@@ -992,7 +992,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 	while (chunk) {
 		struct page *page;
 
-		for (int i = 0; chunk->phys[i]; i++) {
+		for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
 			phys_addr_t phys = chunk->phys[i];
 
 			if (idx + contig_pages > total_pages)

base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
-- 
2.47.3


