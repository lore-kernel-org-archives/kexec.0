Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CD8CAC583
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNqNdIyyKvlQsffc32Vo1vye5nnPAB3Xttji1HxWmGo=; b=1XnL4KzcVvjdgpWG8y6xwXi/tp
	V56D9+KaXLGxsB4GML4hxjP7ILsewnDxeHH8DEOKmQlo1yhkiGhjgdEhT2hEOKNyS4huXWrkN1wqy
	TYs9GCRN6CCffWqrljXuWLIhwUxCI6kYUK40A03KkSogDkMSVcniFKJJA0UuGP07tn+20MR57AHcN
	pcT13wtgKR338pTe+njRDT8Vewh4PYQigE30D2YiLeYqv/LyyIPADqb6JhtXpt/qXotPuVJQAMMeo
	5wF7HOK/zQ1V9uJ1g/BtIEKzXrFyYISr5Vh1Prb83f2G1KXqrnRE5k1MvW58yJRzZLSkJzZdsmDtf
	jCtTQyaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw0cQ-00000008K7p-2dw3;
	Tue, 09 Sep 2025 15:50:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvxI9-00000007121-3C7O
	for kexec@bombadil.infradead.org;
	Tue, 09 Sep 2025 12:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UNqNdIyyKvlQsffc32Vo1vye5nnPAB3Xttji1HxWmGo=; b=oS3EpxdR3rNL7fQBiTJ9oP/kDm
	8m5iLKQJwRwSc640/hrugw57lKj8wvjZ9ANxXxMCaXk/bMO8UxA9MwOYI8HJi6aFAYL0TP+8HOcMG
	Vvcl+l1GIiuTjp62/CNT9eArTQXDRMxhBFqmHAnCydBoBKmH4Ux/YDps+qLO2Sds4vIwpvFOd+sQK
	PiM5ns95awEETsBXMZruGQjHQYx5YnOwppNhhZLaovzpfAlKzqI8UNYffNYp2wte0HEVIZFdKLr5x
	Zpi81O+ob5f/x1zqK/mSkh4LW/nr4aRsPYQXPk1WpHeOxIukTHFnZTfCndwH0PsTFZsKTglZIKoHN
	sAuPjrLg==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvxI6-00000005MJo-2kA7
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 12:17:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A41D4045D;
	Tue,  9 Sep 2025 12:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F2BC4CEF4;
	Tue,  9 Sep 2025 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757420258;
	bh=CINqC1yuoC6EN3JTqav2e34BO45tJWHN4hfmBhvxPS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IFg7XF5CNMe84ZyievChiP1ILlqSCeMTZctwDIz45qv4ppTlVwgySeVsyMhey4TIZ
	 HPJB087o01tclncA+qQFNTwJ+5slt7Neo2Ybi2YKxfpNMdUjskKBEt70norm4UjrH8
	 6xmeU6/C2nzTUxrOhKxG3ByoMFqgvx952HpSIbGXXfTmFgJso6E0a1/lVzLCYMWtTI
	 ME4x1Cd0o187Z3d/Zf38O/NHoGJcQdNd/hyaop6xvqBnIM9TF9AK/XGFJ4kMoWPo/h
	 J2N8U1CU5gqWbDwUKKQ/p8B40uXxaPCKMaK1kHMk7QJ/CmfhaVq1oq2tTWLKRBm3hw
	 9A3L+M93ZW1dA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  <kexec@lists.infradead.org>,  <linux-mm@kvack.org>,
  <linux-efi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <nh-open-source@amazon.com>
Subject: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
In-Reply-To: <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
	<b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
Date: Tue, 09 Sep 2025 14:17:35 +0200
Message-ID: <mafs0segvlt0g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_131743_049166_9B91E54F 
X-CRM114-Status: GOOD (  26.89  )
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

On Thu, Aug 21 2025, Evangelos Petrongonas wrote:

> When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> early during device tree scanning. After kexec, the new kernel
> exclusively uses this region for memory allocations during boot up to
> the initialization of the page allocator
>
> However, when booting with EFI, EFI's reserve_regions() uses
> memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> rebuilding them from EFI data. This destroys KHO scratch regions and
> their flags, thus causing a kernel panic, as there are no scratch
> memory regions.
>
> Instead of wholesale removal, iterate through memory regions and only
> remove non-KHO ones. This preserves KHO scratch regions, which are
> good known memory, while still allowing EFI to rebuild its memory map.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> Changes in v3:
> 	- Improve the code comments, by stating that the scratch regions are
> 	good known memory
>
> Changes in v2:
> 	- Replace the for loop with for_each_mem_region
> 	- Fix comment indentation
> 	- Amend commit message to specify that scratch regions
> 	are known good regions
>
>  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f2..a65c2d5b9e7b 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -12,6 +12,7 @@
>  #include <linux/efi.h>
>  #include <linux/fwnode.h>
>  #include <linux/init.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/memblock.h>
>  #include <linux/mm_types.h>
>  #include <linux/of.h>
> @@ -164,12 +165,32 @@ static __init void reserve_regions(void)
>  		pr_info("Processing EFI memory map:\n");
>  
>  	/*
> -	 * Discard memblocks discovered so far: if there are any at this
> -	 * point, they originate from memory nodes in the DT, and UEFI
> -	 * uses its own memory map instead.
> +	 * Discard memblocks discovered so far except for KHO scratch
> +	 * regions. Most memblocks at this point originate from memory nodes
> +	 * in the DT and UEFI uses its own memory map instead. However, if
> +	 * KHO is enabled, scratch regions, which are good known memory
> +	 * must be preserved.
>  	 */
>  	memblock_dump_all();
> -	memblock_remove(0, PHYS_ADDR_MAX);
> +
> +	if (is_kho_boot()) {
> +		struct memblock_region *r;
> +
> +		/* Remove all non-KHO regions */
> +		for_each_mem_region(r) {
> +			if (!memblock_is_kho_scratch(r)) {
> +				memblock_remove(r->base, r->size);
> +				r--;

Hmm, this caught me off-guard. I had to do a double take to realize that
memblock_remove() would decrease memblock.memory.cnt and move the whole
regions array back. A comment would have been nice here.

But then, I wouldn't want you to do a full resend of the series for this
minor nitpick. So perhaps whoever is taking this patch can add one when
applying? Either way is fine though...

Acked-by: Pratyush Yadav <pratyush@kernel.org>

> +			}
> +		}
> +	} else {
> +		/*
> +		 * KHO is disabled. Discard memblocks discovered so far:
> +		 * if there are any at this point, they originate from memory
> +		 * nodes in the DT, and UEFI uses its own memory map instead.
> +		 */
> +		memblock_remove(0, PHYS_ADDR_MAX);
> +	}
>  
>  	for_each_efi_memory_desc(md) {
>  		paddr = md->phys_addr;

-- 
Regards,
Pratyush Yadav

