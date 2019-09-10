Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7cKW-000259-HT
 for kexec@lists.infradead.org; Tue, 10 Sep 2019 09:20:57 +0000
Received: by mail-ed1-x544.google.com with SMTP id i8so16316536edn.13
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 02:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
 <20190909181221.309510-11-pasha.tatashin@soleen.com>
 <60975350-87f8-56b3-437d-d9ee26ac3bd3@suse.com>
In-Reply-To: <60975350-87f8-56b3-437d-d9ee26ac3bd3@suse.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 10 Sep 2019 10:20:43 +0100
Message-ID: <CA+CK2bBK40T_DEhNvz8nQaKSsanxXpGYhBm05N_NmZtq+JDVTg@mail.gmail.com>
Subject: Re: [PATCH v4 10/17] arm64: trans_pgd: make trans_pgd_map_page generic
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
To: Matthias Brugger <mbrugger@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

> > +/*
> > + * Add map entry to trans_pgd for a base-size page at PTE level.
> > + * page:     page to be mapped.
> > + * dst_addr: new VA address for the pages
> > + * pgprot:   protection for the page.
>
> For consistency please describe all function parameters. From my experience
> function parameter description is normally done in the C-file that implements
> the logic. Don't ask me why.

Ok, I move the comment, and will describe every parameter. Thank you.

>
> > + */
> > +int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> > +                    void *page, unsigned long dst_addr, pgprot_t pgprot);
> >
> >  #endif /* _ASM_TRANS_TABLE_H */
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 94ede33bd777..9b75b680ab70 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -179,6 +179,12 @@ int arch_hibernation_header_restore(void *addr)
> >  }
> >  EXPORT_SYMBOL(arch_hibernation_header_restore);
> >
> > +static void *
> > +hibernate_page_alloc(void *arg)
>
> AFAICS no new line needed here.

Right, will fix it.

>
> > +{
> > +     return (void *)get_safe_page((gfp_t)(unsigned long)arg);
> > +}
> > +
> >  /*
> >   * Copies length bytes, starting at src_start into an new page,
> >   * perform cache maintenance, then maps it at the specified address low
> > @@ -195,6 +201,10 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >                                unsigned long dst_addr,
> >                                phys_addr_t *phys_dst_addr)
> >  {
> > +     struct trans_pgd_info trans_info = {
> > +             .trans_alloc_page       = hibernate_page_alloc,
> > +             .trans_alloc_arg        = (void *)GFP_ATOMIC,
> > +     };
>
> New line between end of struct and other variables.

Sure.

>
> With these changes:
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
