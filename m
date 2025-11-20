Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62697CF8875
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5sjrMVguqYtKBqGhH4ECYdIUD8k3FOXNKADzIAX6Ncg=; b=RTr4sC7fgBwkvnFwoXCYbyXTA0
	t/sWHPsq+y9eS2iOMZuJGEWAWeHSLYzsN6eDFN7E+Wgr2e2XOyxclRn4ZMX7JuxLqlVz+rTVHxm9n
	YBt2wAlOyC+kKNqW4ZXkYJqXfOAgJqbIfdqyg1WQNDHvkadjdqMfnpCeySkibhlOsmt2J9wDl5m4i
	kTrmPK6AV3vIp8Zxwv8c62Q4ppWKjbsxZiuZFba51AiuOdjhaTnNwFB6sei8pZn4zyXTiQghHzIez
	2Pkl1EfEyEGLdD9dmRT8XMmxg3YTdcOqqNYW622noDsh6bzCn2qhSpNOFybf3mMnUp8RExjSP3N34
	s2pLLgGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM7Lj-00000006zRh-0BYK;
	Thu, 20 Nov 2025 16:17:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM7Lh-00000006zRV-2hHc
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 16:17:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E6A8B60146;
	Thu, 20 Nov 2025 16:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8D9C116D0;
	Thu, 20 Nov 2025 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763655451;
	bh=NxStlN0sykH1gh6u/oPgxyBdh3fqUB6K49dDrBU3dDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aeotwaVP/quTK59YtQvEIkiP8/BGxEN9pfdawUrjnS7OkA05j2AJyR4Ra/g5VQSv5
	 UehQfPQbBNvFe4Nk6zt/Ny7nUGJFLrYk4ZX6FD1zR6Zxhu19BmdG1h5WDGqRP/I7E/
	 Kghk8ZEdsMQTqZUDbFhym+ftH4FtEVQvoikKhr5Or2WcufcL4kauCfQlf6O6onaBy5
	 gYpZP/5gEiXN/o59nqfT22nZgjQpRiIWLiNnmmcj4ufXfZdlv7nQ/FeTSTj8eV26Sb
	 a32axiyrfZPbjLgueRCrAjQWV+iKHqBW0YXxyqvt/8f684TLg3o9rWW7gbQKL9PgZ+
	 To+wTcRhvXj5g==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: catalin.marinas@arm.com,  akpm@linux-foundation.org,  graf@amazon.com,
  rppt@kernel.org,  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  changyuanl@google.com,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  kexec@lists.infradead.org,  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH 2/2] liveupdate: Fix boot failure due to kmemleak access
 to unmapped pages
In-Reply-To: <20251120144147.90508-3-ranxiaokai627@163.com> (ranxiaokai's
	message of "Thu, 20 Nov 2025 14:41:47 +0000")
References: <20251120144147.90508-1-ranxiaokai627@163.com>
	<20251120144147.90508-3-ranxiaokai627@163.com>
Date: Thu, 20 Nov 2025 17:17:28 +0100
Message-ID: <mafs05xb43ch3.fsf@kernel.org>
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

On Thu, Nov 20 2025, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> When booting with debug_pagealloc=on while having:
> CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n
> the system fails to boot due to page faults during kmemleak scanning.
>
> This occurs because:
> With debug_pagealloc enabled, __free_pages() invokes
> debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
> freed pages in the direct mapping.
> Commit 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> releases the KHO scratch region via init_cma_reserved_pageblock(),
> unmapping its physical pages. Subsequent kmemleak scanning accesses
> these unmapped pages, triggering fatal page faults.

I don't know how kmemleak works. Why does kmemleak access the unmapped
pages? If pages are not mapped, it should learn to not access them,
right?

>
> Call kmemleak_no_scan_phys() from kho_reserve_scratch() to
> exclude the reserved region from scanning before
> it is released to the buddy allocator.

kho_reserve_scratch() is called on the first boot. It allocates the
scratch areas for subsequent boots. On every KHO boot after this,
kho_reserve_scratch() is not called and kho_release_scratch() is called
instead since the scratch areas already exist from previous boot.

Eventually both paths converge to kho_init() and call
init_cma_reserved_pageblock().

So shouldn't you call kmemleak_no_scan_phys() from kho_init() instead?
This would reduce code duplication and cover both paths.

>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/liveupdate/kexec_handover.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 224bdf5becb6..dd4942d1d76c 100644
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
> @@ -654,6 +655,7 @@ static void __init kho_reserve_scratch(void)
>  	if (!addr)
>  		goto err_free_scratch_desc;
>  
> +	kmemleak_no_scan_phys(addr);
>  	kho_scratch[i].addr = addr;
>  	kho_scratch[i].size = size;
>  	i++;
> @@ -664,6 +666,7 @@ static void __init kho_reserve_scratch(void)
>  	if (!addr)
>  		goto err_free_scratch_areas;
>  
> +	kmemleak_no_scan_phys(addr);
>  	kho_scratch[i].addr = addr;
>  	kho_scratch[i].size = size;
>  	i++;
> @@ -676,6 +679,7 @@ static void __init kho_reserve_scratch(void)
>  		if (!addr)
>  			goto err_free_scratch_areas;
>  
> +		kmemleak_no_scan_phys(addr);
>  		kho_scratch[i].addr = addr;
>  		kho_scratch[i].size = size;
>  		i++;

-- 
Regards,
Pratyush Yadav

