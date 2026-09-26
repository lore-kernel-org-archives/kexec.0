Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B377BC98318
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0MN7/YNmFykM+Q/E4Xx2sgObdvP7k1Pyx2eBjEnQm+E=; b=xsGySzSMU+c5GpkS+M9CDDw/kw
	BWemxtno2LFzdQPQCqzoD0YSgZsMRxsmYnmoX9NwAf9yMeaUxC2D1ELFGn+H/wpCvhPenPKIiwr0h
	tuhvWVPv7kD0ARzZk4NXIQiVUwI+0LoVNTJDJqlEV/nDMgtwAMBryG2Wu/FHANVxB1atYhNs7KzvZ
	kAHikq4/XObQ0pLkQbBPJYAS89Q0myEAxTW75cIFXq+sjf5sdfKS9H+T5KVNQ4JR2lCWa4g8xuoA2
	yRzr1ylHEZsrk9ydX7w3OOIQ+NVNRALzHmnULJdUe7+nDoAd50JyUCptCjL9wxFOGIhz6oX/qmvMP
	oYg96Mlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAON7-0000000FBVE-3V7J;
	Sat, 26 Sep 2026 09:07:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAON6-0000000FBUt-0z8U
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 09:07:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9964543EEC;
	Sat, 26 Sep 2026 09:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491B71F000FF;
	Sat, 26 Sep 2026 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790413623;
	bh=0MN7/YNmFykM+Q/E4Xx2sgObdvP7k1Pyx2eBjEnQm+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lf0MJXkUoYjmOO8Zwb8vIvA5uxqyFRr42qmD8bpiiuuc+YlAQbA5FZg6WmohA2S2W
	 BcPl9Ua2Y0vA4e5sWNQ3N6sorsf4zmkGr6JurTKOEYK2RyUDThaUTviF8/8BfUJI/p
	 8Y4Z+1XRSq0Vk1au3yRFRfptTt1kf1NiZ5T5g//k6ePXa/exIUNtQWRqREzz8jscJU
	 fH+5pnTW869euEUnAZfj/UmTB5EJDr9D7CJC0N1XSRyWETcOOFTKXG7X0rmY6kKoRv
	 hVimUOo8K8gOAtJioFv225DwUSJ/4Je4ZgWAWEl5vBmdYO0/4AftlodYCTfj+23udv
	 ecAcwpbb0lQ8Q==
Date: Sat, 26 Sep 2026 12:06:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	George Guo <guodongtai@kylinos.cn>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: fix global scratch size calculation
Message-ID: <areLMLTC-bO1zcXP@kernel.org>
References: <20260922131217.698809-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922131217.698809-1-sourabhjain@linux.ibm.com>
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

Hi Sourabh,

On Tue, Sep 22, 2026 at 06:42:16PM +0530, Sourabh Jain wrote:
> KHO calculates the global scratch size based on memblock-reserved kernel
> memory. It passes NUMA_NO_NODE to memblock_reserved_kern_size() for
> this calculation.
> 
> When memblock_reserved_kern_size() is called with NUMA_NO_NODE, it
> counts both:
> 
> - memory reserved for a specific NUMA node
> - memory reserved with NUMA_NO_NODE
> 
> KHO needs to distinguish between these two types of reservations.
> When calculating the size of global scratch memory, KHO only needs to
> account for reservations made with NUMA_NO_NODE. Reservations made for
> a specific NUMA node must not be included in the global scratch size.
> 
> Add memblock_reserved_size_nid() to calculate reserved memory for a
> given reservation type and NUMA node. When NUMA_NO_NODE is passed, it
> counts only memory reserved with NUMA_NO_NODE.
> 
> Use the new API for lowmem, global, and per-node KHO scratch size
> calculations. For lowmem and global scratch, count only memory
> reservations that were made with NUMA_NO_NODE. For per-node scratch,
> count only memory reservations that were made with the corresponding
> NUMA node ID.
> 
> Remove memblock_reserved_hugetlb_size() since it has the same
> implementation as the new API and differs only in the memblock
> reservation flag being checked. The new API handles both kernel and
> HugeTLB reservations through its reservation type argument.
> 
> Define the new helper as a static function in the KHO implementation,
> since it is only used by KHO and has no users outside
> kernel/liveupdate/kexec_handover.c.
> 
> On powerpc, the difference can be seen in the scratch_len values
> reported by:
> 
> cat /sys/kernel/debug/kho/out/scratch_len
> 
> Before this change, the global scratch allocation was 0x12000000
> (288 MB):
> 
> 0x1000000   (16 MB)
> 0x12000000  (288 MB)  <- global allocation
> 0x5000000   (80 MB)
> 
> After this change, the global scratch allocation is 0xd000000
> (208 MB):
> 
> 0x1000000   (16 MB)
> 0xd000000   (208 MB)  <- global allocation
> 0x5000000   (80 MB)
> 
> The 80 MB difference is the per-node reservation that was previously
> being included in the global allocation.
> 
> The same issue also affects lowmem scratch memory, but its impact is
> limited because the lowmem scratch memory calculation is restricted to
> the first 4G of memory. The changes also cover the lowmem scratch
> memory case.
> 
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: George Guo <guodongtai@kylinos.cn>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  include/linux/memblock.h           |  1 -
>  kernel/liveupdate/kexec_handover.c | 49 ++++++++++++++++++++++--------
>  mm/memblock.c                      | 22 --------------
>  3 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d62db9e776cf..678fe466529a 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -487,7 +487,6 @@ static inline __init_memblock bool memblock_bottom_up(void)
>  phys_addr_t memblock_phys_mem_size(void);
>  phys_addr_t memblock_reserved_size(void);
>  phys_addr_t memblock_reserved_kern_size(phys_addr_t limit, int nid);
> -phys_addr_t memblock_reserved_hugetlb_size(phys_addr_t limit, int nid);
>  unsigned long memblock_estimated_nr_free_pages(void);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..dc809e1e768c 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -752,6 +752,31 @@ static int __init kho_parse_scratch_size(char *p)
>  }
>  early_param("kho_scratch", kho_parse_scratch_size);
>  
> +static phys_addr_t __init_memblock memblock_reserved_size_nid(phys_addr_t limit, int nid,
> +							      enum memblock_flags region_type)
> +{

Why is this in kexec_handover.c and not in memblock.c?

> +	struct memblock_region *r;
> +	phys_addr_t total = 0;
> +
> +	for_each_reserved_mem_region(r) {
> +		phys_addr_t size = r->size;
> +
> +		if (r->base > limit)
> +			break;
> +
> +		if (r->base + r->size > limit)
> +			size = limit - r->base;
> +
> +#ifdef CONFIG_NUMA
> +		if (nid == memblock_get_region_node(r))
> +#endif

Do we really need the #ifdef here?

> +			if (r->flags & region_type)
> +				total += size;
> +	}
> +
> +	return total;
> +}
> +
>  static void __init scratch_size_update(void)
>  {
>  	/*

-- 
Sincerely yours,
Mike.

