Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 12 Jul 2018 14:32:20 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3.1 2/4] efi/arm: preserve early mapping of UEFI memory
 map longer for BGRT
Message-ID: <20180712133220.GA21647@arm.com>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180709234229.20181-3-takahiro.akashi@linaro.org>
 <93c42065-bece-a4c7-ed99-5e98f91315a6@arm.com>
 <CAKv+Gu_fajf3_P0wKpdV34Ungu=fn0=WG1U_MSQ9WF_2GFRfDA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_fajf3_P0wKpdV34Ungu=fn0=WG1U_MSQ9WF_2GFRfDA@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 10, 2018 at 08:39:16PM +0200, Ard Biesheuvel wrote:
> On 10 July 2018 at 19:57, James Morse <james.morse@arm.com> wrote:
> > Hi Ard,
> >
> > On 10/07/18 00:42, AKASHI Takahiro wrote:
> >> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> The BGRT code validates the contents of the table against the UEFI
> >> memory map, and so it expects it to be mapped when the code runs.
> >>
> >> On ARM, this is currently not the case, since we tear down the early
> >> mapping after efi_init() completes, and only create the permanent
> >> mapping in arm_enable_runtime_services(), which executes as an early
> >> initcall, but still leaves a window where the UEFI memory map is not
> >> mapped.
> >>
> >> So move the call to efi_memmap_unmap() from efi_init() to
> >> arm_enable_runtime_services().
> >
> > I don't have a machine that generates a BGRT, but I can see that efi_mem_type()
> > call in efi_bgrt_init() would cause the same problems we have with kexec and acpi.
> >
> 
> I'm not sure I follow. The BGRT table only contains natively aligned
> fields, so the alignment faults should not occur when accessing this
> table after kexec. The issue addressed by this patch is that
> efi_mem_type() bails when called while EFI_MEMMAP is cleared.
> 
> >
> >> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> >> index b5214c143fee..388a929baf95 100644
> >> --- a/drivers/firmware/efi/arm-init.c
> >> +++ b/drivers/firmware/efi/arm-init.c
> >> @@ -259,7 +259,6 @@ void __init efi_init(void)
> >>
> >>       reserve_regions();
> >>       efi_esrt_init();
> >> -     efi_memmap_unmap();
> >>
> >>       memblock_reserve(params.mmap & PAGE_MASK,
> >>                        PAGE_ALIGN(params.mmap_size +
> >> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> >> index 5889cbea60b8..59a8c0ec94d5 100644
> >> --- a/drivers/firmware/efi/arm-runtime.c
> >> +++ b/drivers/firmware/efi/arm-runtime.c
> >> @@ -115,6 +115,8 @@ static int __init arm_enable_runtime_services(void)
> >>               return 0;
> >>       }
> >>
> >> +     efi_memmap_unmap();
> >
> > This can get called twice if uefi_init() fails after setting the EFI_BOOT flag,
> > but this can only happen if the system table signature is wrong, (or we're out
> > of memory really early).
> >
> 
> I guess we should check the EFI_MEMMAP attribute here as well then.

Do you plan to spin a new version of this patch?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
