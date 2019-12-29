Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ilZVJ-0003qG-Lw
 for kexec@lists.infradead.org; Sun, 29 Dec 2019 14:25:16 +0000
Date: Sun, 29 Dec 2019 22:24:53 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191229142453.GA18486@dhcp-128-65.nay.redhat.com>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <CANTgghnsdijH90qnm24qat70T7FA5qOwmnXXt+NYVxHYa4SLJA@mail.gmail.com>
 <CAPcyv4iRdJO6xrCaN=vrSvYFLZanLazmJLArT5YMfdJ6rc-PEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iRdJO6xrCaN=vrSvYFLZanLazmJLArT5YMfdJ6rc-PEQ@mail.gmail.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Michael Weiser <michael@weiser.dinsnail.net>, linux-efi <linux-efi@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, X86 ML <x86@kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Dan Williams <dan.j.williams.korg@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Hi Dan,
On 12/28/19 at 10:13pm, Dan Williams wrote:
> On Sat, Dec 28, 2019 at 12:54 PM Dan Williams
> <dan.j.williams.korg@gmail.com> wrote:
> >
> > On Tue, Dec 3, 2019 at 11:53 PM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > Michael Weiser reported he got below error during a kexec rebooting:
> > > esrt: Unsupported ESRT version 2904149718861218184.
> > >
> > > The ESRT memory stays in EFI boot services data, and it was reserved
> > > in kernel via efi_mem_reserve().  The initial purpose of the reservation
> > > is to reuse the EFI boot services data across kexec reboot. For example
> > > the BGRT image data and some ESRT memory like Michael reported.
> > >
> > > But although the memory is reserved it is not updated in X86 e820 table.
> > > And kexec_file_load iterate system ram in io resource list to find places
> > > for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> > > initramfs overwritten the ESRT memory and then the failure happened.
> > >
> > > Since kexec_file_load depends on the e820 to be updated, just fix this
> > > by updating the reserved EFI boot services memory as reserved type in e820.
> > >
> > > Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
> > > bypassed in the reservation code path because they are assumed as reserved.
> > > But the reservation is still needed for multiple kexec reboot.
> > > And it is the only possible case we come here thus just drop the code
> > > chunk then everything works without side effects.
> > >
> > > On my machine the ESRT memory sits in an EFI runtime data range, it does
> > > not trigger the problem, but I successfully tested with BGRT instead.
> > > both kexec_load and kexec_file_load work and kdump works as well.
> > >
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > > ---
> > >  arch/x86/platform/efi/quirks.c |    6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> > > +++ linux-x86/arch/x86/platform/efi/quirks.c
> > > @@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_ad
> > >                 return;
> > >         }
> > >
> > > -       /* No need to reserve regions that will never be freed. */
> > > -       if (md.attribute & EFI_MEMORY_RUNTIME)
> > > -               return;
> > > -
> > >         size += addr % EFI_PAGE_SIZE;
> > >         size = round_up(size, EFI_PAGE_SIZE);
> > >         addr = round_down(addr, EFI_PAGE_SIZE);
> > > @@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_ad
> > >         early_memunmap(new, new_size);
> > >
> > >         efi_memmap_install(new_phys, num_entries);
> > > +       e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > +       e820__update_table(e820_table);
> > >  }
> > >
> > >  /*
> > >
> >
> > Bisect says this change (commit af1648984828) is triggering a
> > regression, likely not urgent, in my testing of the new efi_fake_mem=
> > facility to allow memory to be marked "soft reserved" via the kernel
> > command line (commit 199c84717612 x86/efi: Add efi_fake_mem support
> > for EFI_MEMORY_SP). The following command line triggers the crash
> > signature below:
> >
> >     efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000
> >
> > However, this command line works ok:
> >
> >     efi_fake_mem=8G@9G:0x40000
> >
> > So, something about multiple efi_fake_mem statements interacts badly
> > with this change. Nothing obvious occurs to me at the moment, I'll
> > keep debugging, but wanted to highlight this in the meantime in case
> > someone else sees a deeper issue or the root cause.
> 
> Still looking, but this failure does not seem to be specific to the
> "soft reservation" changes. Any update to the efi memmap that pushes
> it over a page boundary triggers this failure. I.e. I can fix the
> problem by over-allocating the efi memmap and then page aligning the
> result. __early_ioremap "should" be handling this case, but it appears
> something else is messing this up.

I seems can not reproduce the bug, but maybe my vm setup is different.
Can you do some debugging about the efi_memmap_insert function see if
something wrong happened, maybe happens when memcpy to some new allocated buffer via
memblock_alloc, just some guess.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
