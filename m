Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haGzb-0005sy-RW
 for kexec@lists.infradead.org; Mon, 10 Jun 2019 09:53:33 +0000
Received: by mail-it1-f196.google.com with SMTP id j204so12168741ite.4
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2019 02:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190610073617.19767-1-kasong@redhat.com>
In-Reply-To: <20190610073617.19767-1-kasong@redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Mon, 10 Jun 2019 17:53:19 +0800
Message-ID: <CACPcB9cRjPPMkC7+yToCZ_MoVw8McMcycRQ6tZT3yjD6pi4-NA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>, Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>

On Mon, Jun 10, 2019 at 3:37 PM Kairui Song <kasong@redhat.com> wrote:
>
> With the recent addition of RSDP parsing in decompression stage, kexec
> kernel now needs ACPI tables to be covered by the identity mapping.
> And in commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and
> ACPI tables to the ident map"), ACPI tables memory region was added to
> the ident map.
>
> But on some machines, there is only ACPI NVS memory region, and the ACPI
> tables is located in the NVS region instead. In such case second kernel
> will still fail when trying to access ACPI tables.
>
> So, to fix the problem, add NVS memory region in the ident map as well.
>
> Fixes: 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI tables to the ident map")
> Suggested-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>
> Tested with my laptop and VM, on top of current tip:x86/boot.
>
>  arch/x86/kernel/machine_kexec_64.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 3c77bdf7b32a..a406602fdb3c 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -54,14 +54,26 @@ static int mem_region_callback(struct resource *res, void *arg)
>  static int
>  map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
>  {
> -       unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +       int ret;
> +       unsigned long flags;
>         struct init_pgtable_data data;
>
>         data.info = info;
>         data.level4p = level4p;
>         flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> -       return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> -                                  &data, mem_region_callback);
> +
> +       ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> +                                 &data, mem_region_callback);
> +       if (ret && ret != -EINVAL)
> +               return ret;
> +
> +       /* ACPI tables could be located in ACPI Non-volatile Storage region */
> +       ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
> +                                 &data, mem_region_callback);
> +       if (ret && ret != -EINVAL)
> +               return ret;
> +
> +       return 0;
>  }
>  #else
>  static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
> --
> 2.21.0
>

Hi, could you help test the tip branch with this applied? This should
fix all the issues, I can't find any other issues now. Thanks.


--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
