Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90739CC6B03
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 10:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9jaFSNsp/CFGLzl6alv0F7/TLQf1iiNaD/MVLusHMzs=; b=A+e4/O70F0RKd1J1QyPQtDijYA
	EJETKIlQH5OopZTiXIS2pq5qtqQcVEKiYm37vKj967eQRA9eC6g7ERULyCr6uCez4qgsrUyzZlM64
	gNJk2qh0Vbc9H5jEjvdRO/I/IpjpLo9jNaC2RCDUFpHvnRk1uEVsCZfrtm+b+b+avUuC4kdF5ZqcB
	upbochurr2s7XgygpyGXh9ooZZRAKGMipUOIXjFBANq23HKycH1pLpkaBx37J6L31S5b3Ok24/JcL
	4EF6BOu6WCJxOm4qT3uUnTaMDNr5DHujHeUDs9KnJQhDPEsOYUg7delHvXQpPigqvApcG29RLpzQ7
	mTRIi9Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZWX-0000000CX4V-1JQZ;
	Tue, 13 Oct 2026 10:14:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZWV-0000000CX3O-0DtW
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 10:14:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3EA3F60A65;
	Tue, 13 Oct 2026 10:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D801F000FF;
	Tue, 13 Oct 2026 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791886458;
	bh=9jaFSNsp/CFGLzl6alv0F7/TLQf1iiNaD/MVLusHMzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pyau+2JBZ47xLEI9AjYwCxEuWFUp6KtSyV6c8/8WT0N4NRCIgNIk3m2zUnq/UELQv
	 KjsUiMlNO+yxD3z4wT+gRyWqjce+x8opkjXeeo8cW7wqadbIJAS1NCiMIFQx8CO0Z5
	 ulJShIemgghxaodPh6CqWYG2YtFAtYtbLo2CmsABAEb9FGXc58la5w9O6mSKkENVo7
	 HibEtbFe6oqdn1TbWpZHHESHkgIE97Bon5u6fh4P61z17grF2aauuVX6tOMWrFEIyH
	 dkHLm0NUip3sgYNpBBeZOx3mFIkikn1/pa7ujFF0hf2ZOUCg7QGpg+ih6Ak0kR5zeY
	 UjgEuD53By39Q==
Date: Tue, 13 Oct 2026 13:14:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] memblock: drop for_each_memblock_type() and open
 code its users
Message-ID: <as4EcgiBH5jjww42@kernel.org>
References: <20261008190828.3221718-1-tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008190828.3221718-1-tarunsahu@google.com>
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

Hi Tarun,

Please for the next time add the cover-letter when sending more than one
patch.

On Thu, Oct 08, 2026 at 07:08:27PM +0000, Tarun Sahu wrote:
> for_each_memblock_type() always starts the iteration at index 0 and its
> body is a trivial 'for' loop, so it hides very little. It also gets in
> the way of iterating from an arbitrary index, which the next patch
> needs.
> 
> Remove the macro and open code its three users: memblock_add_range(),
> memblock_isolate_range() and memblock_dump(). While at it, move the
> region pointer into the loop body scope.
> 
> No functional change.
> 
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  mm/memblock.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index f5aaa38cfa31..59dda7d085f3 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -155,11 +155,6 @@ struct memblock_type physmem = {
>   */
>  static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>  
> -#define for_each_memblock_type(i, memblock_type, rgn)			\
> -	for (i = 0, rgn = &memblock_type->regions[0];			\
> -	     i < memblock_type->cnt;					\
> -	     i++, rgn = &memblock_type->regions[i])
> -
>  #define memblock_dbg(fmt, ...)						\
>  	do {								\
>  		if (memblock_debug)					\
> @@ -615,7 +610,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	phys_addr_t obase = base;
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>  	int idx, nr_new, start_rgn = -1, end_rgn;
> -	struct memblock_region *rgn;
>  
>  	if (!size)
>  		return 0;
> @@ -651,7 +645,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	base = obase;
>  	nr_new = 0;
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for (idx = 0; idx < type->cnt; idx++) {
> +		struct memblock_region *rgn = &type->regions[idx];
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
>  
> @@ -815,7 +810,6 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  {
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>  	int idx;
> -	struct memblock_region *rgn;
>  
>  	*start_rgn = *end_rgn = 0;
>  
> @@ -827,7 +821,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  		if (memblock_double_array(type, base, size) < 0)
>  			return -ENOMEM;
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for (idx = 0; idx < type->cnt; idx++) {
> +		struct memblock_region *rgn = &type->regions[idx];
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
>  
> @@ -2194,11 +2189,11 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
>  	phys_addr_t base, end, size;
>  	enum memblock_flags flags;
>  	int idx;
> -	struct memblock_region *rgn;
>  
>  	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for (idx = 0; idx < type->cnt; idx++) {
> +		struct memblock_region *rgn = &type->regions[idx];
>  		char nid_buf[32] = "";
>  
>  		base = rgn->base;
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 

-- 
Sincerely yours,
Mike.

