Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DE6C28B27
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 01:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oXAk78z0pait+Woj/pzvjhLafLsZG4rU6PcvxTGAP2w=; b=n7gW40LdygqLPUmcABm0vhZzvd
	HH5aI+6RFeiYCeciYnZ3qVO2S6iVw2TjTcuB0cz+DAWuI5Zu2e6mUQqryIR6Dpl3Os0tgJkyGAw0x
	V/cmTajQHc7Ux3FQTkpqrBUTdBloeIjv4yV6n4PoPcR/GV74izJzBPhdtyX8zQC8u2NCsXUx1DscU
	fa9PQ1VA2EGQlpgumLKfeJMFDweQvEBnBeCJb1xDQPvjyz0G68g09Wqt8XZKm3ks12VYIv2+y7CJQ
	7E9kqMKkaYXMQVpSgqoiXH3lB5188IpHus2lbGnjORw6b6LMY1h82ueVXnnRlvAKC1a8k/SGhNEim
	rg9mJ37A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqMUs-0000000CnPf-1Brv;
	Fri, 07 Mar 2025 01:27:30 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqM33-0000000CiIE-17Hp
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 00:58:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741309125; x=1772845125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oXAk78z0pait+Woj/pzvjhLafLsZG4rU6PcvxTGAP2w=;
  b=WW75kKEVr19LwEX+8YZBcpldFnlHb5uQhTKuCTv46Zf1a5Z2XMZ+5bj5
   9XJrtp2EUzIl99PeAejBf29CUIvEMg7pf+zfyzEArJ4lh7YZa4bD/CemY
   sx1y7SH+pkfJgdIZn2otDDTEQZ6RMSKRXVNcsPSw9o3G2YVVh47+CLtnY
   g=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="472783411"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:43 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:1261]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.251:2525] with esmtp (Farcaster)
 id ed8deb03-f964-450e-8c8f-083e6f99ea68; Fri, 7 Mar 2025 00:58:41 +0000 (UTC)
X-Farcaster-Flow-ID: ed8deb03-f964-450e-8c8f-083e6f99ea68
Received: from EX19D014EUA003.ant.amazon.com (10.252.50.119) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D014EUA003.ant.amazon.com (10.252.50.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:34 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTP id 72A2840294;
	Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 0A87A4FF0; Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Pratyush Yadav <ptyadav@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
	"Eric Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: [RFC PATCH 3/5] mm: shmem: allow callers to specify operations to shmem_undo_range
Date: Fri, 7 Mar 2025 00:57:37 +0000
Message-ID: <20250307005830.65293-4-ptyadav@amazon.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307005830.65293-1-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_165845_592466_4292AE46 
X-CRM114-Status: GOOD (  32.14  )
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

In a following patch, support for preserving a shmem file over kexec
handover (KHO) will be added. When a shmem file is to be preserved over
KHO, its pages must be removed from the inode's page cache and kept
reserved. That work is very similar to what shmem_undo_range() does. The
only extra thing that needs to be done is to track the PFN and index of
each page and get an extra refcount on the page to make sure it does not
get freed.

Refactor shmem_undo_range() to accept the ops it should execute for each
folio, along with a cookie to pass along. During undo, three distinct
kinds of operations are made: truncate a folio, truncate a partial
folio, truncate a folio in swap. Add a callback for each of the
operations. Add shmem_default_undo_ops that maintain the old behaviour,
and make callers use that.

Since the ops for KHO might fail (needing to allocate memory, or being
unable to bring a page back from swap for example), there needs to be a
way for them to report errors and stop the undo. Because of this, the
function returns an int instead of void. This has the unfortunate side
effect of implying this function can fail, though during normal usage,
it should never fail. Add some WARNs to ensure that if that assumption
ever changes, it gets caught.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---

Notes:
    I did it this way since it seemed to be duplicating the least amount of
    code. The undo logic is fairly complicated, and I was not too keen on
    replicating it elsewhere. On thinking about this again, I am not so sure
    if that was a good idea since the end result looks a bit complicated.

 mm/shmem.c | 165 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 134 insertions(+), 31 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a80431..d6d9266b27b75 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1064,12 +1064,56 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	return folio;
 }
 
+struct shmem_undo_range_ops {
+	/* Return -ve on error, or number of entries freed. */
+	long (*undo_swap)(struct address_space *mapping, pgoff_t index,
+			  void *old, void *arg);
+	/* Return -ve on error, 0 on success. */
+	int (*undo_folio)(struct address_space *mapping, struct folio *folio,
+			  void *arg);
+	/*
+	 * Return -ve on error, 0 if splitting failed, 1 if splitting succeeded.
+	 */
+	int (*undo_partial_folio)(struct folio *folio, pgoff_t lstart,
+				  pgoff_t lend, void *arg);
+};
+
+static long shmem_default_undo_swap(struct address_space *mapping, pgoff_t index,
+				    void *old, void *arg)
+{
+	return shmem_free_swap(mapping, index, old);
+}
+
+static int shmem_default_undo_folio(struct address_space *mapping,
+				    struct folio *folio, void *arg)
+{
+	truncate_inode_folio(mapping, folio);
+	return 0;
+}
+
+static int shmem_default_undo_partial_folio(struct folio *folio, pgoff_t lstart,
+					    pgoff_t lend, void *arg)
+{
+	/*
+	 * Function returns bool. Convert it to int and return. No error
+	 * returns needed here.
+	 */
+	return truncate_inode_partial_folio(folio, lstart, lend);
+}
+
+static const struct shmem_undo_range_ops shmem_default_undo_ops = {
+	.undo_swap = shmem_default_undo_swap,
+	.undo_folio = shmem_default_undo_folio,
+	.undo_partial_folio = shmem_default_undo_partial_folio,
+};
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
  */
