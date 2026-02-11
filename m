Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6C5E81BD2
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rU1KAvAo1H7MiW39m0oU47bA0IRaQrNpi750xrEsxDc=; b=mBq4RtYo9h2GeP3Q8/ziqGFMGU
	Oz6jlrYc70+lMFxdNHG/1aadDUC03yGuf8ILnR5vvf6VaY1htIQpXl5bNazgbJB2QZ6QRI+FKoqcZ
	jL/ln5eEu+KHwA4PMm7KKwDV4amUNOOiesqHOUGCarMy5cDwRbY4b9hMrrk+GemMllxj57JNMxebU
	r5gjiEkUt1W/R7gbwKqIpyJUfB4d8IOz+ZvD54024ay74Jy1Bcx+IHbZo1FEWa9SfGYtgYerRnMUY
	/umvbcmeGgerdEOvSnioEgybbsey/ZbpZxCjAFNE49Ubh2LnPVzbNSGcSLg8DzdgN5l4XWI9lXIB+
	upic7DlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq6Zd-00000000ROs-0LkP;
	Wed, 11 Feb 2026 09:31:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq6ZZ-00000000ROU-3oJc
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 09:31:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3912D43801;
	Wed, 11 Feb 2026 09:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E968C4CEF7;
	Wed, 11 Feb 2026 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770802309;
	bh=BohRPRiY3VE+/X8kSB1tjVdVbZoLXjZP2UZzgT4RPtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JtJyX6PORi1H5S7yfts2K92qjyIudjo1Q8JLoaiC3KIOs/Cqwib4Ng76J9VdM4rxA
	 gC6DO/zlY3MQSnfUzi/7+2hiKjgfBB3y4mbOjnhKCxWfNlXSzC4Sm3RxD53i+vmKiM
	 KbqMYkulTmZnk8Oj1FrYCeHF2SY6CX6Swi+puBCFg2j4BUc3IRS9+ZzSxeFBRv9t0T
	 Ddzn/n9qOjY1ygk9t0kKLVfLbAbB8wblHYEIIgtacr7pSTrXq3UE7UizWu7qMgo+F3
	 tRH4j1AWvVvzFt+DkxR4WchbuX/UMm0qdupf3bKFNHY8ZziRGgBMxkKZA1CAP8Ou3r
	 ta1sEcm3fEBsQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  akpm@linux-foundation.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v2 1/2] kho: fix missing early_memunmap() call in
 kho_populate()
In-Reply-To: <20260211032937.208353-2-ranxiaokai627@163.com> (ranxiaokai's
	message of "Wed, 11 Feb 2026 03:29:36 +0000")
References: <20260211032937.208353-1-ranxiaokai627@163.com>
	<20260211032937.208353-2-ranxiaokai627@163.com>
Date: Wed, 11 Feb 2026 10:31:45 +0100
Message-ID: <2vxzy0kzr5ha.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_013149_997056_1BEAC551 
X-CRM114-Status: GOOD (  18.10  )
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

Hi Ran,

On Wed, Feb 11 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> kho_populate() returns without calling early_memunmap() on success
> path, this will cause early ioremap virtual address space leak.
>
> Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/liveupdate/kexec_handover.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index fb3a7b67676e..3c705b08a489 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1463,13 +1463,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	struct kho_scratch *scratch = NULL;
>  	phys_addr_t mem_map_phys;
>  	void *fdt = NULL;
> +	bool populated = false;
>  	int err;
>  
>  	/* Validate the input FDT */
>  	fdt = early_memremap(fdt_phys, fdt_len);
>  	if (!fdt) {
>  		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
> -		goto err_report;
> +		goto report;
>  	}
>  	err = fdt_check_header(fdt);
>  	if (err) {
> @@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	kho_in.scratch_phys = scratch_phys;
>  	kho_in.mem_map_phys = mem_map_phys;
>  	kho_scratch_cnt = scratch_cnt;
> -	pr_info("found kexec handover data.\n");
>  
> -	return;
> +	populated = true;
> +	pr_info("found kexec handover data.\n");
>  
>  err_unmap_scratch:
>  	early_memunmap(scratch, scratch_len);
>  err_unmap_fdt:
>  	early_memunmap(fdt, fdt_len);

I meant to say all these labels should be renamed, not just err_report.
So "err_unmap_scratch" should be "unmap_scratch", and "err_unmap_fdt"
should be "unmap_fdt".

> -err_report:
> -	pr_warn("disabling KHO revival\n");
> +report:
> +	if (!populated)
> +		pr_warn("disabling KHO revival\n");
>  }
>  
>  /* Helper functions for kexec_file_load */

-- 
Regards,
Pratyush Yadav

