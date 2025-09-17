Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F89CAC59A
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCoLRximDJC7CAzkSmIC7qmkF1kfGQUDayy2Gj1yZaQ=; b=QnAJCyIZijQtFWvbh2b4XCDZbP
	1c+5V80yDasPA5+EyWP+wsrJqacrgmWBje1FH4BzJ1wKId5kZ955zQCK0T/xBXWl0Bo3pwDhG6J7r
	jjm5u+fZxKeZZCCawsGX6wrkIgAMWooApkw2n050ux4/aRNB8iGJxL8myPa48p8KOmdwBXRUegLC2
	GMSfC/oRpMLlpGI0Ks62KdBt7XJt8GT8DNi+NIXpOHIJK0QEJTpAT6yMhwuj4+qID4GdMWPV2OHy1
	2P7nDmCWSZf+iiuQA08BUHX95DPngTFHttK28h8hdLxg691AqUh4g1CJvoBbPGJJxhfNmESU2osO7
	Ch64ls7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyw98-0000000DfFL-2Il6;
	Wed, 17 Sep 2025 17:40:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyw97-0000000DfDm-1cpy
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 17:40:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CAB386024C;
	Wed, 17 Sep 2025 17:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56019C4CEE7;
	Wed, 17 Sep 2025 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130844;
	bh=8S8e7n6CmQnQKabzKFlVH8Uaq/Xv4oQU9mDtf6delh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imKc2B/Go7tqGnVzKJxq26RWe2jdsBf9Ed5PIKotck8RwFHLfGS0BBPjt8DjrQzwQ
	 PoZq1MNENH7vxNPLowth8cqCBY6VFfgrh/wMPvNHtXoc1QdyvzGZ8KBajL+RtHpAKH
	 BIqzDAu8/OgWWkBn++4a8QixTRL1Z/m4JEbIaMfM7i121nzr00gzHlLgQwfikkq8ZO
	 /7V0AUJnUyLyc32HBkNk+A9WDN+0OI8eYdqYYVDkT5cugq5KiRquwEcou1kuW/iU7K
	 1NOiI35NaZo02txKyCoqSbdnRtMfhvXTf4yEpXQS4PPwgGf9N6kV+jGCJhpSJ0ABX5
	 huHkkfAT7XbvA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] kho: check if kho is finalized in __kho_preserve_order()
Date: Wed, 17 Sep 2025 20:40:30 +0300
Message-ID: <20250917174033.3810435-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917174033.3810435-1-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Instead of checking if kho is finalized in each caller of
__kho_preserve_order(), do it in the core function itself.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/kexec_handover.c | 55 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 8079fc4b9189..f421acc58c1f 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -91,6 +91,29 @@ struct kho_serialization {
 	struct khoser_mem_chunk *preserved_mem_map;
 };
 
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+
+	struct dentry *dir;
+
+	struct mutex lock; /* protects KHO FDT finalization */
+
+	struct kho_serialization ser;
+	bool finalized;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.lock = __MUTEX_INITIALIZER(kho_out.lock),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+		.track = {
+			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
+		},
+	},
+	.finalized = false,
+};
+
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 {
 	void *elm, *res;
@@ -149,6 +172,9 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 
 	might_sleep();
 
+	if (kho_out.finalized)
+		return -EBUSY;
+
 	physxa = xa_load(&track->orders, order);
 	if (!physxa) {
 		int err;
@@ -640,29 +666,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
-
-	struct dentry *dir;
-
-	struct mutex lock; /* protects KHO FDT finalization */
-
-	struct kho_serialization ser;
-	bool finalized;
-};
-
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.lock = __MUTEX_INITIALIZER(kho_out.lock),
-	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-		.track = {
-			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
-		},
-	},
-	.finalized = false,
-};
-
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
@@ -690,9 +693,6 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -716,9 +716,6 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 	int err = 0;
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-- 
2.50.1