-static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
-								 bool unfalloc)
+static int shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
+			    bool unfalloc,
+			    const struct shmem_undo_range_ops *ops, void *arg)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -1081,7 +1125,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	bool same_folio;
 	long nr_swaps_freed = 0;
 	pgoff_t index;
-	int i;
+	int i, ret = 0;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
@@ -1099,17 +1143,31 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += shmem_free_swap(mapping,
-							indices[i], folio);
+
+				ret = ops->undo_swap(mapping, indices[i], folio,
+						     arg);
+				if (ret < 0) {
+					folio_unlock(folio);
+					break;
+				}
+
+				nr_swaps_freed += ret;
 				continue;
 			}
 
-			if (!unfalloc || !folio_test_uptodate(folio))
-				truncate_inode_folio(mapping, folio);
+			if (!unfalloc || !folio_test_uptodate(folio)) {
+				ret = ops->undo_folio(mapping, folio, arg);
+				if (ret < 0) {
+					folio_unlock(folio);
+					break;
+				}
+			}
 			folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
+		if (ret < 0)
+			goto out;
 		cond_resched();
 	}
 
@@ -1127,7 +1185,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	if (folio) {
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		folio_mark_dirty(folio);
-		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
+		ret = ops->undo_partial_folio(folio, lstart, lend, arg);
+		if (ret < 0) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto out;
+		}
+		if (ret == 0) {
 			start = folio_next_index(folio);
 			if (same_folio)
 				end = folio->index;
@@ -1141,7 +1205,14 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		folio = shmem_get_partial_folio(inode, lend >> PAGE_SHIFT);
 	if (folio) {
 		folio_mark_dirty(folio);
-		if (!truncate_inode_partial_folio(folio, lstart, lend))
+		ret = ops->undo_partial_folio(folio, lstart, lend, arg);
+		if (ret < 0) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto out;
+		}
+
+		if (ret == 0)
 			end = folio->index;
 		folio_unlock(folio);
 		folio_put(folio);
@@ -1166,18 +1237,21 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
-				long swaps_freed;
-
 				if (unfalloc)
 					continue;
-				swaps_freed = shmem_free_swap(mapping, indices[i], folio);
-				if (!swaps_freed) {
+
+				ret = ops->undo_swap(mapping, indices[i], folio,
+						     arg);
+				if (ret < 0) {
+					break;
+				} else if (ret == 0) {
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;
+				} else {
+					nr_swaps_freed += ret;
+					continue;
 				}
-				nr_swaps_freed += swaps_freed;
-				continue;
 			}
 
 			folio_lock(folio);
@@ -1193,35 +1267,58 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 						folio);
 
 				if (!folio_test_large(folio)) {
-					truncate_inode_folio(mapping, folio);
-				} else if (truncate_inode_partial_folio(folio, lstart, lend)) {
-					/*
-					 * If we split a page, reset the loop so
-					 * that we pick up the new sub pages.
-					 * Otherwise the THP was entirely
-					 * dropped or the target range was
-					 * zeroed, so just continue the loop as
-					 * is.
-					 */
-					if (!folio_test_large(folio)) {
+					ret = ops->undo_folio(mapping, folio,
+							      arg);
+					if (ret < 0) {
 						folio_unlock(folio);
-						index = start;
 						break;
 					}
+				} else {
+					ret = ops->undo_partial_folio(folio, lstart, lend, arg);
+					if (ret < 0) {
+						folio_unlock(folio);
+						break;
+					}
+
+					if (ret) {
+						/*
+						 * If we split a page, reset the loop so
+						 * that we pick up the new sub pages.
+						 * Otherwise the THP was entirely
+						 * dropped or the target range was
+						 * zeroed, so just continue the loop as
+						 * is.
+						 */
+						if (!folio_test_large(folio)) {
+							folio_unlock(folio);
+							index = start;
+							break;
+						}
+					}
 				}
 			}
 			folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
+		if (ret < 0)
+			goto out;
 	}
 
+	ret = 0;
+out:
 	shmem_recalc_inode(inode, 0, -nr_swaps_freed);
+	return ret;
 }
 
 void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
-	shmem_undo_range(inode, lstart, lend, false);
+	int ret;
+
+	ret = shmem_undo_range(inode, lstart, lend, false,
+			       &shmem_default_undo_ops, NULL);
+
+	WARN(ret < 0, "shmem_undo_range() should never fail with default ops");
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	inode_inc_iversion(inode);
 }
@@ -3740,9 +3837,15 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			info->fallocend = undo_fallocend;
 			/* Remove the !uptodate folios we added */
 			if (index > start) {
-				shmem_undo_range(inode,
-				    (loff_t)start << PAGE_SHIFT,
-				    ((loff_t)index << PAGE_SHIFT) - 1, true);
+				int ret;
+
+				ret = shmem_undo_range(inode,
+						       (loff_t)start << PAGE_SHIFT,
+						       ((loff_t)index << PAGE_SHIFT) - 1,
+						       true,
+						       &shmem_default_undo_ops,
+						       NULL);
+				WARN(ret < 0, "shmem_undo_range() should never fail with default ops");
 			}
 			goto undone;
 		}
-- 
2.47.1


