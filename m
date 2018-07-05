Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fbCkm-00022x-4i
 for kexec@lists.infradead.org; Thu, 05 Jul 2018 22:29:34 +0000
Received: by mail-io0-x242.google.com with SMTP id l7-v6so9185637ioj.1
 for <kexec@lists.infradead.org>; Thu, 05 Jul 2018 15:29:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619064424.6642-2-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 6 Jul 2018 00:29:20 +0200
Message-ID: <CAKv+Gu9sbrGAMSrTC=qc1FnC0OjD5=mroV84aggAzjfJLPW1AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 19 June 2018 at 08:44, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> From: James Morse <james.morse@arm.com>
>
> There has been some confusion around what is necessary to prevent kexec
> overwriting important memory regions. memblock: reserve, or nomap?
> Only memblock nomap regions are reported via /proc/iomem, kexec's
> user-space doesn't know about memblock_reserve()d regions.
>
> Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
> as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
> and thus possible for kexec to overwrite with the new kernel or initrd.
> But this was always broken, as the UEFI memory map is also reserved
> and not marked as nomap.
>
> Exporting both nomap and reserved memblock types is a nuisance as
> they live in different memblock structures which we can't walk at
> the same time.
>
> Take a second walk over memblock.reserved and add new 'reserved'
> subnodes for the memblock_reserved() regions that aren't already
> described by the existing code. (e.g. Kernel Code)
>
> We use reserve_region_with_split() to find the gaps in existing named
> regions. This handles the gap between 'kernel code' and 'kernel data'
> which is memblock_reserve()d, but already partially described by
> request_standard_resources(). e.g.:
> | 80000000-dfffffff : System RAM
> |   80080000-80ffffff : Kernel code
> |   81000000-8158ffff : reserved
> |   81590000-8237efff : Kernel data
> |   a0000000-dfffffff : Crash kernel
> | e00f0000-f949ffff : System RAM
>
> reserve_region_with_split needs kzalloc() which isn't available when
> request_standard_resources() is called, use an initcall.
>
> Reported-by: Bhupesh Sharma <bhsharma@redhat.com>
> Reported-by: Tyler Baicar <tbaicar@codeaurora.org>
> Suggested-by: Akashi Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> CC: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/kernel/setup.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 30ad2f085d1f..5b4fac434c84 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -241,6 +241,44 @@ static void __init request_standard_resources(void)
>         }
>  }
>
> +static int __init reserve_memblock_reserved_regions(void)
> +{
> +       phys_addr_t start, end, roundup_end = 0;
> +       struct resource *mem, *res;
> +       u64 i;
> +
> +       for_each_reserved_mem_region(i, &start, &end) {
> +               if (end <= roundup_end)
> +                       continue; /* done already */
> +
> +               start = __pfn_to_phys(PFN_DOWN(start));
> +               end = __pfn_to_phys(PFN_UP(end)) - 1;
> +               roundup_end = end;
> +
> +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
> +               if (WARN_ON(!res))
> +                       return -ENOMEM;
> +               res->start = start;
> +               res->end = end;
> +               res->name  = "reserved";
> +               res->flags = IORESOURCE_MEM;
> +
> +               mem = request_resource_conflict(&iomem_resource, res);
> +               /*
> +                * We expected memblock_reserve() regions to conflict with
> +                * memory created by request_standard_resources().
> +                */
> +               if (WARN_ON_ONCE(!mem))
> +                       continue;
> +               kfree(res);
> +
> +               reserve_region_with_split(mem, start, end, "reserved");
> +       }
> +
> +       return 0;
> +}
> +arch_initcall(reserve_memblock_reserved_regions);
> +
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>
>  void __init setup_arch(char **cmdline_p)
> --
> 2.17.0
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
