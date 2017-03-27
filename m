Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1csV3p-0002vR-01
 for kexec@lists.infradead.org; Mon, 27 Mar 2017 13:51:55 +0000
Received: by mail-pg0-x232.google.com with SMTP id n5so33135158pgh.0
 for <kexec@lists.infradead.org>; Mon, 27 Mar 2017 06:51:32 -0700 (PDT)
Date: Mon, 27 Mar 2017 22:49:16 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v33 05/14] arm64: mm: allow for unmapping part of kernel
 mapping
Message-ID: <20170327134906.GB4454@fireball>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <20170315095941.25119-3-takahiro.akashi@linaro.org>
 <58D10209.1090406@arm.com> <20170323114309.GE17298@linaro.org>
 <CAKv+Gu-YCGfymnaWzNfxNyoyPwYGCAkPViC_Lwf0WAgnRPD2WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-YCGfymnaWzNfxNyoyPwYGCAkPViC_Lwf0WAgnRPD2WQ@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ard,

On Fri, Mar 24, 2017 at 10:57:02AM +0000, Ard Biesheuvel wrote:
> On 23 March 2017 at 11:43, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > On Tue, Mar 21, 2017 at 10:35:53AM +0000, James Morse wrote:
> >> Hi Akashi,
> >>
> >> On 15/03/17 09:59, AKASHI Takahiro wrote:
> >> > create_pgd_mapping() is enhanced here so that it will accept
> >> > PAGE_KERNEL_INVALID protection attribute and unmap a given range of memory.
> >> >
> >> > The feature will be used in a later kdump patch to implement the protection
> >> > against possible corruption of crash dump kernel memory which is to be set
> >> > aside from ther other memory on primary kernel.
> >>
> >> Nit: ther- > the
> >
> > Fix it.
> >
> >> > Note that, in this implementation, it assumes that all the range of memory
> >> > to be processed is mapped in page-level since the only current user is
> >> > kdump where page mappings are also required.
> >>
> >> Using create_pgd_mapping() like this means the mappings will be updated via the
> >> fixmap which is unnecessary as the page tables will be part of mapped memory. In
> >
> > This might be a reason that we would go for (un)map_kernel_range()
> > over create_pgd_mapping() (? not sure)
> >
> 
> Yes, that is why I suggested it. We already use it to unmap the init
> segment at the end of boot, but I do take your point about it being
> documented as operating on kernel VMAs only.
> 
> Looking at the code, it shouldn't matter (it does not touch or reason
> about VMAs at all, it only walks the page tables and unmaps them), but
> I agree it is better not to rely on that.

OK

> But instead of clearing all permissions, which apparently requires
> changes to alloc_init_pte(), and introduces the restriction that the
> region should be mapped down to pages, could we not simply clear
> PTE_VALID on the region, like we do for debug_pagealloc()?

Now that we are only using page-level mappings for crash kernel memory,
__change_page_common() should work and it even has no concerns that
James pointed out.
I will update my patch soon.

Thanks,
-Takahiro AKASHI

> 
> >> the worst case this adds an extra tlbi for every 2MB of crash image when we map
> >> or unmap it. I don't think this matters.
> >>
> >> This code used to be __init and it is the only user of FIX_PTE, so there won't
> >> be any existing runtime users. The two arch_kexec_unprotect_crashkres() calls in
> >> kexec are both protected by the kexec_mutex, and the call in hibernate happens
> >> after disable_nonboot_cpus(), so these callers can't race with each other.
> >>
> >> This looks safe to me.
> >>
> >>
> >> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> > index d28dbcf596b6..cb359a3927ef 100644
> >> > --- a/arch/arm64/mm/mmu.c
> >> > +++ b/arch/arm64/mm/mmu.c
> >> > @@ -128,7 +128,10 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
> >> >     do {
> >> >             pte_t old_pte = *pte;
> >> >
> >> > -           set_pte(pte, pfn_pte(pfn, prot));
> >> > +           if (pgprot_val(prot))
> >> > +                   set_pte(pte, pfn_pte(pfn, prot));
> >> > +           else
> >> > +                   pte_clear(null, null, pte);
> >>
> >> Lowercase NULLs? This relies on these values never being used... __set_fixmap()
> >> in the same file passes &init_mm and the address, can we do the same to be
> >> consistent?
> >
> > OK.
> >
> > Thanks,
> > -Takahiro AKASHI
> >
> >>
> >> >             pfn++;
> >> >
> >> >             /*
> >>
> >> Reviewed-by: James Morse <james.morse@arm.com>
> >>
> >>
> >> Thanks,
> >>
> >> James
> >>
> >>
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
