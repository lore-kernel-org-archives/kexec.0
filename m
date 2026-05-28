Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B05CD6E4B
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 00:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w9dQKTBesfWptSkwPiRIMzAcNQuxg/BKJwCMO44AZfg=; b=gwmpIEdHN7S6VSBO1Ukl3Anw1z
	rXI5sLyUFNLt1SLh/6Ap80Tesk+Iy08EljddF3fQ56QnlAen3/skyWTjBqVUH5FIGiX7jG2tBQ88i
	tARFDBNSmEAuSlCu/rSd6oeQDidjZDTWVIXkkeauOMK5eDMvhghngcIr5dDGQ7aXambSRfj0BkW6g
	dExcCt+K8xs/o61eoGV2iecHkR+Y9h9kgWKvyqMbpuDnguRl7XEI6AUiIah93c4JXuFUyx73uObXu
	v9NKuzxStC882ANYLLJavzqNLNtQLwKnwUAvnbm2mg7d/QHnBkNDfVaM20v1dIMdUxZ7MvY1bNAi4
	Td3dfdPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOq5-00000004ss7-1xy0;
	Thu, 28 May 2026 00:43:09 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOpU-00000004s4F-3iEz;
	Thu, 28 May 2026 00:42:34 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 1B1D820B7175; Wed, 27 May 2026 17:42:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B1D820B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928942;
	bh=w9dQKTBesfWptSkwPiRIMzAcNQuxg/BKJwCMO44AZfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVCPSidAnGdHB1XpCGnE5OzRo9wqEl3lK8az8GeJAkdMTDi6QvS5UgoQ9IgB915Pd
	 dlJU0HBIv+wFptvDvgMWvzcBah1eeYO7dGzeeoC4bVOKKk20uPM0w/8SyfDk1WOWkk
	 7ZoEp3xh9hJ0xuG840/IpGNcOfkm0h7aJbTCn+3M=
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
Subject: [RFC PATCH 14/20] kho: Add crash-kernel-safe radix tree presence check
Date: Wed, 27 May 2026 17:41:56 -0700
Message-ID: <20260528004204.1484584-15-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_174233_122487_61BD6284 
X-CRM114-Status: GOOD (  24.93  )
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

In the crash kernel, the old kernel's memory is outside the direct
map. Add a read-only radix tree variant that memremaps nodes during
init so that subsequent page presence checks can traverse the tree
with plain pointer dereferencing.

This will be used by the MSHV driver to exclude hypervisor-owned pages
from /proc/vmcore via a pfn_is_ram() callback.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 include/linux/kho_radix_tree.h     |  30 +++++++
 kernel/liveupdate/kexec_handover.c | 124 +++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 4fe2238e1e30..e906a874e612 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -49,6 +49,19 @@ struct kho_radix_walk_cb {
 	int (*table)(phys_addr_t phys, void *data);
 };
 
+/**
+ * struct kho_radix_crash_tree - Read-only radix tree for crash kernel use.
+ * @root: pointer to the remapped root node
+ *
+ * In the crash kernel, the old kernel's memory is not in the direct map.
+ * This variant uses memremap() during init to map the tree nodes and
+ * converts the physical address table entries to virtual addresses in-place,
+ * enabling efficient pointer-based traversal without per-lookup remapping.
+ */
+struct kho_radix_crash_tree {
+	struct kho_radix_node *root;
+};
+
 #ifdef CONFIG_KEXEC_HANDOVER
 
 int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
@@ -59,6 +72,11 @@ int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_node *root
 void kho_radix_destroy_tree(struct kho_radix_tree *tree);
 int kho_radix_tree_freeze(struct kho_radix_tree *tree);
 
+int kho_radix_crash_init(struct kho_radix_crash_tree *tree, phys_addr_t root_pa);
+
+bool kho_radix_crash_contains_page(struct kho_radix_crash_tree *tree,
+				   unsigned long pfn, unsigned int order);
+
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
 static inline int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
@@ -91,6 +109,18 @@ static inline int kho_radix_tree_freeze(struct kho_radix_tree *tree)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_radix_crash_init(struct kho_radix_crash_tree *tree,
+				       phys_addr_t root_pa)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool kho_radix_crash_contains_page(
+					struct kho_radix_crash_tree *tree,
+					unsigned long pfn, unsigned int order)
+{
+	return false;
+}
 #endif /* #ifdef CONFIG_KEXEC_HANDOVER */
 
 #endif	/* _LINUX_KHO_RADIX_TREE_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 2e2b4e73f00d..0dfdf0f9781e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -15,6 +15,7 @@
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kasan.h>
+#include <linux/io.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho_radix_tree.h>
@@ -396,6 +397,129 @@ void kho_radix_destroy_tree(struct kho_radix_tree *tree)
 }
 EXPORT_SYMBOL_GPL(kho_radix_destroy_tree);
 
