Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B505606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UzmwZclV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V43TEX6F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0Epe+yalr0ncnNFeZXalmoB1ngEy5h1+ZCqluOO5m08=; b=UzmwZclVvrYGAQh1S1w6YogxD2
	F554xWwVqqyE2/fcSKOpuF5h0+Gg8LKQ59Pkmfpxdb0tY4V+tn0p7E/yH9oO+7mbwGQRFqhC2lQWi
	q1+JoviUtZLKeuZOeg0tNcU3FMZ08AjncerWFJYmWybwWH4+L1EUahZBEA2e4iQRdbV8TfwRg/y+Z
	9ndseE8UHXcUPHfkW/KFqbYdin1PxlqD0vLSdFUif6amuUFFo/gbFHjHOcWnDb16uf39VwPfrM1OT
	R4Zb00lzmUNrX7HDD00g2UHvqMVtpSh+oLIqsl1Me9DgvVLu5eOEmX0gpmZNhO75PMr5dHYMmXB6d
	7RqDc1jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMKg0-00000008YUT-1FcV;
	Thu, 29 Oct 2026 07:35:56 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMKfy-00000008YUM-3PR4
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 07:35:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E663760211;
	Thu, 29 Oct 2026 07:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135EB1F01825;
	Thu, 29 Oct 2026 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259353;
	bh=0Epe+yalr0ncnNFeZXalmoB1ngEy5h1+ZCqluOO5m08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V43TEX6Fw8eQjHoTKHC2CRjnughswM+IkpybdsCO33FGiISABle3TSCUtdt1TfgZq
	 3sAW4vI1itqPrr1APjhXZ2+WNM0GpELOy/iz6lHNCH1x67fMMjVvCPM1iCzBjpztZZ
	 +vANLaBPjgNZl6lOPZE8fT+fb7OJAXTU2/WYUH3uId87pAVR1tYrLsK8H0iiPVA2LZ
	 RvESoKXHo76HJUx1MFCdBo0JlI+nULCC7LyN3AtDbTITDzparVWWDKdwpAb700rNdu
	 sPBVj66V4DQodubdnKCLyPjO0hDmKnJ5Aah5iOhJOFbUSgfy3jwfoG69l66HZYPKI6
	 Rb9qyByArGDbQ==
Date: Thu, 29 Oct 2026 09:35:45 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com,
	graf@amazon.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] kexec: do not place the next kernel in a
 fixed-address CMA area
Message-ID: <auL3UW2InVqYU6Fs@kernel.org>
References: <20261014145731.3431527-1-radhey.shyam.pandey@amd.com>
 <20261014145731.3431527-2-radhey.shyam.pandey@amd.com>
 <2vxzh5i5orbv.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzh5i5orbv.fsf@kernel.org>
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

