Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hjDy9-0001KU-8h
 for kexec@lists.infradead.org; Fri, 05 Jul 2019 02:29:02 +0000
Date: Fri, 5 Jul 2019 10:28:51 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH kexec-tools] x86: re-order includes to avoid duplicate
 struct e820entry
Message-ID: <20190705022850.GC5897@dhcp-128-65.nay.redhat.com>
References: <20190703080432.28806-1-horms@verge.net.au>
 <20190703083434.GA7897@localhost.localdomain>
 <CACPcB9fAuzRLhXKB1UhW3vJNaAUq0UwRXHYDYb7MrEbXazq_qg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPcB9fAuzRLhXKB1UhW3vJNaAUq0UwRXHYDYb7MrEbXazq_qg@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

Hi Kairui,
On 07/03/19 at 05:08pm, Kairui Song wrote:
> On Wed, Jul 3, 2019 at 4:34 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 07/03/19 at 10:04am, Simon Horman wrote:
> > > xenctrl.h defines struct e820entry as:
> > >
> > >       if defined(__i386__) || defined(__x86_64__)
> > >       ...
> > >       #define E820_RAM        1
> > >       ...
> > >       struct e820entry {
> > >               uint64_t addr;
> > >               uint64_t size;
> > >               uint32_t type;
> > >       } __attribute__((packed));
> > >       ...
> > >       #endif
> > >
> > >  $ dpkg-query -S /usr/include/xenctrl.h
> > >  libxen-dev:amd64: /usr/include/xenctrl.h
> > >  $  dpkg-query -W libxen-dev:amd64
> > >  libxen-dev:amd64     4.8.5+shim4.10.2+xsa282-1+deb9u11
> > >
> > > ./include/x86/x86-linux.h defines struct e820entry as:
> > >
> > >       #ifndef E820_RAM
> > >       struct e820entry {
> > >               uint64_t addr;  /* start of memory segment */
> > >               uint64_t size;  /* size of memory segment */
> > >               uint32_t type;  /* type of memory segment */
> > >               #define E820_RAM    1
> > >               ...
> > >       } __attribute__((packed));
> > >       #endif
> > >
> > > Since cedeee0a3007 ("x86: Introduce helpers for getting RSDP address")
> > > ./kexec/arch/i386/kexec-x86-common.c includes
> > >
> > >       +#include "x86-linux-setup.h"
> > >        #include "../../kexec-xen.h"
> >
> > Not sure if those get rsdp code can go to x86-linux-setup.c then no need
> > the including.
> >
> > Let's see if Kairui has some thoughts.
> >
> 
> Yes, move the helper to x86-linux-setup.c should fix it too. So
> following patch should also be able to fix it:

It would be better to send a formal patch, seems the patch format is not
correct. no sob, and no ident.

