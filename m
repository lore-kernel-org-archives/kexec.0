Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icN7E-0007o5-Ri
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 05:22:23 +0000
Date: Wed, 4 Dec 2019 13:22:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191204052201.GA2665@dhcp-128-65.nay.redhat.com>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
 <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
 <20191129152700.GA8286@weiser.dinsnail.net>
 <20191202085829.GA15808@dhcp-128-65.nay.redhat.com>
 <20191202090520.GA15874@dhcp-128-65.nay.redhat.com>
 <20191202234541.GA27567@weiser.dinsnail.net>
 <20191203115435.GA2606@dhcp-128-65.nay.redhat.com>
 <20191203211146.GA536@weiser.dinsnail.net>
MIME-Version: 1.0
In-Reply-To: <20191203211146.GA536@weiser.dinsnail.net>
Content-Disposition: inline
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
To: Michael Weiser <michael@weiser.dinsnail.net>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 12/03/19 at 10:11pm, Michael Weiser wrote:
> Hi Dave,
> 
> On Tue, Dec 03, 2019 at 07:54:35PM +0800, Dave Young wrote:
> 
> > > Neither adding add_efi_memmap nor adding your patch and setting that option
> > > does make the ESRT memory region appear in /proc/iomem. kexec_file still
> > > loads the kernel across the ESRT region.
> > Hmm, sorry, my bad, actuall add_efi_memmap does not consider the
> > EFI_MEMORY_RUNTIME attribute, it only reads the memory descriptor types.
> 
> > Will read your replied information later, did not get time today, but
> > probably below chunk can help?
> 
> > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > index 3b9fd679cea9..516307617621 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -293,6 +293,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
> >  	early_memunmap(new, new_size);
> 
> >  	efi_memmap_install(new_phys, num_entries);
> > +	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > +	e820__update_table(e820_table);
> >  }
> 
> >  /*
> 
> Yes, that did it:
> 
> 00000000-00000fff : Reserved
> 00001000-0009efff : System RAM
> 0009f000-000fffff : Reserved
>   000a0000-000bffff : PCI Bus 0000:00
>   000e0000-000e3fff : PCI Bus 0000:00
>   000e4000-000e7fff : PCI Bus 0000:00
>   000e8000-000ebfff : PCI Bus 0000:00
>   000ec000-000effff : PCI Bus 0000:00
>   000f0000-000fffff : PCI Bus 0000:00
>     000f0000-000fffff : System ROM
> 00100000-74dd1fff : System RAM
>   65000000-6affffff : Crash kernel
> 74dd2000-74dd2fff : Reserved                   <----- ESRT
> 74dd3000-763f5fff : System RAM
> 763f6000-79974fff : Reserved
> 79975000-799f1fff : ACPI Tables
> 799f2000-79aa6fff : ACPI Non-volatile Storage
>   79a17000-79a17fff : USBC000:00

Ok, good to know it works.  I will think about it and file a patch
later.  There are more things to consider, eg. kexec reboot multiple
times, userspace kexec loader etc.

If we choose to fix it in kexec_file path to avoid those region then we
need to do same in userspace, there will be compatibility issues so I
would still prefer to go with this way you tested.

BTW, on my laptop the ESRT stays in EFI runtime area so I do not see the
problem.  This should be machine/firmware specific.

Here is the info on my laptop:
[    0.000000] efi: mem34: [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007a4b0000-0x000000007a676fff] (1MB)
[    0.020670] esrt: Reserving ESRT space from 0x000000007a4ec000 to 0x000000007a4ec088.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
