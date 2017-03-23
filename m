Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqsjB-0002hB-Mw
 for kexec@lists.infradead.org; Thu, 23 Mar 2017 02:43:55 +0000
Date: Thu, 23 Mar 2017 10:43:27 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec regression since 4.9 caused by efi
Message-ID: <20170323024327.GA10125@dhcp-128-65.nay.redhat.com>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
 <20170313073748.GA6332@dhcp-128-65.nay.redhat.com>
 <20170316124132.GF6261@codeblueprint.co.uk>
 <20170317020951.GA3942@dhcp-128-65.nay.redhat.com>
 <20170317133232.GI6261@codeblueprint.co.uk>
 <20170320021412.GA3793@dhcp-128-65.nay.redhat.com>
 <20170321074826.GA4571@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-hD9TbSX7iyWZSJ+S2SV5n95S+hcYGnH4OBfi_=M49hA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-hD9TbSX7iyWZSJ+S2SV5n95S+hcYGnH4OBfi_=M49hA@mail.gmail.com>
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
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, pjones@redhat.com, Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com

On 03/22/17 at 04:10pm, Ard Biesheuvel wrote:
> On 21 March 2017 at 07:48, Dave Young <dyoung@redhat.com> wrote:
> > On 03/20/17 at 10:14am, Dave Young wrote:
> >> On 03/17/17 at 01:32pm, Matt Fleming wrote:
> >> > On Fri, 17 Mar, at 10:09:51AM, Dave Young wrote:
> >> > >
> >> > > Matt, I think it should be fine although I think the md type checking in
> >> > > efi_mem_desc_lookup() is causing confusion and not easy to understand..
> >> >
> >> > Could you make that a separate patch if you think of improvements
> >> > there?
> >>
> >> Duplicate the lookup function is indeed a little ugly, will do it when I
> >> have a better idea, we can leave it as is since it works.
> >
> > Matt, rethinking about this, how about doint something below, not
> > tested, just seeking for idea and opinons, in this way no need duplicate
> > a function, but there is an assumption that no overlapped mem ranges in
> > efi memmap.
> >
> > Also the case Omar reported is the esrt memory range type is
> > RUNTIME_DATA, that is a little different with the mem attribute of
> > RUNTIME which also includes BOOT_DATA which has been set the RUNTIME
> > attribute, like bgrt in kexec reboot. Should we distinguish the two
> > cases and give out some warnings or debug info?
> >
> >
> > ---
> >  arch/x86/platform/efi/quirks.c |    5 +++++
> >  drivers/firmware/efi/efi.c     |    6 ------
> >  drivers/firmware/efi/esrt.c    |    7 +++++++
> >  3 files changed, 12 insertions(+), 6 deletions(-)
> >
> > --- linux-x86.orig/drivers/firmware/efi/efi.c
> > +++ linux-x86/drivers/firmware/efi/efi.c
> > @@ -376,12 +376,6 @@ int __init efi_mem_desc_lookup(u64 phys_
> >                 u64 size;
> >                 u64 end;
> >
> > -               if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
> > -                   md->type != EFI_BOOT_SERVICES_DATA &&
> > -                   md->type != EFI_RUNTIME_SERVICES_DATA) {
> > -                       continue;
> > -               }
> > -
> >                 size = md->num_pages << EFI_PAGE_SHIFT;
> >                 end = md->phys_addr + size;
> >                 if (phys_addr >= md->phys_addr && phys_addr < end) {
> > --- linux-x86.orig/drivers/firmware/efi/esrt.c
> > +++ linux-x86/drivers/firmware/efi/esrt.c
> > @@ -258,6 +258,13 @@ void __init efi_esrt_init(void)
> >                 return;
> >         }
> >
> > +       if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
> > +             md->type != EFI_BOOT_SERVICES_DATA &&
> > +             md->type != EFI_RUNTIME_SERVICES_DATA) {
> > +               pr_err("ESRT header memory map type is invalid\n");
> > +               return;
> > +       }
> > +
> 
> This looks wrong to me. While the meanings get convoluted in practice,
> the EFI_MEMORY_RUNTIME attribute only means that the firmware requests
> a virtual mapping for the region. It is perfectly legal for a
> EFI_RUNTIME_SERVICES_DATA region not to have the EFI_MEMORY_RUNTIME
> attribute, if the region is never accessed by the runtime services
> themselves, and this is not entirely unlikely for tables that the
> firmware exposes to the OS

Thanks for the comment, if so "!(md->attribute & EFI_MEMORY_RUNTIME) &&"
should be dropped.

BTW, md->type should be md.type, bgrt reserving works fine with this
change but I have no esrt machine to test it. I would like to wait for
Matt's opinions about this first before an update. 

Also cc Peter about the esrt piece.
> 
> >         max = efi_mem_desc_end(&md);
> >         if (max < efi.esrt) {
> >                 pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
> > --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> > +++ linux-x86/arch/x86/platform/efi/quirks.c
> > @@ -201,6 +201,11 @@ void __init efi_arch_mem_reserve(phys_ad
> >                 return;
> >         }
> >
> > +       if (md->attribute & EFI_MEMORY_RUNTIME ||
> > +             md->type != EFI_BOOT_SERVICES_DATA) {
> > +               return;
> > +       }
> > +
> >         size += addr % EFI_PAGE_SIZE;
> >         size = round_up(size, EFI_PAGE_SIZE);
> >         addr = round_down(addr, EFI_PAGE_SIZE);
> >
> >>
> >> >
> >> > > How about move the if chunk early like below because it seems no need
> >> > > to sanity check the addr + size any more if the md is still RUNTIME?
> >> >
> >> > My original version did as you suggest, but I changed it because we
> >> > *really* want to know if someone tries to reserve a range that spans
> >> > regions. That would be totally unexpected and a warning about a
> >> > potential bug/issue.
> >>
> >> Matt, I'm fine if you prefer to capture the range checking errors.
> >> Would you like me to post it or just you send it out?
> >>
> >> Thanks
> >> Dave
> >
> > Thanks
> > Dave
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
