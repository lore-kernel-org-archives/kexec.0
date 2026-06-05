Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD563CD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ioAGw4mo1ZSaLPYQr72a7mMnE73SA6K6tW1O9fGp0Eo=; b=gs4CDC56QyGZPinyfkLTzBgrbP
	VK0Gt6B0Moi9SULt244U2WMd1CFNicfldMHzCxEROgvpWR5lhiWPJgtWjVJdUvNGaxqO1wyYEbcET
	M7EKp3nGMli/SG+0S7T8D+iX8Sq3/JXCWx1WjqV2VgynpcPuKuUOhY+hCYe2Ch+AXOOX/Rkdc0foy
	IxDIVcbFCcGgaNWCCsP9dIM1Jtn1oGUE1wkp+3r4zYY67OaGKip7fSyiIYWaV0zp9Y5CJuZUw3NuA
	gEsIiFNxui7h3eW9OikySHXQBKEHohPPbVc2GtPDrRGED4ueUvcUVY+yTI82yUNFkGq9FDhQYjiKf
	0CQTTAxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZO3-0000000132e-1Aj6;
	Fri, 05 Jun 2026 18:35:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZO2-0000000131d-14Ce
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A441260204;
	Fri,  5 Jun 2026 18:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404861F0089B;
	Fri,  5 Jun 2026 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684517;
	bh=ioAGw4mo1ZSaLPYQr72a7mMnE73SA6K6tW1O9fGp0Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTBqi736uwqUzUJI9Q+VNGsjRDZoHKuLa+3iVAAhbnHhWJxIXcxg8gU8z0tqWrtVv
	 9FCWlBj9VEcEa/BnpGozoyHllj034V/bRRKn+vHsuaxtG3LxCEzdPS2KRQx2L7kens
	 btlbEQkkq3gzDNhJHd7W++WPQ/tKpmAukn0b3+OzlLlgAT3wwON9oh/5+Qda5zH/Jm
	 6FYzfGd2crcelE9VVBt3gw+qSb4VGtokhTO+III6C95A3b9aM/IBW6snlhZ6X3FdCJ
	 ThGmbQaoWfLwvar6GMCXSLZABMu8DwNGXgyNGsv6i5gxMyOBjF3acia4WJ40dg7h+V
	 4oDX9OVkERArA==
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
Subject: [PATCH v2 02/18] kho: disallow wide keys in radix tree
Date: Fri,  5 Jun 2026 20:34:35 +0200
Message-ID: <20260605183501.3884950-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605183501.3884950-1-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
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
 include/linux/kho/abi/kexec_handover.h |  8 ++++++++
 kernel/liveupdate/kexec_handover.c     | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index fb2d37417ad9..6dbb98bfb586 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -278,6 +278,14 @@ enum kho_radix_consts {
 			     KHO_TABLE_SIZE_LOG2) + 1,
 };
 
+/*
+ * The maximum key width this radix tree can track.
+ *
+ * This value isn't ABI itself, but it is derived from values that are ABI.
+ */
+#define KHO_RADIX_KEY_WIDTH (((KHO_TREE_MAX_DEPTH - 1) * KHO_TABLE_SIZE_LOG2) + \
+			     KHO_BITMAP_SIZE_LOG2)
+
 struct kho_radix_node {
 	u64 table[1 << KHO_TABLE_SIZE_LOG2];
 };
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 7349cc82f6dc..e8454dc5b489 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -153,6 +153,11 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
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
@@ -169,6 +174,9 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
 	if (WARN_ON_ONCE(!tree->root))
 		return -EINVAL;
 
+	if (unlikely(fls64(key) > KHO_RADIX_KEY_WIDTH))
+		return -ERANGE;
+
 	might_sleep();
 
 	guard(mutex)(&tree->lock);
@@ -241,6 +249,10 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 	if (WARN_ON_ONCE(!tree->root))
 		return;
 
+	/* Keys wider than KHO_RADIX_KEY_WIDTH are not allowed to be added. */
+	if (unlikely(fls64(key) > KHO_RADIX_KEY_WIDTH))
+		return;
+
 	might_sleep();
 
 	guard(mutex)(&tree->lock);
-- 
2.54.0.1032.g2f8565e1d1-goog


