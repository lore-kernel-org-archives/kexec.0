Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F60CD6E45
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lTYSobW1vcaiuFaW/ih0lOZTdJfa7tMYIcB/6JUObEE=; b=vYp6kBQWThyp1KgkZitcJP2tCT
	Xku+7R2yVJ4yNEYvi4GAZotaKi/cabJaXHlLR9vuGZHFkUFmy0UZm5godT+OLDvcXSBaBe/nn72rR
	ZArR7oO7XqPzaoUBpIq2znighR0PFnkSuEBpqtLbZVda6U17kqK3Xw9D/LxCsTXmCLeQ9PfkZw0Gq
	8MUuyIXvJUe85k+epYgjKxIY3oHiXdrVWdnkToifluTsqu8qmZvrpHTgpYvc2GGFYtL3SJTiOM+ip
	nVz9i02wtV9Rnale74BmLB9iSp6piWGQII3MqzJShsYDXRQuwEU9aWNI72InBMRcAcj48rQ1cnjKd
	CufvrIfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOq6-00000004sv1-3BAq;
	Thu, 28 May 2026 00:43:10 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOpW-00000004s4F-36ag;
	Thu, 28 May 2026 00:42:36 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id EC17820B717A; Wed, 27 May 2026 17:42:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC17820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928943;
	bh=lTYSobW1vcaiuFaW/ih0lOZTdJfa7tMYIcB/6JUObEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bds+T53YSwua67KRic1D3xTDVI8g2FG5kFyh9yUH+NKfBwH0s5MxGdFticf7R97vc
	 C6Xh5MCYze42oBrgNFWnDpyid/h5MQYDeNPF/7cyO0UVqYZALjK7f4naGCfMw8KflQ
	 CRrvEG5Kw9ij3UM6KLbWJBmrvJ8vse+aL8vwqdDw=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 16/20] mshv: Add debugfs interface to page tracker
Date: Wed, 27 May 2026 17:41:58 -0700
Message-ID: <20260528004204.1484584-17-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_174234_816370_81DADC4E 
X-CRM114-Status: GOOD (  18.34  )
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

- expose stats (page-counts for data & metadata)
- expose tracked pages
- expose scheduler type
- add mshv_iterate_preserved() API for walking the radix tree

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_debugfs.c       | 99 +++++++++++++++++++++++++++++++++
 drivers/hv/mshv_page_preserve.c | 13 +++++
 drivers/hv/mshv_page_preserve.h |  3 +
 drivers/hv/mshv_root.h          |  2 +
 drivers/hv/mshv_root_main.c     |  2 +-
 5 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
index 3c3e02237ae9..d79898e21b36 100644
--- a/drivers/hv/mshv_debugfs.c
+++ b/drivers/hv/mshv_debugfs.c
@@ -33,11 +33,18 @@ static struct dentry *mshv_debugfs;
 static struct dentry *mshv_debugfs_partition;
 static struct dentry *mshv_debugfs_lp;
 static struct dentry **parent_vp_stats;
+
 static struct dentry *parent_partition_stats;
 
 static u64 mshv_lps_count;
 static struct hv_stats_page **mshv_lps_stats;
 
+struct mshv_pt_stats {
+	unsigned long count_data;
+	unsigned long count_meta;
+	struct seq_file *stat_file;
+};
+
 static int lp_stats_show(struct seq_file *m, void *v)
 {
 	const struct hv_stats_page *stats = m->private;
@@ -668,8 +675,89 @@ void mshv_debugfs_partition_remove(struct mshv_partition *partition)
 				 partition->pt_stats_dentry);
 }
 
