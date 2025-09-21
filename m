Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAC8CAC5AD
	for <kexec@archiver.kernel.org>; Sun, 21 Sep 2025 05:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b0UkgIRRiUCJy7C6Y062+omUJT2kSrmXXwq/Mgn5w2Q=; b=v43qJAXQy5wCShNWiCLucT/6kc
	zwnBSM/6Mlk0iBF4DiYseFbRIOQ6wOl4132IOIEXF9VsogBCARzHSLvW/iNavFNdAbzrtUh89GB/I
	YRVJ+rWi+HwjPUKhBiuW2ykp0JGXNnXunv2mY0pjvEPSXAspfHiQK30qU6HOlltDUDmzuZk+BRvdS
	Z8WKXqc7nR5BZVquI35tjTCqniTNs86geAlGJJVkRzpLaXbSX0OzPrlBQjmNZYGqVP0qp78kFYE+b
	l5rPRRTjGNZ5AHyqD8ZoAb/bgCg2JGEK3kB8wARBUrgVC7D4up+ENNM3GjQ4oTjBgT0iw02HG0uIg
	bs4KgObQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Csr-00000006hAM-3pAD;
	Sun, 21 Sep 2025 05:45:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Cso-00000006h9N-3evx
	for kexec@lists.infradead.org;
	Sun, 21 Sep 2025 05:45:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F1ED460194;
	Sun, 21 Sep 2025 05:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B61C4CEF7;
	Sun, 21 Sep 2025 05:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758433509;
	bh=qKv5CzwLLtDXYj45Vz9NYuIeSEVLwG4QLtqMDnI6e28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+GIwKUZiWi4CgoEKu3KIu0wCOseJatAQSLSbZrUrAd9QoU8dee7yMHTGBzMSl3ED
	 ghUNJKQmWMNsRQsovFspvdM74/loQb6s8wVAyzRVLnudXh9mi6Y9XAD4BTFIqTrpxV
	 YpM1FDAM8o9cVrU53BDIL8rEfMKrl3lifCqVMPTyMJMNm6vheOM0whKLPYEpG5SKzJ
	 9WwAHXW99DNpa7Mnab+L4PVv6op2Lmf1qcubLtxBjpv2xAQeajXVNojqll7cN0T3pX
	 Dv7AmV7DMnJJuGJ0nmafCjjorQFg5WhjF1blob4QalpCms1ubzOs2Ozz77S1JYfXRf
	 iGTaBzeol9Tbw==
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
Subject: [PATCH v5 1/4] kho: check if kho is finalized in __kho_preserve_order()
Date: Sun, 21 Sep 2025 08:44:55 +0300
Message-ID: <20250921054458.4043761-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250921054458.4043761-1-rppt@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
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
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 55 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 555488eb1a18..85f1bf38b123 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -107,6 +107,29 @@ struct kho_serialization {
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
@@ -165,6 +188,9 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 
 	might_sleep();
 
+	if (kho_out.finalized)
+		return -EBUSY;
+
 	physxa = xa_load(&track->orders, order);
 	if (!physxa) {
 		int err;
@@ -667,29 +693,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
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
@@ -717,9 +720,6 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -743,9 +743,6 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 	int err = 0;
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-- 
2.50.1


