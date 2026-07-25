Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AA9C531D0
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LaqxU7t1DcIW99g2BQNqgYEXNYFD/Bj+yDLgBdqM5CY=; b=H3MFVZdYqa4+k7RkWBO521qnB4
	ta/V8OFwpKBZ4DbMhPph8V+bZY/N9FysQgpZNolp7lz/i4vdfi2+C0tvda1OuHZ1gtcGAM3Uk57jp
	xE0xkSh7liY2aYpKc3M7z1sXyfNeEa8eof85ivUUyWUTH7bYHhHkuDpnpPEOG/kYlih0U4pTLPseH
	HzHuQFWfTajE/d2jAFG465idBDir2794chkieVHEQ4JDjuajMjyOCXTgQJY2L967yKvtC8po+tpL1
	65O5NxuJdTRc0w+kQjmazl4pMsfPLFo6vV2x06Yz1UPjn1NcocxTILfXsmOwEEee0HgpFOQGWkNkk
	F9QffGCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng4Q-00000000aGz-3ZcR;
	Sat, 25 Jul 2026 17:21:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng4P-00000000aGI-3dn4
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 17:21:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 89FD045081;
	Sat, 25 Jul 2026 17:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DA21F00A3A;
	Sat, 25 Jul 2026 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785000113;
	bh=LaqxU7t1DcIW99g2BQNqgYEXNYFD/Bj+yDLgBdqM5CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjMUbw9GW4yPvRDPEp13GAHT6cac7lGwMMM5W1Prw23zFqz1ePacNrbjCsxyXg3Dz
	 J4cO7mEwUJK24lTPeK7h7a1pN8fVezOhTdbT0IUWFYQ1rbolV8QYm4nCyty9Hh3Pei
	 jVfvUm3uVO6JDAtuEWrgh7HRg3Jd6j2gyhQxxGY+dAwPkM214GVLLfQm1/Wg0MM9RJ
	 5nIqc/vl3aqzb82VK8Nk+KfSyEub3nSm9CD8upxUaOKCk+l7C5qjHMkzpNIWyVR9R5
	 0R3lguAjqo/j6iOtwNognXTLC65lcBzPQ+XM33qsHv2KjqYbmGtqHDDakSVyh7yS9p
	 AqTbYrHsUxVbw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/21] kho: disallow wide keys in radix tree
Date: Sat, 25 Jul 2026 19:21:03 +0200
Message-ID: <20260725172133.4018491-4-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260725172133.4018491-1-pratyush@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
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

The KHO radix tree was designed to track preserved pages. So it does not
provide the capability to track any 64-bit key. Instead, it limits the
key width to how much it needs for tracking PFNs and their orders.
Limiting the width reduces the number of levels in the tree.

KHO is not expected to be the only user of the radix tree. With the API
generalized to allow other users, now it is possible to add any key to
the tree.

Check the key width at kho_radix_add_key(), and error out if it exceeds
what the tree can handle. Do this instead of increasing the tree depth
since right now there are no users that need to use wider keys, so this
avoids memory overhead and ABI breakage.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ea24f23ce292..e7451743b87e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -156,6 +156,11 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
  * intermediate nodes do not exist along the path, they are allocated and added
  * to the tree.
  *
+ * NOTE: Currently only keys of width up to %KHO_RADIX_KEY_WIDTH are supported.
+ * This limit only exists because current users of the radix tree don't use more
+ * than that. Changing the maximum width requires changing the tree depth, which
+ * needs bumping the ABI version.
+ *
  * Return: 0 on success, or a negative error code on failure.
  */
 int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
@@ -172,6 +177,9 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
 	if (WARN_ON_ONCE(!tree->root))
 		return -EINVAL;
 
+	if (unlikely(fls64(key) > KHO_RADIX_KEY_WIDTH))
+		return -ERANGE;
+
 	might_sleep();
 
 	guard(mutex)(&tree->lock);
@@ -244,6 +252,10 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 	if (WARN_ON_ONCE(!tree->root))
 		return;
 
+	/* Keys wider than KHO_RADIX_KEY_WIDTH are not allowed to be added. */
+	if (unlikely(fls64(key) > KHO_RADIX_KEY_WIDTH))
+		return;
+
 	might_sleep();
 
 	guard(mutex)(&tree->lock);
-- 
2.55.0.229.g6434b31f56-goog