On Wed, Oct 28, 2026 at 03:03:16PM +0100, Pratyush Yadav wrote:
> On Wed, Oct 14 2026, Radhey Shyam Pandey wrote:
> 
> > kexec_alloc_contig() picks the destination of the next kernel out of the
> > default CMA area, and the next kernel then runs from there in place
> > instead of being copied out. That is only safe if the area will not exist
> > at the same address in the kernel being loaded.
> >
> > For an area whose base came from the device tree, it will. The loaded
> > kernel parses the same description, declares the range it is executing
> > from as a shared-dma-pool, and cma_activate_area() releases the pages
> > holding its own image to the page allocator.
> >
> > Distinguish the two cases. An area placed by cma_declare_contiguous_nid()
> > without a fixed base lands wherever this kernel found room, and the next
> > kernel repeats that search against its own memblock state, so it cannot
> > collide. Record the difference as CMA_FIXED_BASE and refuse to use such
> > an area for the payload, which leaves kexec_locate_mem_hole() to fall
> > back to the memblock hole search as it did before CMA placement existed.
> >
> > This is what makes the KEXEC_FILE_NO_CMA flag unnecessary on platforms
> > that describe their CMA pools in the device tree.
> >
> > Tested on a AMD Versal AI Edge Series Gen 2 VEK385 Evaluation Kit whose
> > device tree declares three CMA pools, the first of which is
> > linux,cma-default:
> >
> >   cma_reserved@800000000     4 GiB at 0x800000000    (default)
> >   cma_reserved@50000000000   6 GiB at 0x50000000000
> >   cma_reserved@60000000000   4 GiB at 0x60000000000
> >
> > All three have a fixed base, so kexec_alloc_contig() declines the default
> > area and kexec_locate_mem_hole() falls through to the memblock search,
> > which places the Image segment at 0x9c00000 size 0x1de0000. The kernel
> > that boots from it reports its image as [0x09c00000-0x0b9e0000] and
> > 14680064K cma-reserved, i.e. all three pools still present and none of
> > them overlapping the running kernel.
> >
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
> >  include/linux/cma.h | 10 ++++++++++
> >  kernel/kexec_file.c | 12 ++++++++++++
> >  mm/cma.c            | 16 ++++++++++++++++
> >  mm/cma.h            |  2 ++
> >  4 files changed, 40 insertions(+)
> >
> > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > index 8555d38a97b1..2fe66377e5d3 100644
> > --- a/include/linux/cma.h
> > +++ b/include/linux/cma.h
> > @@ -61,4 +61,14 @@ extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
> >  extern bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end);
> >  
> >  extern void cma_reserve_pages_on_error(struct cma *cma);
> > +
> > +#ifdef CONFIG_CMA
> > +bool cma_has_fixed_base(const struct cma *cma);
> > +#else
> > +static inline bool cma_has_fixed_base(const struct cma *cma)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  #endif
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index b668ce8d68ee..10e770bcee0b 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/kexec_handover.h>
> > +#include <linux/cma.h>
> >  #include "kexec_internal.h"
> >  
> >  #ifdef CONFIG_KEXEC_SIG
> > @@ -691,6 +692,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
> >  static int kexec_alloc_contig(struct kexec_buf *kbuf)
> >  {
> >  	size_t nr_pages = kbuf->memsz >> PAGE_SHIFT;
> > +	struct cma *cma;
> >  	unsigned long mem;
> >  	struct page *p;
> >  
> > @@ -702,6 +704,16 @@ static int kexec_alloc_contig(struct kexec_buf *kbuf)
> >  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> >  		return -EPERM;
> >  
> > +	/*
> > +	 * The next kernel runs from here rather than being copied out, so it
> > +	 * would declare this area again from the same description and release
> > +	 * the pages holding its own image to the page allocator. Only an area
> > +	 * this kernel placed itself is safe to use.
> > +	 */
> > +	cma = dev_get_cma_area(NULL);
> > +	if (!cma || cma_has_fixed_base(cma))
> > +		return -EOPNOTSUPP;
> > +
> >  	p = dma_alloc_from_contiguous(NULL, nr_pages, get_order(kbuf->buf_align), true);
> >  	if (!p)
> >  		return -ENOMEM;
> > diff --git a/mm/cma.c b/mm/cma.c
> > index a10ea37a261d..1f4d3d48a3bb 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -55,6 +55,19 @@ const char *cma_get_name(const struct cma *cma)
> >  }
> >  EXPORT_SYMBOL_GPL(cma_get_name);
> >  
> > +/**
> > + * cma_has_fixed_base() - was the area placed at an address it did not choose?
> > + * @cma: Contiguous memory region
> > + *
> > + * Such an area is described outside the kernel, typically by a device tree
> > + * reserved-memory node, and so lands at the same address in every kernel
> > + * booted with that description.
> > + */
> > +bool cma_has_fixed_base(const struct cma *cma)
> > +{
> > +	return test_bit(CMA_FIXED_BASE, &cma->flags);
> > +}
> > +
> >  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
> >  					     unsigned int align_order)
> >  {
> > @@ -304,6 +317,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
> >  	cma->ranges[0].count = cma->count;
> >  	cma->nranges = 1;
> >  	cma->nid = NUMA_NO_NODE;
> > +	set_bit(CMA_FIXED_BASE, &cma->flags);
> >  
> >  	*res_cma = cma;
> >  
> > @@ -517,6 +531,8 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
> >  	}
> >  
> >  	(*res_cma)->nid = nid;
> > +	if (!fixed)
> > +		clear_bit(CMA_FIXED_BASE, &(*res_cma)->flags);
> 
> Nit: This reads a bit odd. cma_init_reserved_mem() sets the fixed base
> and then you clear it later. Wouldn't it be better to just pass the
> fixed boolean to cma_init_reserved_mem()?

Actually, we shouldn't expose cma_init_reserved_mem() at all.

The current callers of cma_init_reserved_mem() should be switched to
cma_declare_contiguous_nid() that does sanity checks before calling
cma_init_reserved_mem().

This way the callers won't need to keep the checks for e.g
CMA_MIN_ALIGNMENT and we'll have the clear way to differentiate areas with
fixed based from allocated ones.
 
> With that fixed,
> 
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> 
> >  	*basep = base;
> >  
> >  	return 0;
> > diff --git a/mm/cma.h b/mm/cma.h
> > index 68e574b0f951..1bab24033284 100644
> > --- a/mm/cma.h
> > +++ b/mm/cma.h
> > @@ -80,6 +80,8 @@ enum cma_flags {
> >  	CMA_ZONES_VALID,
> >  	CMA_ZONES_INVALID,
> >  	CMA_ACTIVATED,
> > +	/* Base address was dictated by the caller, not picked by CMA. */
> > +	CMA_FIXED_BASE,
> >  };
> >  
> >  extern struct cma cma_areas[MAX_CMA_AREAS];
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

