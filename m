Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C257CD8CB2
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 00:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=15pG75f2Z2t48VZ4WGWsSL/XAa7DUuBR6QVVyPcF6jU=; b=vPwtOTFaKlBmXAt75d/yZywf45
	Tk5YHkF4gs0Kv+3pWc5881RtfgkkpyJcxY2pqDkaeGGDm2Vivzu4JwRoQQ4OvyG/KNQbSuEfkwsSq
	do6Us9QdFiTkKpmORw2EOjF2d9SKVYUAKc741HHfeOPEL6l+fB4bcfJAz47NfvYG2I3Z1aikMzE72
	ljFMSj6dUbH+4J/8yAfDcv/tb8TGBKaasVSPDZ5th9MX8NaA+rO9iUuMx2IyxX9DsTy9cdbTwno2w
	UpeH7jYUgpg6MUBEhZWovoub9Kew7dYGHvHQGxIpWEte7Qs1E7cDWL5lWf8WGdDrZ096Nvk95BlN2
	oKoaZUlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX75f-00000006ZBF-1qQ5;
	Wed, 10 Jun 2026 00:46:43 +0000
Received: from out-170.mta1.migadu.com ([2001:41d0:203:375::aa])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX75a-00000006ZAN-4BSo
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 00:46:42 +0000
Date: Wed, 10 Jun 2026 08:46:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781052393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15pG75f2Z2t48VZ4WGWsSL/XAa7DUuBR6QVVyPcF6jU=;
	b=iUko+3PeOeAryYAJMwpnmdyxYnMA5u5MoqArFhXmELBhgZf9tZ8oymNJVcG7G01PrPA5TX
	Jd24+xxKinJwUK0U6Ul2wYmqLipUznlt6mRp9V4crs7OCVJRTAE0skl1RfGZpseAE9evbB
	MGpAhBZ7wZtdH4dk2S8dXLNkHsxeQN8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: k-hagio-ab@nec.com, yamazaki-msmt@nec.com, bhe@redhat.com,
	kexec@lists.infradead.org, xiaoleiwangxiaolei@gmail.com
Subject: Re: [PATCH] arm64: Add 5-level page table support for 4K pages with
 52-bit VA
Message-ID: <aiiy7aYG8dITSyQo@MiWiFi-R3L-srv>
References: <20260519031706.3511081-1-xiaolei.wang@windriver.com>
 <e1611077-48de-441f-b86c-4b4e221fbd27@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1611077-48de-441f-b86c-4b4e221fbd27@windriver.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_174639_269366_7345FE49 
X-CRM114-Status: GOOD (  35.48  )
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

On 06/09/26 at 01:34pm, Xiaolei Wang wrote:
> Humble ping...
> 
> Can anyone help review this patch?

Are you posting a patch for makedumpfile utility? If yes, you should
indicate that in patch subject, such as

[PATCH][makedumpfile] arm64: Add 5-level page table support for 4K pages with

I thought it's an arm64 kernel patch.

