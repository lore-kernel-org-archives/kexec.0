Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9ABC79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kW02xwwfobHDqKYd5wNAbqTLVNekBz/ryWW+HAKscjY=; b=lFooJtCUSDM6r6GebRRJry5gRC
	rcDYGpP6nIwHZ43q6N1TH9A+NRMLrqEawNdIr5o01oiP+w8Bn99q23qqoV2dX9C7CXY1vBC79Q04e
	nXMXDbMKDCzc5lsg6MRC9O2vqbqc1hVyN/Un4HIzRPgYPByqVoiaa+ICY2kgO05Bex9EZghHXLvEB
	DfuF+qX0y7pSIY4INe6LBP/Y+4AdbC6cw5vtVDTUG6w8UDyoNfQJ/Rrw7P6hA3S9ETRAA0QSIXcIZ
	zvfag4vhSN6DYWhP7hSVXFspmn2hDVRsP+6oU9zaRIITdqafaC10ebjkjMh2cmBKZZAJeMdLmazoI
	SWbejXRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4II1-0000000BnD1-0TKU;
	Wed, 09 Sep 2026 13:24:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IHx-0000000BnCJ-3amT
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:24:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D15060218;
	Wed,  9 Sep 2026 13:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB011F00AC4;
	Wed,  9 Sep 2026 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960273;
	bh=kW02xwwfobHDqKYd5wNAbqTLVNekBz/ryWW+HAKscjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CmQNemKiITSt5nne5crT7mydGU7xhK9xTOk7q+T6HnPql9JlKKWyL5CvBtlHWJrAx
	 aVS7QTXQoqMOPGt1mRzZAhLwsC7jVG0puSWSK75HdmvNeXVQFDxXRCUGhZZM1I+Ppf
	 Z2tY2gTsyt05FwizpIgaJk9SkISj64mPMHO8LpSI1u6pkxo44CK1P1G9JynYiLTR3j
	 WbPPu/+qE6afFvaL1BWw5Px6eEhxh9oeOp2ALXeFcbVc3BuedKvqb3rAJ+FfsQmtRy
	 65kAdWnDh0YY640IIVbu179iMcNccfiv3R8yJjdGWO4OZ4JncR+2+pMLBbnnAnxoqY
	 /MGQH+zjBIqVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] mm/memory-failure: keep inherited poisoned
 frames out of the buddy allocator
To: "Liam R. Howlett" <liam@infradead.org>, "Michal Hocko" <mhocko@suse.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, kas@kernel.org, "David Hildenbrand" <david@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Thomas Gleixner" <tglx@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Zi Yan" <ziy@nvidia.com>, "Breno
 Leitao" <leitao@debian.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Mike Rapoport" <rppt@kernel.org>, "Miaohe
 Lin" <linmiaohe@huawei.com>, "Suren Baghdasaryan" <surenb@google.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Brendan Jackman" <brendan.jackman@linux.dev>, x86@kernel.org, "Ard
 Biesheuvel" <ardb@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, rmikey@meta.com, harry@kernel.org, kernel-team@meta.com, kexec@lists.infradead.org
In-Reply-To: <20260909-hwpoison-kho-v4-5-359313564495@debian.org>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-5-359313564495@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:24:31 +0000
Message-Id: <20260909132431.7CB011F00AC4@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Healthy pages within a memory block containing a poisoned page are=
 completely leaked, preventing memory offlining.
- [Medium] Concurrent non-atomic updates to per-node memory failure statist=
ics (mf_stats) cause lost updates and corrupted counters.
- [Medium] Memory block poison accounting is skipped during memory hotplug,=
 breaking block-level poison tracking and causing global counter leaks.
- [Medium] Boot-poisoned pages lack the MAGIC_HWPOISON marker, breaking unp=
oison_memory() logic and causing a memory leak on unpoison.
- [Medium] TOCTOU race when setting the HWPoison flag during memory hotplug=
, potentially causing double accounting of memory failure stats.
--

