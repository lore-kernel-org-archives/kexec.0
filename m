Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk49h-0004eT-NH
 for kexec@lists.infradead.org; Thu, 17 Jan 2019 09:40:11 +0000
Received: by mail-ot1-f67.google.com with SMTP id s5so10529288oth.7
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2019 01:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117085316.GA17940@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190117085316.GA17940@dhcp-128-65.nay.redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jan 2019 10:39:57 +0100
Message-ID: <CAJZ5v0hb6Lz0knzNFTZKNb863bvDx2a1EFjTjOG2NdvyyyhniQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
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
To: Dave Young <dyoung@redhat.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Schmauss, Erik" <erik.schmauss@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, Len Brown <lenb@kernel.org>

On Thu, Jan 17, 2019 at 9:53 AM Dave Young <dyoung@redhat.com> wrote:
>
> Add linux-acpi list

Well, thanks, but please resend the patches with a CC to linux-acpi.

> On 01/17/19 at 03:41pm, Kairui Song wrote:
> > On Wed, Jan 16, 2019 at 5:46 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
> > > > I didn't see a way to reuse things in that patch series, situation is
> > > > different, in that patch it needs to get RSDP in very early boot stage
> > > > so it did everything from scratch, in this patch kexec_file_load need
> > > > to get RSDP too, but everything is well setup so things are a lot
> > > > easier, just read from current boot_prams, efi and fallback to
> > > > acpi_find_root_pointer should be good.
> > >
> > > No no. Early code should find out that venerable RSDP thing once and
> > > will save it somewhere for further use. No gazillion parsings of it.
> > > Just once and share it with the rest of the code that needs it.
> > >
> >
> > How about we refill the boot_params.acpi_rsdp_addr if it is not valid
> > in early code, so it could be used as a reliable RSDP address source?
> > That should make things easier.
> >
> > But if early code should parse it and store it should be done in
> > Chao's patch, or I can post another patch to do it if Chao's patch is
> > merged.
> >
> > For now I think good to have something like this in this patch series
> > to always keep storing acpi_rsdp in late code,
> > acpi_os_get_root_pointer_late (maybe comeup with a better name later)
> > could be used anytime to get RSDP and no extra parsing:
> >
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -180,8 +180,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
> >  #endif
> >  }
> >
> > -#ifdef CONFIG_KEXEC
> >  static unsigned long acpi_rsdp;
> > +#ifdef CONFIG_KEXEC
> >  static int __init setup_acpi_rsdp(char *arg)
> >  {
> >         return kstrtoul(arg, 16, &acpi_rsdp);
> > @@ -189,28 +189,38 @@ static int __init setup_acpi_rsdp(char *arg)
> >  early_param("acpi_rsdp", setup_acpi_rsdp);
> >  #endif
> >
> > +acpi_physical_address acpi_os_get_root_pointer_late(void) {
> > +       return acpi_rsdp;
> > +}
> > +
> >  acpi_physical_address __init acpi_os_get_root_pointer(void)
> >  {
> >         acpi_physical_address pa;
> >
> > -#ifdef CONFIG_KEXEC
> >         if (acpi_rsdp)
> >                 return acpi_rsdp;
> > -#endif
> > +
> >         pa = acpi_arch_get_root_pointer();
> > -       if (pa)
> > +       if (pa) {
> > +               acpi_rsdp = pa;
> >                 return pa;
> > +       }
> >
> >         if (efi_enabled(EFI_CONFIG_TABLES)) {
> > -               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > +               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR) {
> > +                       acpi_rsdp = efi.acpi20;
> >                         return efi.acpi20;
> > -               if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> > +               }
> > +               if (efi.acpi != EFI_INVALID_TABLE_ADDR) {
> > +                       acpi_rsdp = efi.acpi;
> >                         return efi.acpi;
> > +               }
> >                 pr_err(PREFIX "System description tables not found\n");
> >         } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> >                 acpi_find_root_pointer(&pa);
> >         }
> >
> >  +       acpi_rsdp = pa;
> >         return pa;
> >  }
> >
> > > --
> > > Regards/Gruss,
> > >     Boris.
> > >
> > > Good mailing practices for 400: avoid top-posting and trim the reply.
> > --
> > Best Regards,
> > Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
