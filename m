Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B631CFD313
	for <kexec@archiver.kernel.org>; Mon, 24 Nov 2025 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Dm/kFOS1zLSSQWJ1ly/EvdynyoLuunfcJ9L+avtprE=; b=I7ZKRjAWynrmnV11BwnmK1N3aW
	Gjv8JvIo1gqtM5rcQfFgqb8QeWpgSGx+Av9Mx0vVaTouWwd8Mkf2G+c/h6dxv6+Xg3G0C+T5U0gtK
	dYE6oKgk89sEeFDGbUOct0pxtmcGLwLQNqsWcT7jjhFx53sisz2N/Juyw+NxlB9FeQjWS79LBOjWm
	0vCX72VcCh41cl9QQ4LCfzNH2aVvrI4k/qYmmwGvNoHz1b3qEPZW8nhAi8IU/bxcfDIxKjEnDmR/G
	Uj6tXUbXdOHJhK6HFoKJmj8b0ETmsnpBHtV7I1IWFTyNYRriqcvBbxcfHvVzq4MnQQD7WSxvQB0lu
	eqxrbfpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNVV8-0000000BdmB-3MSu;
	Mon, 24 Nov 2025 12:17:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNVV5-0000000Bdlk-3A6L
	for kexec@lists.infradead.org;
	Mon, 24 Nov 2025 12:17:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B0678443FE;
	Mon, 24 Nov 2025 12:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D65C4CEF1;
	Mon, 24 Nov 2025 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763986618;
	bh=dZiPM1LFz4RF63yPFs4ZgFUL2y/p+IJlKxTQbSlwnNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Vk41JS3BrTpprUfDmHaAWqzmYN5LKPTP0ikZeODbHurhakhmNlbEtrkZ0/4NlNYP0
	 UtTmKaGui+1CuOO9Fc+Am73Tx5ttc9GQMIb6wyR1JPjbWt37ealpc6i2ZwvIaw4ks+
	 IskBvVXpaM256dD32hbqKvx8NITZs2PAXJMTR7mb5vkI/uqgKG/U1gxBrgPxdnUfWY
	 oO7mpKVWZM7yQDfy+uPkrlkPgixJZnkayC7VHnZFnbGELU65n5c3RLwD30onJxBViW
	 QTYAiULrfLWlPgAr1bGaBxZnLYMQtMQKrcVr3dpsU20tbKxrP0F7uz73WMMygGZ2so
	 /lgH1gnK1nKrw==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: rppt@kernel.org,  akpm@linux-foundation.org,  catalin.marinas@arm.com,
  changyuanl@google.com,  graf@amazon.com,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v3] KHO: Fix boot failure due to kmemleak access to
 non-PRESENT pages
In-Reply-To: <20251124025943.94469-1-ranxiaokai627@163.com> (ranxiaokai's
	message of "Mon, 24 Nov 2025 02:59:43 +0000")
References: <20251124025943.94469-1-ranxiaokai627@163.com>
Date: Mon, 24 Nov 2025 13:16:55 +0100
Message-ID: <mafs0see3zkug.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_041659_812197_0049AFE3 
X-CRM114-Status: GOOD (  17.46  )
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

On Mon, Nov 24 2025, ranxiaokai627@163.com wrote:

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
> KHO scratch areas are allocated from memblock and noted by kmemleak. But
> these areas don't remain reserved but released later to the page allocator
> using init_cma_reserved_pageblock(). This causes subsequent kmemleak scans
> access non-PRESENT pages, leading to fatal page faults.
>
> Mark scratch areas with kmemleak_ignore_phys() after they are allocated
> from memblock to exclude them from kmemleak scanning before they are
> released to buddy allocator to fix this.
>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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

Can you please put the explanation you gave in [0] for why this is not
necessary in KHO boot as a comment here?

After that,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[0] https://lore.kernel.org/all/20251122175735.92578-1-ranxiaokai627@163.com/

>  		for (pfn = base_pfn; pfn < base_pfn + count;
>  		     pfn += pageblock_nr_pages)
>  			init_cma_reserved_pageblock(pfn_to_page(pfn));

-- 
Regards,
Pratyush Yadav

