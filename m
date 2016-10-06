Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [195.159.176.226] (helo=blaine.gmane.org)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsAEv-0001ZE-AH
 for kexec@lists.infradead.org; Thu, 06 Oct 2016 15:05:43 +0000
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
 (envelope-from <glkk-kexec@m.gmane.org>) id 1bsAEJ-0004sZ-Lb
 for kexec@lists.infradead.org; Thu, 06 Oct 2016 17:05:03 +0200
From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 2/8] kexec: generalize and rename get_kernel_stext_sym()
Date: Thu, 6 Oct 2016 15:28:12 +0200
Message-ID: <b88cbd6b-923d-d0c9-ce23-b9ef99aca256@gmail.com>
References: <20160907043401.6403-1-takahiro.akashi@linaro.org>
 <20160907043401.6403-3-takahiro.akashi@linaro.org>
Mime-Version: 1.0
In-Reply-To: <20160907043401.6403-3-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: public-panand-H+wXaHxf7aLQT0dZR+AlfA@plane.gmane.org, public-kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@plane.gmane.org, public-geoff-wEGCiKHe2LqWVfeAwA7xHQ@plane.gmane.org

On 09/07/2016 06:33 AM, AKASHI Takahiro wrote:
> From: Pratyush Anand <panand@redhat.com>
>
> get_kernel_stext_sym() has been defined for both arm and i386. Other
> architecture might need some other kernel symbol address. Therefore rewrite
> this function as generic function to get any kernel symbol address.
>
> More over, kallsyms is not arch specific representation, therefore have
> common function for all arches.
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> [created symbols.c]
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  kexec/Makefile                  |  1 +
>  kexec/arch/arm/crashdump-arm.c  | 40 +---------------------------------------
>  kexec/arch/i386/crashdump-x86.c | 32 +-------------------------------
>  kexec/kexec.h                   |  2 ++
>  kexec/symbols.c                 | 41 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 46 insertions(+), 70 deletions(-)
>  create mode 100644 kexec/symbols.c
>
> diff --git a/kexec/Makefile b/kexec/Makefile
> index 39f365f..2b4fb3d 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -26,6 +26,7 @@ KEXEC_SRCS_base += kexec/kernel_version.c
>  KEXEC_SRCS_base += kexec/lzma.c
>  KEXEC_SRCS_base += kexec/zlib.c
>  KEXEC_SRCS_base += kexec/kexec-xen.c
> +KEXEC_SRCS_base += kexec/symbols.c
>
>  KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 4a89b5e..2bc898b 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -73,48 +73,10 @@ static struct crash_elf_info elf_info = {
>
>  extern unsigned long long user_page_offset;
>
> -/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
> -static unsigned long long get_kernel_stext_sym(void)
> -{
> -	const char *kallsyms = "/proc/kallsyms";
> -	const char *stext = "_stext";
> -	char sym[128];
> -	char line[128];
> -	FILE *fp;
> -	unsigned long long vaddr = 0;
> -	char type;
> -
> -	fp = fopen(kallsyms, "r");
> -	if (!fp) {
> -		fprintf(stderr, "Cannot open %s\n", kallsyms);
> -		return 0;
> -	}
> -
> -	while(fgets(line, sizeof(line), fp) != NULL) {
> -		unsigned long long addr;
> -
> -		if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
> -			continue;
> -
> -		if (strcmp(sym, stext) == 0) {
> -			dbgprintf("kernel symbol %s vaddr = %#llx\n", stext, addr);
> -			vaddr = addr;
> -			break;
> -		}
> -	}
> -
> -	fclose(fp);
> -
> -	if (vaddr == 0)
> -		fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
> -
> -	return vaddr;
> -}
> -
>  static int get_kernel_page_offset(struct kexec_info *info,
>  		struct crash_elf_info *elf_info)
>  {
> -	unsigned long long stext_sym_addr = get_kernel_stext_sym();
> +	unsigned long long stext_sym_addr = get_kernel_sym("stext");
>  	if (stext_sym_addr == 0) {
>  		if (user_page_offset != (-1ULL)) {
>  			elf_info->page_offset = user_page_offset;
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index bbc0f35..664eb3b 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -102,36 +102,6 @@ static int get_kernel_paddr(struct kexec_info *UNUSED(info),
>  	return -1;
>  }
>
> -/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
> -static unsigned long long get_kernel_stext_sym(void)
> -{
> -	const char *kallsyms = "/proc/kallsyms";
> -	const char *stext = "_stext";
> -	char sym[128];
> -	char line[128];
> -	FILE *fp;
> -	unsigned long long vaddr;
> -	char type;
> -
> -	fp = fopen(kallsyms, "r");
> -	if (!fp) {
> -		fprintf(stderr, "Cannot open %s\n", kallsyms);
> -		return 0;
> -	}
> -
> -	while(fgets(line, sizeof(line), fp) != NULL) {
> -		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
> -			continue;
> -		if (strcmp(sym, stext) == 0) {
> -			dbgprintf("kernel symbol %s vaddr = %16llx\n", stext, vaddr);
> -			return vaddr;
> -		}
> -	}
> -
> -	fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
> -	return 0;
> -}
> -
>  /* Retrieve info regarding virtual address kernel has been compiled for and
>   * size of the kernel from /proc/kcore. Current /proc/kcore parsing from
>   * from kexec-tools fails because of malformed elf notes. A kernel patch has
> @@ -182,7 +152,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>
>  	/* Traverse through the Elf headers and find the region where
>  	 * _stext symbol is located in. That's where kernel is mapped */
> -	stext_sym = get_kernel_stext_sym();
> +	stext_sym = get_kernel_sym("stext");


I think this should be get_kernel_sym("_stext");

Apart from that as Simon already mentioned, due to commit
9f62cbd ("kexec/arch/i386: Add support for KASLR memory randomization")
this patch does not apply cleanly.

Regards,
Matthias

>  	for(phdr = ehdr.e_phdr; stext_sym && phdr != end_phdr; phdr++) {
>  		if (phdr->p_type == PT_LOAD) {
>  			unsigned long long saddr = phdr->p_vaddr;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 9194f1c..b4fafad 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -312,4 +312,6 @@ int xen_kexec_load(struct kexec_info *info);
>  int xen_kexec_unload(uint64_t kexec_flags);
>  void xen_kexec_exec(void);
>
> +extern unsigned long long get_kernel_sym(const char *text);
> +
>  #endif /* KEXEC_H */
> diff --git a/kexec/symbols.c b/kexec/symbols.c
> new file mode 100644
> index 0000000..ea6e327
> --- /dev/null
> +++ b/kexec/symbols.c
> @@ -0,0 +1,41 @@
> +#include <stdio.h>
> +#include <string.h>
> +#include "kexec.h"
> +
> +/* Retrieve kernel symbol virtual address from /proc/kallsyms */
> +unsigned long long get_kernel_sym(const char *text)
> +{
> +	const char *kallsyms = "/proc/kallsyms";
> +	char sym[128];
> +	char line[128];
> +	FILE *fp;
> +	unsigned long long vaddr = 0;
> +	char type;
> +
> +	fp = fopen(kallsyms, "r");
> +	if (!fp) {
> +		fprintf(stderr, "Cannot open %s\n", kallsyms);
> +		return 0;
> +	}
> +
> +	while (fgets(line, sizeof(line), fp) != NULL) {
> +		unsigned long long addr;
> +
> +		if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
> +			continue;
> +
> +		if (strcmp(sym, text) == 0) {
> +			dbgprintf("kernel symbol %s vaddr = %#llx\n",
> +								text, addr);
> +			vaddr = addr;
> +			break;
> +		}
> +	}
> +
> +	fclose(fp);
> +
> +	if (vaddr == 0)
> +		fprintf(stderr, "Cannot get kernel %s symbol address\n", text);
> +
> +	return vaddr;
> +}
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
