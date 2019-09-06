Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6JWV-0005wd-Cy
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 19:03:56 +0000
Received: by mail-ed1-x544.google.com with SMTP id i1so7268102edv.4
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 12:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-11-pasha.tatashin@soleen.com>
 <21f6eb6f-be3a-a715-a37c-2f59183ed183@arm.com>
In-Reply-To: <21f6eb6f-be3a-a715-a37c-2f59183ed183@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 15:03:42 -0400
Message-ID: <CA+CK2bAS37vPa0FD7Ya1vnZR29hiEsNfkq6q7+UreNRjRgUEFw@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] arm64,
 trans_pgd: adjust trans_pgd_create_copy interface
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

> > -int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> > +/*
> > + * Create trans_pgd and copy entries from from_table to trans_pgd in range
> > + * [start, end)
> > + */
> > +int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
> > +                       pgd_t *from_table, unsigned long start,
> >                         unsigned long end);
>
> This creates a copy of the linear-map. Why does it need to be told from_table?

This what done as a generic page table entries copy, but I agree, will
remove the from_table.

>
>
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 8c2641a9bb09..8bb602e91065 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -323,15 +323,42 @@ int swsusp_arch_resume(void)
> >       phys_addr_t phys_hibernate_exit;
> >       void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
> >                                         void *, phys_addr_t, phys_addr_t);
> > +     struct trans_pgd_info trans_info = {
> > +             .trans_alloc_page       = hibernate_page_alloc,
> > +             .trans_alloc_arg        = (void *)GFP_ATOMIC,
> > +             /*
> > +              * Resume will overwrite areas that may be marked read only
> > +              * (code, rodata). Clear the RDONLY bit from the temporary
> > +              * mappings we use during restore.
> > +              */
> > +             .trans_flags            = TRANS_MKWRITE,
> > +     };
>
>
> > +     /*
> > +      * debug_pagealloc will removed the PTE_VALID bit if the page isn't in
> > +      * use by the resume kernel. It may have been in use by the original
> > +      * kernel, in which case we need to put it back in our copy to do the
> > +      * restore.
> > +      *
> > +      * Before marking this entry valid, check the pfn should be mapped.
> > +      */
> > +     if (debug_pagealloc_enabled())
> > +             trans_info.trans_flags |= (TRANS_MKVALID | TRANS_CHECKPFN);
>
> The debug_pagealloc_enabled() check should be with the code that generates a different
> entry. Whether the different entry is correct needs to be considered with
> debug_pagealloc_enabled() in mind. You are making this tricky logic less clear.
>
> There is no way the existing code invents an entry for a !pfn_valid() page. With your
> 'checkpfn' flag, this thing can. You don't need to generalise this for hypothetical users.

Ok

>
>
> If kexec needs to create mappings for bogus pages, I'd like to know why.
>

It does not.

>
> >       /*
> >        * Restoring the memory image will overwrite the ttbr1 page tables.
> >        * Create a second copy of just the linear map, and use this when
> >        * restoring.
> >        */
> > -     rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
> > -     if (rc)
> > +     rc = trans_pgd_create_copy(&trans_info, &tmp_pg_dir, init_mm.pgd,
> > +                                PAGE_OFFSET, 0);
>
> > +     if (rc) {
> > +             if (rc == -ENOMEM)
> > +                     pr_err("Failed to allocate memory for temporary page tables.\n");
> > +             else if (rc == -ENXIO)
> > +                     pr_err("Tried to set PTE for PFN that does not exist\n");
> >               goto out;
> > +     }
>
> If you think the distinction for this error message is useful, it would be clearer to
> change it in the current hibernate code before you move it. (_copy_pte() to return an
> error, instead of silently failing). Done here, this is unrelated noise.
>

Ok, will do that.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
