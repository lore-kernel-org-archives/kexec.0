Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WqFLk-0006Lp-Qe
 for kexec@lists.infradead.org; Fri, 30 May 2014 05:27:29 +0000
Date: Fri, 30 May 2014 14:27:04 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] kexec-tools: detect page_offset dynamically
Message-ID: <20140530052701.GE6561@verge.net.au>
References: <1401355203-63794-1-git-send-email-wangnan0@huawei.com>
 <1401355203-63794-2-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401355203-63794-2-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On Thu, May 29, 2014 at 05:20:02PM +0800, Wang Nan wrote:
> ARM kernel can be compiled with CONFIG_VMSPLIT_1G, CONFIG_VMSPLIT_2G or
> CONFIG_VMSPLIT_3G. This patch dynamically detects PAGE_OFFSET according
> to _stext symbol from /proc/kallsyms.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>

Thanks, applied.

> ---
>  kexec/arch/arm/crashdump-arm.c | 49 +++++++++++++++++++++++++++++++++++++++++-
>  kexec/arch/arm/crashdump-arm.h |  4 +++-
>  2 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 0cd6935..e6ff3e0 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -56,11 +56,55 @@ static struct crash_elf_info elf_info = {
>  	.class		= ELFCLASS32,
>  	.data		= ELFDATANATIVE,
>  	.machine	= EM_ARM,
> -	.page_offset	= PAGE_OFFSET,
> +	.page_offset	= DEFAULT_PAGE_OFFSET,
>  };
>  
>  unsigned long phys_offset;
>  
> +/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
> +static unsigned long long get_kernel_stext_sym(void)
> +{
> +	const char *kallsyms = "/proc/kallsyms";
> +	const char *stext = "_stext";
> +	char sym[128];
> +	char line[128];
> +	FILE *fp;
> +	unsigned long long vaddr;
> +	char type;
> +
> +	fp = fopen(kallsyms, "r");	if (!fp) {
> +		fprintf(stderr, "Cannot open %s\n", kallsyms);
> +		return 0;
> +	}
> +
> +	while(fgets(line, sizeof(line), fp) != NULL) {
> +		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
> +			continue;
> +		if (strcmp(sym, stext) == 0) {
> +			dbgprintf("kernel symbol %s vaddr = %16llx\n", stext, vaddr);
> +			return vaddr;
> +		}
> +	}
> +
> +	fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
> +	return 0;
> +}
> +
> +static int get_kernel_page_offset(struct kexec_info *info,
> +		struct crash_elf_info *elf_info)
> +{
> +	unsigned long long stext_sym_addr = get_kernel_stext_sym();
> +	if (stext_sym_addr == 0) {
> +		elf_info->page_offset = (unsigned long long)DEFAULT_PAGE_OFFSET;
> +		dbgprintf("Unable to get _stext symbol from /proc/kallsyms, use default: %llx\n",
> +				elf_info->page_offset);
> +		return 0;
> +	}
> +	elf_info->page_offset = stext_sym_addr & (~KVBASE_MASK);
> +	dbgprintf("page_offset is set to %llx\n", elf_info->page_offset);
> +	return 0;
> +}
> +
>  /**
>   * crash_range_callback() - callback called for each iomem region
>   * @data: not used
> @@ -292,6 +336,9 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>  	phys_offset = usablemem_rgns.ranges->start;
>  	dbgprintf("phys_offset: %#lx\n", phys_offset);
>  
> +	if (get_kernel_page_offset(info, &elf_info))
> +		return -1;
> +
>  	err = crash_create_elf32_headers(info, &elf_info,
>  					 usablemem_rgns.ranges,
>  					 usablemem_rgns.size, &buf, &bufsz,
> diff --git a/kexec/arch/arm/crashdump-arm.h b/kexec/arch/arm/crashdump-arm.h
> index a342922..2dbde04 100644
> --- a/kexec/arch/arm/crashdump-arm.h
> +++ b/kexec/arch/arm/crashdump-arm.h
> @@ -6,9 +6,11 @@ extern "C" {
>  #endif
>  
>  #define COMMAND_LINE_SIZE	1024
> -#define PAGE_OFFSET		0xc0000000
> +#define DEFAULT_PAGE_OFFSET		(0xc0000000)
> +#define KVBASE_MASK	(0x1ffffff)
>  #define CRASH_MAX_MEMORY_RANGES	32
>  
> +
>  extern struct memory_ranges usablemem_rgns;
>  
>  struct kexec_info;
> -- 
> 1.8.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
