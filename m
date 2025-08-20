Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7A8CA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2kU53JEnSe0Nw++617VLP4wrlRSYwLUGWBZDBSJ3y4E=; b=nZOJER+D97E/WmoNmxIgvDNiFN
	bX3Y211hdLyMnbFBh0N1V7OkFWy5UlF0o869PwQdMN6Xtk0dHBsya7QIs8FbCEg2rYvoF0/+fN7Tk
	2vVHdzfLZ7V9u4581TojsCQ/wrx1xRSRrhVDZ+oXmoPZXnwnH4Ui5r4mar1l0dKYjwI/bi0NhlMqL
	ZZnL5uQiSM2ZoR13UySDAKT7I9JpVXcHs/lFJ3l2xjLSq1RskQga18WDt1uU2Ig6tcva4PggByADK
	W1QbwYR8ohys5GsHpCCiqLdXh8uEPzmb67ni8eEt8vk1g7iUY+7CYp99XiZEa9ynHS+v1MRZUaRo9
	eVIsnhMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoeNb-0000000CmIx-0jLu;
	Wed, 20 Aug 2025 08:41:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uodtS-0000000CgVd-2lv9
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 08:10:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7D8A15C5FDE;
	Wed, 20 Aug 2025 08:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762BDC113D0;
	Wed, 20 Aug 2025 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677401;
	bh=ZwBIaVwfHe/T7WlfARZdRvpXDhB+IehKv0D+1cs2k44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTvKw6IuGKUCM074ZO6HCTXEBhK8E5DzlI1NkU+TKjtyZQ9NfmN5Jc00uTv6/kKXa
	 hWwxb3f4bADolcJPjWJGnr7BlVGitV9WGRgHoVDov0n0e81rrltgT7ztXG6CCOadAR
	 A/9LHOmnMv4XoTm46Wi6wryYMO+yr1ndcmZ7Z4+cM94l/e5t+Tfq4j7t3XSGLaYVJe
	 hdsr2Cqlnz6j/nkCAU/SqzZhmd/08f79LP5yPzmavyUjM0kJD/Dz7lE6I9jr9jrSuU
	 BqR8XE6QJRoOvke2raPIVYoNu93YDKztyJOOABw4QkrKbpYxFS6kv6Yy/F9OwC7Q8C
	 AdL744Lg9k08Q==
Date: Wed, 20 Aug 2025 11:09:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2 2/2] efi: Support booting with kexec handover (KHO)
Message-ID: <aKWC0c3kliee8gtu@kernel.org>
References: <cover.1755643201.git.epetron@amazon.de>
 <9e80381d4fafc71d6e0c64d69a8b3ac9c8949865.1755643201.git.epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e80381d4fafc71d6e0c64d69a8b3ac9c8949865.1755643201.git.epetron@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_011002_780087_F44B6560 
X-CRM114-Status: GOOD (  26.63  )
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

On Tue, Aug 19, 2025 at 11:22:46PM +0000, Evangelos Petrongonas wrote:
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
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> Changes in v2:
> 	- Replaced the for loop with for_each_mem_region
> 	- Fixed comment indentation
> 	- Amended commit message to specify that scratch regions
> 	are known good regions
> 
>  drivers/firmware/efi/efi-init.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f2..99f7eecc320f 100644
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
> @@ -164,12 +165,31 @@ static __init void reserve_regions(void)
>  		pr_info("Processing EFI memory map:\n");
>  
>  	/*
> -	 * Discard memblocks discovered so far: if there are any at this
> -	 * point, they originate from memory nodes in the DT, and UEFI
> -	 * uses its own memory map instead.
> +	 * Discard memblocks discovered so far except for KHO scratch
> +	 * regions. Most memblocks at this point originate from memory nodes
> +	 * in the DT and UEFI uses its own memory map instead. However, if
> +	 * KHO is enabled, scratch regions must be preserved.

I'd add that KHO scratch regions are good know memory here as well. With
that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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
> -- 
> 2.47.3

-- 
Sincerely yours,
Mike.

