Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B27D3B7EA
	for <kexec@archiver.kernel.org>; Tue,  9 Dec 2025 04:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHaNF3NLkUcld+qJXROnyemM10ER7BqRqDwEKLhFDTo=; b=JmB4LBXCnPk4k3BlCHAvfOVJxz
	rF0ikT+ulgMcVA934bMB+iIXxjC+4DK5CVPyuhb4x18KtJ9LTmz8VZSr3q8KNEy3TKjjWKzYLv/p+
	HJpIkhUgghL6uz6n7IBNVn/tcUVsQ3GGn/HiZIpMcW2Bqm5XcVCfTt1XV/AvZX1MgvscJM5sSWaNl
	lIB/MDU2TFy62bX/jFj0U+Cpw05Wl3oZ2UofJngnukHMbgWOoVvcJ3XJKrwAzB9PPThaij7aci9Kv
	4AsA8JUqSexH0l0uBfyLuUpZ3O9/MsWft139qhN1NjPDM8FzgxPYHp2seg7cKl+ZEv0wmW8ThVjpx
	z/dXgbSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSpZf-0000000Doga-3hji;
	Tue, 09 Dec 2025 04:43:43 +0000
Received: from out-180.mta0.migadu.com ([2001:41d0:1004:224b::b4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSpZc-0000000Dog9-2Ays
	for kexec@lists.infradead.org;
	Tue, 09 Dec 2025 04:43:42 +0000
Message-ID: <48d0b46e-2b82-44b6-a717-94bc258a508d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765255412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHaNF3NLkUcld+qJXROnyemM10ER7BqRqDwEKLhFDTo=;
	b=Z4RaZnHR0fIYk8Sv17Zr2mt78F7d5wPSTnieVtot08w35Gl9cmheLnXS1geWFqfwS5eRjd
	1dTnwFOYF2fDWvGYEP78fX93UW/XAMectuyHfrIbLeXZ/1SUE3Wvlt7Wf38yfm1OVCIGG1
	TiwkOIHMVpMwzQZpKOK079f7PElyX4c=
Date: Mon, 8 Dec 2025 20:43:22 -0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/10] liveupdate: hugetlb support
To: Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>,
 David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, kexec@lists.infradead.org
References: <20251206230222.853493-1-pratyush@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251206230222.853493-1-pratyush@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_204340_920997_E748B414 
X-CRM114-Status: GOOD (  32.34  )
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


在 2025/12/6 15:02, Pratyush Yadav 写道:
> This series adds support for live updating hugetlb-backed memfd,
> including support for 1G huge pages. This allows live updating VMs which
> use hugepages to back VM memory.
>
> Please take a look at this patch series [0] to know more about the Live
> Update Orchestrator (LUO). It also includes patches for live updating a
> shmem-backed memfd. This series is a follow up to that, adding huge page
> support as well.
>
> You can also read this LWN article [1] to learn more about KHO and Live
> Update Orchestrator, though do note that this article is a bit
> out-of-date. LUO has since evolved. For example, subsystems have been
> replaced with FLB, and the state machine has been simplified.
>
> This series is based on top of mm-non-unstable, which includes the LUO
> FLB patches [2].
>
> This series uses LUO FLB to track how many pages are preserved for each
> hstate, to ensure the live updated kernel does not over-allocate
> hugepages.


Is this patch serise based on the patches in the link 
https://lkml.org/lkml/2025/11/26/1665?

Thanks,

Yanjun.Zhu


>
> Areas for Discussion
> ====================
>
> Why is this an RFC?
> -------------------
>
> While I believe the code is in decent shape, I have only done some basic
> testing and have not put it through more intensive testing, including
> testing on ARM64. I am also not completely confident on the handling of
> reservations and cgroup charging, even though it appears to work on the
> surface.
>
> The goal of this is to start discussion at high level points so we can
> at least agree on the general direction. This also gives people some
> time to see the code, before the session discussing this at LPC 2025
> [3].
>
> Disabling scratch-only earlier in boot
> --------------------------------------
>
> Patch 2 moves KHO memory initialization to earlier in boot. Detailed
> discussion on the topic is in patch 2's message.
>
> Allocating gigantic hugepages after paging_init() on x86
> --------------------------------------------------------
>
> To allow KHO to work with gigantic hugepages on x86, patch 2 moves
> gigantic huge page allocation after paging_init(). This can have some
> impact on ability to allocate gigantic pages, but I believe the impact
> should not be severe. See patch 2 for more detailed discussion and test
> results.
>
> Early-boot access to LUO FLB data
> ---------------------------------
>
> To work with gigantic page allocation, LUO FLB data is needed in early
> boot, before LUO is fully initialized. Patch 3 adds support for fetching
> LUO FLB data in early boot.
>
> Preserving the entire huge page pool vs only used
> -------------------------------------------------
>
> This series makes a design decision on preserving only the number of
> preserved huge pages for each hstate, instead of preserving the entire
> huge page pool. Both approaches were brought up in the Live Update
> meetings. Patch 6 discusses the reasoning in more detail.
>
> [0] https://lore.kernel.org/linux-mm/20251125165850.3389713-1-pasha.tatashin@soleen.com/T/#u
> [1] https://lwn.net/Articles/1033364/
> [2] https://lore.kernel.org/linux-mm/20251125225006.3722394-1-pasha.tatashin@soleen.com/T/#u
> [3] https://lpc.events/event/19/contributions/2044/
>
> Pratyush Yadav (10):
>    kho: drop restriction on maximum page order
>    kho: disable scratch-only earlier in boot
>    liveupdate: do early initialization before hugepages are allocated
>    liveupdate: flb: allow getting FLB data in early boot
>    mm: hugetlb: export some functions to hugetlb-internal header
>    liveupdate: hugetlb subsystem FLB state preservation
>    mm: hugetlb: don't allocate pages already in live update
>    mm: hugetlb: disable CMA if liveupdate is enabled
>    mm: hugetlb: allow freezing the inode
>    liveupdate: allow preserving hugetlb-backed memfd
>
>   Documentation/mm/memfd_preservation.rst |   9 +
>   MAINTAINERS                             |   2 +
>   arch/x86/kernel/setup.c                 |  19 +-
>   fs/hugetlbfs/inode.c                    |  14 +-
>   include/linux/hugetlb.h                 |   8 +
>   include/linux/kho/abi/hugetlb.h         |  98 ++++
>   include/linux/liveupdate.h              |  12 +
>   kernel/liveupdate/Kconfig               |  15 +
>   kernel/liveupdate/kexec_handover.c      |  13 +-
>   kernel/liveupdate/luo_core.c            |  30 +-
>   kernel/liveupdate/luo_flb.c             |  69 ++-
>   kernel/liveupdate/luo_internal.h        |   2 +
>   mm/Makefile                             |   1 +
>   mm/hugetlb.c                            | 113 ++--
>   mm/hugetlb_cma.c                        |   7 +
>   mm/hugetlb_internal.h                   |  50 ++
>   mm/hugetlb_luo.c                        | 699 ++++++++++++++++++++++++
>   mm/memblock.c                           |   1 -
>   mm/memfd_luo.c                          |   4 -
>   mm/mm_init.c                            |  15 +-
>   20 files changed, 1099 insertions(+), 82 deletions(-)
>   create mode 100644 include/linux/kho/abi/hugetlb.h
>   create mode 100644 mm/hugetlb_internal.h
>   create mode 100644 mm/hugetlb_luo.c
>
>
> base-commit: 55b7d75112c25b3e2a5eadc11244c330a5c00a41

-- 
Best Regards,
Yanjun.Zhu


