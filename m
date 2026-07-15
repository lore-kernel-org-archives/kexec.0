Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D25C44501
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lV4Poc1DihoW3yEe6NUT55efNlgQhKaVqNC6dA3nbPo=; b=f3U3SAELqbz1/csyilrLmBGZEz
	0AtTHcdVI16lSdfWz7LAYaFk6p+oLxP0BFTOwdfvaGeYKAnRdjFvIQqTpGnnHXof3oR53m2XQmnav
	P1KsN1yfxYFOsToaYavvdaF8qjQaOtZa3MVVHW+LDifgp2xC80C62YNCS6cB2w2ssyOXSzVJB0Ojz
	q67kdCAAO/a/NWcirY6Nm3hlNQXejnsR0aVPHVWKcpw38XlRijpfoSnoujf2yjGXtK4x/Z+R0g7IA
	ROn7Ekqzie2/Bzrt2rQhQk55F7sebRgHTEbd9s0QVraFHivBv7G2D02/GDYxDUjUqAIs0e6Cyd4MH
	MWbFOXdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1k-0000000EKwQ-39Vf;
	Wed, 15 Jul 2026 09:35:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1k-0000000EKwB-1VCW
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 09:35:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D03B840BA6;
	Wed, 15 Jul 2026 09:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FD21F000E9;
	Wed, 15 Jul 2026 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108139;
	bh=lV4Poc1DihoW3yEe6NUT55efNlgQhKaVqNC6dA3nbPo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IC2dOiOcE0aeg4I1yuBqYKCBVC/e/sDJ0OpaNgKBqAwjlj1KAPl2zbT+bRWMstjad
	 ZVUfj9309wFMiIXXEM5In8AkLNWISQWroRrrT+A5d0iD14Yx5l7s0771HjV0FAUZYT
	 doy/9vBU15HA19RbuSZXppHv+uFXOpJtv1GIL3pY+0tpiKwYNkjVZEmdz7hqQDv60f
	 isJant36z/wVMdwAGazLKepA5oITaz49sySLV0lRVuCJ8HUiX2Nw1pn9/8YLso8H3o
	 VIg9xir9kN6cZQhmR23KKwEPbOd49A6xpbVjfldqwPfwvzCI99TFEHFrHidW/gr6eR
	 MIoENdReJSRCQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 18/21] kho: extend scratch
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260709173821.429921-19-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
 <20260709173821.429921-19-pratyush@kernel.org>
Date: Wed, 15 Jul 2026 12:35:19 +0300
Message-Id: <178410811939.820181.9175877917181976639.b4-review@b4>
X-Mailer: b4 0.16-dev
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