> 
> thanks
> 
> xiaolei
> 
> On 5/19/26 11:17, Xiaolei Wang wrote:
> > From: Xiaolei wang <xiaolei.wang@windriver.com>
> > 
> > makedumpfile fails with "PAGE SIZE 0x1000 and VA Bits 52 not supported"
> > on ARM64 systems configured with CONFIG_ARM64_VA_BITS_52=y and 4KB page
> > size. This combination requires 5-level page tables, which makedumpfile
> > does not currently support.
> > 
> > Add support for 5-level page tables on ARM64 by:
> > - Adding the P4D page table level definitions and helpers
> > - Updating pud_t to contain p4d_t (reflecting the correct hierarchy)
> > - Extending calculate_plat_config() to recognize 4K + 52-bit VA as
> >    pgtable_level=5, and 16K + 52-bit VA as pgtable_level=4
> > - Adding p4d_offset() to handle the additional translation level
> > - Updating vaddr_to_paddr_arm64() to walk through PGD->P4D->PUD->PMD->PTE
> > - Using vabits_actual instead of va_bits in calculate_plat_config() and
> >    PTRS_PER_PGD to correctly handle the case where the kernel is compiled
> >    with VA_BITS=52 but the hardware only supports 48-bit VA (runtime
> >    fallback to 4-level)
> > 
> > The pgtable_level assignments follow arch/arm64/Kconfig:
> > - 4K  + 52-bit VA → 5-level (the only 5-level configuration)
> > - 16K + 52-bit VA → 4-level
> > - 4K  + 48-bit VA → 4-level
> > - 16K + 48-bit VA → 4-level
> > 
> > Fixes: https://github.com/makedumpfile/makedumpfile/issues/18
> > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > ---
> >   arch/arm64.c | 89 +++++++++++++++++++++++++++++++++++++++++++---------
> >   1 file changed, 74 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm64.c b/arch/arm64.c
> > index 1072178..f3f33e4 100644
> > --- a/arch/arm64.c
> > +++ b/arch/arm64.c
> > @@ -29,6 +29,10 @@ typedef struct {
> >   typedef struct {
> >   	pgd_t pgd;
> > +} p4d_t;
> > +
> > +typedef struct {
> > +	p4d_t p4d;
> >   } pud_t;
> >   typedef struct {
> > @@ -42,6 +46,7 @@ typedef struct {
> >   #define __pte(x)	((pte_t) { (x) } )
> >   #define __pmd(x)	((pmd_t) { (x) } )
> >   #define __pud(x)	((pud_t) { (x) } )
> > +#define __p4d(x)	((p4d_t) { (x) } )
> >   #define __pgd(x)	((pgd_t) { (x) } )
> >   static int lpa_52_bit_support_available;
> > @@ -62,7 +67,8 @@ static unsigned long kimage_voffset;
> >   #define PAGE_OFFSET_48		((0xffffffffffffffffUL) << 48)
> >   #define pgd_val(x)		((x).pgd)
> > -#define pud_val(x)		(pgd_val((x).pgd))
> > +#define p4d_val(x)		(pgd_val((x).pgd))
> > +#define pud_val(x)		(p4d_val((x).p4d))
> >   #define pmd_val(x)		(pud_val((x).pud))
> >   #define pte_val(x)		((x).pte)
> > @@ -75,6 +81,7 @@ static unsigned long kimage_voffset;
> >   typedef unsigned long pteval_t;
> >   typedef unsigned long pmdval_t;
> >   typedef unsigned long pudval_t;
> > +typedef unsigned long p4dval_t;
> >   typedef unsigned long pgdval_t;
> >   #define PAGE_SHIFT	PAGESHIFT()
> > @@ -101,6 +108,14 @@ typedef unsigned long pgdval_t;
> >   #define PUD_MASK		(~(PUD_SIZE-1))
> >   #define PTRS_PER_PUD		PTRS_PER_PTE
> > +/*
> > + * P4D_SHIFT determines the size a level 0 page table entry can map.
> > + */
> > +#define P4D_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(0)
> > +#define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
> > +#define P4D_MASK		(~(P4D_SIZE-1))
> > +#define PTRS_PER_P4D		PTRS_PER_PTE
> > +
> >   /*
> >    * PGDIR_SHIFT determines the size a top-level page table entry can map
> >    * (depending on the configuration, this level can be 0, 1 or 2).
> > @@ -108,7 +123,7 @@ typedef unsigned long pgdval_t;
> >   #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (pgtable_level))
> >   #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
> >   #define PGDIR_MASK		(~(PGDIR_SIZE-1))
> > -#define PTRS_PER_PGD		(1 << ((va_bits) - PGDIR_SHIFT))
> > +#define PTRS_PER_PGD		(1 << ((vabits_actual) - PGDIR_SHIFT))
> >   /*
> >    * Section address mask and size definitions.
> > @@ -178,6 +193,22 @@ pgd_pte(pgd_t pgd)
> >   #define __pgd_to_phys(pgd)		__pte_to_phys(pgd_pte(pgd))
> >   #define pgd_offset(pgd, vaddr)		((pgd_t *)(pgd) + pgd_index(vaddr))
> > +/* P4D */
> > +#define p4d_index(vaddr)		(((vaddr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
> > +
> > +static inline pte_t p4d_pte(p4d_t p4d)
> > +{
> > +	return __pte(p4d_val(p4d));
> > +}
> > +
> > +#define __p4d_to_phys(p4d)		__pte_to_phys(p4d_pte(p4d))
> > +
> > +static inline unsigned long
> > +p4d_page_paddr(p4d_t p4d)
> > +{
> > +	return __p4d_to_phys(p4d);
> > +}
> > +
> >   static inline pte_t pud_pte(pud_t pud)
> >   {
> >   	return __pte(pud_val(pud));
> > @@ -237,13 +268,22 @@ __pa(unsigned long vaddr)
> >   		return (vaddr - kimage_voffset);
> >   }
> > +static p4d_t *
> > +p4d_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
> > +{
> > +	if (pgtable_level > 4)
> > +		return (p4d_t *)(pgd_page_paddr(*pgdv) + p4d_index(vaddr) * sizeof(p4d_t));
> > +	else
> > +		return (p4d_t *)(pgda);
> > +}
> > +
> >   static pud_t *
> > -pud_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
> > +pud_offset(p4d_t *p4da, p4d_t *p4dv, unsigned long vaddr)
> >   {
> >   	if (pgtable_level > 3)
> > -		return (pud_t *)(pgd_page_paddr(*pgdv) + pud_index(vaddr) * sizeof(pud_t));
> > +		return (pud_t *)(p4d_page_paddr(*p4dv) + pud_index(vaddr) * sizeof(pud_t));
> >   	else
> > -		return (pud_t *)(pgda);
> > +		return (pud_t *)(p4da);
> >   }
> >   static pmd_t *
> > @@ -257,20 +297,32 @@ pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
> >   static int calculate_plat_config(void)
> >   {
> > -	/* derive pgtable_level as per arch/arm64/Kconfig */
> > -	if ((PAGESIZE() == SZ_16K && va_bits == 36) ||
> > -			(PAGESIZE() == SZ_64K && va_bits == 42)) {
> > +	/*
> > +	 * Derive pgtable_level as per arch/arm64/Kconfig.
> > +	 * Use vabits_actual (runtime VA size) rather than va_bits (compile-time)
> > +	 * because the kernel may reduce the VA space at boot if the hardware
> > +	 * does not support 52-bit VA (LVA). In that case va_bits=52 but
> > +	 * vabits_actual=48, and the page tables are 4-level, not 5-level.
> > +	 */
> > +	int va = vabits_actual;
> > +
> > +	if ((PAGESIZE() == SZ_16K && va == 36) ||
> > +			(PAGESIZE() == SZ_64K && va == 42)) {
> >   		pgtable_level = 2;
> > -	} else if ((PAGESIZE() == SZ_64K && va_bits == 48) ||
> > -			(PAGESIZE() == SZ_64K && va_bits == 52) ||
> > -			(PAGESIZE() == SZ_4K && va_bits == 39) ||
> > -			(PAGESIZE() == SZ_16K && va_bits == 47)) {
> > +	} else if ((PAGESIZE() == SZ_64K && va == 48) ||
> > +			(PAGESIZE() == SZ_64K && va == 52) ||
> > +			(PAGESIZE() == SZ_4K && va == 39) ||
> > +			(PAGESIZE() == SZ_16K && va == 47)) {
> >   		pgtable_level = 3;
> > -	} else if ((PAGESIZE() != SZ_64K && va_bits == 48)) {
> > +	} else if ((PAGESIZE() == SZ_4K && va == 48) ||
> > +			(PAGESIZE() == SZ_16K && va == 48) ||
> > +			(PAGESIZE() == SZ_16K && va == 52)) {
> >   		pgtable_level = 4;
> > +	} else if (PAGESIZE() == SZ_4K && va == 52) {
> > +		pgtable_level = 5;
> >   	} else {
> >   		ERRMSG("PAGE SIZE %#lx and VA Bits %d not supported\n",
> > -				PAGESIZE(), va_bits);
> > +				PAGESIZE(), va);
> >   		return FALSE;
> >   	}
> >   	DEBUG_MSG("pgtable_level: %d\n", pgtable_level);
> > @@ -548,6 +600,7 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
> >   	unsigned long long paddr = NOT_PADDR;
> >   	unsigned long long swapper_phys;
> >   	pgd_t	*pgda, pgdv;
> > +	p4d_t	*p4da, p4dv;
> >   	pud_t	*puda, pudv;
> >   	pmd_t	*pmda, pmdv;
> >   	pte_t 	*ptea, ptev;
> > @@ -565,7 +618,13 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
> >   		return NOT_PADDR;
> >   	}
> > -	puda = pud_offset(pgda, &pgdv, vaddr);
> > +	p4da = p4d_offset(pgda, &pgdv, vaddr);
> > +	if (!readmem(PADDR, (unsigned long long)p4da, &p4dv, sizeof(p4dv))) {
> > +		ERRMSG("Can't read p4d\n");
> > +		return NOT_PADDR;
> > +	}
> > +
> > +	puda = pud_offset(p4da, &p4dv, vaddr);
> >   	if (!readmem(PADDR, (unsigned long long)puda, &pudv, sizeof(pudv))) {
> >   		ERRMSG("Can't read pud\n");
> >   		return NOT_PADDR;
> 

