Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89412C5DF98
	for <kexec@archiver.kernel.org>; Sun, 23 Aug 2026 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FD/dMdn7bQ6iKASWP2WBLR+A6BaEIP1jOQGn6FPkDKI=; b=VFQpElg5WoXBmehOb3Ybuzqnt/
	TpoGE5bWFmmd7aXIjiSIEhYEphL8D3tpz5Af1GBts1blQuQM3tejtvz+uaBf81ZwBOURg7xTUDTqv
	thQGIQ8uHaqjOuYMCRSakbfYlRr3S73SoKQFiztQ5AdJ1Y7YnlCE2D5I51YWDlVQ0nCmpaGtIjMRO
	xVNyk//jltlCvL0vvYKJjOVJu6SIIXQRyDuRHG2RuNMCqN+Lr+6DSyP1DTJ7glmCdMUnTcXuXGrc2
	xoZS405NKjKFRDlL1z9oyuGV+cW9aUvQBF+JCqLVu8Avzo/hEuPwk4I06mJONPNCprWMdwJFVEx/Y
	RY0QA8yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy8NU-0000000FOs0-2hKS;
	Sun, 23 Aug 2026 13:36:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy8NR-0000000FOru-35QA
	for kexec@lists.infradead.org;
	Sun, 23 Aug 2026 13:36:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CA25160052;
	Sun, 23 Aug 2026 13:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313F11F000E9;
	Sun, 23 Aug 2026 13:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787492204;
	bh=FD/dMdn7bQ6iKASWP2WBLR+A6BaEIP1jOQGn6FPkDKI=;
	h=From:To:Cc:Subject:Date;
	b=FFC+KeWUHD1cV0jR39wf8ogvQdP3phUXIL+7bswTAQcsvPtKcB3+SBCbGBGAk8G+Z
	 vIe6qBlIrIaCpaBOYqcdWrUHllzt1C/rOQB33xW87DFOTwU+V+lycjl5ndsJ3awK1p
	 dFeNyKR7piYJTlXfLzWD1ZqdeqMKpKW65a2m7/tytRFuZ1Daq2AYrySkKuJTaQv+iQ
	 dXVHgjN5I0GPNyHifdF4ljd9L0LDB6kmh3qQBCJse+X8tk2kk753PBzqfstAyFP28S
	 sz+VYIpbcnqZbbcv0K6FXlKPaqG4W9eonh7pZHLAT6tarpgxdHYEJdgZcz8snHBBAU
	 pdTq+4cDz+/1A==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] liveupdate: updates for 7.3-rc1, part 2
Date: Sun, 23 Aug 2026 16:36:32 +0300
Message-ID: <20260823133634.3570153-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Hi Linus,

This is the second part of liveupdate changes for v7.3-rc1.

The changes here depend on the work merged via Andrew's tree, so I waited for
his pull request to go in.

The following changes since commit 6d098029de0902372fdaa07e049db3866cbd8907:

  mm/mm_init: fold __init_page_from_nid() into __init_deferred_page() (2026-07-28 21:12:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.3-rc1-20260823

for you to fetch changes up to bc0f793c5c41601b273a2ca64c768adca1d447f5:

  Merge patch series "kho: make boot time huge page allocation work nicely with KHO" (2026-08-04 09:50:03 +0300)

----------------------------------------------------------------
kho: make boot time huge page allocation work nicely with KHO

Today allocation of gigantic pages in HugeTLB cannot work reliably with KHO:

* HugeTLB allocates gigantic pages using memblock and autoscaling of KHO
  scratch accounts for these allocations. When gigantic pages occupy half
  of the memory of more, KHO fails to allocate its scratch memory.
* After kexec handover, memblock allocations exclusively use KHO scratch
  that is not supposed to contain preserved memory. This essentially blocks
  preservation of HugeTLB with gigantic pages.

Extend early memory pools available for KHO kernel with areas that are
guaranteed not to contain preserved memory.

----------------------------------------------------------------
Mike Rapoport (Microsoft) (2):
      Merge branch 'mm-stable-6d098029de09' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm into kho-scratch
      Merge patch series "kho: make boot time huge page allocation work nicely with KHO"

Pratyush Yadav (Google) (21):
      x86/setup: do not include kexec_handover.h from asm/setup.h
      kho: generalize radix tree APIs
      kho: make radix max key width more obvious
      kho: disallow wide keys in radix tree
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
      mm/mm_init: don't rely on memblock to get KHO scratch migratetype
      kho: extend scratch
      memblock: always include KHO headers
      memblock: make HugeTLB bootmem allocation work with KHO
      memblock: add memblock_reserved_hugetlb_size()
      kho: exclude hugetlb memory from scratch size calculation

 MAINTAINERS                                     |   1 +
 arch/x86/boot/compressed/kaslr.c                |   2 +
 arch/x86/include/asm/Kbuild                     |   1 +
 arch/x86/include/asm/setup.h                    |   2 -
 arch/x86/kernel/setup.c                         |   1 +
 include/asm-generic/kexec_handover.h            |  12 +
 include/linux/kexec_handover.h                  |  31 +-
 include/linux/kho/abi/kexec_handover.h          |   9 +-
 include/linux/kho_radix_tree.h                  |  60 ++-
 include/linux/memblock.h                        |  23 +-
 kernel/liveupdate/Makefile                      |   1 -
 kernel/liveupdate/kexec_handover.c              | 525 +++++++++++++++++++-----
 kernel/liveupdate/kexec_handover_debug.c        |  25 --
 kernel/liveupdate/kexec_handover_internal.h     |   9 -
 mm/hugetlb.c                                    |   9 +-
 mm/memblock.c                                   | 154 +++++--
 mm/mm_init.c                                    |  29 +-
 tools/testing/memblock/internal.h               |   5 +
 tools/testing/memblock/linux/kexec_handover.h   |   9 +
 tools/testing/memblock/linux/kho/abi/memblock.h |  10 +
 tools/testing/memblock/linux/libfdt.h           |   9 +
 21 files changed, 673 insertions(+), 254 deletions(-)
 create mode 100644 include/asm-generic/kexec_handover.h
 delete mode 100644 kernel/liveupdate/kexec_handover_debug.c
 create mode 100644 tools/testing/memblock/linux/kexec_handover.h
 create mode 100644 tools/testing/memblock/linux/kho/abi/memblock.h
 create mode 100644 tools/testing/memblock/linux/libfdt.h