+/*
+ * Convert a crash tree node's children from PA to VA in-place via memremap().
+ * On failure, already-remapped pages are not cleaned up -- the crash kernel
+ * is short-lived and will reboot after dump collection, so the leak is
+ * inconsequential.
+ */
+static int kho_radix_crash_convert_node(struct kho_radix_node *node,
+					unsigned int level)
+{
+	struct kho_radix_node *child;
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < (1 << KHO_TABLE_SIZE_LOG2); i++) {
+		if (!node->table[i])
+			continue;
+
+		/* Validate: PA must have bit 63 clear and be page-aligned */
+		if ((node->table[i] & BIT_ULL(63)) ||
+		    (node->table[i] & (PAGE_SIZE - 1)))
+			return -EINVAL;
+
+		child = memremap(node->table[i], PAGE_SIZE, MEMREMAP_WB);
+		if (!child)
+			return -ENOMEM;
+
+		/* Overwrite PA with VA in-place */
+		node->table[i] = (u64)(uintptr_t)child;
+
+		/* Recurse for intermediate levels; level 1 children are leaves */
+		if (level > 1) {
+			err = kho_radix_crash_convert_node(child, level - 1);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * kho_radix_crash_init - Initialize a crash-kernel view of a KHO radix tree.
+ * @tree: The crash tree to initialize.
+ * @root_pa: Physical address of the radix tree root from the old kernel.
+ *
+ * Maps the old kernel's radix tree into the crash kernel's address space
+ * by memremapping each node and converting table entries from physical to
+ * virtual addresses in-place. After successful initialization, the tree
+ * can be traversed with kho_radix_crash_contains_page() using direct
+ * pointer dereferencing.
+ *
+ * This function is intended for use in the crash kernel where the old
+ * kernel's memory is not in the direct map. No locking is used as the
+ * crash kernel is effectively single-threaded during dump collection.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kho_radix_crash_init(struct kho_radix_crash_tree *tree, phys_addr_t root_pa)
+{
+	struct kho_radix_node *root;
+	int err;
+
+	tree->root = NULL;
+
+	if (!root_pa || (root_pa & (PAGE_SIZE - 1)))
+		return -EINVAL;
+
+	root = memremap(root_pa, PAGE_SIZE, MEMREMAP_WB);
+	if (!root)
+		return -ENOMEM;
+
+	err = kho_radix_crash_convert_node(root, KHO_TREE_MAX_DEPTH - 1);
+	if (err)
+		return err;
+
+	tree->root = root;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_radix_crash_init);
+
+/**
+ * kho_radix_crash_contains_page - Check if a page is in a crash-kernel radix tree.
+ * @tree: The crash tree, previously initialized with kho_radix_crash_init().
+ * @pfn: The page frame number to check.
+ * @order: The order of the page.
+ *
+ * Traverses the radix tree using direct pointer dereferencing (the table
+ * entries were converted from PA to VA during init). No locking is used as the
+ * crash kernel is effectively single-threaded during dump collection.
+ *
+ * Note: This function checks specifically for the presence of the page at the
+ * given order. If a larger order page that encompasses this page is preserved,
+ * this function will return false.
+ *
+ * Return: true if the page is present in the tree, false otherwise.
+ */
+bool kho_radix_crash_contains_page(struct kho_radix_crash_tree *tree,
+				   unsigned long pfn, unsigned int order)
+{
+	unsigned long key = kho_encode_radix_key(PFN_PHYS(pfn), order);
+	struct kho_radix_node *node = tree->root;
+	struct kho_radix_leaf *leaf;
+	unsigned int i, idx;
+
+	if (!tree->root)
+		return false;
+
+	/* Traverse using VA pointers stored in table[] */
+	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
+		idx = kho_radix_get_table_index(key, i);
+
+		if (!node->table[idx])
+			return false;
+
+		node = (struct kho_radix_node *)(uintptr_t)node->table[idx];
+	}
+
+	leaf = (struct kho_radix_leaf *)node;
+	idx = kho_radix_get_bitmap_index(key);
+	return test_bit(idx, leaf->bitmap);
+}
+EXPORT_SYMBOL_GPL(kho_radix_crash_contains_page);
+
 static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 			       const struct kho_radix_walk_cb *cb, void *data)
 {
-- 
2.43.0


