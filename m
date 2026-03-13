Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35666105F7A8
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aDtcuq+jZAq8nSruY2x07zz92Rm4Lz2QSe0PkkRpDPo=; b=urasZsFSyIDc72iltUo/aCVApC
	KxX4EdaSTv46LyhPvaniTG74RU3CXXIpclWIFpWCZRVMVGC5j1wbkFAuC0s4CpvunW5SGbMc9kiQO
	uq1qreguW53czxo87DahrbUZgMG8NPGB2BxSuV8bq76hKJDlUMnG2pFb8Ha3k8B/6lsPywuq1QVT8
	APxPvutp3tgLEv/Rp+qm4GPojETLfPVvjfxy/oUEcjvAeGqvhIJnFW/gv9BkWe+YzGP4CNmxxFcxV
	3rU0rsZpjLev4xvbMdMxM8azz6msU9CkK5va95Kvk8UbC772WjO1C5t5tbr4P9cdSB5aWbzLJh5BM
	ytGdyLRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w132C-00000000KZq-31cR;
	Fri, 13 Mar 2026 13:58:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1329-00000000KZj-3KMj
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 13:58:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ED2C361843;
	Fri, 13 Mar 2026 13:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B37AC2BC86;
	Fri, 13 Mar 2026 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773410312;
	bh=kshVJg/rQTERmOD6YiWVGRVHPpNBvBSWyHEFYDvoDCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XX4cQHC3W+i3JG5+SggGUb4YhfFkxWFUaZMFpdj6PwCYa/AYmIZ7GxWKHVCjC6gke
	 kuo1XcRg4bXFWt0s13h6QCHyHjxocZ/hbBR1qz12U95YZ7bHoaQXHucQ4tRAKnEvNe
	 oTVLM6qH3rzagaV2SYXufW1SWuhUb0pWrakRUanvW/tN9Ef/G4VSd7h8TtIH4Z3QUE
	 uR4UO6yU89zstZ+6O80qPMIakUZzD3XL87KJcZd03qnO3bEeaibxKh9iWblSBiA5Mp
	 I3hgd4NKR3w//f7qsBtszC8GsY8Vsv5dc8tWhCdkJMIQ3K9DwRxQw7zMQvONCl8FMv
	 KmneJRjsK5wmw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,  Pratyush
 Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,  Samiullah
 Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 1/2] kho: fix deferred init of kho scratch
In-Reply-To: <20260311125539.4123672-2-mclapinski@google.com> (Michal
	Clapinski's message of "Wed, 11 Mar 2026 13:55:38 +0100")
References: <20260311125539.4123672-1-mclapinski@google.com>
	<20260311125539.4123672-2-mclapinski@google.com>
Date: Fri, 13 Mar 2026 13:58:28 +0000
Message-ID: <2vxz1phnesqj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Michal,

On Wed, Mar 11 2026, Michal Clapinski wrote:

> Currently, if DEFERRED is enabled, kho_release_scratch will initialize
> the struct pages and set migratetype of kho scratch. Unless the whole
> scratch fit below first_deferred_pfn, some of that will be overwritten
> either by deferred_init_pages or memmap_init_reserved_pages.
>
> To fix it, I initialize kho scratch early and modify every other
> path to leave the scratch alone.
>
> In detail:
> 1. Modify deferred_init_memmap_chunk to not initialize kho
> scratch, since we already did that. Then, modify deferred_free_pages
> to not set the migratetype. Also modify reserve_bootmem_region to skip
> initializing kho scratch.
>
> 2. Since kho scratch is now not initialized by any other code, we have
> to initialize it ourselves also on cold boot. On cold boot memblock
> doesn't mark scratch as scratch, so we also have to modify the
> initialization function to not use memblock regions.
>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

I haven't had the time to carefully review this yet, but sharing some
high level thoughts.

IIUC the real problem isn't struct page initialization, but the fact
that if the page is at a pageblock boundary its migrate type is not
correctly set to MIGRATE_CMA. So you fix the problem by making sure no
one else but KHO can initialize the scratch pages.

I think the end result makes the already complicated page initialization
sequence even more complicated. I tried to grok that patch and it makes
my brain hurt.

Can we get away with something simpler? Here's an idea: keep the struct
page init the same as it is now, just modify
init_pageblock_migratetype() to override the migrate type if page lands
in scratch. It already does something similar with MIGRATE_PCPTYPES:

	if (unlikely(page_group_by_mobility_disabled &&
		     migratetype < MIGRATE_PCPTYPES))
		migratetype = MIGRATE_UNMOVABLE;

So we can also add:

	/*
	 * Scratch pages are always MIGRATE_CMA since they can't contain
	 * unmovable allocations.
	 */
	if (unlikely(pfn_is_kho_scratch(page_to_pfn(page))))
		migratetype = MIGRATE_CMA;

Do you think this will work? If yes, then I think it is a lot nicer than
what this patch is doing.

Also, pfn_is_kho_scratch() is pretty much a duplicate of
kho_scratch_overlap(). Please pull kho_scratch_overlap() out of
kexec_handover_debug.c and use that instead.

> ---
> My previous idea of marking scratch as CMA late, after deferred struct
> page init was done, was bad since allocations can be made before that
> and if they land in kho scratch, they become unpreservable.
> Such was the case with iommu page tables.
[...]

-- 
Regards,
Pratyush Yadav

