Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF6EC53200
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3MHqEoaGOKzk9Iff8e6HT/j15eXEiVkvdlAAoZTG4f4=; b=VorHPoBqH1yZd2VuW9iL4yIYWl
	6RnwKSwmLwNkgSCq5nAGw060EtQmuzr902DYhBhPockQOqyI71vNfvv0f6980llCsefiGlaLYmYpi
	x76sa+SPzta9cNfGRoAW2JwWTTDeAhpw8WQXQrquGPeujBgnAPf2AQXpGrwJk26241SPwIFzow5cR
	juYtL1LDQZohyBl7QcWv3lL7FzzuA1fCS+fgOjal47eWDbLfwJf+vDzDTAc+0VczYATdVYCl1r2z8
	+995C6Fwei8TofCXZ/vSkJAfSUG4oR+2KH7nd2xWXYb4GwlehLB3G0wRhIszv6eSaDn3GZQZrykC3
	xChTTTcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2uK-00000007o2B-2ZYq;
	Wed, 29 Jul 2026 11:57:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2uJ-00000007o1p-0dfG
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 11:57:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 840CC4372C;
	Wed, 29 Jul 2026 11:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC831F00A3A;
	Wed, 29 Jul 2026 11:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785326226;
	bh=3MHqEoaGOKzk9Iff8e6HT/j15eXEiVkvdlAAoZTG4f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Xmqcde07rhKigYnfqfFgM+V+S+G84iFflTUPnnW/QqFBYoRduAW8DmMEfmXZSQykI
	 WnH65KFGJIkuFfiuyYkqXsvQ/hhyodbbvwwu52Ac0ZbYbHT+3ezeuvbHLaplBiVrKv
	 xbPSWI1/IZbgNO0XJVyxyzlsqlAu6a2rBiZCgk2vCIIZssY+eMW2ig08WE5YhIl1A3
	 4VLNqjmQ6Y5LnpCbVSo835Hq7YR9p777fGwgCWi0N1D9w3k2Bumh0cK7VdlN0R/bNj
	 /i7Jqyo0wzTGVFNQdPcjLBIPlsSga7RWsUJf8DyuivF6DX13R9Rr7xUuOZfP1cChW5
	 0MQzYsPyFAIzQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <ljs@kernel.org>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Baoquan He <baoquan.he@linux.dev>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Miaohe Lin <linmiaohe@huawei.com>,  Naoya Horiguchi
 <nao.horiguchi@gmail.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  rmikey@meta.com,  riel@surriel.com,  kernel-team@meta.com,  Kiryl
 Shutsemau <kas@kernel.org>
Subject: Re: [PATCH] kexec: keep the next kernel off hardware-poisoned pages
In-Reply-To: <20260728-kexec_posioned-v1-1-160c81d180fe@debian.org> (Breno
	Leitao's message of "Tue, 28 Jul 2026 09:22:57 -0700")
References: <20260728-kexec_posioned-v1-1-160c81d180fe@debian.org>
Date: Wed, 29 Jul 2026 13:57:01 +0200
Message-ID: <2vxz7bme80vm.fsf@kernel.org>
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

On Tue, Jul 28 2026, Breno Leitao wrote:

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
> during the kexec.
>
> Skip hardware-poisoned frames when placing segments: check them in the
> kexec_file hole finder so it lays the next kernel down on good memory,
> and reject a poisoned destination in sanity_check_segment_list() for
> the kexec_load path, which cannot relocate.

kexec_locate_mem_hole() uses kexec_alloc_contig() to try to find a
contiguous range from CMA. If found, it uses that and skips relocation.
Do you know if CMA tracks poisoned pages and skips allocating them?

sanity_check_segment_list() will catch these anyway and error out, but
would be nice if CMA can track poisoned pages in the first place.
Anyway, that is out of scope for this patch, but something you might
want to look into.

>
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/mm.h  |  6 ++++++
>  kernel/kexec_core.c | 10 ++++++++++
>  kernel/kexec_file.c | 14 ++++++++++++++
>  mm/memory-failure.c | 18 ++++++++++++++++++
>  4 files changed, 48 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7fabe6c66b4b7..a89108bcc3f90 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -5192,6 +5192,7 @@ extern const struct attribute_group memory_failure_attr_group;
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  void num_poisoned_pages_inc(unsigned long pfn);
>  void num_poisoned_pages_sub(unsigned long pfn, long i);
> +bool range_contains_hwpoison(phys_addr_t start, unsigned long size);
>  #else
>  static inline void memory_failure_queue(unsigned long pfn, int flags)
>  {
> @@ -5204,6 +5205,11 @@ static inline void num_poisoned_pages_inc(unsigned long pfn)
>  static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
>  {
>  }
> +
> +static inline bool range_contains_hwpoison(phys_addr_t start, unsigned long size)
> +{
> +	return false;
> +}
>  #endif
>  
>  #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d053..18793f925835f 100644
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
> +		if (range_contains_hwpoison(image->segment[i].mem,
> +					    image->segment[i].memsz))
> +			return -EADDRNOTAVAIL;
> +	}
> +
>  	/*
>  	 * The destination addresses are searched from system RAM rather than
>  	 * being allocated from the buddy allocator, so they are not guaranteed
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d86..cd77350f12f85 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -504,6 +504,13 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		/* Avoid placing the next kernel on hardware-poisoned memory */
> +		if (range_contains_hwpoison(temp_start,
> +					    temp_end - temp_start + 1)) {
> +			temp_start = temp_start - PAGE_SIZE;

Sashiko complains about this
https://sashiko.dev/#/patchset/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org:

    If we find a hardware-poisoned page within a large segment, does this loop in
    locate_mem_hole_top_down() cause a CPU soft lockup?

    Since temp_start is shifted by only PAGE_SIZE, the next iteration will call
    range_contains_hwpoison() again. As seen in mm/memory-failure.c, that
    function does a linear scan from the new start address:

    	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
    		if (pfn_valid(pfn) && PageHWPoison(pfn_to_page(pfn)))
    			return true;
    	}

    This means we could rescan almost the entire segment over and over until it
    finally moves past the poisoned page. For a very large segment like a 512MB
    initrd, this would iterate billions of times without yielding.

    Could range_contains_hwpoison() return the address of the poisoned page so
    the hole finder can skip past it efficiently?

Which does seem to make sense. Same problem below.

> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> @@ -546,6 +553,13 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		/* Avoid placing the next kernel on hardware-poisoned memory */
> +		if (range_contains_hwpoison(temp_start,
> +					    temp_end - temp_start + 1)) {
> +			temp_start = temp_start + PAGE_SIZE;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a8b03e2920ba8..032bb23db7566 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -96,6 +96,24 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
>  		memblk_nr_poison_sub(pfn, i);
>  }
>  
> +/*
> + * Check if any page in [start, start + size) has hardware-poisoned segments
> + */
> +bool range_contains_hwpoison(phys_addr_t start, unsigned long size)
> +{
> +	unsigned long pfn, end_pfn;
> +
> +	if (!size || !atomic_long_read(&num_poisoned_pages))
> +		return false;
> +
> +	end_pfn = PHYS_PFN(start + size - 1);
> +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> +		if (pfn_valid(pfn) && PageHWPoison(pfn_to_page(pfn)))
> +			return true;
> +	}
> +	return false;
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
>
> Breno Leitao <leitao@debian.org>
>

-- 
Regards,
Pratyush Yadav

