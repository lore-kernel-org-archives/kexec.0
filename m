Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l34Mt-0006gc-A1
 for kexec@lists.infradead.org; Fri, 22 Jan 2021 21:53:24 +0000
Received: by mail-ej1-x62a.google.com with SMTP id g12so9768277ejf.8
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 13:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-4-pasha.tatashin@soleen.com>
 <c857d4aa-e8ec-81f6-bdea-dff6513c52dc@arm.com>
In-Reply-To: <c857d4aa-e8ec-81f6-bdea-dff6513c52dc@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 22 Jan 2021 16:52:45 -0500
Message-ID: <CA+CK2bC506GE0P86Be3vFTjX8_-4JYfCRC8gGoe7BvJ2b6rASA@mail.gmail.com>
Subject: Re: [PATCH v9 03/18] arm64: trans_pgd: make trans_pgd_map_page generic
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, rfontana@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Selin Dag <selindag@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi James,

I am working on an updated version of this patch series. We had back
and forth discussion on the list and off the list about MMU-enabled
series. So, I decided to sync the last series I had with the current
mainline. Address your last comments (those that I can address), and
send it again, so we can take a fresh look. I will reply to some of
your comments, as I address them in the synced version of my series.

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > kexec is going to use a different allocator, so make
>
> > trans_pgd_map_page to accept allocator as an argument, and also
> > kexec is going to use a different map protection, so also pass
> > it via argument.
>
> This trans_pgd_map_page() used to be create_single_mapping() It creates page tables that
> map one page: the relocation code.
>
> Why do you need a different pgprot? Surely PAGE_KERNEL_EXEC is exactly what you want.

For hibernate case yes, but for MMU enabled kexec case, PAGE_KERNEL is
used, because it is used to copy data segments.

> > diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> > index 23153c13d1ce..ad5194ad178d 100644
> > --- a/arch/arm64/include/asm/trans_pgd.h
> > +++ b/arch/arm64/include/asm/trans_pgd.h
> > @@ -12,10 +12,24 @@
> >  #include <linux/types.h>
> >  #include <asm/pgtable-types.h>
> >
> > +/*
> > + * trans_alloc_page
> > + *   - Allocator that should return exactly one zeroed page, if this
> > + *    allocator fails, trans_pgd returns -ENOMEM error.
>
> trans_pgd is what you pass in to trans_pgd_map_page() or trans_pgd_create_copy().
> Do you mean what those functions return?

I meant to say trans_pgd_*, but I will change the comment to
explicitly say trans_pgd_map_page() and trans_pgd_create_copy() will
return -ENOMEM.

>
>
> > + *
> > + * trans_alloc_arg
> > + *   - Passed to trans_alloc_page as an argument
> > + */
>
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 3d6f0fd73591..607bb1fbc349 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -195,6 +200,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >                                unsigned long dst_addr,
> >                                phys_addr_t *phys_dst_addr)
> >  {
> > +     struct trans_pgd_info trans_info = {
> > +             .trans_alloc_page       = hibernate_page_alloc,
> > +             .trans_alloc_arg        = (void *)GFP_ATOMIC,
> > +     };
>
> As you need another copy of this in the next patch, is it worth declaring this globally
> and making it const?

I think it is alright to have it on the stack instead of permanently
using the data section for this. Plus, we will have a different one
for the kexec case, so having this globally available will make it
strange.

>
>
> > diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> > index d20e48520cef..275a79935d7e 100644
> > --- a/arch/arm64/mm/trans_pgd.c
> > +++ b/arch/arm64/mm/trans_pgd.c
> > @@ -180,8 +185,18 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> >       return rc;
> >  }
> >
> > -int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
> > -                    pgprot_t pgprot)
> > +/*
> > + * Add map entry to trans_pgd for a base-size page at PTE level.
> > + * info:     contains allocator and its argument
> > + * trans_pgd:        page table in which new map is added.
> > + * page:     page to be mapped.
>
> > + * dst_addr: new VA address for the pages
>
> ~s/pages/page/
>
> This thing only maps one page.

Sure, I will change that.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
