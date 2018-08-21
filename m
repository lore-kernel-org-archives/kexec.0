Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fryRo-0001io-RH
 for kexec@lists.infradead.org; Tue, 21 Aug 2018 04:39:18 +0000
Received: by mail-wr1-x441.google.com with SMTP id v17-v6so41414wrr.9
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2018 21:39:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723015732.24252-2-takahiro.akashi@linaro.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
 <20180723015732.24252-2-takahiro.akashi@linaro.org>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 20 Aug 2018 21:39:01 -0700
Message-ID: <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: export memblock_reserve()d regions via
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
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, al.stone@linaro.org, G Gregory <graeme.gregory@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com, tbaicar@codeaurora.org, Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>, james.morse@arm.com, hanjun.guo@linaro.org, Sudeep Holla <sudeep.holla@arm.com>, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>

On Sun, Jul 22, 2018 at 6:57 PM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
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
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> CC: Mark Rutland <mark.rutland@arm.com>
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

Since this patch landed, on the HiKey board at bootup I'm seeing:

[    0.451884] WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/setup.c:271
reserve_memblock_reserved_regions+0xd4/0x13c
[    0.451896] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.18.0-10758-ga534dc3 #709
[    0.451903] Hardware name: HiKey Development Board (DT)
[    0.451913] pstate: 80400005 (Nzcv daif +PAN -UAO)
[    0.451922] pc : reserve_memblock_reserved_regions+0xd4/0x13c
[    0.451931] lr : reserve_memblock_reserved_regions+0xcc/0x13c
[    0.451938] sp : ffffff8008053d30
[    0.451945] x29: ffffff8008053d30 x28: ffffff8008ebe650
[    0.451957] x27: ffffff8008ead060 x26: ffffff8008e113b0
[    0.451969] x25: 0000000000000000 x24: 0000000000488020
[    0.451981] x23: 0000000021ffffff x22: ffffff8008e0d860
[    0.451993] x21: ffffff8008d74370 x20: ffffff8009019000
[    0.452005] x19: ffffffc07507a400 x18: ffffff8009019a48
[    0.452017] x17: 0000000000000000 x16: 0000000000000000
[    0.452028] x15: ffffff80890e973f x14: 0000000000000006
[    0.452040] x13: 0000000000000000 x12: 0000000000000000
[    0.452051] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[    0.452063] x9 : 0000000000000000 x8 : ffffffc07507a480
[    0.452074] x7 : 0000000000000000 x6 : ffffffc07ffffc30
[    0.452086] x5 : 0000000000000000 x4 : 0000000021ffffff
[    0.452097] x3 : 0000000000000001 x2 : 0000000000000001
[    0.452109] x1 : 0000000000000000 x0 : 0000000000000000
[    0.452121] Call trace:
[    0.452130]  reserve_memblock_reserved_regions+0xd4/0x13c
[    0.452140]  do_one_initcall+0x78/0x150
[    0.452148]  kernel_init_freeable+0x198/0x258
[    0.452159]  kernel_init+0x10/0x108
[    0.452170]  ret_from_fork+0x10/0x18
[    0.452181] ---[ end trace b4b78c443df3a750 ]---

From skimming the patch, it seems this is maybe expected? Or should
this warning raise eyebrows? I can't quite figure it out.

It seems to trigger on the pstore memory at 0x21f00000-0x21ffffff.

/proc/iomem now has:
...
07410000-21efffff : System RAM
  11000000-1113cfff : reserved
21f00000-21ffffff : reserved
  21f00000-21f1ffff : persistent_ram
  21f20000-21f3ffff : persistent_ram
  21f40000-21f5ffff : persistent_ram
  21f60000-21f7ffff : persistent_ram
  21f80000-21f9ffff : persistent_ram
  21fa0000-21fbffff : persistent_ram
  21fc0000-21fdffff : persistent_ram
  21fe0000-21ffffff : persistent_ram
22000000-34ffffff : System RAM
...

Where previously it had:
...
07410000-21efffff : System RAM
21f00000-21f1ffff : persistent_ram
21f20000-21f3ffff : persistent_ram
21f40000-21f5ffff : persistent_ram
21f60000-21f7ffff : persistent_ram
21f80000-21f9ffff : persistent_ram
21fa0000-21fbffff : persistent_ram
21fc0000-21fdffff : persistent_ram
21fe0000-21ffffff : persistent_ram
22000000-34ffffff : System RAM
...



thanks
-john

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
