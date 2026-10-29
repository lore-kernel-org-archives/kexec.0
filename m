Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD84606A332
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ui1gjcNZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFv+lWO+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LC5OqSM2Vw9O+/4CpF3iB0BOHKBEOZXJi+4rnGuzDBs=; b=Ui1gjcNZu+5jA/tgrOC/z4sMyo
	3D9PgCGN4HIl/YpFEK2d1X8UdmB7lgiBAvQn9JzDJnpPYmnLjHfAYQ1hstiUjKA5kndtwsO+NFI7B
	tU1QBs2W+5whUWWHAfG7SWXEb+8/omcnTcUz/k5RsfLzyaDPNFnWgMbfQ7gO1B2rBIW+sTEmOVfFX
	kbtZR7A6szEnvPzfZz9CVEwFRSgWOhiRBPI5RLi5Mvwf8yON5UAtjC8Ag46hCuBTn1MA4PDeGo498
	9AvLLR8kzIo7woyj+Y36qdmMs1jPm3nso4KoBHL5EmcpwUJwZrtabVUqeIjoyuFFHyY7QXQJT7m0N
	wt9SCaww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPuR-00000009I3Y-1Ija;
	Thu, 29 Oct 2026 13:11:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPuP-00000009I2k-3ya9
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 13:11:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0FEF942E6C;
	Thu, 29 Oct 2026 13:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4111F01825;
	Thu, 29 Oct 2026 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279468;
	bh=LC5OqSM2Vw9O+/4CpF3iB0BOHKBEOZXJi+4rnGuzDBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=eFv+lWO+8GIypPTLTWnmdjG1odB1+78c6PCYUmxno50cRECb4Z1bBq2rD+PBSm/IS
	 SMfcSGqo+EwzLQ7k0JZiKEkeQkcZcvrTevxTGKRMhPpdcLz0LYFupWmyru4bkNatNu
	 CBmMBRoKwIuGHSDjgnvKLWM6u3tbUBCtMcVFikE1KhmT5+WNIqeIo4knslIAjzMJGJ
	 OnQvATR/NJUbajUFuajnFn2JAD2f0Heq6LufynwAdwjACkDXgopCaqp7fpL2IKCxn9
	 CvlZT5zJx/Bd+UVxf8zLENnJjs0qqcV3eTc9AvrlNAAA8JQUmq0kOlxbSEOqwrh4qZ
	 2Mm+G/0874IDA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>,  akpm@linux-foundation.org,
  david@kernel.org,  ljs@kernel.org,  liam@infradead.org,
  vbabka@kernel.org,  surenb@google.com,  mhocko@suse.com,
  baoquan.he@linux.dev,  pasha.tatashin@soleen.com,  graf@amazon.com,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] kexec: do not place the next kernel in a
 fixed-address CMA area
