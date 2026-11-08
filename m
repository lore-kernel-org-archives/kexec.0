Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9F606A323
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e0hsH8hk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th5tIDew
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5GTPSw8yoiId+WhJTx6l9BtpcfJ94gwfuNXWiBrjWA4=; b=e0hsH8hkhRmBJ12AlYNlVD644l
	tbLv6Pac9Mi8D9XtLypn6BUXCCjG0GTAKBjeXR9MOd1ysdQ+3TKdRmHL7zFU3CAyvQeeaUYleYRlb
	+sVFiLAOoSMDeC9awLDyz40JcXKg+BPgomZFia/mFHDFaDw7eCaAXW0IRiAOEMifdVe+P91iHYjPy
	xLNpTmP90rcL/ZiWwyCUmSDlyWgaeC4jMkB1GEzc41f1pl1Icugv0HiHNdEIG7qwQ6DMWVonoK8dj
	r/FKs0IW/fJImMBu2+h7sAiO+ppIcL0ue2LerGKKEnhOagA3GIY1VcYpBBLERIpDav8ULr3MYlYI0
	8/024o8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ0iB-0000000G1bw-3VkJ;
	Sun, 08 Nov 2026 11:05:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ0iA-0000000G1bU-0Gcx
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 11:05:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ACE1E42A06;
	Sun,  8 Nov 2026 11:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7741F1F0089F;
	Sun,  8 Nov 2026 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794135921;
	bh=5GTPSw8yoiId+WhJTx6l9BtpcfJ94gwfuNXWiBrjWA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Th5tIDewprZendX4fGigw2vL+8B1sr/APy/gtFAfVfQbS6Lk2IhTZpZA5WLxIvgtJ
	 j/L5UqaKKe48k3fkMYGmV6bII35mRZZbn6CwZnuzuiCAzemSUUXvNoELHQ2ONuX4iL
	 UTro6N5WVRrvVYbuoHwHPeoK3huWHGz9+LEO25VRTXpW3BkKMf5L0mJDWuZFvZCaLp
	 rQIs2ITzWhuEBZJtF9A+ErJoBM+350SBMkJ6vpoNJHIa18H8plUq/3CaNZWmHMywZd
	 VKrluIioL8pbB880mGbp917rCZDAWn59BtwIBa7rEcyQJRC3/MQeiSi2IX/BKMHJSb
	 gTOT1W1JropBQ==
Date: Sun, 8 Nov 2026 13:05:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	baoquan.he@linux.dev, pasha.tatashin@soleen.com,
	pratyush@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, kexec@lists.infradead.org
Subject: Re: [PATCH 3/4] mm/cma: reject CMA areas that overlap the kernel
 image
Message-ID: <avBXZ8iW2XPyVbmF@kernel.org>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
 <20261103162429.2053989-4-radhey.shyam.pandey@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103162429.2053989-4-radhey.shyam.pandey@amd.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Nov 03, 2026 at 09:54:28PM +0530, Radhey Shyam Pandey wrote:
> cma_init_reserved_mem() takes a base chosen by its caller and only requires
> that the range already be reserved, so an overlap with the kernel image is
> indistinguishable from the normal case. cma_activate_area() then clears
> PageReserved on those pages and frees them into MIGRATE_CMA, overriding the
> memblock_reserve() of [_text, _end), so live kernel text reaches userspace.
> kexec reached this until the fix this series builds on; a device tree
> placing a shared-dma-pool over where the bootloader loaded the kernel still
> can. Reject the overlap rather than let such a caller corrupt the kernel.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes since RFC:
> - Drop Pratyush reviewed-by tag as there were few changes.
> - Trim the commit description.
> - Drop the redundant comment as suggested by Mike.
> - cma_overlaps_kernel_image() is kept as helpers in asm-generic/sections.h
>   are virtual-address helpers.
> ---
>  mm/cma.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 9c53b2b70dc8..3231a53161cd 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -31,6 +31,8 @@
>  #include <linux/kmemleak.h>
>  #include <trace/events/cma.h>
>  
> +#include <asm/sections.h>

You probably don't need this.

> +
>  #include "internal.h"
>  #include "cma.h"
>  #include "mm_init.h"
> @@ -68,6 +70,16 @@ bool cma_has_dynamic_base(const struct cma *cma)
>  	return test_bit(CMA_DYNAMIC_BASE, &cma->flags);
>  }
>  
> +static bool cma_overlaps_kernel_image(phys_addr_t base, phys_addr_t size)
> +{
> +	phys_addr_t end;
> +
> +	if (check_add_overflow(base, size, &end))
> +		return true;
> +
> +	return base < __pa_symbol(_end) && __pa_symbol(_text) < end;
> +}
> +
>  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>  					     unsigned int align_order)
>  {
> @@ -295,6 +307,15 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  	if (!size || !memblock_is_region_reserved(base, size))
>  		return -EINVAL;
>  
> +	if (cma_overlaps_kernel_image(base, size)) {
> +		phys_addr_t text = __pa_symbol(_text);
> +		phys_addr_t end = __pa_symbol(_end);
> +
> +		pr_err("area %s (%pa, size %pa) overlaps kernel image [%pa-%pa]\n",
> +		       name ?: "(unnamed)", &base, &size, &text, &end);

We don't want to expose addresses of the kernel image.
I'd drop text, end, and probably even base from the printout.

> +		return -EBUSY;
> +	}
> +
>  	/*
>  	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
>  	 * needs pageblock_order to be initialized. Let's enforce it.
> -- 
> 2.44.4
> 

-- 
Sincerely yours,
Mike.

