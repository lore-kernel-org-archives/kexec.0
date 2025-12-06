Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8F6D3B7E6
	for <kexec@archiver.kernel.org>; Sat,  6 Dec 2025 23:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o3VAh2os3b+UvZGIBlby5rPpcBqmxelHC3H161To+tI=; b=QYpXaBo+XRF3uWOGnWQuu5M3KS
	I72lC3TvtSga5twvoJhgH5CqDGRkSBpho4PB7HwdX1OHpbhCTOhl09DGeG33tRgdR/GaeGAAZ2Jcn
	Bdg3V69Up46uCgM2WNqoNx0w6tGeQQe1lNMO5g16Bbbken5SoST74SMmSD44CtoOtoRX7NgoZBT8x
	+/ZWUeSEKP2fVqmdrXPb1FiY5oeF/Y8glrAV/YoCOw9TvYo62Ya2tRp8+O9OwrHzDaIWu+6xmGgH2
	2aqmSCXvdHlr/CzVAybeThXn6l/ldWXpp8njqiV7fEEvKdLSR5TxdUmpev1nBMWZtmJWIF99i3F2M
	BP1RuJ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS1Iq-0000000BHgz-0Cnh;
	Sat, 06 Dec 2025 23:03:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS1Il-0000000BHge-0cbl
	for kexec@lists.infradead.org;
	Sat, 06 Dec 2025 23:02:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E000A41906;
	Sat,  6 Dec 2025 23:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9A8C4CEF5;
	Sat,  6 Dec 2025 23:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765062173;
	bh=6DUm1o6LCjuGMMwws850Z+v4EVJVfUy729NCTOuuZtE=;
	h=From:To:Cc:Subject:Date:From;
	b=RJBCBR/km2500aF5vgAXFl6sUru0D8L/mlvyTxge58ga11iRXtwqV4rZElGW2RXqg
	 zI+NNmcWWWu3PXbyBtbL82tMygV7P2Y2s+a5eRNBX+S2Zpkz3zGQ8t2rCOXLtUPMPf
	 0TFY7poJ2yZ71jSgZbywl0CirbqQZq9w4nSuX6DR2ooegCM7gNgsI0bDxKHdtoxCA0
	 f1T/uevcfPw8Akk2IWz6/w8oRykDBX2GW7ZdedUy/1pXla2938KeChFUtrKICAT/Re
	 tO3BqDFipykd34xCADSx6l81cmz7BZ4JIHm92V+b0En3krxgHIzLuVqGg9JLiyNPFl
	 dvmE30P27EkpQ==
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
Subject: [RFC PATCH 00/10] liveupdate: hugetlb support
Date: Sun,  7 Dec 2025 00:02:10 +0100
Message-ID: <20251206230222.853493-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251206_150255_229903_BA9872A1 
X-CRM114-Status: GOOD (  21.17  )
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

This series adds support for live updating hugetlb-backed memfd,
including support for 1G huge pages. This allows live updating VMs which
use hugepages to back VM memory.

Please take a look at this patch series [0] to know more about the Live
Update Orchestrator (LUO). It also includes patches for live updating a
shmem-backed memfd. This series is a follow up to that, adding huge page
support as well.

You can also read this LWN article [1] to learn more about KHO and Live
Update Orchestrator, though do note that this article is a bit
out-of-date. LUO has since evolved. For example, subsystems have been
replaced with FLB, and the state machine has been simplified.

This series is based on top of mm-non-unstable, which includes the LUO
FLB patches [2].

This series uses LUO FLB to track how many pages are preserved for each
hstate, to ensure the live updated kernel does not over-allocate
hugepages.

Areas for Discussion
====================

Why is this an RFC?
-------------------

While I believe the code is in decent shape, I have only done some basic
testing and have not put it through more intensive testing, including
testing on ARM64. I am also not completely confident on the handling of
reservations and cgroup charging, even though it appears to work on the
surface.

The goal of this is to start discussion at high level points so we can
at least agree on the general direction. This also gives people some
time to see the code, before the session discussing this at LPC 2025
[3].

Disabling scratch-only earlier in boot
--------------------------------------

Patch 2 moves KHO memory initialization to earlier in boot. Detailed
discussion on the topic is in patch 2's message.

Allocating gigantic hugepages after paging_init() on x86
--------------------------------------------------------

To allow KHO to work with gigantic hugepages on x86, patch 2 moves
gigantic huge page allocation after paging_init(). This can have some
impact on ability to allocate gigantic pages, but I believe the impact
should not be severe. See patch 2 for more detailed discussion and test
results.

Early-boot access to LUO FLB data
---------------------------------

To work with gigantic page allocation, LUO FLB data is needed in early
boot, before LUO is fully initialized. Patch 3 adds support for fetching
LUO FLB data in early boot.

Preserving the entire huge page pool vs only used
-------------------------------------------------

This series makes a design decision on preserving only the number of
preserved huge pages for each hstate, instead of preserving the entire
huge page pool. Both approaches were brought up in the Live Update
meetings. Patch 6 discusses the reasoning in more detail.

[0] https://lore.kernel.org/linux-mm/20251125165850.3389713-1-pasha.tatashin@soleen.com/T/#u
[1] https://lwn.net/Articles/1033364/
[2] https://lore.kernel.org/linux-mm/20251125225006.3722394-1-pasha.tatashin@soleen.com/T/#u
[3] https://lpc.events/event/19/contributions/2044/

Pratyush Yadav (10):
  kho: drop restriction on maximum page order
  kho: disable scratch-only earlier in boot
  liveupdate: do early initialization before hugepages are allocated
  liveupdate: flb: allow getting FLB data in early boot
  mm: hugetlb: export some functions to hugetlb-internal header
  liveupdate: hugetlb subsystem FLB state preservation
  mm: hugetlb: don't allocate pages already in live update
  mm: hugetlb: disable CMA if liveupdate is enabled
  mm: hugetlb: allow freezing the inode
  liveupdate: allow preserving hugetlb-backed memfd

 Documentation/mm/memfd_preservation.rst |   9 +
 MAINTAINERS                             |   2 +
 arch/x86/kernel/setup.c                 |  19 +-
 fs/hugetlbfs/inode.c                    |  14 +-
 include/linux/hugetlb.h                 |   8 +
 include/linux/kho/abi/hugetlb.h         |  98 ++++
 include/linux/liveupdate.h              |  12 +
 kernel/liveupdate/Kconfig               |  15 +
 kernel/liveupdate/kexec_handover.c      |  13 +-
 kernel/liveupdate/luo_core.c            |  30 +-
 kernel/liveupdate/luo_flb.c             |  69 ++-
 kernel/liveupdate/luo_internal.h        |   2 +
 mm/Makefile                             |   1 +
 mm/hugetlb.c                            | 113 ++--
 mm/hugetlb_cma.c                        |   7 +
 mm/hugetlb_internal.h                   |  50 ++
 mm/hugetlb_luo.c                        | 699 ++++++++++++++++++++++++
 mm/memblock.c                           |   1 -
 mm/memfd_luo.c                          |   4 -
 mm/mm_init.c                            |  15 +-
 20 files changed, 1099 insertions(+), 82 deletions(-)
 create mode 100644 include/linux/kho/abi/hugetlb.h
 create mode 100644 mm/hugetlb_internal.h
 create mode 100644 mm/hugetlb_luo.c


base-commit: 55b7d75112c25b3e2a5eadc11244c330a5c00a41
-- 
2.43.0