+static int pt_count_data_cb(unsigned long key __maybe_unused, void *stats)
+{
+	((struct mshv_pt_stats *)stats)->count_data++;
+	return 0;
+}
+
+static int pt_count_meta_cb(phys_addr_t phys __maybe_unused, void *stats)
+{
+	((struct mshv_pt_stats *)stats)->count_meta++;
+	return 0;
+}
+
+static int pt_stats_show(struct seq_file *m, void *v)
+{
+	const struct kho_radix_walk_cb cb = {
+		.key = pt_count_data_cb,
+		.table = pt_count_meta_cb,
+	};
+
+	struct mshv_pt_stats pt_stats = {0};
+
+	mshv_iterate_preserved(&cb, &pt_stats);
+	seq_printf(m, "Data pages: %lu\n", pt_stats.count_data);
+	seq_printf(m, "Meta pages: %lu\n", pt_stats.count_meta);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pt_stats);
+
+static int pt_tree_data_cb(unsigned long key, void *stats)
+{
+	seq_printf(((struct mshv_pt_stats *)stats)->stat_file,
+		   "data pfn: %#lx\n", key);
+	return 0;
+}
+
+static int pt_tree_meta_cb(phys_addr_t phys, void *stats)
+{
+	seq_printf(((struct mshv_pt_stats *)stats)->stat_file,
+		   "meta pfn: %#llx\n",
+		   (unsigned long long)(phys >> PAGE_SHIFT));
+	return 0;
+}
+
+static int pt_tree_show(struct seq_file *m, void *v)
+{
+	const struct kho_radix_walk_cb cb = {
+		.key = pt_tree_data_cb,
+		.table = pt_tree_meta_cb,
+	};
+
+	struct mshv_pt_stats pt_stats = {.stat_file = m};
+
+	mshv_iterate_preserved(&cb, &pt_stats);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pt_tree);
+
+static int __init mshv_debugfs_pt_create(struct dentry *parent)
+{
+	struct dentry *d;
+
+	d = debugfs_create_file("pt_stats", 0400, parent, NULL, &pt_stats_fops);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	d = debugfs_create_file("pt_tree", 0400, parent, NULL, &pt_tree_fops);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	return 0;
+}
+
+static int scheduler_info_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "Scheduler type: %s (%d)\n",
+		   scheduler_type_to_string(hv_scheduler_type), hv_scheduler_type);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scheduler_info);
+
 int __init mshv_debugfs_init(void)
 {
+	struct dentry *d;
 	int err;
 
 	mshv_debugfs = debugfs_create_dir("mshv", NULL);
@@ -694,6 +782,17 @@ int __init mshv_debugfs_init(void)
 	if (err)
 		goto unmap_lp_stats;
 
+	err = mshv_debugfs_pt_create(mshv_debugfs);
+	if (err)
+		goto unmap_lp_stats;
+
+	d = debugfs_create_file("scheduler_info", 0400, mshv_debugfs, NULL,
+				&scheduler_info_fops);
+	if (IS_ERR(d)) {
+		err = PTR_ERR(d);
+		goto unmap_lp_stats;
+	}
+
 	return 0;
 
 unmap_lp_stats:
diff --git a/drivers/hv/mshv_page_preserve.c b/drivers/hv/mshv_page_preserve.c
index a79725a74663..bc3a3a688f5b 100644
--- a/drivers/hv/mshv_page_preserve.c
+++ b/drivers/hv/mshv_page_preserve.c
@@ -52,6 +52,19 @@ int mshv_unregister_preserve_page(struct page *pg)
 }
 EXPORT_SYMBOL_GPL(mshv_unregister_preserve_page);
 
+/**
+ * mshv_iterate_preserved() - Walk all preserved pages
+ * @cb: callbacks invoked for each key/table entry
+ * @data: opaque data passed to callbacks
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int mshv_iterate_preserved(const struct kho_radix_walk_cb *cb, void *data)
+{
+	return kho_radix_walk_tree(&preserved_pages_tree, cb, data);
+}
+EXPORT_SYMBOL_GPL(mshv_iterate_preserved);
+
 /* Preserve a single page identified by its PFN key with KHO */
 static int preserve_key_cb(unsigned long key, void *data)
 {
diff --git a/drivers/hv/mshv_page_preserve.h b/drivers/hv/mshv_page_preserve.h
index 0609002e5f1d..ac99b4e33285 100644
--- a/drivers/hv/mshv_page_preserve.h
+++ b/drivers/hv/mshv_page_preserve.h
@@ -6,10 +6,13 @@
 #ifndef _MSHV_PAGE_PRESERVE_H
 #define _MSHV_PAGE_PRESERVE_H
 
+#include <linux/kho_radix_tree.h>
+
 struct page;
 
 int mshv_preserve_init(void);
 int mshv_register_preserve_page(struct page *pg);
 int mshv_unregister_preserve_page(struct page *pg);
+int mshv_iterate_preserved(const struct kho_radix_walk_cb *cb, void *data);
 
 #endif /* _MSHV_PAGE_PRESERVE_H */
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 362768786c17..216053f8e0ab 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -379,4 +379,6 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
+const char *scheduler_type_to_string(enum hv_scheduler_type type);
+
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bd1359eb58dd..5fbd01c12ab8 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2134,7 +2134,7 @@ mshv_dev_release(struct inode *inode, struct file *filp)
 
 static int mshv_root_sched_online;
 
-static const char *scheduler_type_to_string(enum hv_scheduler_type type)
+const char *scheduler_type_to_string(enum hv_scheduler_type type)
 {
 	switch (type) {
 	case HV_SCHEDULER_TYPE_LP:
-- 
2.43.0


