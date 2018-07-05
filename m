Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fbCho-0000WG-Ad
 for kexec@lists.infradead.org; Thu, 05 Jul 2018 22:26:29 +0000
Received: by mail-io0-x243.google.com with SMTP id p7-v6so9150220ioh.13
 for <kexec@lists.infradead.org>; Thu, 05 Jul 2018 15:26:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619064424.6642-3-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-3-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 6 Jul 2018 00:26:16 +0200
Message-ID: <CAKv+Gu8m6DafSohjodBe324=UdubrPRLxGVGfTqOxhJ7FYK5Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] efi/arm: map UEFI memory map even w/o runtime
 services enabled
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
> Under the current implementation, UEFI memory map will be mapped and made
> available in virtual mappings only if runtime services are enabled.
> But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
> to create mappings of ACPI tables using memory attributes described in
> UEFI memory map.
>
> So, as a first step, arm_enter_runtime_services() will be modified
> so that UEFI memory map will be always accessible.
>
> See a relevant commit:
>     arm64: acpi: fix alignment fault in accessing ACPI tables
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This may be taken via the arm64 tree.

> ---
>  drivers/firmware/efi/arm-runtime.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 5889cbea60b8..30ac5c82051e 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -115,6 +115,13 @@ static int __init arm_enable_runtime_services(void)
>                 return 0;
>         }
>
> +       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> +
> +       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> +               pr_err("Failed to remap EFI memory map\n");
> +               return 0;
> +       }
> +
>         if (efi_runtime_disabled()) {
>                 pr_info("EFI runtime services will be disabled.\n");
>                 return 0;
> @@ -127,13 +134,6 @@ static int __init arm_enable_runtime_services(void)
>
>         pr_info("Remapping and enabling EFI services.\n");
>
> -       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> -
> -       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> -               pr_err("Failed to remap EFI memory map\n");
> -               return -ENOMEM;
> -       }
> -
>         if (!efi_virtmap_init()) {
>                 pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
>                 return -ENOMEM;
> --
> 2.17.0
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
