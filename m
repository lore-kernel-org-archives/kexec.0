Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGegG-0005oo-0u
 for kexec@lists.infradead.org; Wed, 17 Apr 2019 07:08:29 +0000
Date: Wed, 17 Apr 2019 15:08:18 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Message-ID: <20190417070818.GE8411@dhcp-128-65.nay.redhat.com>
References: <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic> <20190416095209.GG27892@zn.tnic>
 <20190416114133.GA7541@dhcp-128-65.nay.redhat.com>
 <20190416132253.GE31772@zn.tnic>
 <20190417013838.GA8411@dhcp-128-65.nay.redhat.com>
 <20190417045447.GB8411@dhcp-128-65.nay.redhat.com>
 <CACPcB9cf0dtXFF+kpzBYXm3nvvG3uPDf81P1fa19+D37H9BaEg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPcB9cf0dtXFF+kpzBYXm3nvvG3uPDf81P1fa19+D37H9BaEg@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On 04/17/19 at 02:00pm, Kairui Song wrote:
> On Wed, Apr 17, 2019 at 12:57 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 04/17/19 at 09:38am, Dave Young wrote:
> > > On 04/16/19 at 03:22pm, Borislav Petkov wrote:
> > > > On Tue, Apr 16, 2019 at 07:41:33PM +0800, Dave Young wrote:
> > > > > On 04/16/19 at 11:52am, Borislav Petkov wrote:
> > > > > > I'll queue the below in the next days if there are no more complaints:
> > > > >
> > > > > As for the kexec breakage, even with the V3 patch, kexec still hangs on
> > > > > a Lenovo T420 laptop.  Kairui also reproduced the problem. So can we
> > > > > wait a few days see if we can make some progress to find the cause?
> > > >
> > > > How is applying this patch going to change anything?
> > > >
> > > > I was told that the breakage is there even without it...
> > >
> > > Without this patch, the bug happens in the efi_get_rsdp.. function, this
> > > patch tries to fix that by adding kexec_get.. but the new introduced
> > > kexec_* function does not work on some laptops, so it is not a 100% good
> > > fix, I hoped we can get it working for all known issues.  But if we can
> > > not do it eg. within one week we can go with this version and leave the
> > > laptop issue as a known issue.
> > >
> >
> > Latest debugging status:
> >
> > Kexec boot works with commenting out some code like below, so the guid
> > cmp (memcmp) caused a system reset), still need to find out why:
> >
> > diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> > index d9f9abd63c68..13e7a23ae94c 100644
> > --- a/arch/x86/boot/compressed/acpi.c
> > +++ b/arch/x86/boot/compressed/acpi.c
> > @@ -95,10 +95,12 @@ __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
> >                         table = tbl->table;
> >                 }
> >
> > +/*
> >                 if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> >                         rsdp_addr = table;
> >                 else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> >                         return table;
> > +*/
> >         }
> >
> >         return rsdp_addr;
> > @@ -291,9 +293,10 @@ acpi_physical_address get_rsdp_addr(void)
> >         if (!pa)
> >                 pa = kexec_get_rsdp_addr();
> >
> > +/*
> >         if (!pa)
> >                 pa = efi_get_rsdp_addr();
> > -
> > +*/
> >         if (!pa)
> >                 pa = bios_get_rsdp_addr();
> >
> >
> 
> Hi Dave, for this case I think it's just because GCC will found the
> loop does nothing, and optimize out the whole loop in
> __efi_get_rsdp_addr and will no longer read the actual nr_table value.
> 
> I can fix the boot error on T420 with your patch, but if I add
> anything, like a hardcode value assignment with the right value for
> acpi_rsdp in the loop, it will reset the machine. But set acpi_rsdp
> with a right initial value out side the loop works fine.
> If the loop condition is false, then there should be no difference
> between just comment out the line you mentioned and add an assignment.
> Else it just assign the value multiple times, not very reasonable but
> shouldn't fail.
> 
> And, I inspected the generated ASM code also suggest the same thing.
> So still, access the systab memory is the cause of the system reset on
> certain machines.

Makse sense, my previous debug also point to some systab accessing.
Probably some early pg table mess up.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
