Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57BD7619.1040406@arm.com>
Date: Wed, 24 Aug 2016 11:25:29 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v24 5/9] arm64: kdump: add kdump support
References: <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
 <57AB586D.3080900@arm.com> <20160818071547.GC20080@linaro.org>
 <20160819012651.GE20080@linaro.org>
 <20160819112217.GB22221@localhost.localdomain>
 <20160822012919.GI20080@linaro.org> <57BB0272.1000008@arm.com>
 <20160823003815.GL20080@linaro.org>
 <20160823112343.GC13501@localhost.localdomain>
 <20160824080443.GA12902@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20160824080443.GA12902@dhcp-128-65.nay.redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, mark.rutland@arm.com, linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, matt@codeblueprint.co.uk, bauerman@linux.vnet.ibm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Dave,

On 24/08/16 09:04, Dave Young wrote:
> Looking the arm-init.c, I suspect it missed the some efi ranges as
> reserved ranges like runtime code and runtime data etc. But I might be
> wrong.

This had me confused for too... I think I get it, my understanding is:


> static __init int is_reserve_region(efi_memory_desc_t *md)
> {
>         switch (md->type) {
>         case EFI_LOADER_CODE:
>         case EFI_LOADER_DATA:
>         case EFI_BOOT_SERVICES_CODE:
>         case EFI_BOOT_SERVICES_DATA:
>         case EFI_CONVENTIONAL_MEMORY:
>         case EFI_PERSISTENT_MEMORY:
>                 return 0;

return false - this is the list of region-types to never reserve, regardless of
memory attributes.


>         default:
>                 break;
>         }
>         return is_normal_ram(md);

If its not in the 'never reserve' list above, then we check if the region is
'normal' ram. If it is then it will end up in memblock.memory so we return true,
causing it to be marked nomap too.

reserve_regions() in that same file calls is_normal_ram() directly before adding
all regions with the WB attribute to memblock.memory via
early_init_dt_add_memory_arch().

A runtime region with the WB attribute will be caught by is_reserve_region(),
and is_normal_ram(), so it ends up in memblock.memory and memblock.nomap.


> }
> 
> Let's see the x86 do_add_efi_mem_map, the default case set all other
> types as reserved. Shouldn't this be same in all arches though there's
> no e820 in arm(64)?

> static void __init do_add_efi_memmap(void)
> {
> 
> [snip]
>                 switch (md->type) {
>                 case EFI_LOADER_CODE:
>                 case EFI_LOADER_DATA:
>                 case EFI_BOOT_SERVICES_CODE:
>                 case EFI_BOOT_SERVICES_DATA:
>                 case EFI_CONVENTIONAL_MEMORY:
>                         if (md->attribute & EFI_MEMORY_WB)
>                                 e820_type = E820_RAM;

In this case reserve_regions() will add the memory to memblock.memory because it
has the WB attribute, and not reserve it.


>                         else
>                                 e820_type = E820_RESERVED;

Without the WB attribute, these regions are in neither memblock.memory nor
memblock.nomap.


>                         break;
> [snip]
>                 default:
>                         /*
>                          * EFI_RESERVED_TYPE EFI_RUNTIME_SERVICES_CODE
>                          * EFI_RUNTIME_SERVICES_DATA
>                          * EFI_MEMORY_MAPPED_IO
>                          * EFI_MEMORY_MAPPED_IO_PORT_SPACE EFI_PAL_CODE
>                          */
>                         e820_type = E820_RESERVED;
>                         break;

If any other regions has the WB attribute, it will be added to memblock.memory
and memblock.nomap. If it doesn't, it will appear in neither.


>                 }
> [snip]
> }

Does this help at all?


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
