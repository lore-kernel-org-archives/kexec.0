Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f65.google.com ([209.85.166.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjfJm-0006w8-UE
 for kexec@lists.infradead.org; Wed, 16 Jan 2019 07:08:57 +0000
Received: by mail-io1-f65.google.com with SMTP id v10so4082317ios.13
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 23:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
In-Reply-To: <20190115231005.GF6596@zn.tnic>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 16 Jan 2019 15:08:42 +0800
Message-ID: <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
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
To: Borislav Petkov <bp@alien8.de>
Cc: rafael.j.wysocki@intel.com, Baoquan He <bhe@redhat.com>, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, Chao Fan <fanc.fnst@cn.fujitsu.com>, Len Brown <lenb@kernel.org>

On Wed, Jan 16, 2019 at 7:10 AM Borislav Petkov <bp@alien8.de> wrote:

> > +#ifdef CONFIG_ACPI
> > +     /* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
> > +     if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
> > +             /* Copied from acpi_os_get_root_pointer accordingly */
> > +             params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> > +             if (!params->acpi_rsdp_addr) {
> > +                     if (efi_enabled(EFI_CONFIG_TABLES)) {
> > +                             if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > +                                     params->acpi_rsdp_addr = efi.acpi20;
> > +                             else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> > +                                     params->acpi_rsdp_addr = efi.acpi;
> > +                     } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> > +                             acpi_find_root_pointer(&params->acpi_rsdp_addr);
> > +                     }
> > +             }
> > +             if (!params->acpi_rsdp_addr)
> > +                     pr_warn("RSDP is not available for second kernel\n");
> > +     }
> >  #endif
>
> Amazing the amount of ACPI RDSP parsing and fiddling patches flying
> around these days...
>
> In any case, this needs to be synchronized with:
>
> https://lkml.kernel.org/r/20190107032243.25324-1-fanc.fnst@cn.fujitsu.com
>
> and checked whether the above can be used instead of sprinkling of ACPI
> parsing code left and right.
>
> Thx.

Hi thanks for the suggestion.

I didn't see a way to reuse things in that patch series, situation is
different, in that patch it needs to get RSDP in very early boot stage
so it did everything from scratch, in this patch kexec_file_load need
to get RSDP too, but everything is well setup so things are a lot
easier, just read from current boot_prams, efi and fallback to
acpi_find_root_pointer should be good.

And that patch series also need to consider boot_params.acpi_rsdp_addr
value, or it won't work if the system is rebooted with kexec, efi is
disabled and acpi_rsdp is provided by boot_params (Xen PVH guests also
need to get acpi_rsdp from boot_params according to commit message of
ae7e1238e68f2a472a125673ab506d49158c1889). Will add some comment and
discuss.

>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
