Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yk64D-00051J-Pa
 for kexec@lists.infradead.org; Mon, 20 Apr 2015 07:24:30 +0000
Date: Mon, 20 Apr 2015 15:24:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RFC 5/6] arm64: Add support for binary image
Message-ID: <20150420072402.GG15033@dhcp-16-116.nay.redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <0a15f2079e6c378996dceda1d509df77d2f43899.1429201849.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a15f2079e6c378996dceda1d509df77d2f43899.1429201849.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On 04/16/15 at 10:17pm, Pratyush Anand wrote:
> This patch adds support to use binary image ie arch/arm64/boot/Image.
> 
> Binary image does not have sufficient knowledge to extract page offset
> information, which is needed by kexec tool. Use a new command parameter
> --page-offset, so that user can provide page offset information for
> liner mapping.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---

Seems there's a function get_kernel_page_offset used to get page_offset
automatically in arm. arm64 should have it either.


>  kexec/arch/arm64/crashdump-arm64.h      |  1 +
>  kexec/arch/arm64/include/arch/options.h | 10 ++++--
>  kexec/arch/arm64/kexec-arm64.c          |  3 ++
>  kexec/arch/arm64/kexec-arm64.h          |  2 ++
>  kexec/arch/arm64/kexec-image-arm64.c    | 54 ++++++++++++++++++++++++++++++---
>  5 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
> index d4fd3f2288c9..d53fa34de37a 100644
> --- a/kexec/arch/arm64/crashdump-arm64.h
> +++ b/kexec/arch/arm64/crashdump-arm64.h
> @@ -17,6 +17,7 @@
>  #define CRASH_MAX_MEMORY_RANGES	32
>  
>  extern struct memory_ranges usablemem_rgns;
> +extern struct memory_range crash_reserved_mem;
>  
>  int load_crashdump_segments(struct kexec_info *info, char **option);
>  void modify_ehdr_for_crashmem(struct mem_ehdr *ehdr);
> diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
> index afe3e9827ff3..af14102220ea 100644
> --- a/kexec/arch/arm64/include/arch/options.h
> +++ b/kexec/arch/arm64/include/arch/options.h
> @@ -5,9 +5,10 @@
>  #define OPT_DTB		((OPT_MAX)+1)
>  #define OPT_INITRD	((OPT_MAX)+2)
>  #define OPT_LITE	((OPT_MAX)+3)
> -#define OPT_PORT	((OPT_MAX)+4)
> -#define OPT_REUSE_CMDLINE	((OPT_MAX+5))
> -#define OPT_ARCH_MAX	((OPT_MAX)+6)
> +#define OPT_PAGE_OFFSET	((OPT_MAX)+4)
> +#define OPT_PORT	((OPT_MAX)+5)
> +#define OPT_REUSE_CMDLINE	((OPT_MAX+6))
> +#define OPT_ARCH_MAX	((OPT_MAX)+7)
>  
>  #define KEXEC_ARCH_OPTIONS \
>  	KEXEC_OPTIONS \
> @@ -16,6 +17,7 @@
>  	{ "dtb",          1, NULL, OPT_DTB }, \
>  	{ "initrd",       1, NULL, OPT_INITRD }, \
>  	{ "lite",         0, NULL, OPT_LITE }, \
> +	{ "page-offset",  1, NULL, OPT_PAGE_OFFSET }, \
>  	{ "port",         1, NULL, OPT_PORT }, \
>  	{ "ramdisk",      1, NULL, OPT_INITRD }, \
>  	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
> @@ -30,6 +32,7 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
>  "     --dtb=FILE            Use FILE as the device tree blob.\n"
>  "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
>  "     --lite                Fast reboot, no memory integrity checks.\n"
> +"     --page-offset         Kernel page-offset for binary image load.\n"
>  "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
>  "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
>  "     --reuse-cmdline       Use command line arg of primary kernel.\n";
> @@ -38,6 +41,7 @@ struct arm64_opts {
>  	const char *command_line;
>  	const char *dtb;
>  	const char *initrd;
> +	uint64_t page_offset;
>  	uint64_t port;
>  	int lite;
>  };
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 34e4ebf1eb23..190037c75186 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -99,6 +99,9 @@ int arch_process_options(int argc, char **argv)
>  		case OPT_PORT:
>  			arm64_opts.port = strtoull(optarg, NULL, 0);
>  			break;
> +		case OPT_PAGE_OFFSET:
> +			arm64_opts.page_offset = strtoull(optarg, NULL, 0);
> +			break;
>  		default:
>  			break; /* Ignore core and unknown options. */
>  		}
> diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> index 61e15032cbd6..7e4d0568bd01 100644
> --- a/kexec/arch/arm64/kexec-arm64.h
> +++ b/kexec/arch/arm64/kexec-arm64.h
> @@ -17,6 +17,8 @@
>  #define BOOT_BLOCK_LAST_COMP_VERSION 16
>  #define COMMAND_LINE_SIZE 512
>  
> +#define ARM64_DEFAULT_PAGE_OFFSET 0xfffffe0000000000
> +
>  int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
>  int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
>  	off_t kernel_size, struct kexec_info *info);
> diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
> index b025dc6c0185..2ce68293a37b 100644
> --- a/kexec/arch/arm64/kexec-image-arm64.c
> +++ b/kexec/arch/arm64/kexec-image-arm64.c
> @@ -8,7 +8,9 @@
>  #include <errno.h>
>  #include <getopt.h>
>  #include <libfdt.h>
> +#include <stdlib.h>
>  
> +#include "crashdump-arm64.h"
>  #include "dt-ops.h"
>  #include "image-header.h"
>  #include "kexec-arm64.h"
> @@ -31,15 +33,59 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
>  	dbgprintf("%s: PE format: %s\n", __func__,
>  		(arm64_header_check_pe_sig(h) ? "yes" : "no"));
>  
> -	fprintf(stderr, "kexec: arm64 binary Image files are currently NOT SUPPORTED.\n");
> -
> -	return -1;
> +	return 0;
>  }
>  
>  int image_arm64_load(int argc, char **argv, const char *kernel_buf,
>  	off_t kernel_size, struct kexec_info *info)
>  {
> -	return -ENOSYS;
> +	int result;
> +	uint64_t start;
> +	const struct arm64_image_header *h;
> +	char *header_option = NULL;
> +
> +	h = (const struct arm64_image_header *)(kernel_buf);
> +
> +	arm64_mem.text_offset = le64_to_cpu(h->text_offset);
> +	arm64_mem.image_size = le64_to_cpu(h->image_size);
> +
> +	if(!arm64_opts.page_offset)
> +		arm64_mem.page_offset = ARM64_DEFAULT_PAGE_OFFSET;
> +	else
> +		arm64_mem.page_offset = arm64_opts.page_offset;
> +
> +	if (info->kexec_flags & KEXEC_ON_CRASH) {
> +		result = load_crashdump_segments(info, &header_option);
> +
> +		if (result) {
> +			fprintf(stderr, "kexec: load crashdump segments failed.\n");
> +			return -1;
> +		}
> +		start = crash_reserved_mem.start;
> +	} else {
> +		result = parse_iomem_single("Kernel code\n", &start, NULL);
> +
> +		if (result) {
> +			fprintf(stderr, "kexec: Could not get kernel code address.\n");
> +			return -1;
> +		}
> +		start -= arm64_mem.text_offset;
> +	}
> +
> +	/* Add kernel */
> +	add_segment_phys_virt(info, kernel_buf, kernel_size,
> +			start + arm64_mem.text_offset,
> +			kernel_size, 0);
> +
> +	info->entry = (void *)start + arm64_mem.text_offset;
> +
> +	result = arm64_load_other_segments(info, (unsigned long)info->entry,
> +		header_option);
> +
> +	if (header_option)
> +		free(header_option);
> +
> +	return result;
>  }
>  
>  void image_arm64_usage(void)
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