In-Reply-To: <auL3UW2InVqYU6Fs@kernel.org> (Mike Rapoport's message of "Thu,
	29 Oct 2026 09:35:45 +0200")
References: <20261014145731.3431527-1-radhey.shyam.pandey@amd.com>
	<20261014145731.3431527-2-radhey.shyam.pandey@amd.com>
	<2vxzh5i5orbv.fsf@kernel.org> <auL3UW2InVqYU6Fs@kernel.org>
Date: Thu, 29 Oct 2026 14:11:04 +0100
Message-ID: <2vxzzevwmz2v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29 2026, Mike Rapoport wrote:

> On Wed, Oct 28, 2026 at 03:03:16PM +0100, Pratyush Yadav wrote:
>> On Wed, Oct 14 2026, Radhey Shyam Pandey wrote:
>> 
>> > kexec_alloc_contig() picks the destination of the next kernel out of the
>> > default CMA area, and the next kernel then runs from there in place
>> > instead of being copied out. That is only safe if the area will not exist
>> > at the same address in the kernel being loaded.
>> >
>> > For an area whose base came from the device tree, it will. The loaded
>> > kernel parses the same description, declares the range it is executing
>> > from as a shared-dma-pool, and cma_activate_area() releases the pages
>> > holding its own image to the page allocator.
>> >
>> > Distinguish the two cases. An area placed by cma_declare_contiguous_nid()
>> > without a fixed base lands wherever this kernel found room, and the next
>> > kernel repeats that search against its own memblock state, so it cannot
>> > collide. Record the difference as CMA_FIXED_BASE and refuse to use such
>> > an area for the payload, which leaves kexec_locate_mem_hole() to fall
>> > back to the memblock hole search as it did before CMA placement existed.
>> >
>> > This is what makes the KEXEC_FILE_NO_CMA flag unnecessary on platforms
>> > that describe their CMA pools in the device tree.
>> >
>> > Tested on a AMD Versal AI Edge Series Gen 2 VEK385 Evaluation Kit whose
>> > device tree declares three CMA pools, the first of which is
>> > linux,cma-default:
>> >
>> >   cma_reserved@800000000     4 GiB at 0x800000000    (default)
>> >   cma_reserved@50000000000   6 GiB at 0x50000000000
>> >   cma_reserved@60000000000   4 GiB at 0x60000000000
>> >
>> > All three have a fixed base, so kexec_alloc_contig() declines the default
>> > area and kexec_locate_mem_hole() falls through to the memblock search,
>> > which places the Image segment at 0x9c00000 size 0x1de0000. The kernel
>> > that boots from it reports its image as [0x09c00000-0x0b9e0000] and
>> > 14680064K cma-reserved, i.e. all three pools still present and none of
>> > them overlapping the running kernel.
>> >
>> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
>> > Assisted-by: Claude:claude-opus-5
>> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> > ---
>> >  include/linux/cma.h | 10 ++++++++++
>> >  kernel/kexec_file.c | 12 ++++++++++++
>> >  mm/cma.c            | 16 ++++++++++++++++
>> >  mm/cma.h            |  2 ++
>> >  4 files changed, 40 insertions(+)
>> >
>> > diff --git a/include/linux/cma.h b/include/linux/cma.h
>> > index 8555d38a97b1..2fe66377e5d3 100644
>> > --- a/include/linux/cma.h
>> > +++ b/include/linux/cma.h
>> > @@ -61,4 +61,14 @@ extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
>> >  extern bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end);
>> >  
>> >  extern void cma_reserve_pages_on_error(struct cma *cma);
>> > +
>> > +#ifdef CONFIG_CMA
>> > +bool cma_has_fixed_base(const struct cma *cma);
>> > +#else
>> > +static inline bool cma_has_fixed_base(const struct cma *cma)
>> > +{
>> > +	return false;
>> > +}
>> > +#endif
>> > +
>> >  #endif
>> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> > index b668ce8d68ee..10e770bcee0b 100644
>> > --- a/kernel/kexec_file.c
>> > +++ b/kernel/kexec_file.c
>> > @@ -28,6 +28,7 @@
>> >  #include <linux/vmalloc.h>
>> >  #include <linux/dma-map-ops.h>
>> >  #include <linux/kexec_handover.h>
>> > +#include <linux/cma.h>
>> >  #include "kexec_internal.h"
>> >  
>> >  #ifdef CONFIG_KEXEC_SIG
>> > @@ -691,6 +692,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
>> >  static int kexec_alloc_contig(struct kexec_buf *kbuf)
>> >  {
>> >  	size_t nr_pages = kbuf->memsz >> PAGE_SHIFT;
>> > +	struct cma *cma;
>> >  	unsigned long mem;
>> >  	struct page *p;
>> >  
>> > @@ -702,6 +704,16 @@ static int kexec_alloc_contig(struct kexec_buf *kbuf)
>> >  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
>> >  		return -EPERM;
>> >  
>> > +	/*
>> > +	 * The next kernel runs from here rather than being copied out, so it
>> > +	 * would declare this area again from the same description and release
>> > +	 * the pages holding its own image to the page allocator. Only an area
>> > +	 * this kernel placed itself is safe to use.
>> > +	 */
>> > +	cma = dev_get_cma_area(NULL);
>> > +	if (!cma || cma_has_fixed_base(cma))
>> > +		return -EOPNOTSUPP;
>> > +
>> >  	p = dma_alloc_from_contiguous(NULL, nr_pages, get_order(kbuf->buf_align), true);
>> >  	if (!p)
>> >  		return -ENOMEM;
>> > diff --git a/mm/cma.c b/mm/cma.c
>> > index a10ea37a261d..1f4d3d48a3bb 100644
>> > --- a/mm/cma.c
>> > +++ b/mm/cma.c
>> > @@ -55,6 +55,19 @@ const char *cma_get_name(const struct cma *cma)
>> >  }
>> >  EXPORT_SYMBOL_GPL(cma_get_name);
>> >  
>> > +/**
>> > + * cma_has_fixed_base() - was the area placed at an address it did not choose?
>> > + * @cma: Contiguous memory region
>> > + *
>> > + * Such an area is described outside the kernel, typically by a device tree
>> > + * reserved-memory node, and so lands at the same address in every kernel
>> > + * booted with that description.
>> > + */
>> > +bool cma_has_fixed_base(const struct cma *cma)
>> > +{
>> > +	return test_bit(CMA_FIXED_BASE, &cma->flags);
>> > +}
>> > +
>> >  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>> >  					     unsigned int align_order)
>> >  {
>> > @@ -304,6 +317,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>> >  	cma->ranges[0].count = cma->count;
>> >  	cma->nranges = 1;
>> >  	cma->nid = NUMA_NO_NODE;
>> > +	set_bit(CMA_FIXED_BASE, &cma->flags);
>> >  
>> >  	*res_cma = cma;
>> >  
>> > @@ -517,6 +531,8 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
>> >  	}
>> >  
>> >  	(*res_cma)->nid = nid;
>> > +	if (!fixed)
>> > +		clear_bit(CMA_FIXED_BASE, &(*res_cma)->flags);
>> 
>> Nit: This reads a bit odd. cma_init_reserved_mem() sets the fixed base
>> and then you clear it later. Wouldn't it be better to just pass the
>> fixed boolean to cma_init_reserved_mem()?
>
> Actually, we shouldn't expose cma_init_reserved_mem() at all.
>
> The current callers of cma_init_reserved_mem() should be switched to
> cma_declare_contiguous_nid() that does sanity checks before calling
> cma_init_reserved_mem().

