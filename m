Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FC4D778AC
	for <kexec@archiver.kernel.org>; Fri, 23 Jan 2026 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S2S0WlaV4vxb0aJ8f8js9z0LgDKD8OgU/6Ktc0cMHIg=; b=z6pDL8iJA3uzmtK6GU3B/y9eTn
	vtyJEW+OAklduHkK1aaTEFL4rk8W3tgQNllnKqYQbUvc4OipLsPACSYHqx4S8ueX6lW90TywHVMED
	VJ1Sgm4Q1L7AHYL0gLtIA3bWZ7vh95kCz7MRGOhIU615bbh9g02TAyOEkYUc3k/3sZ8iXAh/zUdZZ
	uK5jW3N06hRnO+nPF+EuDxF7pmvuYAr6uHmSHIDNfbjy+plCjtP2YNpl0s/cWSvhdF8hZsm7VNe6y
	hYwSQxNkLqM9Uw0+jKmJz3A9NtHpeZK1daap2iywVwjW6zl4dChZ6U85iLSy343Vo29nQRxhEiJgE
	EfEBvdxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjMX2-00000009Nn8-255C;
	Fri, 23 Jan 2026 19:09:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjMWu-00000009Nlx-1MNc
	for kexec@lists.infradead.org;
	Fri, 23 Jan 2026 19:09:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A01C43590;
	Fri, 23 Jan 2026 19:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E6AC116D0;
	Fri, 23 Jan 2026 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769195350;
	bh=F+gMVw54pCVD3wiRysjyfpr+kXBpSogewadJH4cJlxw=;
	h=From:To:Cc:Subject:Date:From;
	b=Oxbkg5JSR7Js7ZkUqp86Towi+FnFS1jbUSlVzv1ReOaerdtWzEENi+05FvVEOJP6q
	 LfZHb/XgiXcGeJ0ImbiPd5pt59Rwb78AgxikDCPoaenR+ceh/hNNP/vdF0DU+d6++D
	 HxSgZWB5JSCZnJpYqYVlBVeiYuno9GxYQ54+rs/llNtJmTpKqSAgxQ3UvN2sP88FF/
	 QYC3XU6W68sGmNqLzt4Uf0g6tWRvxbhUjBXP1lfK7eooteNthGafncTFUo9/xRkhzF
	 Lj3Iu1hEMijTWoJi1A4iezrU54Pe/NZyg+VvxemPEV9t8/XAoM+GzdPjx5lEejIWHm
	 UQ0zGcMA2rsYA==
From: Tycho Andersen <tycho@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: fix doc for kho_restore_pages()
Date: Fri, 23 Jan 2026 12:05:06 -0700
Message-ID: <20260123190506.1058669-1-tycho@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_110912_404171_7383EE26 
X-CRM114-Status: UNSURE (   9.82  )
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

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

This function returns NULL if kho_restore_page() returns NULL, which
happens in a couple of corner cases. It never returns an error code.

Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index d4482b6e3cae..4c38ea7987c8 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -281,7 +281,7 @@ EXPORT_SYMBOL_GPL(kho_restore_folio);
  * Restore a contiguous list of order 0 pages that was preserved with
  * kho_preserve_pages().
  *
- * Return: 0 on success, error code on failure
+ * Return: the first page on success, NULL on failure.
  */
 struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
 {

base-commit: c072629f05d7bca1148ab17690d7922a31423984
-- 
2.52.0


