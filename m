Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Gf1-0006SS-KL
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 16:00:33 +0000
Received: by mail-ed1-x544.google.com with SMTP id v38so6746640edm.7
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 09:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-7-pasha.tatashin@soleen.com>
 <bcc3f71f-97d2-dff4-c55a-4798c6e2bede@arm.com>
In-Reply-To: <bcc3f71f-97d2-dff4-c55a-4798c6e2bede@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 12:00:19 -0400
Message-ID: <CA+CK2bCwRm_AQHzrJ8tdjp5k6Yj+32yRsvQsOoy7b44GTdd6wQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/17] arm64, hibernate: add trans_pgd public functions
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

On Fri, Sep 6, 2019 at 11:18 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > trans_pgd_create_copy() and trans_pgd_map_page() are going to be
> > the basis for public interface of new subsystem that handles page
>
> Please don't call this a subsystem. 'sound' and 'mm' are subsystems, this is just some
> shared code.

Sounds good: just could not find a better term to call trans_pgd_*. I
won't fix log commits.

>
> > tables for cases which are between kernels: kexec, and hibernate.
>
> Even though you've baked the get_safe_page() calls into trans_pgd_map_page()?

It is getting removed later. Just for a cleaner migration to new
place, get_safe_page() is included for now.

>
>
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 750ecc7f2cbe..2e29d620b56c 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -182,39 +182,15 @@ int arch_hibernation_header_restore(void *addr)
>
> > +int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
> > +                    unsigned long dst_addr,
> > +                    pgprot_t pgprot)
>
> If this thing is going to be exposed, its name should reflect that its creating a set of
> page tables, to map a single page.
>
> A function called 'map_page' with this prototype should 'obviously' map @page at @dst_addr
> in @trans_pgd using the provided @pgprot... but it doesn't.

Answered below...

>
> This is what 'create' was doing in the old name, if that wasn't obvious, its because
> naming things is hard!
> | trans_create_single_page_mapping()?
>
> (might be too verbose)
>
> I think this bites you in patch 8, where you 'generalise' this.

The new naming makes more sense to me. The old code had function named:

create_safe_exec_page()

It was doing four things: 1. creating the actual page via provided
allocator, 2. copying content from the provided page to new page, 3
creating a new page table. 4 mapping it to a new page table at
specified destination address

After, I generalize this the function the prototype looks like this:

int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
                                         void *page, unsigned long
dst_addr, pgprot_t pgprot)

The function only does the "4" from the old code: map the specified
page at dst_addr. The trans_pgd is already created. Of course, and
mapping function will have to allocate missing tables in the page
tables when necessary.

> > +     return 0;
> > +}
> > +
> > +/*
> > + * Copies length bytes, starting at src_start into an new page,
> > + * perform cache maintentance, then maps it at the specified address low
>
> Could you fix the spelling of maintenance as git thinks you've moved it?

I will.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
