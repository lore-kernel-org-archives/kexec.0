Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F754CFC27C
	for <kexec@archiver.kernel.org>; Fri, 21 Nov 2025 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ps/C03GrU73xa5Wp33M/88ikT+6aQd9rzr+y25IqkQU=; b=D0iwqPmDQJ0+mAaPLA2EgfyVQr
	/DqfyhiKxw6SBKZK0ckOxE3ErRcgkQsazFmnUhfQIK/TZ03+2B7tYDtrc2GuqYK87V9p1iZQ4f4kK
	3r1AFuk5YfYMvJBWGHs0+SW89JFn/wuUCr/VqVUpHRIkwX28giMNzYksfWvDt+FRVYn/UfvFERsBd
	8qlzjpyPJv1gd5NLafHWNk2HQrsJv4Naeyl783kuoLKgYZ1qwyBr3lizI4ts6v+nJJb0mNyeNBPgt
	R1EI4DHE6JZIEfB1jKz8qH8cvOVC6bQr89nnyLH0217A0o+hhtsnqBnve8Q59uPmvtQzV2KNflVJY
	ZmFeqQTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMRJs-00000008QDO-3UXm;
	Fri, 21 Nov 2025 13:37:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMRJr-00000008QCd-19NG
	for kexec@lists.infradead.org;
	Fri, 21 Nov 2025 13:37:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2257943A82;
	Fri, 21 Nov 2025 13:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BB4C4CEF1;
	Fri, 21 Nov 2025 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763732217;
	bh=gmNU8aO4a+0cyi6R2ypDeco/WZeysrGhC1fhSvHHEmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i35emxhE/HumLeVdn4T2hbgV1EKis8USH5PMwPQqjrJdbEVdFlICaKV9t9pBQ+C8w
	 4/9EyDK39Bq0/57mVEfXnqWsU37JKELSoqWnt7XoDdpnYvuY0KNAnJw9qBgjXgNREn
	 uaL0NQvZGiCJatDvarteEp9av6uL4Kp3uUMVuZSc8wXsDOSt7vKdazpwMpJG6wLuDa
	 aF8pRoZIfy/vEjJvxuHacilp9Qj9eK/cwK6RKwZPUSP+MwF19AV7P4RVAbvdVR8c9w
	 +C4YmPGo8rAvlE3OyvHUS1Kkm8Wbm+Kugv1+hpPRQZKHYKYmnqsTCL+Y3c3RLpt0a9
	 pB0TVKRohObWw==
Date: Fri, 21 Nov 2025 15:36:49 +0200
From: Mike Rapoport <rppt@kernel.org>
To: ranxiaokai627@163.com
Cc: catalin.marinas@arm.com, akpm@linux-foundation.org, graf@amazon.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	changyuanl@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org,
	ran.xiaokai@zte.com.cn
Subject: Re: [PATCH 2/2] liveupdate: Fix boot failure due to kmemleak access
 to unmapped pages
Message-ID: <aSBq8T8ETc3zjBf6@kernel.org>
References: <20251120144147.90508-1-ranxiaokai627@163.com>
 <20251120144147.90508-3-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120144147.90508-3-ranxiaokai627@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_053659_332757_40196271 
X-CRM114-Status: GOOD (  17.69  )
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

On Thu, Nov 20, 2025 at 02:41:47PM +0000, ranxiaokai627@163.com wrote:
> Subject: liveupdate: Fix boot failure due to kmemleak access to unmapped pages

Please prefix kexec handover patches with kho: rather than liveupdate.

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
> 
> Call kmemleak_no_scan_phys() from kho_reserve_scratch() to
> exclude the reserved region from scanning before
> it is released to the buddy allocator.
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

There's kmemleak_ignore_phys() that can be called after the scratch areas
allocated from memblock and with that kmemleak should not access them.

Take a look at __cma_declare_contiguous_nid().

>  	kho_scratch[i].addr = addr;
>  	kho_scratch[i].size = size;
>  	i++;

-- 
Sincerely yours,
Mike.

