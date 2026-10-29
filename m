Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B8606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wLs809MD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyhGWe6l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FnIFycVxPAWcUtQJVVl8WWNhkjZ3nGmUb3DoahAD2uA=; b=wLs809MDMpxxowoMCVJLtbB5RR
	wyrSouZjnqlY3j8MM6pFe8Opr1EzUlrO9udA9WSN7dQPZlBWZtVDkNPByunRd4+kTTN27zQva3Bj9
	H4fDuMGWuVWR8UnUrwitn1yQHtH4c50MlPcTJIztKU42iYxyU7HQhW8/t6BFRjlr0ZUuHoPajwNyS
	ylMIV1+djNpi/nRq4zQc/QbM+1wPmq5inFTUT5GsNCHxuz5Xqdj0tEntfmn0bpixnhvjc+yGS+jqL
	1G6KyKJkcK/AcH4TE0Ciwgfy0L+0LHa7kJG49FMsdTIK7rcEygG9C2PchGsbawyL3I4rYHTfWeayk
	gTNbRMQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMKmo-00000008ZTM-0eHx;
	Thu, 29 Oct 2026 07:42:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMKmk-00000008ZT4-1kj0
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 07:42:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A926B41A65;
	Thu, 29 Oct 2026 07:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9341E1F01825;
	Thu, 29 Oct 2026 07:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259773;
	bh=FnIFycVxPAWcUtQJVVl8WWNhkjZ3nGmUb3DoahAD2uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kyhGWe6lxVRHmY2A8+LGSw1PRADfLdQmrVkp+WhLyFDADBLYh8qf3hGC5GTEK+fSF
	 Jj/v3QEiuO7gjUpaIXVyTATrvvq9I6g4baEtUIVoGDwXpnF+o/TeEZDQiRMFkDcbew
	 ZQdVQCTzLEA+Hww6c13lr+LoMchRaHYwLVxQxOkIoM45XpeSdhHLX65djGGdiUJJ78
	 mJUA2Zlei2hoGSD4uWSuxwrH9OGr9GLofCzJqHLnu2IBvJKGUNupUdrj23PTU+bd9N
	 JJDt/fdMYbCWxRtaQV1Ol+ZTtK0g8tYLUsxvNcM7JRAyAW1XcCrcG5SkvYBx9Um9dk
	 0OmuuPIFH28Kw==
Date: Thu, 29 Oct 2026 09:42:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com,
	pratyush@kernel.org, graf@amazon.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] mm/cma: reject CMA areas that overlap the kernel
 image
Message-ID: <auL49EhsNL4jc1o3@kernel.org>
References: <20261014145731.3431527-1-radhey.shyam.pandey@amd.com>
 <20261014145731.3431527-3-radhey.shyam.pandey@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014145731.3431527-3-radhey.shyam.pandey@amd.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 08:27:31PM +0530, Radhey Shyam Pandey wrote:
> cma_init_reserved_mem() takes a base address chosen by its caller and
> requires that the range already be reserved. That makes an overlap with
> the kernel image indistinguishable from the normal case by looking at
> memblock alone, yet such an area is fatal: cma_activate_area() hands it
> to init_cma_reserved_pageblock(), which unconditionally clears
> PageReserved on every page and frees them into MIGRATE_CMA, overriding
> the memblock_reserve() of [_text, _end) that the architecture installed.
> Those pages satisfy ordinary movable allocations from that point on, so
> userspace is handed live kernel text.
> 
> The preceding patch closes the way this is reachable today, where a
> kexec'd kernel runs from inside the default CMA area and then declares
> the range it is executing from as a shared-dma-pool. On a VEK385 that
> reproduced within ~300ms of /sbin/init starting, as a copy-on-write
> fault writing to the read-only linear alias of .text:
> 
>   Unable to handle kernel write to read-only memory at virtual address ffff00084030c000
>   Call trace:
>    copy_page+0x48/0xc4 (P)
>    copy_user_highpage+0x14/0x30
>    __handle_mm_fault+0x318/0x1340
> 
> Dynamically placed areas cannot hit this: __cma_declare_contiguous_nid()
> either rejects a fixed base that is already reserved, or picks an address
> itself and so avoids the kernel image. Only a caller that passes a base
> chosen elsewhere can, so check for the overlap explicitly rather than
> leave the next such caller to corrupt the kernel silently.
> 
> Note that failing here is not by itself sufficient for a device-tree
> pool. fdt_init_reserved_mem_node() responds to an error from a non-nomap
> region by calling memblock_phys_free() on the whole range, which drops
> the kernel image's own reservation along with it, so the pages are still
> released - as plain free memory rather than MIGRATE_CMA. Callers that
> keep their reservation on failure, such as powerpc's fadump_cma_init(),
> are fully protected. For the device-tree path this is a diagnostic and a
> second line of defence behind the preceding patch.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  mm/cma.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 1f4d3d48a3bb..32b799a3f5c8 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -31,6 +31,8 @@
>  #include <linux/kmemleak.h>
>  #include <trace/events/cma.h>
>  
> +#include <asm/sections.h>
> +
>  #include "internal.h"
>  #include "cma.h"
>  #include "mm_init.h"
> @@ -68,6 +70,11 @@ bool cma_has_fixed_base(const struct cma *cma)
>  	return test_bit(CMA_FIXED_BASE, &cma->flags);
>  }
>  
> +static bool cma_overlaps_kernel_image(phys_addr_t base, phys_addr_t size)
> +{
> +	return base < __pa_symbol(_end) && __pa_symbol(_text) < base + size;
> +}

We have helpers for that in include/asm-generic/sections.h

> +
>  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>  					     unsigned int align_order)
>  {
> @@ -295,6 +302,22 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  	if (!size || !memblock_is_region_reserved(base, size))
>  		return -EINVAL;
>  
> +	/*
> +	 * The area being already reserved is expected here, so an overlap with
> +	 * the kernel image cannot be told apart from the normal case by looking
> +	 * at memblock alone. Check for it explicitly: activating such an area
> +	 * clears PageReserved on the kernel's own text and data and releases
> +	 * them to the page allocator.
> +	 */

I don't think this comment is useful, the check itself is clear enough.

> +	if (cma_overlaps_kernel_image(base, size)) {
> +		phys_addr_t text = __pa_symbol(_text);
> +		phys_addr_t end = __pa_symbol(_end);
> +
> +		pr_err("area %s (%pa, size %pa) overlaps kernel image [%pa-%pa]\n",
> +		       name ?: "(unnamed)", &base, &size, &text, &end);
> +		return -EBUSY;
> +	}
> +

With removing cma_init_reserved_mem() from API this would move to
__cma_declare_contiguous_nid().

>  	/*
>  	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
>  	 * needs pageblock_order to be initialized. Let's enforce it.
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

