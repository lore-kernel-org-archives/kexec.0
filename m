Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C7BFF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NpugUNTZD9g61tClU5Que0ViPzYxc36Ts314rAGUAcM=; b=AUS0ZveEuutedeJKoWHdz9ltpM
	9IEnBqei9QFxNOKN44HhhBjOjW0gWNr9rYe+suq9yflYKo+d7vqWyHisMhBMs6sUavyJ8sG27EwcF
	MuoBw6210GcIsalZ8uz2TCWONthlMTVsNPeA05lfA0H+ob6MWel6HjBBF9gID3Y+sq600ep+a7uOQ
	y/3a2se5UTGKZpoBmb1JDVJB5MLyrmXgvVBnC/kkc9fUAf8UUW3hLyaYVxiH6a0mvPui4XINFy83Y
	HApXm9KgCMorT95pwn3gnHYqTPu/3BtAa3PZ229RUHqksan2+vY45kp8AN2g7G3MwziZIZNoh9KMT
	Su80X7HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI598-00000003ghs-0q4G;
	Wed, 29 Apr 2026 13:40:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI596-00000003gfT-07iY
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:40:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BACD744512;
	Wed, 29 Apr 2026 13:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EA4C2BCC4;
	Wed, 29 Apr 2026 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470007;
	bh=X/jw+Bk5Bac+4EPjbmWte83igGvsq79+9wO60I3d/KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bo76h6tsjt/Kk7VeGnOOvD8rM5GSfm98s+BvU+ZliNYz6jNjdcS/zPKtqV0LZSYi/
	 BSQkSQfh6LCSph+fFxrf4n7wP0XgFrJHyBm5IEegjSOlQG9GSZj8vZSJ3cu6bM6M+D
	 J1ShROcki4UEYAltkRnLwhOo8FSNgUEgBXKwSjP01ILPfW9M3h6O32BD9SoCzOah5g
	 DWQJ3pHhFcyaKmis7Nq6sIGdw0/heFz71ZjjuM18Wj8nCiaZinpecyhBsDs0TBvo5u
	 rz6dnKtUY6UCn3XA1moPZLIS8jZ/rPDdgYTC2Okm3rXnLuQiGgoItrrIWLs1uJqOj6
	 tCSb6/IISJMKg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] kho: extended scratch
Date: Wed, 29 Apr 2026 15:39:12 +0200
Message-ID: <20260429133928.850721-11-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_064008_116199_EB0DFF47 
X-CRM114-Status: GOOD (  30.14  )
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

Motivation
==========

The scratch space is allocated by the first kernel in the KHO chain, and
is reused by all subsequent kernels. The size of the space is either set
via the commandline by the system administrator or by calculating the
amount of memory used by the kernel and adding a multiplier. In either
case, the scratch space is a heuristic and is liable to fill up and fail
allocation if a kernel uses more memory than expected.

In addition, gigantic huge pages (usually 1 GiB) are allocated via
memblock, and in a KHO boot that memory comes from the scratch space. In
hypervisors it is common to dedicate a major part of the system's memory
to gigantic hugepages for VM memory.

If this memory needs to come from scratch space, then scratch needs to
be greater than the memory needed for huge pages, which is impractical.
In addition, hugepages can be preserved memory. Allocating them from
scratch violates the assumption that scratch contains no preserved
memory.

Methodology
===========

Introduce extended scratch areas. These areas are discovered at boot by
walking the preserved memory radix tree and looking for free blocks of
memory. They then marked as scratch to allow allocations from them. This
makes KHO more resilient to memory pressure and allows supporting huge
page preservation.

Since the preserved memory radix tree mixes both physical address and
order into a single key, and does not track table pages, it is difficult
to identify free areas from it directly. Walk the tree and digest it
down into another radix tree. The latter tracks blocks of
KHO_EXT_SHIFT (1 GiB as of now) granularity. Then walk the digested tree
and mark the areas between the present keys as scratch.

Performance
===========

The discovery algorithm traverses the preserved memory radix tree
exactly once. While it does use memory for the digested radix tree,
since the blocks are split by 1 GiB, a single bitmap with 4k pages can
track up to 32 TiB of memory. So there are likely to be very few radix
tree pages used in this tracking. For systems with all physical memory
below 32 TiB, this should result in a total of 6 pages being
used (KHO_TREE_MAX_DEPTH == 6).

