Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A228EC5AD4E
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+SkRVVFBnEWD5Uv1sCu0rIS7Pvrxt+IlmbSlVY+WN7Y=; b=TO3/pxyfKQfnzKg+Fd+O2Tl9Pa
	vdQ2EaQSqaUrFVEMsM3spmCip8gLPvAr+SFFfF3Etdep2msQJIxbHgzTwl4W26oU64N9+Q1Erm9Me
	ontOLarCsL+5AxPrUMQ04SAmH55t7Hkt3DTeXesx546kfLiLGFl11q9L5BRnqLGP5RU5bWBmT4Q4f
	iv76fEy4ItC2R8jz9wvjqEP7Xb22FYs3F8w2BWjkUt/TKBd4AL5ZekVmt1xyVgAniCMX8Vt9E3/S+
	7QuCyoMxeDiNaNNs2L/cpIheT2uxPDsI54Xejt89MsS+IVdJKCMmlmhjX5dJE0JRl8mmzqYY3uBHf
	Cvc5os0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtMdL-0000000BR6E-0e02;
	Mon, 10 Aug 2026 09:49:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtMdJ-0000000BR67-2UZ0
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 09:49:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C43043D43;
	Mon, 10 Aug 2026 09:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B111F00A3A;
	Mon, 10 Aug 2026 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786355364;
	bh=+SkRVVFBnEWD5Uv1sCu0rIS7Pvrxt+IlmbSlVY+WN7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wv/1X9ERDgtWjYDxjzZQQsH8DYErF0xSN/m1nsTerJ1Er+kroo9T/21BDk/j7AewG
	 mb2IJDCbaMfAABiZxqGXtWe5JStNGY6g0/WzmFXrx554ub8uhd/ljk/R+OWXnj3cp/
	 0tygfj2/ykqQIc+PBCczkCegW+aR7tcmzWLCT1SxdlBpBCcab2B4uHgg/Wvm3+ujcx
	 y6Xghqh0QnekpoJg3KSLMBFUs8G2mZiWSS4VeVJvhj/hxr72sfn6l/Iyuz8A2Oi/XI
	 X36EjV8hcVDySuD886VIh8l+yt1mrmxrYolrGduttG11EGbUV8UCoJuayodjM0Kfxw
	 d1BGVKDTr82WQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 295951980070;
	Mon, 10 Aug 2026 05:49:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 05:49:22 -0400
X-ME-Sender: <xms:np55ar1l-aHPos9U5GDLl5hYwTm7qdWJFyo8XYSTPt1sqS8vYicOIQ>
    <xme:np55an8lqTEzAiU6nGPZIiQtccrVTyYORD2hTZd8Trlknuos4yvZPJXQ4kHJ1-Y1G
    W8RVByBchNeBv2s-z-P0SlD89V9d5QwxfUIljZ70ntXeayeMbMLhheD>
X-ME-Received: <xmr:np55ak-Fnnvnnq6tfDHIhNzNeOl1ddR5u81vHIXw3U6DwCZAMFJjRd1KRBc>
X-ME-Proxy-Cause: dmFkZTFtndxpDvAd2Xc8GhLUujyEL1KRBU/KLtnlxPJZ7PwJKuizNvh0Z5nvw5UODqwllm
    V4MP/pzGB/+3yE3nyd/lTZP/DgxMaCzSp9LGMHqIIu5mW0q53R2kwdRWr/xnKVxR15lPSC
    6b/OyYNV6nBONIIr/iqg5mahro16YCqwYKiUDNTuj1ocDqtFiwahujtpDXS8/QEl3XAZQC
    56SNpjPa2MPTK7IwzS1MW+R5q4t+LW63JuusoKHkwFCrP7blr7f0yikhAdellsewTJzzVc
    AtFf/73lGdkx0+oyvTFwmDb2fmam7twddPl8c1I0F76DieNBdRAaxIqGNcDWsWNFhVYmk6
    tFPJssgPaanMKR0g5JNUTeSZpap8AVWgDRH6m9ouaqcRUvZ5DAc4z6uBq3qwaFGaFy+j8b
    rDWdAj4xmKJHMDe2hc6z4PPA6xyZA9BM50A67IBlmXVlMYlZnc8T1W75xqs7t0zVhPqEmz
    NevDSjJ2NtfeSGWwVymgzkAj0Zq3aPHtl+TAmYFHPzP9z+lLetaHhmaC7OYQlMQL9NXzo6
    5OlgE1tfBVtJmrb//XHvAY24EfEV1wlL1MrwWR4oI+8Be9WUdtOAwLoQx4SAIfo9cpncKU
    8/SMJs8PW0OzgA8cvO95mlFUTED6FWBB2SZeRXr7kiWpyFH6xcJmYOp+QxEg
