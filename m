Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57277C5B56A
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rk9UOpZ43Bg6UIPw6bOq+CDpdVOO/s9lEMnFfYVyJoA=; b=0EPORvwrgOIeTYOFrbVlA4z0l/
	3IJtoZrGFijv3+POqsK+l6VlA9/h6OfhnIdzWaNhm2rU1fw9ICKuMQXYa/73bZJyoPhKEfh3XEMFd
	o/0Lz2vh3gUnbJIa6bXGWHzaTVSjkQFn5TGOAC5LufjiVgreNiXqvUqnxQ2cCdqHH40LE8vw77emX
	Z+I33MQvIXxtcNV2hdS1oybpGNNLM2EFyiD1/vrbQtKvSghBMdP05Jcr9BPK1ZpTqVgg9gGDfQeiA
	ee5kqliROCTy4gIhOD0lZgLYnhqPT+fIz46evgkMYeEtObAMDnTphQ2laGpFOGE5yypqrBVoE//M9
	0J97tE+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtSvm-0000000CP1d-2YTS;
	Mon, 10 Aug 2026 16:32:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtSvl-0000000CP1H-3jjQ
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 16:32:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 488DC60052;
	Mon, 10 Aug 2026 16:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991251F000E9;
	Mon, 10 Aug 2026 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786379572;
	bh=Rk9UOpZ43Bg6UIPw6bOq+CDpdVOO/s9lEMnFfYVyJoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AhuyDLlYFJT9hF3iINS6yz/+oWRveYHiCtkc4o/LaMcyij/2v5EDHCKGrJc6xN0Du
	 Cvz/6AcB0JJWVbIWJLX3OkLynEUIoy7bPRy34dGl68az1bKkOsB/sdVJ/qOC9EfP89
	 qeXgERuQj3dD22+1DnCRqrnxP5Tjfvr0HDGKBJzb8ABUsxVt9BvASxV9EN8IOsSFuJ
	 S4aTqDUne214774iXtfFp18qzbjRP5f26WfPYwbM9VJMTtPk1K7dE7cSi5k7aPAWA9
	 aOeo3pn/eGyr9s90N0kawTXpJ2Cp6dO+oCkCrrzMjcnd8iVCUrjyf/enoSYO6ztuAf
	 IfKvDMvY2tL7A==
Date: Mon, 10 Aug 2026 19:32:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	rmikey@meta.com, riel@surriel.com, kernel-team@meta.com,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v5] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <ann9Kcesyb4T9Z8b@kernel.org>
References: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
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

Hi Breno,

On Mon, Aug 10, 2026 at 06:32:04AM -0700, Breno Leitao wrote:
> Memory failures (such as unrecoverable ECCs errors) are getting more and
> more common. The kernel knows how to handle it while running, marking it
> as poisoned (and SIGBUS user tasks).
> 
> Poisoned memory is removed from the buddy allocator, but, not from
> other places. A current problem is that kexec will load new kernel
> on top of a bad/poisoned memory, which is undesirable.
> 
> If the next kernel's image, initrd or purgatory lands on poisoned frame,
> the relocation copy writes to the bad memory and the machine checks

What does the machine check here? ;-)

> during the kexec.
> 
> Skip hardware-poisoned frames when placing segments: check them in the
> kexec_file hole finder so it lays the next kernel down on good memory,
> and reject a poisoned destination in sanity_check_segment_list() for
> the kexec_load path, which cannot relocate.
> 
> The two hole finders walk in opposite directions, so each asks for the
> end of the poison it has to clear: the top-down walk for the first
> poisoned page in the window, the bottom-up walk for the last. A poisoned
> hugetlb folio counts in full, as hugetlb keeps the flag on the folio and
> the poisoned subpages on its raw hwpoison list.

I had hard time parsing these two paragraphs. Can you please add more human
touch to them?
 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d053..7ee8c9f078f6b 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -212,6 +212,16 @@ int sanity_check_segment_list(struct kimage *image)
>  	}
>  #endif
>  
> +	/*
> +	 * Reject destinations that land on hardware-poisoned memory: the
> +	 * relocation copy would machine-check on the bad frame.

Would cause machine-check exception?

> +	 */
> +	for (i = 0; i < nr_segments; i++) {
> +		if (range_first_hwpoison(image->segment[i].mem,
> +					 image->segment[i].memsz) != PHYS_ADDR_MAX)
> +			return -EHWPOISON;
> +	}
> +
>  	/*
>  	 * The destination addresses are searched from system RAM rather than
>  	 * being allocated from the buddy allocator, so they are not guaranteed
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d86..9ba6cc01af929 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -475,6 +475,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  {
>  	struct kimage *image = kbuf->image;
>  	unsigned long temp_start, temp_end;
> +	phys_addr_t poison;
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> @@ -504,6 +505,15 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		poison = range_first_hwpoison(temp_start, kbuf->memsz);
> +		if (poison != PHYS_ADDR_MAX) {
> +			/* we hit a poisoned page */
> +			if (poison < kbuf->memsz)
> +				return 0;

Won't we break out on the next iteration boundaries check? I.e.

		if (temp_start < start || temp_start < kbuf->buf_min)
			return 0;

> +			temp_start = poison - kbuf->memsz;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> @@ -520,6 +530,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  {
>  	struct kimage *image = kbuf->image;
>  	unsigned long temp_start, temp_end;
> +	phys_addr_t poison;
>  
>  	temp_start = max(start, kbuf->buf_min);
>  
> @@ -546,6 +557,13 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		poison = range_last_hwpoison(temp_start, kbuf->memsz);
> +		if (poison != PHYS_ADDR_MAX) {
> +			/* we hit a poisoned page */
> +			temp_start = poison + PAGE_SIZE;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a8b03e2920ba8..f3875680e7955 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -96,6 +96,47 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
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
> +
> +		cond_resched();

cond_resched() for every pfn is too much, isn't it?

> +
> +		if (!page || !is_page_hwpoison(page))
> +			continue;
> +
> +		if (first)
> +			return PFN_PHYS(pfn);
> +
> +		poison = PFN_PHYS(pfn);
> +	}
> +
> +	return poison;
> +}
> +
> +phys_addr_t range_first_hwpoison(phys_addr_t start, unsigned long size)
> +{
> +	return range_hwpoison(start, size, true);
> +}
> +
> +phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size)
> +{
> +	return range_hwpoison(start, size, false);
> +}
> +
>  /**
>   * MF_ATTR_RO - Create sysfs entry for each memory failure statistics.
>   * @_name: name of the file in the per NUMA sysfs directory.
> 
> ---
> base-commit: c5e32e86ca02b003f86e095d379b38148999293d
> change-id: 20260727-kexec_posioned-72bb0a4143a0
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

-- 
Sincerely yours,
Mike.

