Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5BAF3C248
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=os8LJwgTVC15dJZoK2SNHppYxuMj/YeuyOkX7l1pAKs=; b=jHMi/eKrBnmlzWyvMETDCB0SNC
	fFVKWCW0CxhacGjJ389TE4uNFd3ycq+Z65Ij39GHWcbhngI2+CW0Er5UcxF86EHYfNBd4g1nkjyDM
	5SsKdnfOELXZoSCTtUtrIf5z8Slv/pGNbm4xq9P9N88f199gegB77Yz3BjhILOzeIpFyGGMBZkUKu
	jFjLm2oKABaGQSxARTmebw7JS1JDAyxOelZxd1ZYxw+0F4lLg2iZ3z0FptkD2hTYtclSGN6pTyDH+
	dKxjuOdquYpm0A48ZcHmrZdwqNHJL584wxjw/1IFHTTObRvxsVFY3YphunFLV32JoTzWewawFF2av
	ItAkO+UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzZp4-00000007K1W-1bik;
	Mon, 09 Mar 2026 12:34:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzZp2-00000007K1A-3fKE
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 12:34:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 42CB5600B0;
	Mon,  9 Mar 2026 12:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF2DC4CEF7;
	Mon,  9 Mar 2026 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773059695;
	bh=gAZtsXuVCQZAaWSuJc+3R0a9ehVlq0Y70kTuOfLhCbE=;
	h=From:To:Cc:Subject:Date:From;
	b=aokPU8BvqTGchyuCzIuNeiQ8qP/hrE7iYZZdXhyaNuqAaFkiXwphl6BhDnLOZ7TRN
	 ZJkJlJngDQMyZRE85FpXe8HlO14vh0anff0e6Z++FkX/8o52bE9w8vbh5VCxvivppS
	 R9iSiQDviOzYYPPgDOBH1enVCr5/8v2mSc5c0XGoGoU+DmCxk5vKewHAOwmK/h7J0O
	 AGv7hwbxcMUk0FB1N9lZwaf0dj6kcOdLgv7O2l2fRx9CxwBfwWs9vjt8d/Zyf8NSsf
	 gYCJVnjOYxB/2Ydo3dIBfKFV9cIx0IauaTY8nUOPbg8wvDQVGt5nCYGY5yQag2I6xc
	 81jT83wv7xryQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kho: make sure preservations do not span multiple NUMA nodes
Date: Mon,  9 Mar 2026 12:34:06 +0000
Message-ID: <20260309123410.382308-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
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

The KHO restoration machinery is not capable of dealing with
preservations that span multiple NUMA nodes. kho_preserve_folio()
guarantees the preservation will only span one NUMA node since folios
can't span multiple nodes.

This leaves kho_preserve_pages(). While semantically
kho_preserve_pages() only deals with 0-order pages, so all preservations
should be single page only, in practice it combines preservations to
higher orders for efficiency. This can result in a preservation spanning
multiple nodes. Break up the preservations into a smaller order if that
happens.

Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    Ref: https://lore.kernel.org/linux-mm/CA+CK2bDvaGmfkCPCMWM6gPcd4FfUyD6e5yWE+kNcma1vT3Jw3g@mail.gmail.com/

 kernel/liveupdate/kexec_handover.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cc68a3692905..bc9bd18294ee 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -869,9 +869,17 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 	}
 
 	while (pfn < end_pfn) {
-		const unsigned int order =
+		unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
 
+		/*
+		 * Make sure all the pages in a single preservation are in the
+		 * same NUMA node. The restore machinery can not cope with a
+		 * preservation spanning multiple NUMA nodes.
+		 */
+		while (pfn_to_nid(pfn) != pfn_to_nid(pfn + (1UL << order) - 1))
+			order--;
+
 		err = __kho_preserve_order(track, pfn, order);
 		if (err) {
 			failed_pfn = pfn;
-- 
2.53.0.473.g4a7958ca14-goog


