Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551E4F3C241
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+QvVfVDDjSHdOMuU9xEZB+TDS7YqSYDHOoyyOBkn68=; b=Uk2JqEuRC6xj3Sc1gcWG4x/uIc
	t7ud9CdD043tgfToNX5yIxT7jlAgnLj9xkeuxozH9phm0D+dX1RDHD5TaKZQCiMpkfZuJa82hE9VQ
	3QglXpRt+NnP2Mdjg4rda0wfalsMS1GZKd1z3CEME/FKa6JFv0pDpiatU8l7aoZ0wmOn++eybdQD6
	fB0ZpOyBGVnpZII7beywWyg3znKJ3M3ADSS3kvazfQgBqx8tWywP9txmqEZNtw9pgbf7losnTlYX2
	XFxhn6vfwPe334OPFce49Hr2IKjvy6vNTs8P16FBKrsNZ6OIs3eJHdHexKItQ5W6z3R1J8UhfTXn3
	UcgIW4mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzZp6-00000007K1x-2xGQ;
	Mon, 09 Mar 2026 12:35:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzZp3-00000007K1Q-48Du
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 12:34:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 67BF36013A;
	Mon,  9 Mar 2026 12:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E5AC2BC86;
	Mon,  9 Mar 2026 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773059697;
	bh=+0wA474v7nGumxjsD4uBjOHoecHS+At9sWy47yvU5l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgRs7yMhnJmvtZQe6EkaO6+UoTSVjE9edgYr80SRJ2nUwqQ+tMX3FpQy0xEUzElMa
	 GfKLr1bFcQ3BBJFwmFS36Jm3ULHgZZUQfkZ6TbtdS2lBvAWOj6MYOAeS5qZ1JhUge4
	 U4OnGbdoMqOLhOAfFvzeVtcpwlfPzR/152dQvJAQMno18ikG+2u/7CpP9oirOn1KqR
	 kgCqOnhQ5AzednCk+s2cw5aTdEYLFBNp1qE15umTtU2PPaTmAPlo8RGXErq8c/PWTE
	 cYT0FseEtymrV41BwP5IDGMSJ1KEy2sszqbVIrS76ThxLAhwyq11rCJJ2HEl9+D03W
	 JOQShaugTHwrw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kho: drop restriction on maximum page order
Date: Mon,  9 Mar 2026 12:34:07 +0000
Message-ID: <20260309123410.382308-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260309123410.382308-1-pratyush@kernel.org>
References: <20260309123410.382308-1-pratyush@kernel.org>
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

KHO currently restricts the maximum order of a restored page to the
maximum order supported by the buddy allocator. While this works fine
for much of the data passed across kexec, it is possible to have pages
larger than MAX_PAGE_ORDER.

For one, it is possible to get a larger order when using
kho_preserve_pages() if the number of pages is large enough, since it
tries to combine multiple aligned 0-order preservations into one higher
order preservation.

For another, upcoming support for hugepages can have gigantic hugepages
being preserved over KHO.

There is no real reason for this limit. The KHO preservation machinery
can handle any page order. Remove this artificial restriction on max
page order.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    This patch was first sent with this RFC series [0]. I am sending it
    separately since it is an independent patch that is useful even without
    hugepage preservation. No changes since the RFC.
    
    [0] https://lore.kernel.org/linux-mm/20251206230222.853493-1-pratyush@kernel.org/T/#u

 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index bc9bd18294ee..1038e41ff9f9 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -253,7 +253,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	 * check also implicitly makes sure phys is order-aligned since for
 	 * non-order-aligned phys addresses, magic will never be set.
 	 */
-	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
+	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC))
 		return NULL;
 	nr_pages = (1 << info.order);
 
-- 
2.53.0.473.g4a7958ca14-goog


