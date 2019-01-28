Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCsE-0006yh-70
 for kexec@lists.infradead.org; Mon, 28 Jan 2019 19:47:16 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2] Remove the memory encryption mask to obtain the true
 physical address
Date: Mon, 28 Jan 2019 19:45:23 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0356730A@BPXM09GP.gisp.nec.co.jp>
References: <20190128054643.31572-1-lijiang@redhat.com>
 <e05d77ac-e12d-b06d-7564-9e0e9991ed1b@amd.com>
In-Reply-To: <e05d77ac-e12d-b06d-7564-9e0e9991ed1b@amd.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Lianbo Jiang <lijiang@redhat.com>
Cc: "anderson@redhat.com" <anderson@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

On 1/28/2019 9:24 AM, Lendacky, Thomas wrote:
> On 1/27/19 11:46 PM, Lianbo Jiang wrote:
> > For AMD machine with SME feature, if SME is enabled in the first
> > kernel, the crashed kernel's page table(pgd/pud/pmd/pte) contains
> > the memory encryption mask, so makedumpfile needs to remove the
> > memory encryption mask to obtain the true physical address.
> >
> > Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> > ---
> > Changes since v1:
> > 1. Merge them into a patch.
> > 2. The sme_mask is not an enum number, remove it.
> > 3. Sanity check whether the sme_mask is in vmcoreinfo.
> > 4. Deal with the huge pages case.
> > 5. Cover the 5-level path.
> >
> >  arch/x86_64.c  | 30 +++++++++++++++++-------------
> >  makedumpfile.c |  4 ++++
> >  makedumpfile.h |  1 +
> >  3 files changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/x86_64.c b/arch/x86_64.c
> > index 537fb78..7b3ed10 100644
> > --- a/arch/x86_64.c
> > +++ b/arch/x86_64.c
> > @@ -291,6 +291,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
> >  	unsigned long page_dir, pgd, pud_paddr, pud_pte, pmd_paddr, pmd_pte;
> >  	unsigned long pte_paddr, pte;
> >  	unsigned long p4d_paddr, p4d_pte;
> > +	unsigned long sme_me_mask = ~0UL;
> >
> >  	/*
> >  	 * Get PGD.
> > @@ -302,6 +303,9 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
> >  			return NOT_PADDR;
> >  	}
> >
> > +	if (NUMBER(sme_mask) != NOT_FOUND_NUMBER)
> > +		sme_me_mask = ~(NUMBER(sme_mask));
> 
> This is a bit confusing since this isn't the sme_me_mask any more, but the
> complement. Might want to somehow rename this so that it doesn't cause any
> confusion.
> 
> > +
> >  	if (check_5level_paging()) {
> >  		page_dir += pgd5_index(vaddr) * sizeof(unsigned long);
> >  		if (!readmem(PADDR, page_dir, &pgd, sizeof pgd)) {
> > @@ -309,7 +313,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
> >  			return NOT_PADDR;
> >  		}
> >  		if (info->vaddr_for_vtop == vaddr)
> > -			MSG("  PGD : %16lx => %16lx\n", page_dir, pgd);
> > +			MSG("  PGD : %16lx => %16lx\n", page_dir, (pgd & sme_me_mask));
> 
> No need to remove the mask here.  You're just printing out the value of
> the entry. It might be nice to know whether the encryption bit is set or
> not - after all, ENTRY_MASK is still part of this value.

Agreed.

> 
> >
> >  		if (!(pgd & _PAGE_PRESENT)) {
> >  			ERRMSG("Can't get a valid pgd.\n");
> > @@ -318,20 +322,20 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
> >  		/*
> >  		 * Get P4D.
> >  		 */
> > -		p4d_paddr  = pgd & ENTRY_MASK;
> > +		p4d_paddr  = pgd & ENTRY_MASK & sme_me_mask;
> 
> This goes back to my original comment that you should just make a local
> variable that is "ENTRY_MASK & ~(NUMBER(sme_mask))" since you are
> performing this ANDing everywhere ENTRY_MASK is used - except then you
> miss the one at the very end of this routine on the return statement.