commit 804f678a0cc93ac88d9e22aff45a011384c3ac87
Author: Breno Leitao <leitao@debian.org>

mm/memory-failure: keep inherited poisoned frames out of the buddy allocator

This commit checks if pages being given to the allocator are poisoned and m=
arks
them accordingly. It hooks into __free_pages_core() so poisoned frames never
enter the buddy allocator. A new function hwpoison_boot_page() is used to s=
et
the appropriate state for these pages.

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d9b8be696aac3..f6afdb2a89a94 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c

[ ... ]

> +static void update_per_node_mf_stats(unsigned long pfn, enum mf_result r=
esult);
> +
> +/* Not num_poisoned_pages_inc(): its per block half divides by zero this=
 early. */
> +void __meminit hwpoison_boot_page(struct page *page)
> +{
> +	if (PageHWPoison(page))
> +		return;
> +
> +	SetPageHWPoison(page);

[Severity: Medium]
Could a concurrent hardware MCE race with hwpoison_boot_page() here? During
memory hotplug, this path checks PageHWPoison(page) and then non-atomically
calls SetPageHWPoison(page). This might lead to both paths setting the flag
and double accounting in both global and per-node memory failure statistics.

> +	set_page_count(page, 1);
> +	/* The page has been completely isolated =3D=3D MF_RECOVERED */

[Severity: Medium]
Does this code need to call SetPageHWPoisonTakenOff(page) here? Without the
MAGIC_HWPOISON marker, if unpoison_memory() is called on a boot-poisoned
page, it might not properly recognize the page as having been taken off the
buddy allocator, potentially causing a permanent memory leak on unpoison.

> +	update_per_node_mf_stats(page_to_pfn(page), MF_RECOVERED);

[Severity: Medium]
Are the non-atomic increments inside update_per_node_mf_stats() safe when
called concurrently during boot? Since __free_pages_core() can be executed
concurrently by multiple kthreads, the unprotected non-atomic increments li=
ke
++mf_stats->recovered might lead to corrupted per-node memory failure
statistics.

> +	atomic_long_inc(&num_poisoned_pages);

[Severity: Medium]
Does bypassing num_poisoned_pages_inc() here break memory hot-remove
accounting? By calling atomic_long_inc(&num_poisoned_pages) instead of
num_poisoned_pages_inc(), the hotplug memory block's nr_hwpoison counter is
left at 0. If the block is later hot-removed, the global num_poisoned_pages
counter would not be decremented properly.

> +}
> +
>  /**
>   * MF_ATTR_RO - Create sysfs entry for each memory failure statistics.

[ ... ]

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 404896b53003e..9e2ce833fd409 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c

[ ... ]

> @@ -1613,6 +1626,18 @@ void __meminit __free_pages_core(struct page *page=
, unsigned int order,
>  		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>  	}
> =20
> +	/* First: a block parked by __free_unaccepted() never returns here. */
> +	if (range_contains_poisoned_memory(page_to_phys(page),
> +					   PAGE_SIZE << order)) {
> +		poison_block(page, order);
> +		/*
> +		 * TODO: free the frames in the block that are not poisoned.
> +		 * They stay out of the allocator and still count in
> +		 * managed_pages, so a unit costs up to a block.
> +		 */
> +		return;
> +	}

[Severity: High]
Does this early return completely leak the unpoisoned pages within the memo=
ry
block? By returning early and bypassing __free_pages_ok(), the healthy pages
in the block are not returned to the buddy allocator. Since these leaked
pages lack PageBuddy, PageOffline, or PageHWPoison, memory offlining
(test_pages_isolated) might permanently fail with -EBUSY for this block.

> +
>  	if (page_contains_unaccepted(page, order)) {
>  		if (order =3D=3D MAX_PAGE_ORDER && __free_unaccepted(page))
>  			return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-hwpoison-k=
ho-v4-0-359313564495@debian.org?part=3D5