An alternate way of achieving this would be to call kho_mem_retrieve()
earlier in boot and mark all the KHO preservations as reserved. But that
can blow up memblock.reserved with a bunch of 4K pages scattered
everywhere, which will reduce performance of subsequent allocations.
Since the free blocks are tracked in chunks of 1 GiB, this won't blow up
memblock.memory as much.

Practical evaluation
====================

The testing is done on a x86_64 qemu VM running under KVM with 64G
memory and 12 CPUs. The machine pre-allocates 50 1G pages.

Since the performance scales with how busy the radix tree is, tests are
done with 2 preservation patterns: first with two 1M memfds, second with
two 1G memfds, both using 4k pages.

Test case 1 - 1M memfd
~~~~~~~~~~~~~~~~~~~~~~

This test case has two memfds with 1M memory each in 4k pages, plus
other preservations from LUO core and other KHO users.

This is how the radix tree stats look like:

    radix_nodes:       0x2f
    nr_preservations:  0x22d
    mem_preserved:     0xa2b000

    per order preservations:
    order  0:  0x215
    order  1:  0x9
    order  2:  0x1
    order  3:  0x2
    order  4:  0x5
    order  5:  0x1
    order  6:  0x2
    order  7:  0x2
    order  9:  0x1
    order 10:  0x1

and this is how long it takes to extend the scratch after KHO boot:

    kho_extend_scratch(): time taken: 88 us
    kho_extend_scratch(): total memory recovered: 0xf7ff7b000 (~62G)

Test case 2 - 1G memfd
~~~~~~~~~~~~~~~~~~~~~~

This test case has two memfds with 1G memory each in 4k pages, plus
other preservations from LUO core and other KHO users.

This is how the radix tree stats look like:

    radix_nodes:       0x45
    nr_preservations:  0x80832
    mem_preserved:     0x8102d000

    per order preservations:
    order  0:  0x80817
    order  1:  0x7
    order  2:  0x2
    order  3:  0x4
    order  4:  0x2
    order  5:  0x2
    order  6:  0x4
    order  7:  0x3
    order  8:  0x1
    order  9:  0x2

and this is how long it takes to extend the scratch after KHO boot:

    kho_extend_scratch(): time taken: 21769 us
    kho_extend_scratch(): total memory recovered: 0xe40000000 (57G)

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kexec_handover.h     |   1 +
 kernel/liveupdate/kexec_handover.c | 148 +++++++++++++++++++++++++----
 mm/mm_init.c                       |   1 +
 3 files changed, 133 insertions(+), 17 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..6ce46f36ed99 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -37,6 +37,7 @@ void kho_remove_subtree(void *blob);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
 
 void kho_memory_init(void);
+void kho_extend_scratch(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 1a04e089f779..c2b843a5fb28 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -84,6 +84,23 @@ static struct kho_out kho_out = {
 	},
 };
 
