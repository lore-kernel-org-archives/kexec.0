Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4951EA811B
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YSwYNeCOyJFr9mH7yM3wvUmcRA7MNm7DC826kAO04RA=; b=D++8Z5gCsw62GtFPXbhSS/mKdx
	FwxJNODlSuVfdIEtZT0cpX0UyBfn+zGuzzP1VeNSA4vYA3RoTNWc5C8T/QDx803RmkwHRFxpbANje
	ScID3Plw7cELOYZIk3CAVdsv/3Cg2fiazW/CHpyBZ/v+X5yav9KjJw4VTjeHWeBk11ogebxBkPQi0
	vS49pn/dF84F89GY+DTHZeLm6k7VooVJ3UmotQmxwLBEm17Cu5NFO0UcwzdgNl3UnTvDMqyJeUv+7
	xmkdZTRk6SxiHcO+C3wAX3664n32pM0iAX5IE1CiFUJVbhtEnQFpHNypFTF2o2kPr5v5S+VVEzWMP
	OSMJMflw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpo39-0000000H0TU-3t7e;
	Tue, 10 Feb 2026 13:45:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpo38-0000000H0TF-3C9o
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:45:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 232E260136;
	Tue, 10 Feb 2026 13:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09900C16AAE;
	Tue, 10 Feb 2026 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770731105;
	bh=26+FDCEQwNmok8Zy9VH7xG1rfoNpFpyh5Os30EkIFhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L07Th7f5XZMNL4DPZNp7iGhK/MkggMhPQd+6GnpSRO9uacbIChCGIArP3Bk65MT7e
	 VeVhJoldE25cfN6Mnr0ssXWFinpEq7DyU+kTPVT3Dc+/RfRDh73hcocq+JHplE/xcp
	 3VkH4D/F4PW7wkpFZ2SZavF9ycU+9UyN6+yOMQDxqR25sjr5HE780HZXaBRIWigGsC
	 yMD6SG8159daR0BsYEMUsVHf5un/W1geMNRnsc2zn6jvopbYhfOlo0UVT/hFzpgTss
	 NOMM9bNJb1/HL4Z0+KU6IUMExl2XBc7G3ZylQHhhvXzwED9dPJIWZFC3JUNd5/IyZq
	 nmCXB/3rkO+eA==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  akpm@linux-foundation.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  ran.xiaokai@zte.com.cn,
  stable@vger.kernel.org
Subject: Re: [PATCH -next 1/2] kho: fix missing early_memunmap() call in
 kho_populate()
In-Reply-To: <20260206043121.197564-2-ranxiaokai627@163.com> (ranxiaokai's
	message of "Fri, 6 Feb 2026 04:31:20 +0000")
References: <20260206043121.197564-1-ranxiaokai627@163.com>
	<20260206043121.197564-2-ranxiaokai627@163.com>
Date: Tue, 10 Feb 2026 14:45:02 +0100
Message-ID: <2vxzv7g4sof5.fsf@kernel.org>
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

Hi Ran,

Thanks for the fix.

On Fri, Feb 06 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> kho_populate() returns without calling early_memunmap() on success
> path, this will cause early ioremap virtual address space leak.
>
> Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>
> b50634c5e84a ("kho: cleanup error handling in kho_populate()")
> has not landed in upstream, so
> Cc: <stable@vger.kernel.org> is unnecessary?
>
>  kernel/liveupdate/kexec_handover.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index fb3a7b67676e..76b714db175d 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1463,6 +1463,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	struct kho_scratch *scratch = NULL;
>  	phys_addr_t mem_map_phys;
>  	void *fdt = NULL;
> +	int populated = 0;

Nit: Please use a bool and true/false. I think it reads much nicer.

>  	int err;
>  
>  	/* Validate the input FDT */
> @@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	kho_in.scratch_phys = scratch_phys;
>  	kho_in.mem_map_phys = mem_map_phys;
>  	kho_scratch_cnt = scratch_cnt;
> -	pr_info("found kexec handover data.\n");
>  
> -	return;
> +	populated = 1;
> +	pr_info("found kexec handover data.\n");
>  
>  err_unmap_scratch:
>  	early_memunmap(scratch, scratch_len);
>  err_unmap_fdt:
>  	early_memunmap(fdt, fdt_len);
>  err_report:

Nit: now that this code can be reached by non-error paths, we should
re-name the labels. I think dropping the "err_" prefix should be enough.

With these fixed,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> -	pr_warn("disabling KHO revival\n");
> +	if (!populated)
> +		pr_warn("disabling KHO revival\n");
>  }
>  
>  /* Helper functions for kexec_file_load */

-- 
Regards,
Pratyush Yadav

