Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S7FUS-0002Yu-9w
 for kexec@lists.infradead.org; Tue, 13 Mar 2012 00:21:29 +0000
Date: Tue, 13 Mar 2012 09:21:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5] Add generic debug option
Message-ID: <20120313002116.GB24671@verge.net.au>
References: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
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
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

On Thu, Mar 08, 2012 at 02:39:38PM +0800, Cong Wang wrote:
> Currently the debugging code is under #ifdef DEBUG, which
> means when we want to debug, we have to re-compile the source
> code with -DDEBUG. This is not convenient, we want to have
> a generic --debug option so that we can enable debugging code
> without re-compiling.
> 
> This patch moves the arch-specific --debug to generic place
> and moves code under #ifdef DEBUG to --debug on x86.
> 
> BTW, the size of kexec binary increases very little after this patch.

Hi Cong,

In general I am happy with making kexec easier to use.  However, it would
be nice not to make kexec-tools even bigger than it already is. Its size
already seems to be an issue for some people on ARM at least.  Do you
have some feeling for the change in binary size on architectures other than
i386?

> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  kexec/arch/i386/crashdump-x86.c          |   74 +++++++++++++-----------------
>  kexec/arch/i386/include/arch/options.h   |    1 -
>  kexec/arch/i386/kexec-beoboot-x86.c      |   12 +----
>  kexec/arch/i386/kexec-bzImage.c          |   18 ++-----
>  kexec/arch/i386/kexec-x86.h              |    2 +-
>  kexec/arch/i386/x86-linux-setup.c        |    1 -
>  kexec/arch/ppc/include/arch/options.h    |    3 +-
>  kexec/arch/ppc/kexec-dol-ppc.c           |    8 +---
>  kexec/arch/x86_64/kexec-elf-rel-x86_64.c |    4 +-
>  kexec/crashdump.c                        |    5 +-
>  kexec/kexec-elf-rel.c                    |   11 ++--
>  kexec/kexec.c                            |    4 ++
>  kexec/kexec.h                            |   15 +++---
>  13 files changed, 63 insertions(+), 95 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 436797a..590c883 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -76,9 +76,7 @@ static int get_kernel_paddr(struct kexec_info *UNUSED(info),
>  
>  	if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
>  		elf_info->kern_paddr_start = start;
> -#ifdef DEBUG
> -		printf("kernel load physical addr start = 0x%016Lx\n", start);
> -#endif
> +		dbgprintf("kernel load physical addr start = 0x%016Lx\n", start);
>  		return 0;
>  	}
>  
> @@ -150,10 +148,8 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  				/* Align size to page size boundary. */
>  				size = (size + align - 1) & (~(align - 1));
>  				elf_info->kern_size = size;
> -#ifdef DEBUG
> -				printf("kernel vaddr = 0x%lx size = 0x%llx\n",
> +				dbgprintf("kernel vaddr = 0x%lx size = 0x%llx\n",
>  					saddr, size);
> -#endif
>  				return 0;
>  			}
>  		}
> @@ -211,10 +207,8 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  		if (count != 2)
>  			continue;
>  		str = line + consumed;
> -#ifdef DEBUG
> -		printf("%016Lx-%016Lx : %s",
> +		dbgprintf("%016Lx-%016Lx : %s",
>  			start, end, str);
> -#endif
>  		/* Only Dumping memory of type System RAM. */
>  		if (memcmp(str, "System RAM\n", 11) == 0) {
>  			type = RANGE_RAM;
> @@ -290,15 +284,15 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  	}
>  	*range = crash_memory_range;
>  	*ranges = memory_ranges;
> -#ifdef DEBUG
> +
>  	int i;
> -	printf("CRASH MEMORY RANGES\n");
> +	dbgprintf("CRASH MEMORY RANGES\n");
>  	for(i = 0; i < memory_ranges; i++) {
>  		start = crash_memory_range[i].start;
>  		end = crash_memory_range[i].end;
> -		printf("%016Lx-%016Lx\n", start, end);
> +		dbgprintf("%016Lx-%016Lx\n", start, end);
>  	}
> -#endif
> +
>  	return 0;
>  }
>  
> @@ -385,17 +379,17 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
>  			memmap_p[j+1] = memmap_p[j];
>  		memmap_p[tidx].start = addr;
>  		memmap_p[tidx].end = addr + size - 1;
> -#ifdef DEBUG
> -	printf("Memmap after adding segment\n");
> +
> +	dbgprintf("Memmap after adding segment\n");
>  	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
>  		mstart = memmap_p[i].start;
>  		mend = memmap_p[i].end;
>  		if (mstart == 0 && mend == 0)
>  			break;
> -		printf("%016llx - %016llx\n",
> +		dbgprintf("%016llx - %016llx\n",
>  			mstart, mend);
>  	}
> -#endif
> +
>  	return 0;
>  }
>  
> @@ -471,18 +465,18 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
>  			memmap_p[j-1] = memmap_p[j];
>  		memmap_p[j-1].start = memmap_p[j-1].end = 0;
>  	}
> -#ifdef DEBUG
> -	printf("Memmap after deleting segment\n");
> +
> +	dbgprintf("Memmap after deleting segment\n");
>  	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
>  		mstart = memmap_p[i].start;
>  		mend = memmap_p[i].end;
>  		if (mstart == 0 && mend == 0) {
>  			break;
>  		}
> -		printf("%016llx - %016llx\n",
> +		dbgprintf("%016llx - %016llx\n",
>  			mstart, mend);
>  	}
> -#endif
> +
>  	return 0;
>  }
>  
> @@ -546,10 +540,10 @@ static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
>  			die("Command line overflow\n");
>  		strcat(cmdline, str_mmap);
>  	}
> -#ifdef DEBUG
> -		printf("Command line after adding memmap\n");
> -		printf("%s\n", cmdline);
> -#endif
> +
> +	dbgprintf("Command line after adding memmap\n");
> +	dbgprintf("%s\n", cmdline);
> +
>  	return 0;
>  }
>  
> @@ -574,10 +568,10 @@ static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
>  	if (cmdlen > (COMMAND_LINE_SIZE - 1))
>  		die("Command line overflow\n");
>  	strcat(cmdline, str);
> -#ifdef DEBUG
> -		printf("Command line after adding elfcorehdr\n");
> -		printf("%s\n", cmdline);
> -#endif
> +
> +	dbgprintf("Command line after adding elfcorehdr\n");
> +	dbgprintf("%s\n", cmdline);
> +
>  	return 0;
>  }
>  
> @@ -606,9 +600,9 @@ static int get_crash_notes(int cpu, uint64_t *addr, uint64_t *len)
>  
>  		*addr = x86__pa(vaddr + (cpu * MAX_NOTE_BYTES));
>  		*len = MAX_NOTE_BYTES;
> -#ifdef DEBUG
> -		printf("crash_notes addr = %Lx\n", *addr);
> -#endif
> +
> +		dbgprintf("crash_notes addr = %Lx\n", *addr);
> +
>  		fclose(fp);
>  		return 0;
>  	} else
> @@ -658,10 +652,9 @@ static int cmdline_add_memmap_acpi(char *cmdline, unsigned long start,
>  		die("Command line overflow\n");
>  	strcat(cmdline, str_mmap);
>  
> -#ifdef DEBUG
> -		printf("Command line after adding acpi memmap\n");
> -		printf("%s\n", cmdline);
> -#endif
> +	dbgprintf("Command line after adding acpi memmap\n");
> +	dbgprintf("%s\n", cmdline);
> +
>  	return 0;
>  }
>  
> @@ -688,15 +681,12 @@ static void get_backup_area(unsigned long *start, unsigned long *end)
>  		if (count != 2)
>  			continue;
>  		str = line + consumed;
> -#ifdef DEBUG
> -		printf("%016lx-%016lx : %s",
> +		dbgprintf("%016lx-%016lx : %s",
>  			mstart, mend, str);
> -#endif
> +
>  		/* Hopefully there is only one RAM region in the first 640K */
>  		if (memcmp(str, "System RAM\n", 11) == 0 && mend <= 0xa0000 ) {
> -#ifdef DEBUG
> -			printf("%s: %016lx-%016lx : %s", __func__, mstart, mend, str);
> -#endif
> +			dbgprintf("%s: %016lx-%016lx : %s", __func__, mstart, mend, str);
>  			*start = mstart;
>  			*end = mend;
>  			fclose(fp);
> diff --git a/kexec/arch/i386/include/arch/options.h b/kexec/arch/i386/include/arch/options.h
> index 990527c..89dbd26 100644
> --- a/kexec/arch/i386/include/arch/options.h
> +++ b/kexec/arch/i386/include/arch/options.h
> @@ -67,7 +67,6 @@
>  	{ "args-elf",		0, NULL, OPT_ARGS_ELF },	\
>  	{ "args-linux",		0, NULL, OPT_ARGS_LINUX },	\
>  	{ "args-none",		0, NULL, OPT_ARGS_NONE },	\
> -	{ "debug",		0, NULL, OPT_DEBUG },		\
>  	{ "module",		1, 0, OPT_MOD },		\
>  	{ "real-mode",		0, NULL, OPT_REAL_MODE },
>  
> diff --git a/kexec/arch/i386/kexec-beoboot-x86.c b/kexec/arch/i386/kexec-beoboot-x86.c
> index 6d459ae..a65e094 100644
> --- a/kexec/arch/i386/kexec-beoboot-x86.c
> +++ b/kexec/arch/i386/kexec-beoboot-x86.c
> @@ -64,8 +64,7 @@ int beoboot_probe(const char *buf, off_t len)
>  
>  void beoboot_usage(void)
>  {
> -	printf(	"-d, --debug               Enable debugging to help spot a failure.\n"
> -		"    --real-mode           Use the kernels real mode entry point.\n"
> +	printf(	"    --real-mode           Use the kernels real mode entry point.\n"
>  		);
>         
>  	/* No parameters are parsed */
> @@ -81,14 +80,13 @@ int beoboot_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
>  	struct beoboot_header bb_header;
>  	const char *command_line, *kernel, *initrd;
>  
> -	int debug, real_mode_entry;
> +	int real_mode_entry;
>  	int opt;
>  	int result;
>  
>  	/* See options.h -- add any more there, too. */
>  	static const struct option options[] = {
>  		KEXEC_ARCH_OPTIONS
> -		{ "debug",		0, 0, OPT_DEBUG },
>  		{ "real-mode",		0, 0, OPT_REAL_MODE },
>  		{ 0, 			0, 0, 0 },
>  	};
> @@ -97,7 +95,6 @@ int beoboot_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
>  	/*
>  	 * Parse the command line arguments
>  	 */
> -	debug = 0;
>  	real_mode_entry = 0;
>  	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
>  		switch(opt) {
> @@ -109,9 +106,6 @@ int beoboot_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
>  		case '?':
>  			usage();
>  			return -1;
> -		case OPT_DEBUG:
> -			debug = 1;
> -			break;
>  		case OPT_REAL_MODE:
>  			real_mode_entry = 1;
>  			break;
> @@ -134,7 +128,7 @@ int beoboot_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
>  		kernel,        bb_header.kernel_size,
>  		command_line,  bb_header.cmdline_size,
>  		initrd,        bb_header.initrd_size,
> -		real_mode_entry, debug);
> +		real_mode_entry);
>  
>  	return result;
>  }
> diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
> index 29e9165..54c4427 100644
> --- a/kexec/arch/i386/kexec-bzImage.c
> +++ b/kexec/arch/i386/kexec-bzImage.c
> @@ -85,8 +85,7 @@ int bzImage_probe(const char *buf, off_t len)
>  
>  void bzImage_usage(void)
>  {
> -	printf(	"-d, --debug               Enable debugging to help spot a failure.\n"
> -		"    --real-mode           Use the kernels real mode entry point.\n"
> +	printf(	"    --real-mode           Use the kernels real mode entry point.\n"
>  		"    --command-line=STRING Set the kernel command line to STRING.\n"
>  		"    --append=STRING       Set the kernel command line to STRING.\n"
>  		"    --reuse-cmdline       Use kernel command line from running system.\n"
> @@ -100,7 +99,7 @@ int do_bzImage_load(struct kexec_info *info,
>  	const char *kernel, off_t kernel_len,
>  	const char *command_line, off_t command_line_len,
>  	const char *initrd, off_t initrd_len,
> -	int real_mode_entry, int debug)
> +	int real_mode_entry)
>  {
>  	struct x86_linux_header setup_header;
>  	struct x86_linux_param_header *real_mode;
> @@ -297,7 +296,7 @@ int do_bzImage_load(struct kexec_info *info,
>  		printf("Starting the kernel in real mode\n");
>  		regs32.eip = elf_rel_get_addr(&info->rhdr, "entry16");
>  	}
> -	if (real_mode_entry && debug) {
> +	if (real_mode_entry && kexec_debug) {
>  		unsigned long entry16_debug, pre32, first32;
>  		uint32_t old_first32;
>  		/* Find the location of the symbols */
> @@ -338,14 +337,13 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
>  	char *ramdisk_buf;
>  	off_t ramdisk_length;
>  	int command_line_len;
> -	int debug, real_mode_entry;
> +	int real_mode_entry;
>  	int opt;
>  	int result;
>  
>  	/* See options.h -- add any more there, too. */
>  	static const struct option options[] = {
>  		KEXEC_ARCH_OPTIONS
> -		{ "debug",		0, 0, OPT_DEBUG },
>  		{ "command-line",	1, 0, OPT_APPEND },
>  		{ "append",		1, 0, OPT_APPEND },
>  		{ "reuse-cmdline",	0, 0, OPT_REUSE_CMDLINE },
> @@ -356,10 +354,6 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
>  	};
>  	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
>  
> -	/*
> -	 * Parse the command line arguments
> -	 */
> -	debug = 0;
>  	real_mode_entry = 0;
>  	ramdisk = 0;
>  	ramdisk_length = 0;
> @@ -373,8 +367,6 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
>  		case '?':
>  			usage();
>  			return -1;
> -		case OPT_DEBUG:
> -			debug = 1;
>  			break;
>  		case OPT_APPEND:
>  			append = optarg;
> @@ -403,7 +395,7 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
>  		buf, len,
>  		command_line, command_line_len,
>  		ramdisk_buf, ramdisk_length,
> -		real_mode_entry, debug);
> +		real_mode_entry);
>  
>  	free(command_line);
>  	return result;
> diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
> index aca1841..dfcc51d 100644
> --- a/kexec/arch/i386/kexec-x86.h
> +++ b/kexec/arch/i386/kexec-x86.h
> @@ -70,7 +70,7 @@ int do_bzImage_load(struct kexec_info *info,
>  	const char *kernel, off_t kernel_len,
>  	const char *command_line, off_t command_line_len,
>  	const char *initrd, off_t initrd_len,
> -	int real_mode_entry, int debug);
> +	int real_mode_entry);
>  
>  int beoboot_probe(const char *buf, off_t len);
>  int beoboot_load(int argc, char **argv, const char *buf, off_t len,
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 0528cea..95c9f97 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -13,7 +13,6 @@
>   * GNU General Public License for more details.
>   *
>   */
> -/* #define DEBUG 1 */
>  #define _GNU_SOURCE
>  #include <stdint.h>
>  #include <stdio.h>
> diff --git a/kexec/arch/ppc/include/arch/options.h b/kexec/arch/ppc/include/arch/options.h
> index 0c00ea7..b2176ab 100644
> --- a/kexec/arch/ppc/include/arch/options.h
> +++ b/kexec/arch/ppc/include/arch/options.h
> @@ -40,8 +40,7 @@
>  	{"initrd",	 1, 0, OPT_APPEND},\
>  	{"gamecube",	 1, 0, OPT_GAMECUBE},\
>  	{"dtb",	    1, 0, OPT_DTB},\
> -	{"reuse-node",	   1, 0, OPT_NODES},\
> -	{"debug",	 0, 0, OPT_DEBUG},
> +	{"reuse-node",	   1, 0, OPT_NODES},
>  
>  #define KEXEC_ALL_OPT_STR KEXEC_OPT_STR
>  
> diff --git a/kexec/arch/ppc/kexec-dol-ppc.c b/kexec/arch/ppc/kexec-dol-ppc.c
> index 8de5293..5fc5e06 100644
> --- a/kexec/arch/ppc/kexec-dol-ppc.c
> +++ b/kexec/arch/ppc/kexec-dol-ppc.c
> @@ -311,8 +311,7 @@ int dol_ppc_probe(const char *buf, off_t dol_length)
>  void dol_ppc_usage(void)
>  {
>  	printf
> -	    ("-d, --debug               Enable debugging to help spot a failure.\n"
> -	     "    --command-line=STRING Set the kernel command line to STRING.\n"
> +	    ("    --command-line=STRING Set the kernel command line to STRING.\n"
>  	     "    --append=STRING       Set the kernel command line to STRING.\n");
>  
>  }
> @@ -339,7 +338,6 @@ int dol_ppc_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
>  	/* See options.h -- add any more there, too. */
>          static const struct option options[] = {
>                  KEXEC_ARCH_OPTIONS
> -                {"debug",        0, 0, OPT_DEBUG},
>                  {"command-line", 1, 0, OPT_APPEND},
>                  {"append",       1, 0, OPT_APPEND},
>                  {0, 0, 0, 0},
> @@ -349,7 +347,6 @@ int dol_ppc_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
>  	/*
>  	 * Parse the command line arguments
>  	 */
> -	debug = 0;
>  	command_line = 0;
>  	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
>  		switch (opt) {
> @@ -361,9 +358,6 @@ int dol_ppc_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
>  		case '?':
>  			usage();
>  			return -1;
> -		case OPT_DEBUG:
> -			debug = 1;
> -			break;
>  		case OPT_APPEND:
>  			command_line = optarg;
>  			break;
> diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> index 8b2e0e5..a1291a6 100644
> --- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> +++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> @@ -60,9 +60,7 @@ static const char *reloc_name(unsigned long r_type)
>  void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
>  	void *location, unsigned long address, unsigned long value)
>  {
> -#ifdef DEBUG
> -	fprintf(stderr, "%s\n", reloc_name(r_type));
> -#endif
> +	dbgprintf("%s\n", reloc_name(r_type));
>  	switch(r_type) {
>  	case R_X86_64_NONE:
>  		break;
> diff --git a/kexec/crashdump.c b/kexec/crashdump.c
> index 847d080..cdd3ef6 100644
> --- a/kexec/crashdump.c
> +++ b/kexec/crashdump.c
> @@ -102,9 +102,8 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
>  		die("Cannot parse %s: %s\n", crash_notes, strerror(errno));
>  	*addr = (uint64_t) temp;
>  	*len = MAX_NOTE_BYTES; /* we should get this from the kernel instead */
> -#ifdef DEBUG
> -	printf("%s: crash_notes addr = %Lx\n", __FUNCTION__, *addr);
> -#endif
> +
> +	dbgprintf("%s: crash_notes addr = %Lx\n", __FUNCTION__, *addr);
>  
>  	fclose(fp);
>  	return 0;
> diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
> index f102fb8..c04c972 100644
> --- a/kexec/kexec-elf-rel.c
> +++ b/kexec/kexec-elf-rel.c
> @@ -363,8 +363,8 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
>  				name = ehdr->e_shdr[ehdr->e_shstrndx].sh_data;
>  				name += ehdr->e_shdr[sym.st_shndx].sh_name;
>  			}
> -#ifdef DEBUG
> -			fprintf(stderr, "sym: %10s info: %02x other: %02x shndx: %lx value: %lx size: %lx\n",
> +
> +			dbgprintf("sym: %10s info: %02x other: %02x shndx: %lx value: %lx size: %lx\n",
>  				name,
>  				sym.st_info,
>  				sym.st_other,
> @@ -372,7 +372,6 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
>  				sym.st_value,
>  				sym.st_size);
>  
> -#endif
>  			if (sym.st_shndx == STN_UNDEF) {
>  			/*
>  			 * NOTE: ppc64 elf .ro shows up a  UNDEF section.
> @@ -405,10 +404,10 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
>  			value = sym.st_value;
>  			value += sec_base;
>  			value += rel.r_addend;
> -#ifdef DEBUG
> -			fprintf(stderr, "sym: %s value: %lx addr: %lx\n",
> +
> +			dbgprintf("sym: %s value: %lx addr: %lx\n",
>  				name, value, address);
> -#endif
> +
>  			machine_apply_elf_rel(ehdr, rel.r_type,
>  				(void *)location, address, value);
>  		}
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 89e725e..19133fa 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -50,6 +50,7 @@
>  unsigned long long mem_min = 0;
>  unsigned long long mem_max = ULONG_MAX;
>  static unsigned long kexec_flags = 0;
> +int kexec_debug = 0;
>  
>  void die(char *fmt, ...)
>  {
> @@ -893,6 +894,7 @@ void usage(void)
>  	       "                      context of current kernel during kexec.\n"
>  	       "     --load-jump-back-helper Load a helper image to jump back\n"
>  	       "                      to original kernel.\n"
> +	       " -d, --debug           Enable debugging to help spot a failure.\n"
>  	       "\n"
>  	       "Supported kernel file types and options: \n");
>  	for (i = 0; i < file_types; i++) {
> @@ -1066,6 +1068,8 @@ int main(int argc, char *argv[])
>  		case OPT_VERSION:
>  			version();
>  			return 0;
> +		case OPT_DEBUG:
> +			kexec_debug = 1;
>  		case OPT_NOIFDOWN:
>  			do_ifdown = 0;
>  			break;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 9b59890..dfd3630 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -95,6 +95,13 @@ do { \
>  } while(0)
>  
>  extern unsigned long long mem_min, mem_max;
> +extern int kexec_debug;
> +
> +#define dbgprintf(...) \
> +do { \
> +	if (kexec_debug) \
> +		fprintf(stderr, __VA_ARGS__); \
> +} while(0)
>  
>  struct kexec_segment {
>  	const void *buf;
> @@ -198,6 +205,7 @@ extern int file_types;
>  	{ "mem-min",		1, 0, OPT_MEM_MIN }, \
>  	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
>  	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
> +	{ "debug",		0, 0, OPT_DEBUG }, \
>  
>  #define KEXEC_OPT_STR "hvdfxluet:p"
>  
> @@ -258,13 +266,6 @@ extern int add_backup_segments(struct kexec_info *info,
>  
>  #define MAX_LINE	160
>  
> -#ifdef DEBUG
> -#define dbgprintf(_args...) do {printf(_args);} while(0)
> -#else
> -static inline int __attribute__ ((format (printf, 1, 2)))
> -	dbgprintf(const char *UNUSED(fmt), ...) {return 0;}
> -#endif
> -
>  char *concat_cmdline(const char *base, const char *append);
>  
>  #endif /* KEXEC_H */
> -- 
> 1.7.7.6
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
