Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29A8CD1297
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1cj3p388M/S8fstPOqvIwS2hzSzyo5GApF9WxbiPSy4=; b=nORVZBB6qkYr/dAUaGRBikWlx+
	3yMecOJidJ/AsRUIJfcoD2mrJOtpx7zWtzI7s1jDA9VUBa0duB3Qw88N/TtErzECpQKL12GKMhR3y
	tm+Up59VdwfR15cCcvY0/LH/REWPE8KzgkVCDy1mt0165YTHscFUM8RvYpMzzbSFqN47LgEOLnnb2
	H0GEVnnTVsJijV32eYu6zS5BV9pW0yNL4DcB42e3Urtp9UOXLWtOR4vdC6kJ485yb2kOuNfMJKoDN
	uANDAvfQeP9Q4vfrM2xchq5HmqVH/81tlSBPoYWteNJbe2sYjrvyb2ivwaqLocruTDafElFgdwQ9R
	BL8fhhhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58l-00000003gQr-3KzF;
	Wed, 29 Apr 2026 13:39:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58j-00000003gQi-3NnX
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:39:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EF6C460142;
	Wed, 29 Apr 2026 13:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2195C19425;
	Wed, 29 Apr 2026 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777469984;
	bh=w869zNKzhithGNRmRqp8WYig74dnCUUN98eSnQq4g4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=MJs6lfTE7V3kbascG1+hudy/89zmczFa5PxlZb5UB9FFDeycEMZORLHAl0r9HeTbG
	 xqc3Gi0YqX51ek5zsuVTKbNZU/INQwG7AjqhtYWOg7E9FRvYtQM0Da8ZNgcTV67nCR
	 kcuSTAj4LjOQ49eRp1hus4XCBUTq5/X9mJX03PiQ4ttbMrRAehATP2YYWKXE5dPdru
	 VCsmOKouXvBl7J0S5gjrxRzqYFh+k778oF8861LTfFygHVLDtX/ZaJBwXUiKc69zK5
	 D0jKzuL4H3n57HWS3knDqaHryDPzba/sy0Ustoy6M9jDA/bDNZlPNRCSrHkTu8UFoU
	 lAoK9K3AxOKHw==
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
Subject: [PATCH 00/12] kho: make boot time huge page allocation work nicely with KHO
Date: Wed, 29 Apr 2026 15:39:02 +0200
Message-ID: <20260429133928.850721-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
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

Discovering the scratch areas needs some changes to the radix tree APIs
and to memblock. Patches 1-8 do that.

Patch 9 introduces extended scratch to memblock.

Patch 10 adds the extended scratch discovery logic.

Patch 11 cleans up the preserved memory map API.

Finally, patch 12 puts all the pieces together and uses only extended
scratch for hugepage allocation and does not count then towards
RSRV_KERN.

[0] https://lore.kernel.org/linux-mm/20251206230222.853493-1-pratyush@kernel.org/T/#u

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (12):
  kho: generalize radix tree APIs
  kho: store incoming radix tree in kho_in
  kho: add a struct for radix callbacks
  kho: add callback for table pages
  kho: add data argument to radix walk callback
  kho: allow early-boot usage of the KHO radix tree
  kho: allow destroying KHO radix tree
  kho: add kho_radix_init_tree()
  memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
  kho: extended scratch
  kho: return virtual address of mem_map
  mm/hugetlb: make bootmem allocation work with KHO

 include/linux/kexec_handover.h     |   1 +
 include/linux/kho_radix_tree.h     |  44 ++--
 include/linux/memblock.h           |  14 ++
 kernel/liveupdate/kexec_handover.c | 389 ++++++++++++++++++++++-------
 mm/hugetlb.c                       |  19 +-
 mm/memblock.c                      | 177 ++++++++++---
 mm/mm_init.c                       |   1 +
 7 files changed, 489 insertions(+), 156 deletions(-)


base-commit: eee13213401bafb7ffe3b447adffb1f570b9d813
-- 
2.54.0.545.g6539524ca2-goog


