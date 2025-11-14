Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA47CE8D4F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KUEecNRoeBKG0XiBz+zcBfCaqxy8Kw7OvPQ59OVjlp8=; b=EbPadcxaO2qrGy9Okb+ySJ60Nq
	IV2hjsW1iUXygn/wRahJv3RZx7ng8aNLZPwN8K8L1bNfaoylULKQkiecBOwxKjvrjFypNVBxZSJkk
	grRxGXk04nHv7L7fQAlMoZLV9CtkFaG4nRVdBGJjg7RPVkyep0H9cCNK9+68cL9+kCt84RomDyV7a
	1Uk6R1jjaIhDkl7QZqp54MgIJEeLzvSKxBSqTjAcRhVrdaliOJVTTzmrnELBvq3qxZueBrCCrL0yG
	yU145Zw8p8+6LPcDuI7xI7RidWEtuPHHnvS7JOiETLwE20u/ElON8F4JaAGix2OBLDuyIlkpbuYGp
	55i/zHNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwSX-0000000Cify-245Q;
	Fri, 14 Nov 2025 16:15:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwSW-0000000Cifo-2dA6
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:15:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 14E5F60174;
	Fri, 14 Nov 2025 16:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E27C116D0;
	Fri, 14 Nov 2025 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763136935;
	bh=mS05zN0VOwxcIzYeKKKWbjayWEtwO0xQ9kdg6GbidOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZwFnJlVY28QzM9QIPLYI58Lo7h47lF3Ah6v4Eq+44AwDgv3fODBre/S6VrWs8hth
	 BlZS3y6bx+osk95r4i8m8r7Fe/sCVNuR5NoKt8h2PJOD8e/lz76TCOtXdnlh3Q3Rth
	 +EOVlg9JTIMGb4+o5+0Pt6mZ/qr/3lfRQ2ToalES0NHGEyDAf0ejHk72tlOaIuQ6uw
	 e8u44IuwWr3SK8UJCCAeydFyOv90rnPB3OogbeL4dbg1R4cguV7ca3DViK6WYTdrRO
	 PbWyboobPJKmEv7zB8f03zlqyNvbC0W9X+Aw6SNlXf5Rj3/n3sD+/B/vQ2V2CZUqiS
	 Mon4k6NpRynJw==
Date: Fri, 14 Nov 2025 18:15:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com,
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca,
	ebiggers@google.com, graf@amazon.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1 09/13] kho: Update FDT dynamically for subtree
 addition/removal
Message-ID: <aRdVn-e3Wu_pFdmZ@kernel.org>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-10-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114155358.2884014-10-pasha.tatashin@soleen.com>
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

On Fri, Nov 14, 2025 at 10:53:54AM -0500, Pasha Tatashin wrote:
> Currently, sub-FDTs were tracked in a list (kho_out.sub_fdts) and the
> final FDT is constructed entirely from scratch during kho_finalize().
> 
> We can maintain the FDT dynamically:
> 1. Initialize a valid, empty FDT in kho_init().
> 2. Use fdt_add_subnode and fdt_setprop in kho_add_subtree to
>    update the FDT immediately when a subsystem registers.
> 3. Use fdt_del_node in kho_remove_subtree to remove entries.
> 
> This removes the need for the intermediate sub_fdts list and the
> reconstruction logic in kho_finalize(). kho_finalize() now
> only needs to trigger memory map serialization.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 144 ++++++++++++++---------------
>  1 file changed, 68 insertions(+), 76 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 8ab77cb85ca9..822da961d4c9 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -724,37 +713,67 @@ static void __init kho_reserve_scratch(void)
>   */
>  int kho_add_subtree(const char *name, void *fdt)
>  {
> -	struct kho_sub_fdt *sub_fdt;
> +	phys_addr_t phys = virt_to_phys(fdt);
> +	void *root_fdt = kho_out.fdt;
> +	int err = -ENOMEM;
> +	int off, fdt_err;
>  
> -	sub_fdt = kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
> -	if (!sub_fdt)
> -		return -ENOMEM;
> +	guard(mutex)(&kho_out.lock);
> +
> +	fdt_err = fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
> +	if (fdt_err < 0)
> +		return err;
> -	INIT_LIST_HEAD(&sub_fdt->l);
> -	sub_fdt->name = name;
> -	sub_fdt->fdt = fdt;
> +	off = fdt_add_subnode(root_fdt, 0, name);

	fdt_err = fdt_add_subnode();

and then we don't need off

> +	if (off < 0) {
> +		if (off == -FDT_ERR_EXISTS)
> +			err = -EEXIST;

Is it really -ENOMEM for other FDT_ERR values?
		
> +		goto out_pack;
> +	}
> +
> +	err = fdt_setprop(root_fdt, off, PROP_SUB_FDT, &phys, sizeof(phys));
> +	if (err < 0)
> +		goto out_pack;
>  
> -	guard(mutex)(&kho_out.fdts_lock);
> -	list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
>  	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
>  
> -	return 0;
> +out_pack:
> +	fdt_pack(root_fdt);
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(kho_add_subtree);

-- 
Sincerely yours,
Mike.

