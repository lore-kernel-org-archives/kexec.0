Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 6 Jul 2018 14:37:59 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
Message-ID: <20180706133758.GB11172@arm.com>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org>
 <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
 <20180705164824.GA7445@arm.com>
 <CAKv+Gu-c0wcscUZzRqOTAHg-L70jFf80T=7x6pVPe7iK8-wykw@mail.gmail.com>
 <20180706004226.GO28220@linaro.org>
 <20180706013311.GP28220@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180706013311.GP28220@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, James Morse <james.morse@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Bhupesh Sharma <bhsharma@redhat.com>, Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>

Hi Akashi,

On Fri, Jul 06, 2018 at 10:33:13AM +0900, AKASHI Takahiro wrote:
> On Fri, Jul 06, 2018 at 09:42:28AM +0900, AKASHI Takahiro wrote:
> > I almost believed that my patch#2 was just a preparatory one for patch#3
> > where arm_enable_runtime_services() is moved aggressively forward.
> > But acpi_os_ioremap() is not a __init function and I can now agree to
> > keeping patch#2.
> > 
> > Meanwhile, the consequent code with Ard's patch would look like:
> > ---8<---
> > static int __init arm_enable_runtime_services(void)
> > {
> >         ...
> >         efi_memmap_unmap();
> > 
> >         mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> > 
> >         if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> >                 pr_err("Failed to remap EFI memory map\n");
> >                 return 0;
> >         }
> >         ...
> > }
> > --->8---
> > It seems to me that it makes no sense.
> 
> Oops, it does. Comments at efi_memmap_init_late() say:
> ---8<---
>  * The reason there are two EFI memmap initialisation
>  * (efi_memmap_init_early() and this late version) is because the
>  * early EFI memmap should be explicitly unmapped once EFI
>  * initialisation is complete as the fixmap space used to map the EFI
>  * memmap (via early_memremap()) is a scarce resource.
> --->8---
> 
> > Is it okay to take them out?
> 
> Never mind.

I'm struggling with your monologue...

Please can you send a v3 of the series, containing the patches that you
think are necessary, along with the Acks you've collected?

Thanks,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
