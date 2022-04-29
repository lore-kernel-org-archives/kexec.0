From: Simon Horman <horms@verge.net.au>
Date: Fri, 29 Apr 2022 11:40:10 +0200
Subject: [PATCH] Add method to pass initrd through cmdline
In-Reply-To: <20220418013659.5545-1-lihui@loongson.cn>
References: <20220418013659.5545-1-lihui@loongson.cn>
Message-ID: <YmuyegqF7HeSfkah@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Hui Li,

thanks for your patch.

On Mon, Apr 18, 2022 at 09:36:59AM +0800, Hui Li wrote:
> Problem description:
> Under loongson platform,use command:
> kexec -l vmlinux... --append="root=UUID=28e1..." --initrd=...
> kexec -e
> quick restart failed.
> 
> The reason of this problem:
> The kernel cannot parse the UUID,UUID is parsed in the initrd.
> Loongson platform obtain the initrd through cmdline in kernel.
> In kexec-tools, initrd is not added to cmdline.

Is this common to other platforms?
If not, is there a reason that Loongson takes this approach?

> The solution:
> Add initrd parameter to cmdline. and add a CONFIG_LOONGSON configuration
> to distinguish PAGE_OFFSET between different platforms under mips.
> 
> Signed-off-by: Hui Li <lihui@loongson.cn>
> ---
>  configure.ac                     |  5 ++++
>  kexec/arch/mips/crashdump-mips.h |  6 ++++-
>  kexec/arch/mips/kexec-elf-mips.c | 43 ++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index cf8e8a2..26bfbcd 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -111,6 +111,11 @@ AC_ARG_WITH([booke],
>  		AC_DEFINE(CONFIG_BOOKE,1,
>  			[Define to build for BookE]))
>  
> +AC_ARG_WITH([loongson],
> +		AC_HELP_STRING([--with-loongson],[build for loongson]),
> +		AC_DEFINE(CONFIG_LOONGSON,1,
> +			[Define to build for LoongsoN]))
> +
>  dnl ---Programs
>  dnl To specify a different compiler, just 'export CC=/path/to/compiler'
>  if test "${build}" != "${host}" ; then
> diff --git a/kexec/arch/mips/crashdump-mips.h b/kexec/arch/mips/crashdump-mips.h
> index 7edd859..d53c696 100644
> --- a/kexec/arch/mips/crashdump-mips.h
> +++ b/kexec/arch/mips/crashdump-mips.h
> @@ -5,7 +5,11 @@ struct kexec_info;
>  int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
>  				unsigned long max_addr, unsigned long min_base);
>  #ifdef __mips64
> -#define PAGE_OFFSET	0xa800000000000000ULL
> +#ifdef CONFIG_LOONGSON
> +#define PAGE_OFFSET 0xFFFFFFFF80000000ULL
> +#else
> +#define PAGE_OFFSET 0xa800000000000000ULL
> +#endif

Could this be detected at runtime?

It seems awkward to set the PAGE_OFFSET at compile time and
thus need separate builds for separate platforms (with no warning
if the wrong one is used).

>  #define MAXMEM		0
>  #else
>  #define PAGE_OFFSET	0x80000000
> diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
> index a2d11fc..1de418e 100644
> --- a/kexec/arch/mips/kexec-elf-mips.c
> +++ b/kexec/arch/mips/kexec-elf-mips.c
> @@ -40,6 +40,44 @@ static const int probe_debug = 0;
>  #define CMDLINE_PREFIX "kexec "
>  static char cmdline_buf[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
>  
> +/* Converts unsigned long to ascii string. */
> +static void ultoa(unsigned long i, char *str)
> +{
> +	int j = 0, k;
> +	char tmp;
> +
> +	do {
> +		str[j++] = i % 10 + '0';
> +	} while ((i /= 10) > 0);
> +	str[j] = '\0';

Could the above be achieved using printf?

> +	/* Reverse the string. */
> +	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
> +		tmp = str[k];
> +		str[k] = str[j];
> +		str[j] = tmp;
> +	}

I'm confused as to why the string needs to be reversed.
Could it be avoided by byte-swapping 'i' before rendering it to a string? 

> +}
> +
> +/* Adds initrd parameters to command line. */
> +static int cmdline_add_initrd(char *cmdline, unsigned long addr, char *new_para)
> +{
> +	int cmdlen, len;
> +	char str[30], *ptr;
> +
> +	ptr = str;
> +	strcpy(str, new_para);
> +	ptr += strlen(str);
> +	ultoa(addr, ptr);
> +	len = strlen(str);
> +	cmdlen = strlen(cmdline) + len;
> +	if (cmdlen > (COMMAND_LINE_SIZE - 1))
> +		die("Command line overflow\n");
> +	strcat(cmdline, str);
> +
> +	return 0;
> +}
> +
> +
>  int elf_mips_probe(const char *buf, off_t len)
>  {
>  	struct mem_ehdr ehdr;
> @@ -171,6 +209,11 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
>  		/* Now that the buffer for initrd is prepared, update the dtb
>  		 * with an appropriate location */
>  		dtb_set_initrd(&dtb_buf, &dtb_length, initrd_base, initrd_base + initrd_size);
> +
> +		/* Add the initrd parameters to cmdline */
> +		cmdline_add_initrd(cmdline_buf, PAGE_OFFSET + initrd_base, " rd_start=");
> +		cmdline_add_initrd(cmdline_buf, initrd_size, " rd_size=");
> +

Will this be safe for existing use-cases?

