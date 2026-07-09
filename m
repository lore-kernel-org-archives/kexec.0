Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A610BC44506
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ML+T1jqorHxvPA3U5Bm2XJPJkZmW94GzjT4iRAPtUPo=; b=pyALLN5xUCmqaslkHgNc4NVSZI
	YKMXVgdZp9dTNS6/VuPlAmKA9yVxAjmXnwdno+B4dY4PPtWwme1kDuobm4mvYirMErcTmi+WXTECR
	RNMY6vV9aT/zXJrI0fL0T77qBso1Yq9xXOWkhjxlx9m+H1TZBWBND4paoyziuZDErCsOdjUxtzcB2
	a/p6y6QYCz14G5tR43pvHxSOyXvIs3apHjdGKrjdQTJD1fv+AQWw0SbUgQuIFgh50wIGVDmGdzPU3
	d5uKZUjCmalo+k6uw2mDJDSQAbWuuqIivRhiHIFccqPesSD8eY528TgNUwoG0Ck33t6XkHkQgyAjY
	iIyeK8iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whshn-000000037yn-25I1;
	Thu, 09 Jul 2026 17:38:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whshl-000000037yd-2OQz
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:38:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B36106137D;
	Thu,  9 Jul 2026 17:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454201F000E9;
	Thu,  9 Jul 2026 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618712;
	bh=ML+T1jqorHxvPA3U5Bm2XJPJkZmW94GzjT4iRAPtUPo=;
	h=From:To:Cc:Subject:Date;
	b=f1gPSnOFpVzoXykjOTween5Dbx8dOb9BTJGWIR7Xq333E9/2WgOFIwmnIQeGe9zth
	 fySmSZxYtVMYYgdTHBe4Y8tEq1c3jlWBkB6h09ElBpzvrA9Ck1Ia5lsKr4qCTdGnwR
	 tKm9FLDLPSQx+F4BRy1QES6YcKpplnnlxiVdHghEHWE+Bnpl69/ibTKtfeI3Wx8iki
	 mOkw9XpDbm9YueViPD5e7PgUesoVHQowwqHXOlF/vAoDL0oG6r0U3wp6P4GdDqYrkd
	 j98zUeJ0D9jAjjg/STQi9KEvT5iqO+wRWqZyznYs6RqqG/D5b6SsZu23v2G7q+SNDH
	 AL6ZVP+YgHvqQ==
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
Subject: [PATCH v3 00/21] kho: make boot time huge page allocation work nicely with KHO
Date: Thu,  9 Jul 2026 19:37:49 +0200
Message-ID: <20260709173821.429921-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
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

Hi,

Gigantic huge page allocation is somewhat broken currently with KHO.

First, they break scratch size accounting. Since they are allocated
using the memblock alloc APIs, they count towards RSRV_KERN, and this
scratch size when using scratch_scale. This means if huge pages take a
large enough chunk of system memory scratch size will blow up and fail
to allocate.

Second, scratch can not contain preserved memory, and if hugepages are
allocated from scratch, they will fail to be preserved with the upcoming
hugetlb preservation series [0].

Fix this by introducing the concept of extended scratch areas. They are
areas that the kernel discovers on boot by walking the radix tree and
finding free memory ranges. See patch 10 for more details.

Discovering the scratch areas needs some preparatory changes to KHO, the
radix tree APIs, and to memblock. Patches 1-17 do that.

Patch 18 adds the scratch discovery logic.

Patch 19 adds the dedicated memblock hugetlb allocator.

Patch 20-21 fix the scratch size calculation with using scratch_scale.

This series is based on top of the liveupdate/kho-scratch branch.

[0] https://lore.kernel.org/linux-mm/20251206230222.853493-1-pratyush@kernel.org/T/#u

Changes in v3:

More notable changes:

- Refactor how key width and table depth is calculated.
- I noticed that extended scratch breaks migrate type init during
  testing. Below two changes fix it:
- Remove memblock_is_kho_scratch_memory() and kho_scratch_migratetype().
  Instead, add kho_init_scratch_migratetype() and rework how migrate
  type for scratch pages is initialized.
- Move migrate type initialization from deferred_free_pages() to
  deferred_init_pages().

Other changes:

- Use kho_get_mem_map() directly in kho_populate() and add a comment on
  why it is okay to use.
