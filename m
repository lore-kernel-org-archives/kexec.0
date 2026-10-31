Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695D606A31D
	for <kexec@archiver.kernel.org>; Sat, 31 Oct 2026 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=N+MyMakC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fs0KlZas
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=gKWLK/+RB8/IbvWZCyjfSS+z65/1SuUIYYg4zekcjqc=; b=N+MyMakC5sREKs9Vkbd4JtOFDg
	/6vankV6gYh4cAjjP2e9oKdZja78eDfRKdAVhMpXY7ct/P6RyLrV4pUEMwK2v0CtwmJPEaGxIVYyR
	yObckJV/JwAxjr9UoMCinDGl38S+/1uQ7IQgyHFSPHH+dUKGSxcQuQ0eDQTEgIKNw/ACjJU3hmqUn
	95Ymq0Kz+lK/WaIW1pR2dR2V1WKYHKj3MsNwOGjy/7gJNjpEsqiLGtdoJVcqnHaNTzeLLBlFS2w6F
	IF2Ot7E1v5dikcReFTIEwu+JJONFRrANaFk21CBWXiSA5FZZcSPuTltC+UNwxz4NUm4pFDxnx/k6q
	U3ACWE0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5ZQ-0000000D8oN-1uVb;
	Sat, 31 Oct 2026 09:40:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5ZO-0000000D8oB-3KVc
	for kexec@lists.infradead.org;
	Sat, 31 Oct 2026 09:40:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 70887600C8;
	Sat, 31 Oct 2026 09:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393F81F000C1;
	Sat, 31 Oct 2026 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439613;
	bh=gKWLK/+RB8/IbvWZCyjfSS+z65/1SuUIYYg4zekcjqc=;
	h=From:Subject:Date:To:Cc;
	b=fs0KlZasSVLdJoJyamJ31ldiUqIcdWL5HWJoVfcaS8cGtP5Dd2m+JDV2nRHeQzeG3
	 NIhdcxwvxcwjb865WA1nbkQbdaBo8P6O/i2qlUN03Fxs+sTUUVy4YDLEVeZ/tzUPwJ
	 xfZJnbKu2MzqN6vB3S788DM1qBIJNsJeZ+o29c/5u5rPyW0YfOufNz4Cdd3bRdTxVK
	 AAWboiAAOLom+rX421rcXjbBPG9qoOMN5CyMoBshth5wYThydg0uLue32qAU/LWAe6
	 iSYwWriy4VBep5+yCNpZfTbvK9EjyCesjbR9wDxn0ttFts9KxUXqqqA3DefhGXw7A4
	 rgpKXF9FPYNsQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v3 00/47] mm: various (urgent?) fixes
Date: Sat, 31 Oct 2026 10:39:29 +0100
Message-Id: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFK35WoC/12NXQ7CIBAGr9LwLIafSlufvIcxBujSoqYYqETT9
 O5CjUn18cvOzE4ogLcQ0L6YkIdog3VDGnxTIN3LoQNs27QRI0xQwig29gnhrJ0HrFojeG2kIYy
 jJNw9LNfEH0+fHR7qAnrMhUz0NozOv5ZvkWbuG67W4UgxwcJUpQLdyJ1Shyv4AW5b5zuUy5Gt3
 ebHZcmVotRQmZrLP3ee5zcv/EeS8wAAAA==
X-Change-ID: 20261021-fixes_core-bdf638faf023
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, SJ Park <sj@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Mani Tofigh <mt4022@columbia.edu>, Samiullah Khawaja <skhawaja@google.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6243; i=david@kernel.org;
 h=from:subject:message-id; bh=Ne44W0pCdibrhZU6s/JF3yraM75zMPmZidCGDEhFZEY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebo8Ua5C0WaSwyadW96j1Wz7LddYeU8Q7E6ti7J/JL
 6xud+LoKGVhEONgkBVTZAkKvm/w8uW62mo3PmaYOaxMIEMYuDgFYCL3DzAydOXlbhBleu3Dvf7E
 q5XvM+UlRRg6ZaYfu2VRr1+2uehvHCPDU1Mdnzt5fO7mXbtrg61kpjx+/Pb7nrfdS4o4l88RbN7
 NCAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks to everyone for the review! Hoping I can get some more? :)

A quick resend, I'll queue these immediately after sending to get them
into -next asap. Don't let that discourage you from reviewing ;)

---
Changes in v3:
- Replace "mm/memfd: check for real shmem inodes before accessing shmem
  state" by "mm/shmem: make shmem_file() check the file's inode"
- "mm/huge_memory: fix zapping migration entries for device-private
  THPs": drop "!is_present" check
- Pick up tags
- Link to v2: https://patch.msgid.link/20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org

Changes in v2:
- "mm/memfd: check for real shmem inodes before accessing shmem state"
 - Call it inode_is_shmem
- "mm/truncate: look again if a folio left the mapping"
 - Different fix for truncate_inode_pages_range
 - Adjust description
- "mm/huge_memory: fix zapping migration entries for device-private THPs"
 - Move handling in zap_deposited_table
- "mm/mmu_gather: fix flushing ranges with 4 GiB or larger"
 - Adjust description"
- "mm/huge_memory: split huge PUDs when adjusting VMA boundaries"
 - Drop split_pud check
