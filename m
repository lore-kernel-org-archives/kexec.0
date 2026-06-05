Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97D0CD6E7E
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YfLHlVxyR5EYNIvS2b9hctrQDZeBzNQYJP8K26NqgQo=; b=t8PMrmlQVNq6gZgEiCbV7nLQtP
	ksCIa6rZgODx2PNUnPYHgFbqtS/DnoDkKPGnix3NHekiCyx5wcAzMJXw2WWHhwioKXJt6wGsZaSZt
	ZJAnK8YCqmmPM/mO85Q8EpPagMPEBa7MbMi5rwhD34oT9RdVomWFhOFkA4+oTHzR2ih7gHioHUWVU
	9+evlCCSphvfL8QAFFCnvir1jAJ7h6Kp0fxuDk1cniV3n6NYQObAQL5pARudidwv7OJ6DY3TIsLZx
	3qYgPOB6CRB4mvtAaGifBSbIaaE7afkgLnV3de0js5PKaLwyOt2b3VG8am8cQSJJ0Jz4m06ekK/Jx
	xamUqDlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZNz-0000000130F-0N17;
	Fri, 05 Jun 2026 18:35:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZNx-00000001306-2S6a
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B1398600AE;
	Fri,  5 Jun 2026 18:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BE11F00893;
	Fri,  5 Jun 2026 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684512;
	bh=YfLHlVxyR5EYNIvS2b9hctrQDZeBzNQYJP8K26NqgQo=;
	h=From:To:Cc:Subject:Date;
	b=B4SkuHOwbpSMPXI9ruNO7rv/8yWdd8bv8ro0F9nWQkm6nqfl+gyMpWpb0cKTLPHie
	 z/XNlFaOrjGa4VmKsmdR+GkdbJld7zgVRxUgGudXk3+BbEzNetVxmx5HHBp54QJLB6
	 niasdzmUY36GOFGOUfi1DPrL8DSjIv7gcq2VZYdpjECJtyP+NUoXAPI1CZkniE0VB7
	 zfWER+QtNuRfTU6o5Vu9HD6dRTd7zj2b4pU49RpuriOG/7MPIM0mkcXoiv5H987Ljk
	 V58MtYDpC8vh8tEyZhOH5BAvoQrG27WKhS0+Va/VqG3yjfig4ipQJL3dQ42cAim+b1
	 VIHJwm+goFsLg==
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
Subject: [PATCH v2 00/18] kho: make boot time huge page allocation work nicely with KHO
Date: Fri,  5 Jun 2026 20:34:33 +0200
Message-ID: <20260605183501.3884950-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
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
radix tree APIs, and to memblock. Patches 1-14 do that.

Patch 15 adds the scratch discovery logic.

Patch 16 adds the dedicated memblock hugetlb allocator.

Patch 17-18 fix the scratch size calculation with using scratch_scale.

[0] https://lore.kernel.org/linux-mm/20251206230222.853493-1-pratyush@kernel.org/T/#u

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

Pratyush Yadav (Google) (18):
  kho: generalize radix tree APIs
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
  kho: export kho_scratch_overlap()
  kho: initialize kho_scratch pointer earlier in boot
  memblock: use kho_scratch_overlap() to decide migratetype
  kho: extend scratch
  memblock: make HugeTLB bootmem allocation work with KHO
  memblock: allow calculating reserved size by flags
  kho: exclude hugetlb memory from scratch size calculation

 include/linux/kexec_handover.h              |  10 +
 include/linux/kho/abi/kexec_handover.h      |   8 +
 include/linux/kho_radix_tree.h              |  44 +-
 include/linux/memblock.h                    |   9 +-
 kernel/liveupdate/Makefile                  |   1 -
 kernel/liveupdate/kexec_handover.c          | 495 +++++++++++++++-----
 kernel/liveupdate/kexec_handover_debug.c    |  25 -
 kernel/liveupdate/kexec_handover_internal.h |   9 -
 mm/hugetlb.c                                |  22 +-
 mm/memblock.c                               | 120 ++++-
 mm/mm_init.c                                |   1 +
 11 files changed, 540 insertions(+), 204 deletions(-)
 delete mode 100644 kernel/liveupdate/kexec_handover_debug.c


base-commit: 2935777b418d2bfcbfe96705bb2c0fa6c0d94e18
-- 
2.54.0.1032.g2f8565e1d1-goog


