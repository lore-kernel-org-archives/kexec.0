Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C3EC55175
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8b0HjIx8i/4Q0eCfCNUr0RTIks21JMqujJ7T9iW+M0=; b=cL/4o22NqdlpXNSqALTsGFmjX+
	zwELbk14bbN0Z66O2iQ8aJs253stbknKZ/zcrUKW7K6CTbKX2vS8hMdgI+f1gI2buYdNr40VD01HA
	pSl2h4xj/7q1Bu0g1Ye5TQP8OUmjn8lFuXCJpsoRauNpTxCdc9sXCjgU/4ubwc578dO9OGVb5fyW6
	KyIGZdg32lTpbadqv6ArPVBON9bGNvdZaUof4hPvgOb+E9ud9SNPIzdV0EiRhh3K95Jx4m1Bc9O2/
	/oeu4ytooIRu8uHv8SjzlN8dAFaSv5XsSvdVT9L9hesyGhU/nD57YBYJpZwxfl7Rs9kvqYH9XoH3V
	9vqEZiMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PY-0000000E51v-07aH;
	Sat, 01 Aug 2026 08:49:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PW-0000000E50W-3agp
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 08:49:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 41C8D60A98;
	Sat,  1 Aug 2026 08:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58441F00ACA;
	Sat,  1 Aug 2026 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574178;
	bh=b8b0HjIx8i/4Q0eCfCNUr0RTIks21JMqujJ7T9iW+M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RrBX6MivTy3ybY4Ecjin0z2IJWcIaY0ZHg8MxTj4KIGL788PdS3noKBf0Ly5IQleL
	 WN3zaDOgNKOgsKDBjvZogI8MIaChWplcoFbdZvzbB+4VPndTVwbgreMru1ggrjyBGi
	 FuVIMBvGXP6SzgYpYud7i/haPWwSER/aczlKKHvkBbFRt8lCmSK45DehNoVgwJDjSe
	 58sBeEH3PqfFU66mit+FXIcQE2xwhRyZlf4vjIdH1EWBV66LQ7F/iCKb00l3nUUcus
	 y3oGizZdSYlcDg61+ruli6r8Os8f2DxyWnT5GA7bDWR6x60LCpvZe9PxZqyv5RMnAk
	 voscwLHeB2zSQ==
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
Subject: [PATCH v6 18/22] kho: extend scratch
Date: Sat,  1 Aug 2026 10:48:27 +0200
Message-ID: <20260801084833.1897543-19-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <20260801084833.1897543-1-pratyush@kernel.org>
References: <20260801084833.1897543-1-pratyush@kernel.org>
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

Discover areas that don't contain any preserved memory at boot by
walking the preserved memory radix tree. Mark them as scratch to allow
allocations from them. This makes KHO more resilient to memory pressure
and allows supporting huge page preservation.

Since the preserved memory radix tree mixes both physical address and
order into a single key, and does not track table pages, it is difficult
to identify free areas from it directly. Walk the tree and digest it
down into another radix tree. The latter tracks blocks of
KHO_SCRATCH_EXT_BLKSIZE (1 GiB as of now) granularity. Then walk the
digested tree and mark the areas between the present keys as scratch.

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

There is no inherent reason for using 1 GiB as the discovered block
size. This can be changed later if needed. Currently, KHO is mainly
targeted for server grade systems with hundreds of gigabytes to
terabytes of memory. So 1 GiB is a reasonable granularity for those
systems. For smaller systems this doesn't work as well, but we can
arrive at a better heuristic when we have concrete use cases.

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

    radix_nodes:       0x13
    nr_preservations:  0x214
    mem_preserved:     0x227000

    per order preservations:
      order  0:  0x20f
      order  1:  0x4
      order  4:  0x1

and this is how long it takes to extend the scratch after KHO boot:

    KHO: KHO extend time: 47 us
    KHO: KHO extend total mem: 0xe6c17b000 (~57G)

Test case 2 - 1G memfd
~~~~~~~~~~~~~~~~~~~~~~

