Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fzhEb-0002hv-Vb
 for kexec@lists.infradead.org; Tue, 11 Sep 2018 11:53:35 +0000
Date: Tue, 11 Sep 2018 13:53:18 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] multiboot-x86: support for non-elf kernels
Message-ID: <20180911115318.b5hdt6njw6tsjzmi@verge.net.au>
References: <04CFF83395A9F5F237D87D2F60C4D35A@felloff.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04CFF83395A9F5F237D87D2F60C4D35A@felloff.net>
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
To: cinap_lenrek@felloff.net
Cc: kexec@lists.infradead.org

Hi,

thanks for your patch and sorry for the delay in reviewing it.

On Thu, Aug 02, 2018 at 04:04:01PM +0200, cinap_lenrek@felloff.net wrote:
> Add support for non-elf multiboot kernels (such as Plan 9)
> by handling the MULTIBOOT_AOUT_KLUDGE bit.
> 
> When the bit is clear then we are dealing with an ELF file
> and probe for ELF as before with elf_x86_probe().
> 
> When the bit is set then load_addr, load_end_addr, header_addr
> and entry_addr from the multiboot header are used load the
> memory image.
> 
> Signed-off-by: Friedemann Gerold <cinap_lenrek@felloff.net>
> ---
> diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
> index 69027e2..afa0959 100644
> --- a/kexec/arch/i386/kexec-multiboot-x86.c
> +++ b/kexec/arch/i386/kexec-multiboot-x86.c
> @@ -8,7 +8,6 @@
>   *  TODO:  
>   *    - smarter allocation of new segments
>   *    - proper support for the MULTIBOOT_VIDEO_MODE bit
> - *    - support for the MULTIBOOT_AOUT_KLUDGE bit
>   *
>   *
>   *  Copyright (C) 2003  Tim Deegan (tjd21 at cl.cam.ac.uk)
> @@ -59,6 +58,7 @@
>  /* Static storage */
>  static char headerbuf[MULTIBOOT_SEARCH];
>  static struct multiboot_header *mbh = NULL;
> +static off_t mbh_offset = 0;

I would prefer if we moved to fewer rather than more global variables.
But perhaps that is a bigger question than this patch seeks to answer.

>  
>  #define MIN(_x,_y) (((_x)<=(_y))?(_x):(_y))
>  
> @@ -67,10 +67,6 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
>  /* Is it a good idea to try booting this file? */
>  {
>  	int i, len;
> -	/* First of all, check that this is an ELF file */
> -	if ((i=elf_x86_probe(buf, buf_len)) < 0) {
> -		return i;
> -	}
>  	/* Now look for a multiboot header in the first 8KB */
>  	len = MULTIBOOT_SEARCH;
>  	if (len > buf_len) {
> @@ -81,10 +77,10 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
>  		/* Short file */
>  		return -1;
>  	}
> -	for (i = 0; i <= (len - 12); i += 4)
> +	for (mbh_offset = 0; mbh_offset <= (len - 12); mbh_offset += 4)
>  	{
>  		/* Search for a multiboot header */
> -		mbh = (struct multiboot_header *)(headerbuf + i);
> +		mbh = (struct multiboot_header *)(headerbuf + mbh_offset);
>  		if (mbh->magic != MULTIBOOT_MAGIC 
>  		    || ((mbh->magic+mbh->flags+mbh->checksum) & 0xffffffff))
>  		{
> @@ -92,13 +88,34 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
>  			continue;
>  		}
>  		if (mbh->flags & MULTIBOOT_AOUT_KLUDGE) {
> -			/* Requires options we don't support */
> -			fprintf(stderr, 
> -				"Found a multiboot header, but it uses "
> -				"a non-ELF header layout,\n"
> -				"and I can't do that (yet).  Sorry.\n");
> -			return -1;
> -		} 
> +			if (mbh->load_addr & 0xfff) {
> +				fprintf(stderr, "multiboot load address not 4k aligned\n");
> +				return -1;
> +			}
> +			if (mbh->load_addr > mbh->header_addr) {
> +				fprintf(stderr, "multiboot header address > load address\n");
> +				return -1;
> +			}
> +			if (mbh->load_end_addr < mbh->load_addr) {
> +				fprintf(stderr, "multiboot load end address < load address\n");
> +				return -1;
> +			}
> +			if (mbh->bss_end_addr < mbh->load_end_addr) {
> +				fprintf(stderr, "multiboot bss end address < load end address\n");
> +				return -1;
> +			}
> +			if (mbh->load_end_addr - mbh->header_addr > buf_len - mbh_offset) {
> +				fprintf(stderr, "multiboot file truncated\n");
> +				return -1;
> +			}
> +			if (mbh->entry_addr < mbh->load_addr || mbh->entry_addr >= mbh->load_end_addr) {
> +				fprintf(stderr, "multiboot entry out of range\n");
> +				return -1;
> +			}
> +		} else {
> +			if ((i=elf_x86_probe(buf, buf_len)) < 0)
> +				return i;

Is it desirable for this check to be run for each iteration of the loop.

> +		}
>  		if (mbh->flags & MULTIBOOT_UNSUPPORTED) {
>  			/* Requires options we don't support */
>  			fprintf(stderr, 
> @@ -154,7 +171,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	struct AddrRangeDesc *mmap;
>  	int command_line_len;
>  	int i, result;
> -	uint32_t u;
> +	uint32_t u, entry;
>  	int opt;
>  	int modules, mod_command_line_space;
>  	/* See options.h -- add any more there, too. */
> @@ -211,8 +228,18 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	}
>  	command_line_len = strlen(command_line) + 1;
>  	
> -	/* Load the ELF executable */
> -	elf_exec_build_load(info, &ehdr, buf, len, 0);
> +	if (mbh->flags & MULTIBOOT_AOUT_KLUDGE) {
> +		add_segment(info,
> +			buf + (mbh_offset - (mbh->header_addr - mbh->load_addr)),
> +			mbh->load_end_addr - mbh->load_addr,
> +			mbh->load_addr,
> +			mbh->bss_end_addr - mbh->load_addr);
> +		entry = mbh->entry_addr;
> +	} else {
> +		/* Load the ELF executable */
> +		elf_exec_build_load(info, &ehdr, buf, len, 0);
> +		entry = ehdr.e_entry;
> +	}
>  
>  	/* Load the setup code */
>  	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size, 0,
> @@ -384,7 +420,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
>  	regs.eax = 0x2BADB002;
>  	regs.ebx = mbi_offset;
> -	regs.eip = ehdr.e_entry;
> +	regs.eip = entry;
>  	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
>  
>  out:
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
