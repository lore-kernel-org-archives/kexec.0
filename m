Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nbypg-0002GV-RD
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 16:09:05 +0000
Subject: Re: [PATCH] Fix --reuse-cmdline so it is usable.
References: <m1d4167c5s.fsf@fess.ebiederm.org>
	<20100125072352.GD23849@verge.net.au>
	<m1eile4n5g.fsf@fess.ebiederm.org>
	<20100201120957.GA4305@verge.net.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 01 Feb 2010 08:08:51 -0800
In-Reply-To: <20100201120957.GA4305@verge.net.au> (Simon Horman's message of
	"Mon\, 1 Feb 2010 23\:10\:01 +1100")
Message-ID: <m1mxztos4s.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Simon Horman <horms@verge.net.au> writes:

> On Mon, Jan 25, 2010 at 12:14:03AM -0800, Eric W. Biederman wrote:
>> Simon Horman <horms@verge.net.au> writes:
>> 
>> > On Tue, Jan 19, 2010 at 12:05:03AM -0800, Eric W. Biederman wrote:
>> >> 
>> >> A colleague of mine implemented kdump and it used --reuse-cmdline
>> >> with some rather interesting and unexpected results.
>> >> 
>> >> Update the getopt specification so that --reuse-cmdline does not
>> >> attempt to take an argument that it will not use.
>> >> 
>> >> Update the processing of --append so that --reuse-cmdline followed
>> >> by --append actually appends the parameters specified by --reuse-cmdline.
>> >
>> > Hi Eric,
>> >
>> > sorry for being slow. Been semi-offline for LCA and am now catching
>> > up on things.
>> 
>> No problem, I am pretty out of it right now as well.
>> 
>> > [snip]
>> >
>> >> diff --git a/kexec/kexec.c b/kexec/kexec.c
>> >> index a1cec86..f4c22a6 100644
>> >> --- a/kexec/kexec.c
>> >> +++ b/kexec/kexec.c
>> >> @@ -994,6 +994,22 @@ void check_reuse_initrd(void)
>> >>  	free(line);
>> >>  }
>> >>  
>> >> +const char *concat_cmdline(const char *base, const char *append)
>> >> +{
>> >> +	const char *cmdline;
>> >> +	if (!base && !append)
>> >> +		return NULL;
>> >> +	if (!base)
>> >> +		return append;
>> >> +	if (!append)
>> >> +		return base;
>> >> +	cmdline = xmalloc(strlen(base) + 1 + strlen(append) + 1);
>> >> +	strcpy(cmdline, base);
>> >> +	strcat(cmdline, " ");
>> >> +	strcat(cmdline, append);
>> >> +	return cmdline;
>> >> +}
>> >> +
>> >
>> > This introduces a memory leak.
>> 
>> Yep.
>> 
>> > Perhaps it should strdup append and base in the !base and !append cases
>> > respectively and expect the caller to always call free.
>> >
>> > I realise that its a small leak in a programme that will soon exit anyway.
>> > But for the sake of being able to use tools like valgrind to analyse
>> > problems it seems to me that leaks are worth avoiding.  (Not that I have
>> > run valgrind on kexec-tools to see what happens :-)
>> 
>> I see your point but I think we already have a memory leak here (
>> Where does the memory that getopt uses come from? ), and I think on a
>> trivial application like /sbin/kexec that is simply not long running
>> it can't matter.  I'm even willing to call not freeing memory
>> explicitly a performance optimization in cases like this ;)
>
> Clearly this is a matter of taste. And as it happens I fall on
> the side of the fence that thinks that the leak should be avoided.
>
> I propose applying the following after your patch:
>
> From: Simon Horman <horms@verge.net.au>
>
> don't leak in concat_cmdline

It is a bit of a shame that we loose the const attributes.
Beyond that the idiom
	if (xyz)
		free(xyz)
can just become:
	free(xyz)

Eric



> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> Index: kexec-tools/kexec/arch/i386/kexec-bzImage.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/i386/kexec-bzImage.c	2010-02-01 23:07:15.000000000 +1100
> +++ kexec-tools/kexec/arch/i386/kexec-bzImage.c	2010-02-01 23:07:15.000000000 +1100
> @@ -332,8 +332,8 @@ int do_bzImage_load(struct kexec_info *i
>  int bzImage_load(int argc, char **argv, const char *buf, off_t len, 
>  	struct kexec_info *info)
>  {
> -	const char *command_line = NULL, *append = NULL;
> -	const char *ramdisk;
> +	char *command_line = NULL;
> +	const char *ramdisk, *append = NULL;
>  	char *ramdisk_buf;
>  	off_t ramdisk_length;
>  	int command_line_len;
> @@ -406,5 +406,7 @@ int bzImage_load(int argc, char **argv, 
>  		ramdisk_buf, ramdisk_length,
>  		real_mode_entry, debug);
>  
> +	if (command_line)
> +		free(command_line);
>  	return result;
>  }
> Index: kexec-tools/kexec/arch/i386/kexec-elf-x86.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/i386/kexec-elf-x86.c	2010-02-01 23:07:15.000000000 +1100
> +++ kexec-tools/kexec/arch/i386/kexec-elf-x86.c	2010-02-01 23:07:15.000000000 +1100
> @@ -88,8 +88,8 @@ int elf_x86_load(int argc, char **argv, 
>  	struct kexec_info *info)
>  {
>  	struct mem_ehdr ehdr;
> -	const char *command_line = NULL, *append = NULL;
> -	char *modified_cmdline;
> +	char *command_line = NULL, *modified_cmdline = NULL;
> +	const char *append = NULL;
>  	int command_line_len;
>  	int modified_cmdline_len;
>  	const char *ramdisk;
> @@ -264,8 +264,11 @@ int elf_x86_load(int argc, char **argv, 
>  			if (rc < 0)
>  				return -1;
>  			/* Use new command line. */
> +			if (command_line)
> +				free(command_line);
>  			command_line = modified_cmdline;
>  			command_line_len = strlen(modified_cmdline) + 1;
> +			modified_cmdline = NULL;
>  		}
>  
>  		/* Tell the kernel what is going on */
> @@ -288,5 +291,10 @@ int elf_x86_load(int argc, char **argv, 
>  	else {
>  		die("Unknown argument style\n");
>  	}
> +
> +	if (command_line)
> +		free(command_line);
> +	if (modified_cmdline)
> +		free(modified_cmdline);
>  	return 0;
>  }
> Index: kexec-tools/kexec/kexec.c
> ===================================================================
> --- kexec-tools.orig/kexec/kexec.c	2010-02-01 23:07:15.000000000 +1100
> +++ kexec-tools/kexec/kexec.c	2010-02-01 23:07:15.000000000 +1100
> @@ -62,6 +62,14 @@ void die(char *fmt, ...)
>  	exit(1);
>  }
>  
> +char *xstrdup(const char *str)
> +{
> +	char *new = strdup(str);
> +	if (!new)
> +		die("Cannot strdup \"%s\": %s\n",
> +			str, strerror(errno));
> +	return new;
> +}
>  
>  void *xmalloc(size_t size)
>  {
> @@ -994,15 +1002,15 @@ void check_reuse_initrd(void)
>  	free(line);
>  }
>  
> -const char *concat_cmdline(const char *base, const char *append)
> +char *concat_cmdline(const char *base, const char *append)
>  {
> -	const char *cmdline;
> +	char *cmdline;
>  	if (!base && !append)
>  		return NULL;
> -	if (!base)
> -		return append;
> -	if (!append)
> -		return base;
> +	if (append)
> +		return xstrdup(append);
> +	if (base)
> +		return xstrdup(base);
>  	cmdline = xmalloc(strlen(base) + 1 + strlen(append) + 1);
>  	strcpy(cmdline, base);
>  	strcat(cmdline, " ");
> Index: kexec-tools/kexec/arch/i386/kexec-multiboot-x86.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/i386/kexec-multiboot-x86.c	2010-02-01 23:07:15.000000000 +1100
> +++ kexec-tools/kexec/arch/i386/kexec-multiboot-x86.c	2010-02-01 23:07:15.000000000 +1100
> @@ -147,8 +147,8 @@ int multiboot_x86_load(int argc, char **
>  	unsigned long mbi_base;
>  	struct entry32_regs regs;
>  	size_t mbi_bytes, mbi_offset;
> -	const char *command_line=NULL, *append=NULL;
> -	char *imagename, *cp;
> +	char *command_line = NULL;
> +	char *imagename, *cp, *append = NULL;;
>  	struct memory_range *range;
>  	int ranges;
>  	struct AddrRangeDesc *mmap;
> @@ -389,6 +389,8 @@ int multiboot_x86_load(int argc, char **
>  	regs.eip = ehdr.e_entry;
>  	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
>  
> +	if (command_line)
> +		free(command_line);
>  	return 0;
>  }
>  
> Index: kexec-tools/kexec/arch/x86_64/kexec-elf-x86_64.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/x86_64/kexec-elf-x86_64.c	2010-02-01 23:07:15.000000000 +1100
> +++ kexec-tools/kexec/arch/x86_64/kexec-elf-x86_64.c	2010-02-01 23:07:15.000000000 +1100
> @@ -87,8 +87,8 @@ int elf_x86_64_load(int argc, char **arg
>  	struct kexec_info *info)
>  {
>  	struct mem_ehdr ehdr;
> -	const char *command_line = NULL, *append = NULL;
> -	char *modified_cmdline;
> +	const char *append = NULL;
> +	char *command_line = NULL, *modified_cmdline;
>  	int command_line_len;
>  	int modified_cmdline_len;
>  	const char *ramdisk;
> @@ -249,8 +249,11 @@ int elf_x86_64_load(int argc, char **arg
>  			if (rc < 0)
>  				return -1;
>  			/* Use new command line. */
> +			if (command_line)
> +				free(command_line);
>  			command_line = modified_cmdline;
>  			command_line_len = strlen(modified_cmdline) + 1;
> +			modified_cmdline = NULL;
>  		}
>  
>  		/* Tell the kernel what is going on */
> @@ -273,5 +276,10 @@ int elf_x86_64_load(int argc, char **arg
>  	else {
>  		die("Unknown argument style\n");
>  	}
> +
> +	if (command_line)
> +		free(command_line);
> +	if (modified_cmdline)
> +		free(modified_cmdline);
>  	return 0;
>  }
> Index: kexec-tools/kexec/kexec.h
> ===================================================================
> --- kexec-tools.orig/kexec/kexec.h	2010-02-01 23:07:15.000000000 +1100
> +++ kexec-tools/kexec/kexec.h	2010-02-01 23:07:15.000000000 +1100
> @@ -261,6 +261,6 @@ static inline int __attribute__ ((format
>  	dbgprintf(const char *fmt, ...) {return 0;}
>  #endif
>  
> -const char *concat_cmdline(const char *base, const char *append);
> +char *concat_cmdline(const char *base, const char *append);
>  
>  #endif /* KEXEC_H */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
