Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6148CFC518
	for <kexec@archiver.kernel.org>; Sun, 23 Nov 2025 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGJBxA3HpMNht2r+f4Xo2T/V6gkIV+T8N1PxUbEDDvw=; b=hEL+0iWvCp+WtmAJ2z3UtSXzWp
	Dvn2kgC9xq2nfgUEpp8SBr57e8Cll83y9OU/Wnyqiqm40SfQZIZpIC0H5iB+EDVyLQDBSB/SUmX6w
	otiSvxr6y3Hd5O2bBWMSmIhUXupu40P+7jzQH407eZkZvITrty26IkVzxKDzKllo4gMP139aeXxpQ
	UWwni9K7VhDOSG3RZQf3W3dTu0KP9M77fUkoqpb5YvgE5PEsjcI39D10lmw89OHPteWhUTpdYtZRk
	b38zlJkt+fSIcklQEBO1PnepnlLGtSW5HjSMPbPuxuCehGcntHdm1s+AlFcfLcfT0ne6Oi/CssjTC
	N566Kr0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vN6NW-0000000AIoB-0t3Z;
	Sun, 23 Nov 2025 09:27:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vN6NU-0000000AInk-0l4f
	for kexec@lists.infradead.org;
	Sun, 23 Nov 2025 09:27:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 05A0D4434A;
	Sun, 23 Nov 2025 09:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E48C116B1;
	Sun, 23 Nov 2025 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763890046;
	bh=5u89c6u7PmgUNyXcIwwe0ortgOiu9oUgVZBpk9oXbqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uv94iUmHued1v2Q4orS2+AolylSWhtdqajQaxRz+LM6oKZ1dsvahXFkJfRAbyEfCI
	 J69bPl2Q5R+eo9qpF5RWgUiTwHb4Cnaejhd3cC3J1vp3lJVp/PNKwSBroHCdZs43Ji
	 xkyGSqx4e7WI+Eoy3a4zMUzDcBKv9jur1CP769YTXrtu+e6ggpCztMqjPjC2FPmn+L
	 g+xrh8j1qsLR9LDL1NT97JYL8+HxMuRg8YkboaEjLk4ct8HEtDKHNnxsTAXWhHzTuS
	 epE8pdwJh5skTw58RJCZkBs3uTYO8QBPzVmcIHKrIP9SUKGQXIfqR+6Xtd7v/UpGeI
	 1CuF6xraQ5nvw==
Date: Sun, 23 Nov 2025 11:27:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: ranxiaokai627@163.com
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com,
	changyuanl@google.com, graf@amazon.com, pasha.tatashin@soleen.com,
	pratyush@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v2] KHO: Fix boot failure due to kmemleak access to
 non-PRESENT pages
Message-ID: <aSLTd7pAWgalkT7X@kernel.org>
References: <20251122182929.92634-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122182929.92634-1-ranxiaokai627@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_012728_261382_32207E1C 
X-CRM114-Status: GOOD (  18.13  )
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

Hi,

On Sat, Nov 22, 2025 at 06:29:29PM +0000, ranxiaokai627@163.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> When booting with debug_pagealloc=on while having:
> CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n
> the system fails to boot due to page faults during kmemleak scanning.
> 
> This occurs because:
> With debug_pagealloc is enabled, __free_pages() invokes
> debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
> freed pages in the kernel page table.
> Commit 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> triggers this when releases the KHO scratch region calling
> init_cma_reserved_pageblock(). Subsequent kmemleak scanning accesses
> these non-PRESENT pages, leading to fatal page faults.

I believe this is more clear:

With debug_pagealloc is enabled, __free_pages() invokes
debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
freed pages in the kernel page table.
KHO scratch areas are allocated from memblock and noted by kmemleak. But
these areas don't remain reserved but released later to the page allocator
using init_cma_reserved_pageblock(). This causes subsequent kmemleak scans
access non-PRESENT pages, leading to fatal page faults.
 
> Call kmemleak_ignore_phys() from kho_init() to exclude
> the reserved region from kmemleak scanning before
> it is released to the buddy allocator to fix this.

I'd suggest

Mark scratch areas with kmemleak_ignore_phys() after they are allocated
from memblock to exclude them from kmemleak scanning before they are
released to buddy allocator to fix this.

> 

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")

> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

With the changes above

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/liveupdate/kexec_handover.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 224bdf5becb6..c729d455ee7b 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/cleanup.h>
>  #include <linux/cma.h>
> +#include <linux/kmemleak.h>
>  #include <linux/count_zeros.h>
>  #include <linux/kexec.h>
>  #include <linux/kexec_handover.h>
> @@ -1369,6 +1370,7 @@ static __init int kho_init(void)
>  		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
>  		unsigned long pfn;
>  
> +		kmemleak_ignore_phys(kho_scratch[i].addr);
>  		for (pfn = base_pfn; pfn < base_pfn + count;
>  		     pfn += pageblock_nr_pages)
>  			init_cma_reserved_pageblock(pfn_to_page(pfn));
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.

