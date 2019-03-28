Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f67.google.com ([209.85.166.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9Rk3-0006xr-PN
 for kexec@lists.infradead.org; Thu, 28 Mar 2019 09:54:37 +0000
Received: by mail-io1-f67.google.com with SMTP id f6so16671610iop.3
 for <kexec@lists.infradead.org>; Thu, 28 Mar 2019 02:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190328094910.12368-1-kasong@redhat.com>
In-Reply-To: <20190328094910.12368-1-kasong@redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Thu, 28 Mar 2019 17:54:22 +0800
Message-ID: <CACPcB9fwGZSW2v5VjKmpaXseveg+z1qWCq2bUGairccGo6LxQw@mail.gmail.com>
Subject: Re: [PATCH] x86: Always to to fill acpi_rsdp_addr in boot params
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

On Thu, Mar 28, 2019 at 5:49 PM Kairui Song <kasong@redhat.com> wrote:
>
> Since kernel commit e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address
> from boot params if available"), kernel accept a acpi_rsdp_addr param in
> boot_params. Sync the x86_linux_param_header to support this param.
>
> And previously we are already appending 'acpi_rsdp=' command line only for
> loading crash kernel on EFI systems, it will be better to try to set the
> boot param for any kernel get loaded, to help the kernel finding the
> RSDP value more stably. Otherwise if the user decide to disable EFI
> service in second kernel, it will fail to boot.
>
> There is no better way to find the RSDP address from legacy BIOS
> interface rather than scanning the memory region and search for it,
> which will always be done by the kernel as a fallback, so we only
> look for RSDP in previous boot params, cmdline and EFI firmware.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  include/x86/x86-linux.h            |  8 ++--
>  kexec/arch/i386/crashdump-x86.c    | 34 +++++------------
>  kexec/arch/i386/kexec-x86-common.c | 60 ++++++++++++++++++++++++++++++
>  kexec/arch/i386/kexec-x86.h        |  1 +
>  kexec/arch/i386/x86-linux-setup.c  |  6 ++-
>  kexec/arch/i386/x86-linux-setup.h  |  1 +
>  6 files changed, 80 insertions(+), 30 deletions(-)
>
> diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
> index 352ea02..a5d8df8 100644
> --- a/include/x86/x86-linux.h
> +++ b/include/x86/x86-linux.h
> @@ -45,8 +45,7 @@ struct apm_bios_info {
>         uint16_t cseg_len;      /* 0x4e */
>         uint16_t cseg_16_len;   /* 0x50 */
>         uint16_t dseg_len;      /* 0x52 */
> -       uint8_t  reserved[44];  /* 0x54 */
> -};
> +} __attribute__((packed));
>
>  /*
>   * EDD stuff
> @@ -113,12 +112,15 @@ struct x86_linux_param_header {
>         uint8_t  reserved4[2];                  /* 0x3e -- 0x3f reserved for future expansion */
>
>         struct apm_bios_info apm_bios_info;     /* 0x40 */
> +       uint8_t  reserved4_1[28];               /* 0x54 */
> +       uint64_t acpi_rsdp_addr;                /* 0x70 */
> +       uint8_t  reserved4_2[8];                /* 0x78 */
>         struct drive_info_struct drive_info;    /* 0x80 */
>         struct sys_desc_table sys_desc_table;   /* 0xa0 */
>         uint32_t ext_ramdisk_image;             /* 0xc0 */
>         uint32_t ext_ramdisk_size;              /* 0xc4 */
>         uint32_t ext_cmd_line_ptr;              /* 0xc8 */
> -       uint8_t reserved4_1[0x1c0 - 0xcc];      /* 0xe4 */
> +       uint8_t reserved4_3[0x1c0 - 0xcc];      /* 0xe4 */
>         uint8_t efi_info[32];                   /* 0x1c0 */
>         uint32_t alt_mem_k;                     /* 0x1e0 */
>         uint8_t  reserved5[4];                  /* 0x1e4 */
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 140f45b..262d157 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -787,35 +787,19 @@ static int sysfs_efi_runtime_map_exist(void)
>  /* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
>  static void cmdline_add_efi(char *cmdline)
>  {
> -       FILE *fp;
> -       int cmdlen, len;
> -       char line[MAX_LINE], *s;
> -       const char *acpis = " acpi_rsdp=";
> +       int cmdlen;
> +       uint64_t acpi_rsdp;
>
> -       fp = fopen("/sys/firmware/efi/systab", "r");
> -       if (!fp)
> -               return;
> +       acpi_rsdp = get_acpi_rsdp();
> +       cmdlen = strlen(cmdline);
>
> -       while(fgets(line, sizeof(line), fp) != 0) {
> -               /* ACPI20= always goes before ACPI= */
> -               if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
> -                       line[strlen(line) - 1] = '\0';
> -                       s = strchr(line, '=');
> -                       s += 1;
> -                       len = strlen(s) + strlen(acpis);
> -                       cmdlen = strlen(cmdline) + len;
> -                       if (cmdlen > (COMMAND_LINE_SIZE - 1))
> -                               die("Command line overflow\n");
> -                       strcat(cmdline, acpis);
> -                       strcat(cmdline, s);
> -                       dbgprintf("Command line after adding efi\n");
> -                       dbgprintf("%s\n", cmdline);
> +       if (!acpi_rsdp)
> +               return;
>
> -                       break;
> -               }
> -       }
> +       if (cmdlen + sizeof(" acpi_rsdp=0x") + 16 > (COMMAND_LINE_SIZE - 1))
> +               die("Command line overflow\n");
>
> -       fclose(fp);
> +       sprintf(cmdline + cmdlen, " acpi_rsdp=0x%016lx", acpi_rsdp);
>  }
>
>  static void get_backup_area(struct kexec_info *info,
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index de99758..4b8eb26 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -39,6 +39,7 @@
>  #include "../../firmware_memmap.h"
>  #include "../../crashdump.h"
>  #include "kexec-x86.h"
> +#include "x86-linux-setup.h"
>  #include "../../kexec-xen.h"
>
>  /* Used below but not present in (older?) xenctrl.h */
> @@ -392,4 +393,63 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>         return ret;
>  }
>
> +static uint64_t cmdline_get_acpi_rsdp(void) {
> +       uint64_t acpi_rsdp = 0;
> +       char *tmp_cmdline, *rsdp_param;
>
> +       tmp_cmdline = get_command_line();
> +       rsdp_param = strstr(tmp_cmdline, "acpi_rsdp=");
> +
> +       if (rsdp_param)
> +               sscanf(rsdp_param, "acpi_rsdp=%lx", &acpi_rsdp);
> +
> +       free(tmp_cmdline);
> +       return acpi_rsdp;
> +}
> +
> +static uint64_t bootparam_get_acpi_rsdp(void) {
> +       uint64_t acpi_rsdp = 0;
> +       off_t offset = offsetof(struct x86_linux_param_header, acpi_rsdp_addr);
> +
> +       if (get_bootparam(&acpi_rsdp, offset, sizeof(acpi_rsdp)))
> +               return 0;
> +
> +       return acpi_rsdp;
> +}
> +
> +static uint64_t efi_get_acpi_rsdp(void) {
> +       FILE *fp;
> +       char line[MAX_LINE], *s;
> +       uint64_t acpi_rsdp = 0;
> +
> +       fp = fopen("/sys/firmware/efi/systab", "r");
> +       if (!fp)
> +               return acpi_rsdp;
> +
> +       while(fgets(line, sizeof(line), fp) != 0) {
> +               /* ACPI20= always goes before ACPI= */
> +               if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
> +                       s = strchr(line, '=') + 1;
> +                       sscanf(s, "0x%lx", &acpi_rsdp);
> +                       break;
> +               }
> +       }
> +       fclose(fp);
> +
> +       return acpi_rsdp;
> +}
> +
> +uint64_t get_acpi_rsdp(void)
> +{
> +       uint64_t acpi_rsdp = 0;
> +
> +       acpi_rsdp = cmdline_get_acpi_rsdp();
> +
> +       if (!acpi_rsdp)
> +               acpi_rsdp = bootparam_get_acpi_rsdp();
> +
> +       if (!acpi_rsdp)
> +               acpi_rsdp = efi_get_acpi_rsdp();
> +
> +       return acpi_rsdp;
> +}
> diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
> index c2bcd37..1b58c3b 100644
> --- a/kexec/arch/i386/kexec-x86.h
> +++ b/kexec/arch/i386/kexec-x86.h
> @@ -86,4 +86,5 @@ int nbi_load(int argc, char **argv, const char *buf, off_t len,
>  void nbi_usage(void);
>
>  extern unsigned xen_e820_to_kexec_type(uint32_t type);
> +extern uint64_t get_acpi_rsdp(void);
>  #endif /* KEXEC_X86_H */
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 8fad115..5b00b42 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -123,7 +123,6 @@ void setup_linux_bootloader_parameters_high(
>         cmdline_ptr[cmdline_len - 1] = '\0';
>  }
>
> -static int get_bootparam(void *buf, off_t offset, size_t size);
>  static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
>  {
>         struct fb_fix_screeninfo fix;
> @@ -452,7 +451,7 @@ char *find_mnt_by_fsname(char *fsname)
>         return mntdir;
>  }
>
> -static int get_bootparam(void *buf, off_t offset, size_t size)
> +int get_bootparam(void *buf, off_t offset, size_t size)
>  {
>         int data_file;
>         char *debugfs_mnt, *sysfs_mnt;
> @@ -902,4 +901,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
>
>         /* fill the EDD information */
>         setup_edd_info(real_mode);
> +
> +       /* Always try to fill acpi_rsdp_addr */
> +       real_mode->acpi_rsdp_addr = get_acpi_rsdp();
>  }
> diff --git a/kexec/arch/i386/x86-linux-setup.h b/kexec/arch/i386/x86-linux-setup.h
> index f5d23d3..0c651e5 100644
> --- a/kexec/arch/i386/x86-linux-setup.h
> +++ b/kexec/arch/i386/x86-linux-setup.h
> @@ -21,6 +21,7 @@ static inline void setup_linux_bootloader_parameters(
>  }
>  void setup_linux_system_parameters(struct kexec_info *info,
>         struct x86_linux_param_header *real_mode);
> +int get_bootparam(void *buf, off_t offset, size_t size);
>
>
>  #define SETUP_BASE    0x90000
> --
> 2.20.1
>

For the title, s/to to/try to/, sorry for the typo...

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