> Motivation
> ==========
> 
> The scratch space is allocated by the first kernel in the KHO chain, and
> is reused by all subsequent kernels. The size of the space is either set
> via the commandline by the system administrator or by calculating the
> amount of memory used by the kernel and adding a multiplier. In either
> case, the scratch space is a heuristic and is liable to fill up and fail
> allocation if a kernel uses more memory than expected.
> 
> In addition, gigantic huge pages (usually 1 GiB) are allocated via
> memblock, and in a KHO boot that memory comes from the scratch space. In
> hypervisors it is common to dedicate a major part of the system's memory
> to gigantic hugepages for VM memory.
> 
> If this memory needs to come from scratch space, then scratch needs to
> be greater than the memory needed for huge pages, which is impractical.
> In addition, hugepages can be preserved memory. Allocating them from
> scratch violates the assumption that scratch contains no preserved
> memory.
> 
> Methodology
> ===========
> 
> Discover areas that don't contain any preserved memory at boot by
> walking the preserved memory radix tree. Mark them as scratch to allow
> allocations from them. This makes KHO more resilient to memory pressure
> and allows supporting huge page preservation.
> 
> Since the preserved memory radix tree mixes both physical address and
> order into a single key, and does not track table pages, it is difficult
> to identify free areas from it directly. Walk the tree and digest it
> down into another radix tree. The latter tracks blocks of
> KHO_EXT_SHIFT (1 GiB as of now) granularity. Then walk the digested tree
> and mark the areas between the present keys as scratch.
> 
> Performance
> ===========
> 
> The discovery algorithm traverses the preserved memory radix tree
> exactly once. While it does use memory for the digested radix tree,
> since the blocks are split by 1 GiB, a single bitmap with 4k pages can
> track up to 32 TiB of memory. So there are likely to be very few radix
> tree pages used in this tracking. For systems with all physical memory
> below 32 TiB, this should result in a total of 6 pages being
> used (KHO_TREE_MAX_DEPTH == 6).
> 
> An alternate way of achieving this would be to call kho_mem_retrieve()
> earlier in boot and mark all the KHO preservations as reserved. But that
> can blow up memblock.reserved with a bunch of 4K pages scattered
> everywhere, which will reduce performance of subsequent allocations.
> Since the free blocks are tracked in chunks of 1 GiB, this won't blow up
> memblock.memory as much.
> 
> There is no inherent reason for using 1 GiB as the discovered block
> size. This can be changed later if needed. Currently, KHO is mainly
> targeted for server grade systems with hundreds of gigabytes to
> terabytes of memory. So 1 GiB is a reasonable granularity for those
> systems. For smaller systems this doesn't work as well, but we can
> arrive at a better heuristic when we have concrete use cases.
> 
> Practical evaluation
> ====================
> 
> The testing is done on a x86_64 qemu VM running under KVM with 64G
> memory and 12 CPUs. The machine pre-allocates 50 1G pages.
> 
> Since the performance scales with how busy the radix tree is, tests are
> done with 2 preservation patterns: first with two 1M memfds, second with
> two 1G memfds, both using 4k pages.
> 
> Test case 1 - 1M memfd
> ~~~~~~~~~~~~~~~~~~~~~~
> 
> This test case has two memfds with 1M memory each in 4k pages, plus
> other preservations from LUO core and other KHO users.
> 
> This is how the radix tree stats look like:
> 
>     radix_nodes:       0x13
>     nr_preservations:  0x214
>     mem_preserved:     0x227000
> 
>     per order preservations:
>       order  0:  0x20f
>       order  1:  0x4
>       order  4:  0x1
> 
> and this is how long it takes to extend the scratch after KHO boot:
> 
>     KHO: KHO extend time: 47 us
>     KHO: KHO extend total mem: 0xe6c17b000 (~57G)
> 
> Test case 2 - 1G memfd
> ~~~~~~~~~~~~~~~~~~~~~~
> 
> This test case has two memfds with 1G memory each in 4k pages, plus
> other preservations from LUO core and other KHO users.
> 
> This is how the radix tree stats look like:
> 
>     radix_nodes:       0x28
>     nr_preservations:  0x80816
>     mem_preserved:     0x80829000
> 
>     per order preservations:
>       order  0:  0x80811
>       order  1:  0x4
>       order  4:  0x1
> 
> and this is how long it takes to extend the scratch after KHO boot:
> 
>     KHO: KHO extend time: 22514 us
>     KHO: KHO extend total mem: 0xd3f200000 (~52G)
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index b400976851e76..2c48488746290 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -84,6 +84,23 @@ static struct kho_out kho_out = {
>  	},
>  };
>  
> +struct kho_in {
> +	phys_addr_t fdt_phys;
> +	phys_addr_t scratch_phys;
> +	char previous_release[__NEW_UTS_LEN + 1];
> +	u32 kexec_count;
> +	struct kho_debugfs dbg;
> +	struct kho_radix_tree radix_tree;
> +};
> +
> +static struct kho_in kho_in = {
> +};
> +
> +static const void *kho_get_fdt(void)
> +{
> +	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
> +}
> +
>  /**
>   * kho_encode_radix_key - Encodes a physical address and order into a radix key.
>   * @phys: The physical address of the page.
> @@ -895,6 +912,128 @@ static void __init kho_reserve_scratch(void)
>  	kho_enable = false;
>  }
>  
> +/*
> + * Look for free blocks of 1G. This is a heuristic chosen to work efficiently
> + * with large systems with hundreds of gigabytes of memory. It will work poorly
> + * on smaller systems. The algorithm itself doesn't depend on the actual value,
> + * so it can be changed to a different heuristic later if needed.
> + */
> +#define KHO_EXT_BLKSIZE		SZ_1G
> +#define KHO_EXT_SHIFT		const_ilog2(KHO_EXT_BLKSIZE)

Nit: EXT_ what? ;-)

> +
> +/* Called for the KHO preserved memory radix tree. */
> +static int __init kho_ext_walk_leaf(unsigned long key, void *data)

I have to say this function still confuses me :)

> +{
> +	/* Radix tree tracking free blocks. */
> +	struct kho_radix_tree *tree = data;
> +	phys_addr_t start, end;
> +	unsigned int order;
> +	int err;
> +
> +	start = kho_decode_radix_key(key, &order);

I would add a comment here, that the key is from the memory tracker and
it is decoded to an address.

-- 
Sincerely yours,
Mike.


