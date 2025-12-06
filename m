Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B9DD3B7E5
	for <kexec@archiver.kernel.org>; Sat,  6 Dec 2025 23:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BiUTuUfe5vAoZQo+9tpLwvrSqI7Z3ZybwMJj6eLoJo8=; b=4pEOR9s4KPuE4wJmhQtU10LLJK
	xkD02kFXk+rSe1jQRhA7ASLI+Mq8vz9ag1w3b5E3YBAepmXaJWos7Pispop/DI9PqUuFTzYzEHa2R
	4D0+0P+R2fpYVp05aamKC3NMPujLJckTYZWb+Exjnr2s7isF3PaUXQIv7rq+PKjcVTMgZBjLG15Rq
	ppCVGK6KjBD3lOaG5j/UKvuTKDn6PfmocdKtS2Fx7b9iM4mAxLc97H9rqIaObdoqv92YLJ09WeDyo
	yWqnuW6mTXYm59fuxQH3/7Gx0eDOxH61A42wlR3FXCzMGGKCUPD0yQSV8VIljq+CF0morf5ptt2GY
	eRa2QF9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS1JH-0000000BHof-1gso;
	Sat, 06 Dec 2025 23:03:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS1JG-0000000BHoP-268x
	for kexec@lists.infradead.org;
	Sat, 06 Dec 2025 23:03:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CC2946014C;
	Sat,  6 Dec 2025 23:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE274C4CEF5;
	Sat,  6 Dec 2025 23:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765062205;
	bh=KGnOcfnpQ9BU9FZJbzrgiU8lnduu/8HRPawdKcV6t1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUUDtxnD5j/gPnDazGeJDlVfGjKWIZmBD0OblMoGkBSR3WryqOqAP2BtduJHW0Ts1
	 zib5G2oPsbnoO0PpF3BE0aBcSjgf6rrxSEeHGJHAqhF6kJ1LszXt5G2ohGlc6+yUdy
	 s1fCdKColhX6jzjtk3VgF8N3NHN5Ai/CNEdqHnMiqpgkchklfoS77EULfkVIzP83kL
	 M4+grCe+p4WBo9sEMdr8CqWz1LBua/gXhaTVXsVMG/RhWBproCM+CptJ+pjKgNbYVp
	 fqabR6XaYXZQVJh7v5K0/LZS5/J14mfdaibZoq4izdmEGRDNVjD6mVEdyWP87vNXgC
	 jzCJjlTmsF/Gw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [RFC PATCH 04/10] liveupdate: flb: allow getting FLB data in early boot
Date: Sun,  7 Dec 2025 00:02:14 +0100
Message-ID: <20251206230222.853493-5-pratyush@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251206230222.853493-1-pratyush@kernel.org>
References: <20251206230222.853493-1-pratyush@kernel.org>
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

To support hugepage preservation using LUO, the hugetlb subsystem needs
to get liveupdate data when it allocates the hugepages to find out how
many pages are coming from live update. This data is preserved via LUO
FLB.

Since gigantic hugepage allocations happen before LUO (and much of the
rest of the system) is initialized, the usual
liveupdate_flb_get_incoming() can not work.

Add a read-only variant that fetches the FLB data but does not trigger
its retrieve or do any locking or reference counting. It is the caller's
responsibility to make sure there are no side effects of using this data
to the proper retrieve call that would happen later.

Refactor the logic to find the right FLB in the serialized data in a
helper that can be used from both luo_flb_retrieve_one() (called from
luo_flb_get_incoming()), and from luo_flb_get_incoming_early().

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/linux/liveupdate.h  |  6 ++++
 kernel/liveupdate/luo_flb.c | 69 +++++++++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 78e8c529e4e7..39b429d2c62c 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -232,6 +232,7 @@ int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
 
 int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
 int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
+int liveupdate_flb_incoming_early(struct liveupdate_flb *flb, u64 *datap);
 
 #else /* CONFIG_LIVEUPDATE */
 
@@ -283,5 +284,10 @@ static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
 	return -EOPNOTSUPP;
 }
 
+int liveupdate_flb_incoming_early(struct liveupdate_flb *flb, u64 *datap)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index e80ac5b575ec..fb287734a88e 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -145,12 +145,25 @@ static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
 	}
 }
 
+static struct luo_flb_ser *luo_flb_find_ser(struct luo_flb_header *fh,
+					    const char *name)
+{
+	if (!fh->active)
+		return ERR_PTR(-ENODATA);
+
+	for (int i = 0; i < fh->header_ser->count; i++) {
+		if (!strcmp(fh->ser[i].name, name))
+			return &fh->ser[i];
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
 static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
-	struct luo_flb_header *fh = &luo_flb_global.incoming;
 	struct liveupdate_flb_op_args args = {0};
-	bool found = false;
+	struct luo_flb_ser *ser;
 	int err;
 
 	guard(mutex)(&private->incoming.lock);
@@ -158,20 +171,12 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	if (private->incoming.obj)
 		return 0;
 
-	if (!fh->active)
-		return -ENODATA;
+	ser = luo_flb_find_ser(&luo_flb_global.incoming, flb->compatible);
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
 
-	for (int i = 0; i < fh->header_ser->count; i++) {
-		if (!strcmp(fh->ser[i].name, flb->compatible)) {
-			private->incoming.data = fh->ser[i].data;
-			private->incoming.count = fh->ser[i].count;
-			found = true;
-			break;
-		}
-	}
-
-	if (!found)
-		return -ENOENT;
+	private->incoming.data = ser->data;
+	private->incoming.count = ser->count;
 
 	args.flb = flb;
 	args.data = private->incoming.data;
@@ -188,6 +193,40 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	return 0;
 }
 
+/**
+ * liveupdate_flb_incoming_early - Fetch FLB data in early boot.
+ * @flb:   The FLB definition
+ * @datap: Pointer to serialized state handle of the FLB
+ *
+ * This function is intended to be called during early boot, before the
+ * liveupdate subsystem is fully initialized. It must only be called after
+ * liveupdate_early_init().
+ *
+ * Directly returns the u64 handle to the serialized state of the FLB, and does
+ * not trigger its retrieve. A later fetch of the FLB will trigger the retrieve.
+ * Callers must make sure there are no side effects because of this.
+ *
+ * Return: 0 on success, -errno on failure. -ENODATA means no incoming FLB data,
+ * -ENOENT means specific FLB not found in incoming data, and -EOPNOTSUPP when
+ * live update is disabled or not early initialization not finished.
+ */
+int __init liveupdate_flb_incoming_early(struct liveupdate_flb *flb, u64 *datap)
+{
+	struct luo_flb_ser *ser;
+
+	if (!luo_early_initialized()) {
+		pr_warn("LUO FLB retrieved before LUO early init!\n");
+		return -EOPNOTSUPP;
+	}
+
+	ser = luo_flb_find_ser(&luo_flb_global.incoming, flb->compatible);
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	*datap = ser->data;
+	return 0;
+}
+
 static void luo_flb_file_finish_one(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
-- 
2.43.0


