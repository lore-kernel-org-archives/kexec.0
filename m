Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam12on2139.outbound.protection.outlook.com
 ([40.107.244.139] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lW0Ix-006S3M-8M
 for kexec@lists.infradead.org; Mon, 12 Apr 2021 17:24:57 +0000
Date: Mon, 12 Apr 2021 13:24:35 -0400
From: Joe Korty <joe.korty@concurrent-rt.com>
Subject: Re: [CFT][PATCH] kexec: Remove the error prone kernel_version function
Message-ID: <20210412172435.GA37849@zipoli.concurrrent-rt.com>
References: <20210409154642.GA30739@zipoli.concurrrent-rt.com>
 <m1blanmnqc.fsf@fess.ebiederm.org>
Content-Disposition: inline
In-Reply-To: <m1blanmnqc.fsf@fess.ebiederm.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>, Hariprasad Nellitheertha <hari@in.ibm.com>, Tim Deegan <tjd21@cl.cam.ac.uk>, Hongyan Xia <hongyxia@amazon.com>, David Hildenbrand <david@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>

On Fri, Apr 09, 2021 at 11:22:51AM -0500, Eric W. Biederman wrote:
> 
> During kexec there are two kernel versions at play.  The version of
> the running kernel and the version of the kernel that will be booted.
> 
> On powerpc it appears people have been using the version of the
> running kernel to attempt to detect properties of the kernel to be
> booted which is just wrong.  As the linux kernel version that is being
> detected is a no longer supported kernel just remove that buggy and
> confused code.
> 
> On x86_64 the kernel_version is used to compute the starting virtual
> address of the running kernel so a proper core dump may be generated.
> Using the kernel_version stopped working a while ago when the starting
> virtual address  became randomized.
> 
> The old code was kept for the case where the kernel was not built with
> randomization support, but there is nothing in reading /proc/kcore
> that won't work to detect the starting virtual address even there.
> In fact /proc/kcore must have the starting virtual address or a
> debugger can not make sense of the running kernel.
> 
> So just make computing the starting virtual address on x86_64
> unconditional.  With a hard coded fallback just in case something went
> wrong.
> 
> Doing something with kernel_version() has become important as recent
> stable kernels have seen the minor version to > 255.  Just removing
> kernel_version() looks like the best option.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Can folks please test this patch and verify that it works.  I really
> think simply removing the problem code is going to be a much more robust
> solution than papering over the bug.
> 
>  kexec/Makefile                     |  1 -
>  kexec/arch/i386/crashdump-x86.c    | 28 +++++----------
>  kexec/arch/ppc/crashdump-powerpc.c |  3 +-
>  kexec/arch/ppc64/crashdump-ppc64.c |  3 +-
>  kexec/kernel_version.c             | 57 ------------------------------
>  kexec/kexec.h                      |  4 ---
>  6 files changed, 11 insertions(+), 85 deletions(-)
>  delete mode 100644 kexec/kernel_version.c
> 
> diff --git a/kexec/Makefile b/kexec/Makefile
> index 8e3e9ea39664..e69e30950ac8 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -22,7 +22,6 @@ KEXEC_SRCS_base += kexec/firmware_memmap.c
>  KEXEC_SRCS_base += kexec/crashdump.c
>  KEXEC_SRCS_base += kexec/crashdump-xen.c
>  KEXEC_SRCS_base += kexec/phys_arch.c
> -KEXEC_SRCS_base += kexec/kernel_version.c
>  KEXEC_SRCS_base += kexec/lzma.c
>  KEXEC_SRCS_base += kexec/zlib.c
>  KEXEC_SRCS_base += kexec/kexec-xen.c
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index d5b5b6850fe8..ea3e7c73c621 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -55,16 +55,8 @@ static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>  	int kv;
>  
>  	if (elf_info->machine == EM_X86_64) {
> -		kv = kernel_version();
> -		if (kv < 0)
> -			return -1;
> -
> -		if (kv < KERNEL_VERSION(2, 6, 27))
> -			elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_2_6_27;
> -		else if (kv < KERNEL_VERSION(4, 20, 0))
> -			elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_4_20_0;
> -		else
> -			elf_info->page_offset = X86_64_PAGE_OFFSET;
> +		/* get_kernel_vaddr_and_size will override this */
> +		elf_info->page_offset = X86_64_PAGE_OFFSET;
>  	}
>  	else if (elf_info->machine == EM_386) {
>  		elf_info->page_offset = X86_PAGE_OFFSET;
> @@ -151,17 +143,15 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  
>  	/* Search for the real PAGE_OFFSET when KASLR memory randomization
>  	 * is enabled */
> -	if (get_kernel_sym("page_offset_base") != 0) {
> -		for(phdr = ehdr.e_phdr; phdr != end_phdr; phdr++) {
> -			if (phdr->p_type == PT_LOAD) {
> -				vaddr = phdr->p_vaddr & pud_mask;
> -				if (lowest_vaddr == 0 || lowest_vaddr > vaddr)
> -					lowest_vaddr = vaddr;
> -			}
> +	for(phdr = ehdr.e_phdr; phdr != end_phdr; phdr++) {
> +		if (phdr->p_type == PT_LOAD) {
> +			vaddr = phdr->p_vaddr & pud_mask;
> +			if (lowest_vaddr == 0 || lowest_vaddr > vaddr)
> +				lowest_vaddr = vaddr;
>  		}
> -		if (lowest_vaddr != 0)
> -			elf_info->page_offset = lowest_vaddr;
>  	}
> +	if (lowest_vaddr != 0)
> +		elf_info->page_offset = lowest_vaddr;
>  
>  	/* Traverse through the Elf headers and find the region where
>  	 * _stext symbol is located in. That's where kernel is mapped */
> diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
> index 4ad026f38dd0..15e85313ff75 100644
> --- a/kexec/arch/ppc/crashdump-powerpc.c
> +++ b/kexec/arch/ppc/crashdump-powerpc.c
> @@ -255,8 +255,7 @@ static void add_cmdline(char *cmdline, char *str)
>  	int cmdline_size;
>  	int cmdlen = strlen(cmdline) + strlen(str);
>  
> -	cmdline_size = (kernel_version() < KERNEL_VERSION(3, 15, 0) ?
> -			512 : COMMAND_LINE_SIZE);
> +	cmdline_size = COMMAND_LINE_SIZE;
>  	if (cmdlen > (cmdline_size - 1))
>  		die("Command line overflow\n");
>  	strcat(cmdline, str);
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index 26f9a01a8174..addd769de401 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.c
> +++ b/kexec/arch/ppc64/crashdump-ppc64.c
> @@ -478,8 +478,7 @@ static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
>  	strcat(str, byte);
>  	len = strlen(str);
>  	cmdlen = strlen(cmdline) + len;
> -	cmdline_size = (kernel_version() < KERNEL_VERSION(3, 15, 0) ?
> -			512 : COMMAND_LINE_SIZE);
> +	cmdline_size = COMMAND_LINE_SIZE;
>  	if (cmdlen > (cmdline_size - 1))
>  		die("Command line overflow\n");
>  	strcat(cmdline, str);
> diff --git a/kexec/kernel_version.c b/kexec/kernel_version.c
> deleted file mode 100644
> index 21fb13adf095..000000000000
> --- a/kexec/kernel_version.c
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -#include "kexec.h"
> -#include <errno.h>
> -#include <string.h>
> -#include <sys/utsname.h>
> -#include <string.h>
> -#include <limits.h>
> -#include <stdlib.h>
> -
> -long kernel_version(void)
> -{
> -	struct utsname utsname;
> -	unsigned long major, minor, patch;
> -	char *p;
> -
> -	if (uname(&utsname) < 0) {
> -		fprintf(stderr, "uname failed: %s\n", strerror(errno));
> -		return -1;
> -	}
> -
> -	p = utsname.release;
> -	major = strtoul(p, &p, 10);
> -	if (major == ULONG_MAX) {
> -		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
> -		return -1;
> -	}
> -
> -	if (*p++ != '.') {
> -		fprintf(stderr, "Unsupported utsname.release: %s\n",
> -			utsname.release);
> -		return -1;
> -	}
> -
> -	minor = strtoul(p, &p, 10);
> -	if (minor == ULONG_MAX) {
> -		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
> -		return -1;
> -	}
> -
> -	/* There may or may not be a patch level for this kernel */
> -	if (*p++ == '.') {
> -		patch = strtoul(p, &p, 10);
> -		if (patch == ULONG_MAX) {
> -			fprintf(stderr, "strtoul failed: %s\n",strerror(errno));
> -			return -1;
> -		}
> -	} else {
> -		patch = 0;
> -	}
> -
> -	if (major >= 256 || minor >= 256 || patch >= 256) {
> -		fprintf(stderr, "Unsupported utsname.release: %s\n",
> -			utsname.release);
> -		return -1;
> -	}
> -
> -	return KERNEL_VERSION(major, minor, patch);
> -}
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index f0f347d5e9e0..595dd681db6d 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -179,10 +179,6 @@ struct arch_map_entry {
>  extern const struct arch_map_entry arches[];
>  long physical_arch(void);
>  
> -#define KERNEL_VERSION(major, minor, patch) \
> -	(((major) << 16) | ((minor) << 8) | patch)
> -long kernel_version(void);
> -
>  void usage(void);
>  int get_memory_ranges(struct memory_range **range, int *ranges,
>  						unsigned long kexec_flags);
> -- 
> 2.30.1

[ Sorry this has taken so long --jak ]

Successful dump was acquired using a hand-built 4.4.262-kdump kernel.
The new kdump tools were installed in /usr/local, and a modified kdumpctl
(making it use the new tools) was put in in /tmp/kdumpctl.  When I do:
 
    kdumpctl start
    echo c >/proc/sysrq

I get the 'Unsupported utsname.release' error message, and the 'echo c'
fails to create a dump directory in /var/crash.  When I do:

    /tmp/kdumpctl start
    echo c >/proc/sysrq

I no longer get the 'Unsupported' error message and a dump directory
appears in /var/crash.  I did not test if the dump itself was good.

Tested-by: Joe Korty <joe.korty@conurrent-rt.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
