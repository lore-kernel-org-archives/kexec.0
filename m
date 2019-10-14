Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iK2MZ-0002F1-Eo
 for kexec@lists.infradead.org; Mon, 14 Oct 2019 15:34:24 +0000
Received: by mail-qt1-x841.google.com with SMTP id j31so25994317qta.5
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2019 08:34:22 -0700 (PDT)
Date: Mon, 14 Oct 2019 15:34:19 +0000
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v6 08/17] arm64: hibernate: add trans_pgd public functions
Message-ID: <20191014153419.galjhum7amnyuiml@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-9-pasha.tatashin@soleen.com>
 <2ea69969-154d-fa55-767d-43ea8971dd0e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ea69969-154d-fa55-767d-43ea8971dd0e@arm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: James Morse <james.morse@arm.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

> > +
> > +	memcpy(page, src_start, length);
> > +	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> > +
> > +	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
> > +	if (!trans_pgd)
> > +		return -ENOMEM;
> > +
> > +	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
> > +				PAGE_KERNEL_EXEC);
> > +	if (rc)
> > +		return rc;
> > +
> >  	/*
> >  	 * Load our new page tables. A strict BBM approach requires that we
> >  	 * ensure that TLBs are free of any entries that may overlap with the
> 
> (I suspect you are going to to duplicate this in the kexec code. Kexec has the same
> pattern: instructions that have to be copied to do the relocation of the rest of memory)
> 

Yes, the relocation function is also copied, but I do not see an easy
way to unify this particular code with kexec. We can discuss in kexec
part of this series what else can be unified with hibernate's code.

> 
> > @@ -462,6 +476,24 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
> 
> > +int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> > +			  unsigned long end)
> > +{
> > +	int rc;
> > +	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
> > +
> > +	if (!trans_pgd) {
> > +		pr_err("Failed to allocate memory for temporary page tables.\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	rc = copy_page_tables(trans_pgd, start, end);
> > +	if (!rc)
> > +		*dst_pgdp = trans_pgd;
> 
> *dst_pgdp was already allocated in swsusp_arch_resume().

Good catch, I forgot to remove allocation from swsusp_arch_resume().

 
> > +
> > +	return rc;
> > +}
> > +
> >  /*
> >   * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
> >   *
> > @@ -488,7 +520,7 @@ int swsusp_arch_resume(void)
> >  		pr_err("Failed to allocate memory for temporary page tables.\n");
> >  		return -ENOMEM;
> >  	}
> 
> If the allocation moves into 'trans_pgd_create_copy()', please move the code just above
> here (cut off by the diff) that allocates it in swsusp_arch_resume().
> 
> Its actually okay to leak memory like this, hibernate's allocator acts as a memory pool.
> It either gets freed if we fail to resume, or vanishes when the resumed kernel takes over.

I did.

> 
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
