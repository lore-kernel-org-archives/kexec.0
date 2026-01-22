Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AF1D3EE64
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vTHvVWFze9CJnkjQ6D1yc3NzdZ7K4HhoZBQaVdDFWhQ=; b=c/heCXqO7UFKPqU8rRt7aNW55T
	6w06YG1XI7+0oQY+RzA6saX/eB4AWmC3yO43IrjB23w6mCXNsbTrpKaguSYcj+eOnt7hMWldLeu05
	AEkL5VuKL1oeiPo318CmbZEC8SZglKybV+uj+y5WD1zajBW+Y76F07UnA+kFzG7t8WyNxhjRWD9jL
	2al75ywZLPdXWGblFECaD45VhdiNoQZqE4QFYguUXhRZd0rosQZHKaDCdlKce/PYQAnRxrLiz2U/y
	Q1jxe978goeV+eErbiD9FedRunlkFd15cI0ixvHoPHygb1+qK6HQeP5ppDZFQeTeaFSygfdXWw4in
	MIrSPaIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viugZ-0000000793p-0HFw;
	Thu, 22 Jan 2026 13:25:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viugW-0000000793T-2Bgf
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 13:25:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DC2944384A;
	Thu, 22 Jan 2026 13:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BE2C116C6;
	Thu, 22 Jan 2026 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088315;
	bh=d1MizkSspn35pSSs7WFrLUELoQ81+EVmGUW7ZT92Lrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrWDFB4LDs5qEsCqYCX4YttxexqobOOT5/sJCBLb0TEh9RryY3YsPgJZ/e5riSTlR
	 IQ30Vc0vhpPtnYWppdOv4w+ZHtC8SNvTXJ8Kif6FC36DzL2brlBX+okaosbATHG8DH
	 OiYwZLCElV2t0XYYeIHbXIiql8paKwShrc3rN80YTviSbeSNBx3NvpQpZlrT99h8QJ
	 lcXzaakIx/Lee+fvfPbbHkIMGcXMFp56ydFtnTcHz+NXe0rS/olpls4/T2D8QlvNAT
	 ed+eqflFLefMPQSfIEQwJP82SaiVpEjY5Olt34bHZaoNrvsc7amCvDKhh1gdK63vB1
	 TJJtGQeF9zNsQ==
Date: Thu, 22 Jan 2026 15:25:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: cleanup error handling in kho_populate()
Message-ID: <aXIlNX5uxms5DLrj@kernel.org>
References: <20260122121757.575987-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122121757.575987-1-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_052516_625964_C50C3948 
X-CRM114-Status: GOOD (  23.30  )
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

(cc the correct Pratyush's address)

On Thu, Jan 22, 2026 at 02:17:57PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> * use dedicated labels for error handling instead of checking if a pointer
>   is not null to decide if it should be unmapped
> * drop assignment of values to err that are only used to print a numeric
>   error code, there are pr_warn()s for each failure already so printing a
>   numeric error code in the next line does not add anything useful
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 39 +++++++++++++-----------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index d4482b6e3cae..e248ce2e04b7 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1441,46 +1441,40 @@ void __init kho_memory_init(void)
>  void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  			 phys_addr_t scratch_phys, u64 scratch_len)
>  {
> +	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
>  	struct kho_scratch *scratch = NULL;
>  	phys_addr_t mem_map_phys;
>  	void *fdt = NULL;
> -	int err = 0;
> -	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
> +	int err;
>  
>  	/* Validate the input FDT */
>  	fdt = early_memremap(fdt_phys, fdt_len);
>  	if (!fdt) {
>  		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
> -		err = -EFAULT;
> -		goto out;
> +		goto err_report;
>  	}
>  	err = fdt_check_header(fdt);
>  	if (err) {
>  		pr_warn("setup: handover FDT (0x%llx) is invalid: %d\n",
>  			fdt_phys, err);
> -		err = -EINVAL;
> -		goto out;
> +		goto err_unmap_fdt;
>  	}
>  	err = fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
>  	if (err) {
>  		pr_warn("setup: handover FDT (0x%llx) is incompatible with '%s': %d\n",
>  			fdt_phys, KHO_FDT_COMPATIBLE, err);
> -		err = -EINVAL;
> -		goto out;
> +		goto err_unmap_fdt;
>  	}
>  
>  	mem_map_phys = kho_get_mem_map_phys(fdt);
> -	if (!mem_map_phys) {
> -		err = -ENOENT;
> -		goto out;
> -	}
> +	if (!mem_map_phys)
> +		goto err_unmap_fdt;
>  
>  	scratch = early_memremap(scratch_phys, scratch_len);
>  	if (!scratch) {
>  		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
>  			scratch_phys, scratch_len);
> -		err = -EFAULT;
> -		goto out;
> +		goto err_unmap_fdt;
>  	}
>  
>  	/*
> @@ -1497,7 +1491,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  		if (WARN_ON(err)) {
>  			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
>  				&area->addr, &size, ERR_PTR(err));
> -			goto out;
> +			goto err_unmap_scratch;
>  		}
>  		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
>  	}
> @@ -1519,13 +1513,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	kho_scratch_cnt = scratch_cnt;
>  	pr_info("found kexec handover data.\n");
>  
> -out:
> -	if (fdt)
> -		early_memunmap(fdt, fdt_len);
> -	if (scratch)
> -		early_memunmap(scratch, scratch_len);
> -	if (err)
> -		pr_warn("disabling KHO revival: %d\n", err);
> +	return;
> +
> +err_unmap_scratch:
> +	early_memunmap(scratch, scratch_len);
> +err_unmap_fdt:
> +	early_memunmap(fdt, fdt_len);
> +err_report:
> +	pr_warn("disabling KHO revival\n");
>  }
>  
>  /* Helper functions for kexec_file_load */
> 
> base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
> -- 
> 2.51.0
> 

-- 
Sincerely yours,
Mike.

