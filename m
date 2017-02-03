Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 3 Feb 2017 14:22:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
Message-ID: <20170203142216.GF30497@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
 <20170201160354.GF4756@leverpostej>
 <20170202102131.GD13549@linaro.org>
 <20170202114437.GH31394@leverpostej>
 <20170202140102.GA22666@fireball>
 <20170202143535.GM31394@leverpostej>
 <20170202145553.GA3238@fireball>
 <20170203061317.GC29585@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170203061317.GC29585@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, geoff@infradead.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Feb 03, 2017 at 03:13:18PM +0900, AKASHI Takahiro wrote:
> On Thu, Feb 02, 2017 at 11:55:54PM +0900, AKASHI Takahiro wrote:
> > On Thu, Feb 02, 2017 at 02:35:35PM +0000, Mark Rutland wrote:

> > > I think that if we only allow ourselves to make PTEs invalid, we don't
> > > have to handle that case. If we use page_mappings_only, we should only
> > > check pgattr_change_is_safe() for the pte level, and the {pmd,pud,pgd}
> > > entries shouldn't change.
> > > 
> > > Is the below sufficient to allow that, or have I missed something?
> > 
> > I think it will be OK, but will double-check tomorrow.
> > However, is is acceptable that create_pgd_mapping( __prot(0) ) can
> > only handle the cases of page-mapping-only?
> > That would be fine to kdump, but in general?

Given we're only going to use this for page mappings, I think it's fine
(and preferable) to restrict it to page mappings for now. Until we need
to do this for the pmd/pud/pgd levels, those won't see any testing, and
it will be very easy for us to accidentally break this.

> My proposed code is attached below.
> I think that the changes are quite trivial and it works even if
> there is a section mapping as far as we refrain from reclaiming
> unsed p[ug]d tables.
> 
> (Of course, we can't merely unmap a subset of a section mapping here.)

Sure. We have a similar restriction when changing permissions, so I
think that's fine.

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 17243e43184e..7f96eabc99d7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -140,7 +140,11 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>                         __prot = prot;
>         }
> 
> -		set_pte(pte, pfn_pte(pfn, __prot));
> +		if (pgprot_val(prot) & PTE_VALID)
> +			set_pte(pte, pfn_pte(pfn, __prot));
> +		else
> +			pte_clear(null, null, pte);

It took me a moment to figure out how this line could compile. ;)

I'm happy to take this approach in alloc_init_pte(), but as above I'd
prefer that we only handled it there, and left the pmd/pud/pgd code
as-is for now.

We can/should add a comment to make that clear.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
