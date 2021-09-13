Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPi5R-0010mR-EK
 for kexec@lists.infradead.org; Mon, 13 Sep 2021 09:17:15 +0000
Date: Mon, 13 Sep 2021 11:17:10 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/3] multiboot2: Accept x86-64 images
Message-ID: <20210913091708.GC11132@vergenet.net>
References: <20210911024900.1899877-1-hello@zhaofeng.li>
 <20210911024900.1899877-4-hello@zhaofeng.li>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210911024900.1899877-4-hello@zhaofeng.li>
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
To: Zhaofeng Li <hello@zhaofeng.li>
Cc: kexec@lists.infradead.org

On Fri, Sep 10, 2021 at 07:49:00PM -0700, Zhaofeng Li wrote:
> Signed-off-by: Zhaofeng Li <hello@zhaofeng.li>
> ---
>  kexec/arch/i386/kexec-mb2-x86.c  | 34 ++++++++++++++++++++++++++++++--
>  kexec/arch/x86_64/kexec-x86_64.c |  4 ++--
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
> index 49fcc2d..31b4ce1 100644
> --- a/kexec/arch/i386/kexec-mb2-x86.c
> +++ b/kexec/arch/i386/kexec-mb2-x86.c
> @@ -72,12 +72,42 @@ struct multiboot2_header_info {
>  #define ALIGN_UP(addr, align) \
>  	((addr + (typeof (addr)) align - 1) & ~((typeof (addr)) align - 1))
>  
> +static const int probe_debug = 0;
> +
> +static int elf_x86_or_x64_probe(const char *buf, off_t len)

There is a lot of duplication between at least this function,
elf_x86_probe and elf_x86_64_probe. I wonder if there is any value in
reconciling that.

> +{
> +	struct mem_ehdr ehdr;
> +	int result;
> +	result = build_elf_exec_info(buf, len, &ehdr, 0);
> +	if (result < 0) {
> +		if (probe_debug) {
> +			fprintf(stderr, "Not an ELF executable\n");
> +		}
> +		goto out;
> +	}
> +
> +	/* Verify the architecuture specific bits */
> +	if ((ehdr.e_machine != EM_386) && (ehdr.e_machine != EM_486) && (ehdr.e_machine != EM_X86_64)) {

nit: line-wrap please

> +		/* for a different architecture */
> +		if (probe_debug) {
> +			fprintf(stderr, "Not i386 or x86_64 ELF executable\n");
> +		}
> +		result = -1;
> +		goto out;
> +	}
> +	result = 0;
> + out:
> +	free_elf_info(&ehdr);
> +	return result;
> +}
> +
>  int multiboot2_x86_probe(const char *buf, off_t buf_len)
>  /* Is it a good idea to try booting this file? */
>  {
>  	int i, len;
> -	/* First of all, check that this is an ELF file */
> -	if ((i=elf_x86_probe(buf, buf_len)) < 0)
> +
> +	/* First of all, check that this is an ELF file for either x86 or x86-64 */
> +	if ((i=elf_x86_or_x64_probe(buf, buf_len)) < 0)

nit: as we are touching this line could we split the assignment and test of i?

	i = ...;
	if (i < 0)

>  		return i;
>  
>  	/* Now look for a multiboot header. */
> diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
> index 394cfca..ffd84f0 100644
> --- a/kexec/arch/x86_64/kexec-x86_64.c
> +++ b/kexec/arch/x86_64/kexec-x86_64.c
> @@ -33,11 +33,11 @@
>  #include <arch/options.h>
>  
>  struct file_type file_type[] = {
> +	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
> +	  multiboot2_x86_usage },
>  	{ "elf-x86_64", elf_x86_64_probe, elf_x86_64_load, elf_x86_64_usage },
>  	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
>  	  multiboot_x86_usage },
> -	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
> -	  multiboot2_x86_usage },
>  	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
>  	{ "bzImage64", bzImage64_probe, bzImage64_load, bzImage64_usage },
>  	{ "bzImage", bzImage_probe, bzImage_load, bzImage_usage },
> -- 
> 2.32.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
