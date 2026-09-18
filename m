Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB346C982D2
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 00:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ze9UETo+1hNVH97tpJEWQvJ1yZNxYlSuzO4Oj6uf588=; b=v4aN8VrARWHwqiGHro4hADZixT
	E+KWPb/33KQkkbAtZ459RSv8c+u/SB8JfaP2zzSg2kqEyBS59HTvgqOi9DXDQM0LrMTvUtJGqRCWg
	CeX7NGpUnIkgj3znJ1sc/3UP47Iqsu0jDR5gmYElaKpDxBVlkuijgajHJyu6Orkn6yFMqfk5EAYDw
	/vmrp9ZSzEam5NjckUjoym8ci44cig7XYXMSUXmFaL+N+Ggh/DULdnno/8QWX2Y+9Ai75DmmCR4/k
	6xU7aezMxxSMkjkZRwn0Kd1hHvluKOGxgzEhryxocNPa59wTxk6dzlpuHCmcxIPIBsf0bppaaEIwe
	wJDH+Tzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7McE-0000000D38C-0xxb;
	Fri, 18 Sep 2026 00:38:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7McC-0000000D37k-3dVJ
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 00:38:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 51DFF437B9;
	Fri, 18 Sep 2026 00:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A161F000FF;
	Fri, 18 Sep 2026 00:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789691888;
	bh=Ze9UETo+1hNVH97tpJEWQvJ1yZNxYlSuzO4Oj6uf588=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=d+bSl1GvJPGpKJYMJztB6DW2nOd5gK/0XiKZ5AIB6VuavdGfd3Prp+D3XBcOpYA2R
	 iIwVPvgYhgv6yfq2RUHTq4tnZGKxFiz/sxeJePe2MHqQYzaJoFt/VExnajbgcNtN30
	 sa5IxWpBsDig62Xv2bnappORxL1PDe2qQS/Q7poO1/9geVH64dcJjyP+wYLajXtPGW
	 BpqwM8jasLiVs4z8X42oTLB+m9XNHKPXhw0LX6S3Rtspl31EcKrWRP7ZRwE6r3GQ1F
	 JgCdXruZNKoLXeJgzsha6AEnjUkqjx6HxogeUiC1370bKypIA0nJRIYT5WQ0KL2FIB
	 p85YVOSKrGvqQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  dmatlack@google.com,  Mike Rapoport
 <rppt@kernel.org>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  dev.jain@arm.com,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] memblock: drop for_each_memblock_type() and open
 code its users
In-Reply-To: <20260918002239.4024231-1-tarunsahu@google.com> (Tarun Sahu's
	message of "Fri, 18 Sep 2026 00:22:38 +0000")
References: <20260918002239.4024231-1-tarunsahu@google.com>
Date: Fri, 18 Sep 2026 02:38:04 +0200
Message-ID: <2vxzwlsj5r83.fsf@kernel.org>
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

On Fri, Sep 18 2026, Tarun Sahu wrote:

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
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  mm/memblock.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 9ce86349a29f..5aae75d34dec 100644
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
> @@ -651,7 +646,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	base = obase;
>  	nr_new = 0;
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for (idx = 0; idx < type->cnt; idx++) {
> +		rgn = &type->regions[idx];

Nit: this is really odd to read. You assign rgn and then declare rbase
and rend. Doesn't checkpatch complain?

Regardless, I reckon it would be a lot nicer to read of you move the
declaration of rgn into the loop. Same for the others below.

LGTM otherwise, so after fixing this up, feel free to add:

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
>  
> @@ -827,7 +823,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  		if (memblock_double_array(type, base, size) < 0)
>  			return -ENOMEM;
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for (idx = 0; idx < type->cnt; idx++) {
> +		rgn = &type->regions[idx];
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
>  
> @@ -2198,7 +2195,8 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
>  
>  	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for (idx = 0; idx < type->cnt; idx++) {
> +		rgn = &type->regions[idx];
>  		char nid_buf[32] = "";
>  
>  		base = rgn->base;

-- 
Regards,
Pratyush Yadav