- Link to v1: https://patch.msgid.link/20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org

---

Chris Mason (11):
      mm/huge_memory: fix truncate racing with PMD zapping
      mm/huge_memory: fix zapping migration entries for device-private THPs
      mm/khugepaged: preserve dirty bits when collapsing PTE-mapped THPs
      mm/gup: fix clearing folios in memfd_pin_folios()
      mm/gup: fix out-of-bounds write for nr_pages == 0 in GUP-fast
      mm/mmu_notifier: set ->mm only after mmgrab()
      mm/memory: reject remote COW faults on PFN mappings
      mm: fix unkillable fault loop on MAP_DROPPABLE memory
      mm: fix deadlock of mremap() against UFFDIO_MOVE
      mm/ksm: check large swap-cache folios before mapping them
      mm/vma: call ->may_split() before a partial merge

David Hildenbrand (Arm) (20):
      fork: take mmap_lock before copying mm_struct
      mm/shmem: make shmem_file() check the file's inode
      mm/truncate: look again if a folio left the mapping
      mm/filemap: finish fault cleanup before dropping the fault lock
      mm/rmap: handle device-exclusive entries in folio_referenced_one()
      mm/huge_memory: fix list corruption when deferred_split_scan() races with deferred_split_folio()
      mm/huge_memory: properly handle refcounted PUD mappings on fork
      mm/khugepaged: check if PTE table is empty in try_collapse_pte_mapped_thp()
      mm/gup: recheck the PUD under PTL in follow_pud_mask()
      mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
      mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
      mm/userfaultfd: wake waiters when registration modes are removed
      mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
      mm/mremap: recheck PUDs under the page table lock
      mm/madvise: fix data loss from MADV_FREE on a KSM page
      mm/ksm: reset the unstable trees of all nodes
      mm/ksm: fix use of a freed anon_vma at swap-in
      mm/huge_memory: split huge PUDs when adjusting VMA boundaries
      mm/vma: don't leak the charge for stack growth
      mm/memory-tiers: unregister empty tiers outside memory_tier_lock

Gregory Price (1):
      mm/userfaultfd: compare exact registration modes before skipping

Josef Bacik (14):
      mm/mglru: don't use stack pointers when walking PUD and PMD tables
      mm/memfd: make f_pos accesses atomic
      mm/filemap: read mapping->a_ops->free_folio under i_lock
      mm/filemap: don't lose a folio lock wakeup to a signal
      mm/huge_memory: fix livelock on device private folio
      mm/khugepaged: always recheck the pmd in try_collapse_pte_mapped_thp()
      mm/khugepaged: fix PMD table lock leak in try_collapse_pte_mapped_thp()
      mm/userfaultfd: wake all waiters on unregister
      mm/mmu_gather: fix flushing ranges with 4 GiB or larger
      mm/mmu_notifier: finish non-blocking interval invalidation on error
      mm/mremap: fix moving PUD leaves
      mm/memory_hotplug: avoid races in pfn_to_online_page() with dying pgmap
      mm: fix unmap_mapping_range() beyond 4 GiB on 32-bit
      fs/proc/task_mmu: refuse addresses beyond 32 bits on 32bit

Rik van Riel (1):
      mm/cma: don't release CMA pages still in use

 fs/proc/task_mmu.c            |   6 ++
 include/asm-generic/tlb.h     |   3 +-
 include/linux/huge_mm.h       |   5 +-
 include/linux/ksm.h           |   6 +-
 include/linux/memremap.h      |   6 ++
 include/linux/mmu_notifier.h  |   3 +-
 include/linux/shmem_fs.h      |  15 ++---
 include/linux/userfaultfd_k.h |   2 -
 kernel/fork.c                 |  20 ++++--
 mm/cma.c                      |  10 ++-
 mm/filemap.c                  |  88 ++++++++++++-------------
 mm/gup.c                      |  53 ++++++++++-----
 mm/huge_memory.c              | 146 +++++++++++++++++++++++++++++++-----------
 mm/hugetlb.c                  |  14 +---
 mm/internal.h                 |  28 ++++++++
 mm/khugepaged.c               |  79 +++++++++++------------
 mm/ksm.c                      |  56 ++++++++++++----
 mm/madvise.c                  |   9 +++
 mm/memfd.c                    |   2 +
 mm/memory-tiers.c             |  29 ++++-----
 mm/memory.c                   |  30 ++++++---
 mm/memory_hotplug.c           |  13 ++--
 mm/memremap.c                 |  13 ++++
 mm/mmap.c                     |   8 +--
 mm/mmu_notifier.c             |  24 +++++--
 mm/mremap.c                   | 103 +++++++++++++----------------
 mm/nommu.c                    |   2 +-
 mm/rmap.c                     |  23 +++++--
 mm/shmem.c                    |   5 ++
 mm/swapfile.c                 |   3 +-
 mm/truncate.c                 |  13 +++-
 mm/userfaultfd.c              |  75 ++++++++++------------
 mm/util.c                     |  13 ++++
 mm/vma.c                      |  24 +++++--
 mm/vmscan.c                   |   4 +-
 35 files changed, 580 insertions(+), 353 deletions(-)

---

base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d

change-id: 20261021-fixes_core-bdf638faf023

--

Cheers,

David