X-ME-Proxy: <xmx:np55aiEaKhAztSCSslrJnrDpDkGNFELCNJiFtupfeFPwAXCfDnKiJQ>
    <xmx:np55amfI9jzmuhXm0uHv1ppTLwS84wPJz6Jrv5_NUHJh4xZOuwiJdA>
    <xmx:np55aplvVOISzBVBrLEav2PVtLLzRqJ7Ehrh0FFrhfG610vYrZ2RWg>
    <xmx:np55agp5ZdijI1sH-Z4Lobz29FtuW7Sv1UfOAAPOG_3pXSGotQMsfQ>
    <xmx:np55am-zCMrydn-RbeG9t0dC_-Aayrld788RTw4bVIaL26sWnyuJnp91>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 05:49:17 -0400 (EDT)
Date: Mon, 10 Aug 2026 10:49:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v4] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <anmb9FHMEMygENiO@thinkstation>
References: <20260807-kexec_posioned-v4-1-70d57f14625d@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-kexec_posioned-v4-1-70d57f14625d@debian.org>
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

On Fri, Aug 07, 2026 at 07:05:09AM -0700, Breno Leitao wrote:
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d053..e097e980b1439 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -212,6 +212,16 @@ int sanity_check_segment_list(struct kimage *image)
>  	}
>  #endif
>  
> +	/*
> +	 * Reject destinations that land on hardware-poisoned memory: the
> +	 * relocation copy would machine-check on the bad frame.
> +	 */
> +	for (i = 0; i < nr_segments; i++) {
> +		if (range_first_hwpoison(image->segment[i].mem,
> +					 image->segment[i].memsz) != PHYS_ADDR_MAX)
> +			return -EADDRNOTAVAIL;

Other -EADDRNOTAVAIL usage indicate error on user side. But this is not
a user fault. Maybe -EHWPOISON instead.

> +	}
> +
>  	/*
>  	 * The destination addresses are searched from system RAM rather than
>  	 * being allocated from the buddy allocator, so they are not guaranteed

...

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a8b03e2920ba8..c485e205fb633 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -96,6 +96,78 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
>  		memblk_nr_poison_sub(pfn, i);
>  }
>  
> +/*
> + * Return the first or the last hardware-poisoned online page in [start,
> + * start + size), or PHYS_ADDR_MAX if the range is clean.
> + */
> +static phys_addr_t range_hwpoison(phys_addr_t start, unsigned long size,
> +				  bool first)
> +{
> +	phys_addr_t poison = PHYS_ADDR_MAX;
> +	unsigned long pfn, end_pfn;
> +
> +	if (!size || !atomic_long_read(&num_poisoned_pages))
> +		return poison;
> +
> +	end_pfn = PHYS_PFN(start + size - 1);
> +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> +		struct page *page = pfn_to_online_page(pfn);
> +		struct folio *folio;
> +
> +		cond_resched();
> +
> +		if (!page)
> +			continue;
> +
> +		folio = page_folio(page);
> +		if (folio_test_hugetlb(folio)) {
> +			/*
> +			 * hugetlbfs is a bit special, given the poison
> +			 * information is at the folio, not at the page
> +			 */
> +			unsigned long folio_end;
> +
> +			/*
> +			 * No hugetlb_lock: the scan is racy either way, a frame
> +			 * can be poisoned right after it. Just don't let a folio
> +			 * dissolved under us walk the scan backwards.
> +			 */
> +			folio_end = folio_pfn(folio) + folio_nr_pages(folio) - 1;
> +			folio_end = max(folio_end, pfn);
> +
> +			if (folio_test_hwpoison(folio)) {
> +				if (first)
> +					return PFN_PHYS(pfn);
> +				poison = PFN_PHYS(min(folio_end, end_pfn));
> +			}
> +			/* skip all the pfns that belong to hugetlb */
> +			pfn = folio_end;
> +			continue;
> +		}
> +
> +		if (!PageHWPoison(page))
> +			/* page is good, let's go to the next one */
> +			continue;

If you don't care about re-using clean part of poisoned hugetlb folio,
use is_page_hwpoison(page).

This would do:

		if (!page || !is_page_hwpoison(page))
			continue;

You would spin a bit on the same folio, but shouldn't be a big deal.

> +
> +		if (first)
> +			return PFN_PHYS(pfn);
> +
> +		poison = PFN_PHYS(pfn);
> +	}
> +
> +	return poison;
> +}
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