This test case has two memfds with 1G memory each in 4k pages, plus
other preservations from LUO core and other KHO users.

This is how the radix tree stats look like:

    radix_nodes:       0x28
    nr_preservations:  0x80816
    mem_preserved:     0x80829000

    per order preservations:
      order  0:  0x80811
      order  1:  0x4
      order  4:  0x1

and this is how long it takes to extend the scratch after KHO boot:

    KHO: KHO extend time: 22514 us
    KHO: KHO extend total mem: 0xd3f200000 (~52G)

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    As one might notice, the "scratch" terminology starts to break down
    here. There is the original "scratch", which is passed down by the
    previous kernel. It is marked MEMBLOCK_KHO_SCRATCH. There is also the
    discovered "scratch", which also gets marked MEMBLOCK_KHO_SCRATCH, but
    has nothing to do with the former.
    
    For limiting the scope of this series, I haven't done the rename here. I
    can do it as a follow up series once this stabilizes and lands into
    -next.
    
    I suggest the following scheme:
    
    - Rename "KHO scratch" to "KHO bootmem". Update the documentation and
      all code to use this name. We have the kho_scratch kernel cmdline
      parameter, which is harder to change, but perhaps we can rename it to
      "kho_bootmem" and if someone complains we can add it back.
    
    - Rename MEMBLOCK_KHO_SCRATCH to MEMBLOCK_KHO_NOPRSRV. This describes
      the property of the memory not its origin. Then KHO can mark its
      "bootmem" as KHO_NOPRSRV because bootmem never has any preserved
      memory. Later, kho_extend_scratch() (which is also due for a better
      name) can also mark its discovered areas as KHO_NOPRSRV.

 kernel/liveupdate/kexec_handover.c | 170 ++++++++++++++++++++++++++---
 1 file changed, 153 insertions(+), 17 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6e8682469bd7..e649e68d861f 100644
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
@@ -868,6 +885,140 @@ static void __init kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
+/*
+ * Look for free blocks of 1G. This is a heuristic chosen to work efficiently
+ * with large systems with hundreds of gigabytes of memory. It will work poorly
+ * on smaller systems. The algorithm itself doesn't depend on the actual value,
+ * so it can be changed to a different heuristic later if needed.
+ */
+#define KHO_SCRATCH_EXT_BLKSIZE		SZ_1G
+#define KHO_SCRATCH_EXT_BLKSHIFT	const_ilog2(KHO_SCRATCH_EXT_BLKSIZE)
+
+/* Called for the KHO preserved memory radix tree. */
+static int __init kho_ext_walk_leaf(unsigned long key, void *data)
+{
+	struct kho_radix_tree *busy_blocks = data;
+	phys_addr_t start, end;
+	unsigned int order;
+	int err;
+
+	/*
+	 * The key is from the KHO preserved memory radix tree. It is decoded to
+	 * a physical address of a preservation and its order.
+	 */
+	start = kho_decode_radix_key(key, &order);
+	end = start + (1UL << (order + PAGE_SHIFT));
+
+	while (start < end) {
+		err = kho_radix_add_key(busy_blocks, start >> KHO_SCRATCH_EXT_BLKSHIFT);
+		if (err)
+			return err;
+
+		start += (1UL << KHO_SCRATCH_EXT_BLKSHIFT);
+	}
+
+	return 0;
+}
+
+/* Called for the KHO preserved memory radix tree. */
+static int __init kho_ext_walk_node(phys_addr_t phys, void *data)
+{
+	struct kho_radix_tree *busy_blocks = data;
+
+	return kho_radix_add_key(busy_blocks, phys >> KHO_SCRATCH_EXT_BLKSHIFT);
+}
+
+/* Called for the busy block radix tree. */
+static int __init kho_ext_mark_scratch(unsigned long key, void *data)
+{
+	phys_addr_t *prev_end = data;
+	phys_addr_t start = key << KHO_SCRATCH_EXT_BLKSHIFT;
+	int err;
+
+	if (start > *prev_end) {
+		err = memblock_mark_kho_scratch(*prev_end, start - *prev_end);
+		if (err)
+			return err;
+	}
+
+	*prev_end = start + (1UL << KHO_SCRATCH_EXT_BLKSHIFT);
+	return 0;
+}
+
+/*
+ * kho_extend_scratch - Extend the scratch regions
+ *
+ * The KHO preserved memory radix tree mixes both physical address and order
+ * into a single key. This makes it hard to look for free ranges directly. This
+ * function first walks the radix tree and digests it down into another radix
+ * tree, whose keys identify blocks of size KHO_SCRATCH_EXT_BLKSIZE which
+ * contain preserved memory.
+ *
+ * Then it walks the digested radix tree and marks everything that doesn't have
+ * preserved memory as scratch.
+ *
+ * NOTE: This function allocates memory so it should be called when scratch has
+ * available space.
+ *
+ * NOTE: The pages of the KHO preserved memory radix tree tables are not marked
+ * as preserved in the preserved memory tree. But they are expected to remain
+ * untouched until the tree is fully parsed. So this function also considers
+ * them to be "preserved memory" and marks their blocks as busy.
+ *
+ * NOTE: efi_init()::reserve_regions() removes all regions except
+ * MEMBLOCK_KHO_SCRATCH. This function adds such regions but they are not KHO
+ * scratch memory, so they should not be removed. This function should always be
+ * called after reserve_regions().
+ */
+static void __init kho_extend_scratch(void)
+{
+	const struct kho_radix_walk_cb kho_cb = {
+		.leaf = kho_ext_walk_leaf,
+		.node = kho_ext_walk_node,
+	};
+	const struct kho_radix_walk_cb ext_cb = {
+		.leaf = kho_ext_mark_scratch,
+	};
+	static struct lock_class_key busy_radix_class;
+	struct kho_radix_tree busy_blocks;
+	phys_addr_t prev_end = 0;
+	int err = 0;
+
+	err = kho_radix_init_tree(&busy_blocks, NULL);
+	if (err)
+		goto print;
+
+	/*
+	 * The walk of kho_in.radix_tree adds keys to busy_blocks. The walk
+	 * takes the kho_in radix tree lock and adding the key takes busy_blocks
+	 * lock. Since both are struct kho_radix_tree and share the same lock
+	 * class, lockdep gets confused. Set a different class for
+	 * busy_blocks.lock to make lockdep happy.
+	 */
+	lockdep_set_class(&busy_blocks.lock, &busy_radix_class);
+
+	/* Walk the KHO radix tree to find busy blocks. */
+	err = kho_radix_walk_tree(&kho_in.radix_tree, &kho_cb, &busy_blocks);
+	if (err)
+		goto out;
+
+	/* Walk the busy blocks and mark everything between keys as scratch. */
+	err = kho_radix_walk_tree(&busy_blocks, &ext_cb, &prev_end);
+	if (err)
+		goto out;
+
+	/* Mark everything from last busy block to end of DRAM. */
+	if (prev_end < memblock_end_of_DRAM())
+		err = memblock_mark_kho_scratch(prev_end, memblock_end_of_DRAM() - prev_end);
+
+	/* fallthrough */
+out:
+	kho_radix_destroy_tree(&busy_blocks);
+print:
+	if (err)
+		pr_err("Failed to extend scratch: %pe\n", ERR_PTR(err));
+}
+
 /**
  * kho_add_subtree - record the physical address of a sub blob in KHO root tree.
  * @name: name of the sub tree.
@@ -1442,23 +1593,6 @@ void kho_restore_free(void *mem)
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
@@ -1769,6 +1903,8 @@ void __init kho_memory_init_early(void)
 		kho_in.scratch_phys = 0;
 		return;
 	}
+
+	kho_extend_scratch();
 }
 
 void __init kho_memory_init(void)
-- 
2.55.0.571.g244d577d93-goog


