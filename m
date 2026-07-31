Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE3BC5516F
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+IlztmyqYuuXlGVT0cph9tanuKKLkq7z25QvgzYv6g=; b=P4XarRKs98JtMWLNT9tQsFB9XD
	BQr7+JpIdejmcjTvCtnlINYPIFaAR9y1lbED4URhqiPf31/cYrysffCFmJTnhh9B8XVAaPtggkm+U
	gfJ2kQXo4W2gf8t3liIRKN31WEPRBXN7SXepzTAbqlCGlbPvgGe7XQ/o5xmKWCnrGcJ49tN6ipf4r
	9RHjW6U0K8CUGUQbDEOsxZ/3twSw09ftpQMEkZsumuwaSIceS2TuV0ehE7tUATr4/d8aLtQskIR4I
	OCzqS9+4sf1jFob5t4KrQEHYmCasgNnCVvSRMmmNICB5D0/jryH3hGEOCh0D/Va/noSqq7yZJ/ZRt
	b6WhzcyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wprMU-0000000DHn6-2vAr;
	Fri, 31 Jul 2026 17:49:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wprMT-0000000DHmy-3xFI
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 17:49:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 894B6600C3;
	Fri, 31 Jul 2026 17:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30A01F00AC4;
	Fri, 31 Jul 2026 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785520172;
	bh=/+IlztmyqYuuXlGVT0cph9tanuKKLkq7z25QvgzYv6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JYtB/zJEZ0LkWBkIp7+O/oltIUsdXqYZq0qhsQUFYpPDn/qFOCinYN9gucrzMUyl8
	 tJd4nZ5wkcviTVyevyDvtTy4n3fp7v7omMHe53yF1q7tAonA78OLe0XskXfmrVb9Tm
	 tkd65uNjWxX8hayREMZ/2mWr0WdmsUvEwNhgXe5U5KL85WIsWGnoE9wM6k0bBaVbU+
	 OnuwKMMxSQhvUDP+9bdEwJMA/ba5xoLaG28zpQ+l7L4mnJMGrfTxJMoYIbtahMYMoY
	 +gFwy5k2OxVm6YAef1tm0l2LR4AZAeYwnXolbHiAxE9Foy/lQKx8Vmywv/9fLDYM/5
	 PghZrsHzacl9Q==
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
Subject: Re: [PATCH v2] kexec: keep the next kernel off hardware-poisoned pages
In-Reply-To: <20260730-kexec_posioned-v2-1-f92d18551f64@debian.org> (Breno
	Leitao's message of "Thu, 30 Jul 2026 08:55:50 -0700")
References: <20260730-kexec_posioned-v2-1-f92d18551f64@debian.org>
Date: Fri, 31 Jul 2026 19:49:27 +0200
Message-ID: <2vxzecgj6od4.fsf@kernel.org>
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

On Thu, Jul 30 2026, Breno Leitao wrote:

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
>
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://patch.msgid.link/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org
> ---
>  include/linux/mm.h  |  8 ++++++++
>  kernel/kexec_core.c | 10 ++++++++++
>  kernel/kexec_file.c | 19 +++++++++++++++++++
>  mm/memory-failure.c | 28 ++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7fabe6c66b4b7..48cad9a519d08 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -5192,6 +5192,8 @@ extern const struct attribute_group memory_failure_attr_group;
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  void num_poisoned_pages_inc(unsigned long pfn);
>  void num_poisoned_pages_sub(unsigned long pfn, long i);
> +bool range_contains_hwpoison(phys_addr_t start, unsigned long size,
> +			     phys_addr_t *poison);
>  #else
>  static inline void memory_failure_queue(unsigned long pfn, int flags)
>  {
> @@ -5204,6 +5206,12 @@ static inline void num_poisoned_pages_inc(unsigned long pfn)
>  static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
>  {
>  }
> +
> +static inline bool range_contains_hwpoison(phys_addr_t start, unsigned long size,
> +					   phys_addr_t *poison)
> +{
> +	return false;
> +}
>  #endif
>  
>  #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d053..9f6ed3c04299b 100644
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
> +					    image->segment[i].memsz, NULL))
> +			return -EADDRNOTAVAIL;
> +	}
> +
>  	/*
>  	 * The destination addresses are searched from system RAM rather than
>  	 * being allocated from the buddy allocator, so they are not guaranteed
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d86..95cc981a557be 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -475,6 +475,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  {
>  	struct kimage *image = kbuf->image;
>  	unsigned long temp_start, temp_end;
> +	phys_addr_t poisoned_addr;
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> @@ -504,6 +505,14 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		if (range_contains_hwpoison(temp_start, temp_end - temp_start + 1,
> +					    &poisoned_addr)) {
> +			if (poisoned_addr < kbuf->memsz)
> +				return 0;
> +			temp_start = poisoned_addr - kbuf->memsz;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> @@ -520,6 +529,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  {
>  	struct kimage *image = kbuf->image;
>  	unsigned long temp_start, temp_end;
> +	phys_addr_t poisoned_addr;
>  
>  	temp_start = max(start, kbuf->buf_min);
>  
> @@ -546,6 +556,15 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		/*
> +		 * Avoid placing the next kernel on hardware-poisoned memory.
> +		 */
> +		if (range_contains_hwpoison(temp_start, temp_end - temp_start + 1,
> +					    &poisoned_addr)) {
> +			temp_start = poisoned_addr + PAGE_SIZE;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a8b03e2920ba8..04a1883d51fda 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -96,6 +96,34 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
>  		memblk_nr_poison_sub(pfn, i);
>  }
>  
> +/*
> + * Return true if any online page in [start, start + size) is hardware
> + * poisoned.  On a hit, when @poison is not NULL, @poison is set to the
> + * address of the first poisoned page, which is ugly, but I cannot only

Won't the last page be better? If two poisoned pages land in the range,
you'd like to search past the last one.

> + * return phys_addr_t, thus this "extra" parameter, instead of returning
> + * the hit.
> + */
> +bool range_contains_hwpoison(phys_addr_t start, unsigned long size,
> +			     phys_addr_t *poison)

Perhaps

    phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size)  ?

And if no poisoned page lands here then a default of 0 or ~0UL?

> +{
> +	unsigned long pfn, end_pfn;
> +
> +	if (!size || !atomic_long_read(&num_poisoned_pages))
> +		return false;
> +
> +	end_pfn = PHYS_PFN(start + size - 1);
> +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> +		struct page *page = pfn_to_online_page(pfn);
> +
> +		if (page && PageHWPoison(page)) {
> +			if (poison)
> +				*poison = PFN_PHYS(pfn);
> +			return true;
> +		}
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

