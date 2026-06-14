Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BF0CD98C5
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OiJl936KF9izhXytFX0Tlq9uruq3JEx7g1vwKQuIhjI=; b=nLwYmKZbolM894DxqGNmm+x0d3
	9/cKcIuGGjmHK1tWsa/3oD8bWtZ0SoXvL3SlcrUDmpyxg3pjBWdp5wVUNgz5IcQJUclx60bRJ7BxZ
	LFonyGTJ11OECNvuj1BZ+EBqZJZg0BKqarKDe3zCeuZTXtXeNQ9bQsWjXj1aBr5meaV1uB0Z8xPNH
	xoLFP620lLFSYa6vHXO7X31ZDnz0tTlbyvgx+8bfJX9d7sz2dfbYXX3IdJlk8h3UUHia2DRU5NlIn
	ig+idJ3n3hlu05+Sn8x8jw388+CkzRKp62VJckz2vfWdQjYv4qQ0uQlnX9cv0jb2+bscctMC8moe4
	Q40m0QpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjYE-0000000Cwt6-0TJv;
	Sun, 14 Jun 2026 12:02:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjYD-0000000CwsQ-00No
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:02:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C02A242ABA;
	Sun, 14 Jun 2026 12:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA53C1F00A3F;
	Sun, 14 Jun 2026 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781438572;
	bh=OiJl936KF9izhXytFX0Tlq9uruq3JEx7g1vwKQuIhjI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OXuaMyhTkjPqLkEUlUu/a0Ve25QH7gxz52VWbsMEZzrtb2HVUYKezEcQl7/bnNfgI
	 uf19MItwBCcjden4/gwLnGEHIAgXIftWvQ/OF+d6wEIVZQt0SDrn6pMvHJyZCR6ZJx
	 5QhKxiO4sbVYoIoE1rrSrEvJ0Hmwf5Kva5dybiwyt76BJgx4IdZhOY4JcgFhwHY/8R
	 n7jVperTgdzc3/YVPsdxadj3na+naxKpdAmiS/u+kcvhYMt7HJ2uGBhHy9kxnwZViJ
	 IegQ8wXyqCI+c/XL7ZuEg6AhMH9qUoC4audbUYPBvuGpz+5c2qRy1JDppgVHH0qeRf
	 0vCHHTitj1XHQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 15/18] kho: extend scratch
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260605183501.3884950-16-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
 <20260605183501.3884950-16-pratyush@kernel.org>
Date: Sun, 14 Jun 2026 15:02:31 +0300
Message-Id: <178143855117.2123877.6330314807920146675.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 20:34:48 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index af22086ca2d6..8540608b8602 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -869,6 +886,119 @@ static void __init kho_reserve_scratch(void)
>  	kho_enable = false;
>  }
>  
> +#define KHO_EXT_SHIFT 30 /* 1 GiB */

Please add a comment why exactly 1 Gib.
I'd also define a size macro as SZ_1G and make shift const_ilog2(SIZE)

> +
> +static int __init kho_ext_walk_key(unsigned long key, void *data)

Maybe _leaf? No strong feelings though

> +{
> +	struct kho_radix_tree *tree = data;

Would be nice to say which tree in the variable name ;)

> [ ... skip 15 lines ... ]
> +	return 0;
> +}
> +
> +static int __init kho_ext_walk_node(phys_addr_t phys, void *data)
> +{
> +	struct kho_radix_tree *tree = data;

Ditto

> [ ... skip 15 lines ... ]
> +
> +	*prev_end = start + (1UL << KHO_EXT_SHIFT);
> +	return 0;
> +}
> +
> +/**

I don't think we expose statics as kernel-doc somewhere, so this
probably shouldn't be a kernel-doc comment

> + * kho_extend_scratch - Extend the scratch regions
> + *
> + * The KHO radix tree mixes both physical address and order into a single key.

Here it's rather the preserved memory map radix tree or something like
that.

> + * This makes it hard to look for free ranges directly. This function first
> + * walks the radix tree and digests it down into another radix tree, whose keys

Here as well, maybe don't even mention radix to make it shorter, the
important part is that we wakk the preserved memory map and create a
radix tree that identifies blocks around the preserved memory.

> + * identify blocks of KHO_EXT_SHIFT which contain preserved memory.
> + *
> + * Then it walks the digested radix tree and marks everything that doesn't have
> + * preserved memory as scratch.
> + *
> + * NOTE: This function allocates memory so it should be called when scratch has
> + * available space.
> + *
> + * NOTE: The pages of the KHO radix tree tables are not marked as preserved in

^ preserved memory map radix tree :)

> + * the KHO tree. But they are expected to remain untouched until the tree is
> + * fully parsed. So this function also considers them to be "preserved memory"
> + * and marks their blocks as busy.
> + */
> +static void __init kho_extend_scratch(void)
> +{
> +	const struct kho_radix_walk_cb kho_cb = {
> +		.leaf = kho_ext_walk_key,
> +		.node = kho_ext_walk_node,
> +	};
> +	const struct kho_radix_walk_cb ext_cb = {
> +		.leaf = kho_ext_mark_scratch,
> +	};
> +	struct kho_radix_tree radix;

sashiko says:

  Is it possible for the radix variable to contain uninitialized stack memory
  here?
  If radix is uninitialized, tree->root might contain garbage data when passed
  to kho_radix_init_tree()

and I agree :)

This should be

	struct kho_radix_tree radix = { 0 };

-- 
Sincerely yours,
Mike.