> 
> ---
>  kexec/arch/i386/kexec-x86-common.c | 45 ------------------------------
>  kexec/arch/i386/kexec-x86.h        |  1 -
>  kexec/arch/i386/x86-linux-setup.c  | 43 ++++++++++++++++++++++++++++
>  kexec/arch/i386/x86-linux-setup.h  |  2 +-
>  4 files changed, 44 insertions(+), 47 deletions(-)
> 
> diff --git a/kexec/arch/i386/kexec-x86-common.c
> b/kexec/arch/i386/kexec-x86-common.c
> index 5c55ec8..63a2823 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -39,7 +39,6 @@
>  #include "../../firmware_memmap.h"
>  #include "../../crashdump.h"
>  #include "kexec-x86.h"
> -#include "x86-linux-setup.h"
>  #include "../../kexec-xen.h"
> 
>  /* Used below but not present in (older?) xenctrl.h */
> @@ -392,47 +391,3 @@ int get_memory_ranges(struct memory_range
> **range, int *ranges,
> 
>   return ret;
>  }
> -
> -static uint64_t bootparam_get_acpi_rsdp(void) {
> - uint64_t acpi_rsdp = 0;
> - off_t offset = offsetof(struct x86_linux_param_header, acpi_rsdp_addr);
> -
> - if (get_bootparam(&acpi_rsdp, offset, sizeof(acpi_rsdp)))
> - return 0;
> -
> - return acpi_rsdp;
> -}
> -
> -static uint64_t efi_get_acpi_rsdp(void) {
> - FILE *fp;
> - char line[MAX_LINE], *s;
> - uint64_t acpi_rsdp = 0;
> -
> - fp = fopen("/sys/firmware/efi/systab", "r");
> - if (!fp)
> - return acpi_rsdp;
> -
> - while(fgets(line, sizeof(line), fp) != 0) {
> - /* ACPI20= always goes before ACPI= */
> - if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
> - s = strchr(line, '=') + 1;
> - sscanf(s, "0x%lx", &acpi_rsdp);
> - break;
> - }
> - }
> - fclose(fp);
> -
> - return acpi_rsdp;
> -}
> -
> -uint64_t get_acpi_rsdp(void)
> -{
> - uint64_t acpi_rsdp = 0;
> -
> - acpi_rsdp = bootparam_get_acpi_rsdp();
> -
> - if (!acpi_rsdp)
> - acpi_rsdp = efi_get_acpi_rsdp();
> -
> - return acpi_rsdp;
> -}
> diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
> index 1b58c3b..c2bcd37 100644
> --- a/kexec/arch/i386/kexec-x86.h
> +++ b/kexec/arch/i386/kexec-x86.h
> @@ -86,5 +86,4 @@ int nbi_load(int argc, char **argv, const char *buf,
> off_t len,
>  void nbi_usage(void);
> 
>  extern unsigned xen_e820_to_kexec_type(uint32_t type);
> -extern uint64_t get_acpi_rsdp(void);
>  #endif /* KEXEC_X86_H */
> diff --git a/kexec/arch/i386/x86-linux-setup.c
> b/kexec/arch/i386/x86-linux-setup.c
> index 057ee14..588b1f4 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -846,6 +846,49 @@ out:
>   return;
>  }
> 
> +static uint64_t bootparam_get_acpi_rsdp(void) {
> + uint64_t acpi_rsdp = 0;
> + off_t offset = offsetof(struct x86_linux_param_header, acpi_rsdp_addr);
> +
> + if (get_bootparam(&acpi_rsdp, offset, sizeof(acpi_rsdp)))
> + return 0;
> +
> + return acpi_rsdp;
> +}
> +
> +static uint64_t efi_get_acpi_rsdp(void) {
> + FILE *fp;
> + char line[MAX_LINE], *s;
> + uint64_t acpi_rsdp = 0;
> +
> + fp = fopen("/sys/firmware/efi/systab", "r");
> + if (!fp)
> + return acpi_rsdp;
> +
> + while(fgets(line, sizeof(line), fp) != 0) {
> + /* ACPI20= always goes before ACPI= */
> + if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
> + s = strchr(line, '=') + 1;
> + sscanf(s, "0x%lx", &acpi_rsdp);
> + break;
> + }
> + }
> + fclose(fp);
> +
> + return acpi_rsdp;
> +}
> +
> +uint64_t get_acpi_rsdp(void)
> +{
> + uint64_t acpi_rsdp = 0;
> +
> + acpi_rsdp = bootparam_get_acpi_rsdp();
> +
> + if (!acpi_rsdp)
> + acpi_rsdp = efi_get_acpi_rsdp();
> +
> + return acpi_rsdp;
> +}
>  void setup_linux_system_parameters(struct kexec_info *info,
>      struct x86_linux_param_header *real_mode)
>  {
> diff --git a/kexec/arch/i386/x86-linux-setup.h
> b/kexec/arch/i386/x86-linux-setup.h
> index 0c651e5..1e81805 100644
> --- a/kexec/arch/i386/x86-linux-setup.h
> +++ b/kexec/arch/i386/x86-linux-setup.h
> @@ -22,7 +22,7 @@ static inline void setup_linux_bootloader_parameters(
>  void setup_linux_system_parameters(struct kexec_info *info,
>   struct x86_linux_param_header *real_mode);
>  int get_bootparam(void *buf, off_t offset, size_t size);
> -
> +uint64_t get_acpi_rsdp(void);
> 
>  #define SETUP_BASE    0x90000
>  #define KERN32_BASE  0x100000 /* 1MB */
> -- 
> 2.21.0
> 
> Best Regards,
> Kairui Song

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