+struct kho_in {
+	phys_addr_t fdt_phys;
+	phys_addr_t scratch_phys;
+	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
+	struct kho_debugfs dbg;
+	struct kho_radix_tree radix_tree;
+};
+
+static struct kho_in kho_in = {
+};
+
+static const void *kho_get_fdt(void)
+{
+	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
+}
+
 /**
  * kho_encode_radix_key - Encodes a physical address and order into a radix key.
  * @phys: The physical address of the page.
@@ -840,6 +857,120 @@ static void __init kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
+#define KHO_EXT_SHIFT 30 /* 1 GiB */
+
+static int __init kho_ext_walk_key(unsigned long key, void *data)
+{
+	struct kho_radix_tree *tree = data;
+	phys_addr_t start, end;
+	unsigned int order;
+	int err;
+
+	start = kho_decode_radix_key(key, &order);
+	end = start + (1UL << (order + PAGE_SHIFT));
+
+	while (start < end) {
+		err = kho_radix_add_key(tree, start >> KHO_EXT_SHIFT);
+		if (err)
+			return err;
+
+		start += (1UL << KHO_EXT_SHIFT);
+	}
+
+	return 0;
+}
+
+static int __init kho_ext_walk_table(phys_addr_t phys, void *data)
+{
+	struct kho_radix_tree *tree = data;
+
+	return kho_radix_add_key(tree, phys >> KHO_EXT_SHIFT);
+}
+
+static int __init kho_ext_mark_scratch(unsigned long key, void *data)
+{
+	phys_addr_t *prev_end = data;
+	phys_addr_t start = key << KHO_EXT_SHIFT;
+	int err;
+
+	if (start > *prev_end) {
+		err = memblock_mark_kho_scratch_ext(*prev_end, start - *prev_end);
+		if (err)
+			return err;
+	}
+
+	*prev_end = start + (1UL << KHO_EXT_SHIFT);
+	return 0;
+}
+
+/**
+ * kho_extend_scratch - Extend the scratch regions
+ *
+ * The KHO radix tree mixes both physical address and order into a single key.
+ * This makes it hard to look for free ranges directly. This function first
+ * walks the radix tree and digests it down into another radix tree, whose keys
+ * identify blocks of KHO_EXT_SHIFT which contain preserved memory.
+ *
+ * Then it walks the digested radix tree and marks everything that doesn't have
+ * preserved memory as scratch.
+ *
+ * NOTE: This function allocates memory so it should be called when scratch has
+ * available space.
+ *
+ * NOTE: The pages of the KHO radix tree tables are not marked as preserved in
+ * the KHO tree. But they are expected to remain untouched until the tree is
+ * fully parsed. So this function also considers them to be "preserved memory"
+ * and marks their blocks as busy.
+ */
+void __init kho_extend_scratch(void)
+{
+	const struct kho_radix_walk_cb kho_cb = {
+		.key = kho_ext_walk_key,
+		.table = kho_ext_walk_table,
+	};
+	const struct kho_radix_walk_cb ext_cb = {
+		.key = kho_ext_mark_scratch,
+	};
+	struct kho_radix_tree radix;
+	phys_addr_t prev_end = 0, mem_map_phys;
+	int err = 0;
+
+	if (!is_kho_boot())
+		return;
+
+	/* Make sure the KHO radix tree is initialized. */
+	mem_map_phys = kho_get_mem_map_phys(kho_get_fdt());
+	err = kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_phys));
+	if (err)
+		goto print;
+
+	err = kho_radix_init_tree(&radix, NULL);
+	if (err)
+		goto print;
+
+	/* Walk the KHO radix tree to find busy blocks. */
+	err = kho_radix_walk_tree(&kho_in.radix_tree, &kho_cb, &radix);
+	if (err)
+		goto out;
+
+	/* Walk the blocks and mark everything between keys as scratch. */
+	err = kho_radix_walk_tree(&radix, &ext_cb, &prev_end);
+	if (err)
+		goto out;
+
+	/* Mark everything from last busy block to end of DRAM. */
+	if (prev_end < memblock_end_of_DRAM())
+		err = memblock_mark_kho_scratch_ext(prev_end,
+						    memblock_end_of_DRAM() - prev_end);
+
+	/* fallthrough */
+out:
+	kho_radix_destroy_tree(&radix);
+print:
+	if (err)
+		pr_err("Failed to extend scratch: %pe\n", ERR_PTR(err));
+}
+
 /**
  * kho_add_subtree - record the physical address of a sub blob in KHO root tree.
  * @name: name of the sub tree.
@@ -1384,23 +1515,6 @@ void kho_restore_free(void *mem)
 }
 EXPORT_SYMBOL_GPL(kho_restore_free);
 
-struct kho_in {
-	phys_addr_t fdt_phys;
-	phys_addr_t scratch_phys;
-	char previous_release[__NEW_UTS_LEN + 1];
-	u32 kexec_count;
-	struct kho_debugfs dbg;
-	struct kho_radix_tree radix_tree;
-};
-
-static struct kho_in kho_in = {
-};
-
-static const void *kho_get_fdt(void)
-{
-	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
-}
-
 /**
  * is_kho_boot - check if current kernel was booted via KHO-enabled
  * kexec
diff --git a/mm/mm_init.c b/mm/mm_init.c
index eddc0f03a779..10916cdf0029 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2688,6 +2688,7 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
+	kho_extend_scratch();
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
-- 
2.54.0.545.g6539524ca2-goog


