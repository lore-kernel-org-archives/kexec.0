Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f195.google.com ([209.85.166.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQ4e6-0000Nt-42
 for kexec@lists.infradead.org; Mon, 13 May 2019 06:41:12 +0000
Received: by mail-it1-f195.google.com with SMTP id i63so11811175ita.3
 for <kexec@lists.infradead.org>; Sun, 12 May 2019 23:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190315093547.6057-1-lijiang@redhat.com>
In-Reply-To: <20190315093547.6057-1-lijiang@redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Mon, 13 May 2019 14:40:59 +0800
Message-ID: <CACPcB9fwdsj+gOfZUuAUGvPCHn2vF67jH-+2Mc8=mJquaGJSWA@mail.gmail.com>
Subject: Re: [PATCH] kexec/x86: Unconditionally add the acpi_rsdp command line
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, brijesh.singh@amd.com

On Fri, Mar 15, 2019 at 5:36 PM Lianbo Jiang <lijiang@redhat.com> wrote:
>
> The Linux kernel commit 3a63f70bf4c3 introduces the early parsing
> of the RSDP. This means that boot loader must either set the
> boot_params.acpi_rsdp_addr or pass a command line 'acpi_rsdp=xxx'
> to tell the RDSP physical address.
>
> Currently, kexec neither sets the boot_params.acpi_rsdp or passes
> acpi_rsdp command line if it sees the first kernel support efi
> runtime. This is causing the second kernel boot failure.
> The EFI runtime is not available so early in the boot process so
> unconditionally pass the 'acpi_rsdp=xxx' to the second kernel.
>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 140f45b..a29b15b 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -35,7 +35,6 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> -#include <dirent.h>
>  #include "../../kexec.h"
>  #include "../../kexec-elf.h"
>  #include "../../kexec-syscall.h"
> @@ -772,18 +771,6 @@ static enum coretype get_core_type(struct crash_elf_info *elf_info,
>         }
>  }
>
> -static int sysfs_efi_runtime_map_exist(void)
> -{
> -       DIR *dir;
> -
> -       dir = opendir("/sys/firmware/efi/runtime-map");
> -       if (!dir)
> -               return 0;
> -
> -       closedir(dir);
> -       return 1;
> -}
> -
>  /* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
>  static void cmdline_add_efi(char *cmdline)
>  {
> @@ -978,9 +965,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>         dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>         if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
>                 return -1;
> -       if (!bzImage_support_efi_boot || arch_options.noefi ||
> -           !sysfs_efi_runtime_map_exist())
> -               cmdline_add_efi(mod_cmdline);
> +       cmdline_add_efi(mod_cmdline);
>         cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
>
>         /* Inform second kernel about the presence of ACPI tables. */
> --
> 2.17.1
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Hi Lianbo,

I've sent another patch similiar to yours:
[PATCH] x86: Always try to fill acpi_rsdp_addr in boot params

I'll update V2 and your use case should also be covered in that patch,
as we have talked in IRC previously, thanks!

--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