Fair enough.

On a side note, there have been some internal bug reports on CmaFree in
/proc/meminfo being large but CmaTotal being zero. That's because KHO
bootmem counts as CmaFree due to MIGRATE_CMA, but never declares a CMA
area. No real problem, just the accounting mismatch throws people off
when looking at things.

I played around with marking KHO bootmem as proper CMA areas, and I
prototyped something that used cma_init_reserved_mem(), but I can switch
that over to cma_declare_contiguous_nid().

Anyway, the hard part in those patches is declaring a CMA area _after_
KHO, since now that isn't fully free. I haven't solved that problem yet.
Maybe some day.

>
> This way the callers won't need to keep the checks for e.g
> CMA_MIN_ALIGNMENT and we'll have the clear way to differentiate areas with
> fixed based from allocated ones.
>  
>> With that fixed,
>> 
>> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> 
>> >  	*basep = base;
>> >  
>> >  	return 0;
>> > diff --git a/mm/cma.h b/mm/cma.h
>> > index 68e574b0f951..1bab24033284 100644
>> > --- a/mm/cma.h
>> > +++ b/mm/cma.h
>> > @@ -80,6 +80,8 @@ enum cma_flags {
>> >  	CMA_ZONES_VALID,
>> >  	CMA_ZONES_INVALID,
>> >  	CMA_ACTIVATED,
>> > +	/* Base address was dictated by the caller, not picked by CMA. */
>> > +	CMA_FIXED_BASE,
>> >  };
>> >  
>> >  extern struct cma cma_areas[MAX_CMA_AREAS];
>> 
>> -- 
>> Regards,
>> Pratyush Yadav

-- 
Regards,
Pratyush Yadav

