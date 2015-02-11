Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLgOW-0002aL-EI
 for kexec@lists.infradead.org; Wed, 11 Feb 2015 23:08:33 +0000
Date: Thu, 12 Feb 2015 08:08:07 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] multiboot: fix crash on NULL kernel command line
Message-ID: <20150211230807.GA6735@verge.net.au>
References: <1423172184-8076-1-git-send-email-2ameya@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1423172184-8076-1-git-send-email-2ameya@gmail.com>
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
To: Ameya Palande <2ameya@gmail.com>
Cc: kexec@lists.infradead.org

On Thu, Feb 05, 2015 at 01:36:24PM -0800, Ameya Palande wrote:
> If "--command-line" option is not specified, then kexec segfaults while
> dereferencing NULL command line string pointer. While we are at it, also
> fix indentation and use '{' and '}' consistently.
> 
> Signed-off-by: Ameya Palande <2ameya@gmail.com>

Somehow I missed this. Please CC me on patches for kexec-tools as
it makes it easier for me to see them.

Please resubmit this patch split up so that fixes and cleanups are separate.
One patch per issue is the rule of thumb. This makes it easier to review
and prioritise patches.

> ---
>  kexec/arch/i386/kexec-multiboot-x86.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
> index fce7f05..0dbac70 100644
> --- a/kexec/arch/i386/kexec-multiboot-x86.c
> +++ b/kexec/arch/i386/kexec-multiboot-x86.c
> @@ -169,8 +169,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	static const char short_options[] = KEXEC_ARCH_OPT_STR "";
>  	
>  	/* Probe for the MB header if it's not already found */
> -	if (mbh == NULL && multiboot_x86_probe(buf, len) != 1) 
> -	{
> +	if (mbh == NULL && multiboot_x86_probe(buf, len) != 1) {
>  		fprintf(stderr, "Cannot find a loadable multiboot header.\n");
>  		return -1;
>  	}
> @@ -180,8 +179,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	modules = 0;
>  	mod_command_line_space = 0;
>  	result = 0;
> -	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1)
> -	{
> +	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
>  		switch(opt) {
>  		default:
>  			/* Ignore core options */

> @@ -192,7 +190,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  			append = optarg;
>  			break;
>  		case OPT_REUSE_CMDLINE:
> -			tmp_cmdline = get_command_line();
> +			command_line = get_command_line();
>  			break;
>  		case OPT_MOD:
>  			modules++;
> @@ -201,11 +199,17 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  		}
>  	}
>  	imagename = argv[optind];
> -	command_line = concat_cmdline(tmp_cmdline, append);
> +
> +	/* Final command line = imagename + <OPT_REUSE_CMDLINE> + <OPT_CL> */
> +	tmp_cmdline = concat_cmdline(command_line, append);
> +	if (command_line) {
> +		free(command_line);
> +	}
> +	command_line = concat_cmdline(imagename, tmp_cmdline);
>  	if (tmp_cmdline) {
>  		free(tmp_cmdline);
>  	}
> -	command_line_len = strlen(command_line) + strlen(imagename) + 2;
> +	command_line_len = strlen(command_line) + 1;
>  	
>  	/* Load the ELF executable */
>  	elf_exec_build_load(info, &ehdr, buf, len, 0);
> @@ -232,8 +236,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	mbi_buf = xmalloc(mbi_bytes);
>  	mbi = mbi_buf;
>  	memset(mbi, 0, sizeof(*mbi));
> -	sprintf(((char *)mbi) + sizeof(*mbi), "%s %s",
> -		imagename, command_line);
> +	sprintf(((char *)mbi) + sizeof(*mbi), "%s", command_line);
>  	sprintf(((char *)mbi) + sizeof(*mbi) + command_line_len, "%s",
>  		BOOTLOADER " " BOOTLOADER_VERSION);
>  	mbi->flags = MB_INFO_CMDLINE | MB_INFO_BOOT_LOADER_NAME;
> @@ -274,9 +277,9 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  			if ((range[i].start <= 0x100000)
>  			    && (range[i].end > mem_upper + 0x100000))
>  				mem_upper = range[i].end - 0x100000;
> +		} else {
> +			mmap[i].Type = 0xbad;  /* Not RAM */
>  		}
> -		else
> -		mmap[i].Type = 0xbad;  /* Not RAM */
>  	}
>  
>  	if (mbh->flags & MULTIBOOT_MEMORY_INFO) { 
> @@ -324,8 +327,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  		/* Go back and parse the module command lines */
>  		optind = opterr = 1;
>  		while((opt = getopt_long(argc, argv, 
> -					 short_options, options, 0)) != -1)
> -		{
> +					 short_options, options, 0)) != -1) {
>  			if (opt != OPT_MOD) continue;
>  
>  			/* Split module filename from command line */
> @@ -358,14 +360,13 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  			mod_clp += strlen(mod_clp) + 1;
>  			modp++;
>  		}
> -		
>  	}
>  
>  	/* Find a place for the MBI to live */
>  	if (sort_segments(info) < 0) {
> -                result = -1;
> +		result = -1;
>  		goto out;
> -        }
> +	}
>  	mbi_base = add_buffer(info,
>  		mbi_buf, mbi_bytes, mbi_bytes, 4, 0, 0xFFFFFFFFUL, 1);
>  		
> @@ -394,4 +395,3 @@ out:
>  /*
>   *  EOF (kexec-multiboot-x86.c)
>   */
> -
> -- 
> 1.8.3.1
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