This was my idea I said to Lianbo before seeing your comment, but
yes, including ENTRY_MASK in a local variable is better than that.
Thanks for your good suggestion.

As for the variable's name, I think that "entry_mask" is good enough,
but any better name?

  unsigned long entry_mask = ENTRY_MASK;

  if (NUMBER(sme_mask) != NOT_FOUND_NUMBER)
      entry_mask &= ~(NUMBER(sme_mask));
  ...
  p4d_paddr = pgd & entry_mask;

And, I found that the find_vmemmap_x86_64() function also uses the
page table for the -e option and looks to be affected by SME.
Lianbo, would you fix the function, too?

Thanks,
Kazu

> 
> >  		p4d_paddr += p4d_index(vaddr) * sizeof(unsigned long);
> >  		if (!readmem(PADDR, p4d_paddr, &p4d_pte, sizeof p4d_pte)) {
> >  			ERRMSG("Can't get p4d_pte (p4d_paddr:%lx).\n", p4d_paddr);
> >  			return NOT_PADDR;
> >  		}
> >  		if (info->vaddr_for_vtop == vaddr)
> > -			MSG("  P4D : %16lx => %16lx\n", p4d_paddr, p4d_pte);
> > +			MSG("  P4D : %16lx => %16lx\n", p4d_paddr, (p4d_pte & sme_me_mask));
> >
> >  		if (!(p4d_pte & _PAGE_PRESENT)) {
> >  			ERRMSG("Can't get a valid p4d_pte.\n");
> >  			return NOT_PADDR;
> >  		}
> > -		pud_paddr  = p4d_pte & ENTRY_MASK;
> > +		pud_paddr  = p4d_pte & ENTRY_MASK & sme_me_mask;
> >  	}else {
> >  		page_dir += pgd_index(vaddr) * sizeof(unsigned long);
> >  		if (!readmem(PADDR, page_dir, &pgd, sizeof pgd)) {
> > @@ -339,13 +343,13 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
> >  			return NOT_PADDR;
> >  		}
> >  		if (info->vaddr_for_vtop == vaddr)
> > -			MSG("  PGD : %16lx => %16lx\n", page_dir, pgd);
> > +			MSG("  PGD : %16lx => %16lx\n", page_dir, (pgd & sme_me_mask));
> >
> >  		if (!(pgd & _PAGE_PRESENT)) {
> >  			ERRMSG("Can't get a valid pgd.\n");
> >  			return NOT_PADDR;
> >  		}
> > -		pud_paddr  = pgd & ENTRY_MASK;
> > +		pud_paddr  = pgd & ENTRY_MASK & sme_me_mask;
> >  	}
> >
> >  	/*
> > @@ -357,47 +361,47 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
> >  		return NOT_PADDR;
> >  	}
> >  	if (info->vaddr_for_vtop == vaddr)
> > -		MSG("  PUD : %16lx => %16lx\n", pud_paddr, pud_pte);
> > +		MSG("  PUD : %16lx => %16lx\n", pud_paddr, (pud_pte & sme_me_mask));
> >
> >  	if (!(pud_pte & _PAGE_PRESENT)) {
> >  		ERRMSG("Can't get a valid pud_pte.\n");
> >  		return NOT_PADDR;
> >  	}
> >  	if (pud_pte & _PAGE_PSE)	/* 1GB pages */
> > -		return (pud_pte & ENTRY_MASK & PUD_MASK) +
> > +		return (pud_pte & ENTRY_MASK & PUD_MASK & sme_me_mask) +
> >  			(vaddr & ~PUD_MASK);
> >
> >  	/*
> >  	 * Get PMD.
> >  	 */
> > -	pmd_paddr  = pud_pte & ENTRY_MASK;
> > +	pmd_paddr  = pud_pte & ENTRY_MASK & sme_me_mask;
> >  	pmd_paddr += pmd_index(vaddr) * sizeof(unsigned long);
> >  	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof pmd_pte)) {
> >  		ERRMSG("Can't get pmd_pte (pmd_paddr:%lx).\n", pmd_paddr);
> >  		return NOT_PADDR;
> >  	}
> >  	if (info->vaddr_for_vtop == vaddr)
> > -		MSG("  PMD : %16lx => %16lx\n", pmd_paddr, pmd_pte);
> > +		MSG("  PMD : %16lx => %16lx\n", pmd_paddr, (pmd_pte & sme_me_mask));
> >
> >  	if (!(pmd_pte & _PAGE_PRESENT)) {
> >  		ERRMSG("Can't get a valid pmd_pte.\n");
> >  		return NOT_PADDR;
> >  	}
> >  	if (pmd_pte & _PAGE_PSE)	/* 2MB pages */
> > -		return (pmd_pte & ENTRY_MASK & PMD_MASK) +
> > +		return (pmd_pte & ENTRY_MASK & PMD_MASK & sme_me_mask) +
> >  			(vaddr & ~PMD_MASK);
> >
> >  	/*
> >  	 * Get PTE.
> >  	 */
> > -	pte_paddr  = pmd_pte & ENTRY_MASK;
> > +	pte_paddr  = pmd_pte & ENTRY_MASK & sme_me_mask;
> >  	pte_paddr += pte_index(vaddr) * sizeof(unsigned long);
> >  	if (!readmem(PADDR, pte_paddr, &pte, sizeof pte)) {
> >  		ERRMSG("Can't get pte (pte_paddr:%lx).\n", pte_paddr);
> >  		return NOT_PADDR;
> >  	}
> >  	if (info->vaddr_for_vtop == vaddr)
> > -		MSG("  PTE : %16lx => %16lx\n", pte_paddr, pte);
> > +		MSG("  PTE : %16lx => %16lx\n", pte_paddr, (pte & sme_me_mask));
> >
> >  	if (!(pte & _PAGE_PRESENT)) {
> >  		ERRMSG("Can't get a valid pte.\n");
> 
> Just after here is where I think an "& sme_me_mask" is missing...
> 
> Thanks,
> Tom
> 
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 8923538..2237eb8 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -977,6 +977,8 @@ next_page:
> >  	read_size = MIN(info->page_size - PAGEOFFSET(paddr), size);
> >
> >  	pgaddr = PAGEBASE(paddr);
> > +	if (NUMBER(sme_mask) != NOT_FOUND_NUMBER)
> > +		pgaddr = pgaddr & ~(NUMBER(sme_mask));
> >  	pgbuf = cache_search(pgaddr, read_size);
> >  	if (!pgbuf) {
> >  		++cache_miss;
> > @@ -2276,6 +2278,7 @@ write_vmcoreinfo_data(void)
> >  	WRITE_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
> >  	WRITE_NUMBER("N_ONLINE", N_ONLINE);
> >  	WRITE_NUMBER("pgtable_l5_enabled", pgtable_l5_enabled);
> > +	WRITE_NUMBER("sme_mask", sme_mask);
> >
> >  	WRITE_NUMBER("PG_lru", PG_lru);
> >  	WRITE_NUMBER("PG_private", PG_private);
> > @@ -2672,6 +2675,7 @@ read_vmcoreinfo(void)
> >  	READ_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
> >  	READ_NUMBER("N_ONLINE", N_ONLINE);
> >  	READ_NUMBER("pgtable_l5_enabled", pgtable_l5_enabled);
> > +	READ_NUMBER("sme_mask", sme_mask);
> >
> >  	READ_NUMBER("PG_lru", PG_lru);
> >  	READ_NUMBER("PG_private", PG_private);
> > diff --git a/makedumpfile.h b/makedumpfile.h
> > index 73813ed..e97b2e7 100644
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -1912,6 +1912,7 @@ struct number_table {
> >  	long	NR_FREE_PAGES;
> >  	long	N_ONLINE;
> >  	long	pgtable_l5_enabled;
> > +	long	sme_mask;
> >
> >  	/*
> >   	* Page flags
> >
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