- Don't say "export kho_scratch_overlap()".
- Add a comment in kho_extend_scratch() that it should always be called
  after efi_init()::reserve_regions().
- Get rid of memblock_reserved_size_flags(). Use
  memblock_reserved_hugetlb_size() instead.
- Define KHO_EXT_BLKSIZE to SZ_1G and add a comment explaining why the
  size was picked.
- Fix memblock tests build.
- Rename kho_ext_walk_key() to kho_ext_walk_leaf().
- Add some comments around the kho_ext tree callbacks to clarify which
  tree the function is called for and which one it uses.
- Move initialization of kho_in.radix_tree to kho_memory_init_early().
- Do not check if the tree is already initialized in kho_radix_init_tree().

Changes in v2:

Detailed changelog below.

At a high level, the major change in this version is to remove
MEMBLOCK_KHO_SCRATCH_EXT. Keep MEMBLOCK_KHO_SCRATCH as the only memory
type and mark the discovered areas with it. For HugeTLB, add a dedicated
allocation routine and if allocated memory lands in scratch, do a retry.
Also introduce MEMBLOCK_RSRV_HUGETLB to help with accounting of scratch
area sizes.

- Fixup commit message in patch 1 to make namespacing change clearer.
- Use @key in kernel-doc for radix functions.
- Add a runtime check on key width.
- Move all mem retrieval logic to kho_mem_retrieve().
- Add a comment in kho_mem_retrieve() explaining why mem_map won't be NULL.
- Rename callbacks to ->leaf() and ->node().
- Fixup commit messages.
- Clear tree->root in kho_radix_destroy_tree(). This lets the tree be
  re-initialized by calling kho_radix_init_tree()
- Add kho_get_mem_map() earlier in the series.
- Export kho_scratch_overlap() and use it in memblock_is_kho_scratch_memory().
- Get rid of MEMBLOCK_KHO_SCRATCH_EXT.
- Introduce MEMBLOCK_RSRV_HUGETLB.
- Introduce memblock_alloc_hugetlb() for hugetlb bootmem allocations.
- Refactor memblock_reserved_kern_size() to allow calculating size by flags.
- Exclude hugetlb memory from scratch size calculation.
- Collect R-bys.

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (21):
  kho: generalize radix tree APIs
  kho: make radix max key width more obvious
  kho: disallow wide keys in radix tree
  kho: return virtual address of mem_map
  kho: store incoming radix tree in kho_in
  kho: move all memory retrieval logic to kho_mem_retrieve()
  kho: add a struct for radix callbacks
  kho: add callback for table pages
  kho: add data argument to radix walk callback
  kho: allow early-boot usage of the KHO radix tree
  kho: allow destroying KHO radix tree
  kho: add kho_radix_init_tree()
  kho: expose kho_scratch_overlap() to kexec_handover.h
  kho: initialize kho_scratch pointer earlier in boot
  kho: initialize preserved memory map radix tree earlier
  mm/mm_init: init deferred page migratetype in deferred_init_pages()
  mm/mm_init: don't rely on memblock to get KHO scratch migratetype
  kho: extend scratch
  memblock: make HugeTLB bootmem allocation work with KHO
  memblock: add memblock_reserved_hugetlb_size()
  kho: exclude hugetlb memory from scratch size calculation

 include/linux/kexec_handover.h              |  16 +
 include/linux/kho/abi/kexec_handover.h      |   9 +-
 include/linux/kho_radix_tree.h              |  44 +-
 include/linux/memblock.h                    |  23 +-
 kernel/liveupdate/Makefile                  |   1 -
 kernel/liveupdate/kexec_handover.c          | 549 +++++++++++++++-----
 kernel/liveupdate/kexec_handover_debug.c    |  25 -
 kernel/liveupdate/kexec_handover_internal.h |   9 -
 mm/hugetlb.c                                |  22 +-
 mm/memblock.c                               | 144 +++--
 mm/mm_init.c                                |  59 ++-
 tools/testing/memblock/internal.h           |   5 +
 12 files changed, 645 insertions(+), 261 deletions(-)
 delete mode 100644 kernel/liveupdate/kexec_handover_debug.c


base-commit: 08412b8c707fdbccb7bf2116f0554fe09113cd53
-- 
2.55.0.141.g00534a21ce-goog


