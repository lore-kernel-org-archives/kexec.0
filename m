Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPXv-0003JB-6b
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 14:18:28 +0000
Date: Tue, 15 Jan 2019 15:18:24 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: add kexec_file_load support
Message-ID: <20190115141823.reuldlydgymt4pt3@verge.net.au>
References: <20190111095727.27935-1-takahiro.akashi@linaro.org>
 <a3e1923a-1528-b4ff-f9a7-4b51c6a5463b@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3e1923a-1528-b4ff-f9a7-4b51c6a5463b@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org

On Tue, Jan 15, 2019 at 12:26:04AM +0530, Bhupesh Sharma wrote:
> Hi Akashi,
> 
> Thanks for the patch.
> 
> On 01/11/2019 03:27 PM, AKASHI Takahiro wrote:
> > # My kexec_file patch for arm64 is now merged in v5.0-rc1.
> > 
> > With this patch, kexec_file_load() system call is supported.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >   kexec/arch/arm64/kexec-arm64.c        | 10 +++++++++-
> >   kexec/arch/arm64/kexec-elf-arm64.c    |  9 +++++++++
> >   kexec/arch/arm64/kexec-image-arm64.c  | 28 ++++++++++++++++++++++++++-
> >   kexec/arch/arm64/kexec-uImage-arm64.c |  7 +++++++
> >   kexec/kexec-syscall.h                 |  3 +++
> >   5 files changed, 55 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > index 536c64b06384..1cde75d1a771 100644
> > --- a/kexec/arch/arm64/kexec-arm64.c
> > +++ b/kexec/arch/arm64/kexec-arm64.c
> > @@ -141,6 +141,7 @@ int arch_process_options(int argc, char **argv)
> >   	int opt;
> >   	char *cmdline = NULL;
> >   	const char *append = NULL;
> > +	int do_kexec_file_syscall = 0;
> >   	for (opt = 0; opt != -1; ) {
> >   		opt = getopt_long(argc, argv, short_options, options, 0);
> > @@ -158,6 +159,9 @@ int arch_process_options(int argc, char **argv)
> >   		case OPT_INITRD:
> >   			arm64_opts.initrd = optarg;
> >   			break;
> > +		case OPT_KEXEC_FILE_SYSCALL:
> > +			do_kexec_file_syscall = 1;
> > +			break;
> >   		default:
> >   			break; /* Ignore core and unknown options. */
> >   		}
> > @@ -169,7 +173,11 @@ int arch_process_options(int argc, char **argv)
> >   		arm64_opts.command_line);
> >   	dbgprintf("%s:%d: initrd: %s\n", __func__, __LINE__,
> >   		arm64_opts.initrd);
> > -	dbgprintf("%s:%d: dtb: %s\n", __func__, __LINE__, arm64_opts.dtb);
> > +	dbgprintf("%s:%d: dtb: %s\n", __func__, __LINE__,
> > +		(do_kexec_file_syscall && arm64_opts.dtb ? "(ignored)" :
> > +							arm64_opts.dtb));
> > +	if (do_kexec_file_syscall)
> > +		arm64_opts.dtb = NULL;
> >   	return 0;
> >   }
> > diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
> > index fc83b42c9d2b..e14f8e92004b 100644
> > --- a/kexec/arch/arm64/kexec-elf-arm64.c
> > +++ b/kexec/arch/arm64/kexec-elf-arm64.c
> > @@ -5,10 +5,12 @@
> >   #define _GNU_SOURCE
> >   #include <errno.h>
> > +#include <fcntl.h>
> >   #include <limits.h>
> >   #include <stdlib.h>
> >   #include <linux/elf.h>
> > +#include "arch/options.h"
> >   #include "crashdump-arm64.h"
> >   #include "kexec-arm64.h"
> >   #include "kexec-elf.h"
> > @@ -47,6 +49,13 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
> >   	int result;
> >   	int i;
> > +	if (info->file_mode) {
> > +		fprintf(stderr,
> > +			"ELF executable is not supported in kexec_file\n");
> > +
> > +		return EFAILED;
> > +	}
> > +
> >   	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
> >   	if (result < 0) {
> > diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
> > index e1b1e54b149f..685a99352e39 100644
> > --- a/kexec/arch/arm64/kexec-image-arm64.c
> > +++ b/kexec/arch/arm64/kexec-image-arm64.c
> > @@ -4,10 +4,15 @@
> >   #define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> >   #include "crashdump-arm64.h"
> > +#include "image-header.h"
> > +#include "kexec.h"
> >   #include "kexec-arm64.h"
> >   #include "kexec-syscall.h"
> > -#include <limits.h>
> > +#include "arch/options.h"
> >   int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
> >   {
> > @@ -35,6 +40,27 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
> >   	unsigned long kernel_segment;
> >   	int result;
> > +	if (info->file_mode) {
> > +		if (arm64_opts.initrd) {
> > +			info->initrd_fd = open(arm64_opts.initrd, O_RDONLY);
> > +			if (info->initrd_fd == -1) {
> > +				fprintf(stderr,
> > +					"Could not open initrd file %s:%s\n",
> > +					arm64_opts.initrd, strerror(errno));
> > +				result = EFAILED;
> > +				goto exit;
> > +			}
> > +		}
> > +
> > +		if (arm64_opts.command_line) {
> > +			info->command_line = (char *)arm64_opts.command_line;
> > +			info->command_line_len =
> > +					strlen(arm64_opts.command_line) + 1;
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> >   	header = (const struct arm64_image_header *)(kernel_buf);
> >   	if (arm64_process_image_header(header))
> > diff --git a/kexec/arch/arm64/kexec-uImage-arm64.c b/kexec/arch/arm64/kexec-uImage-arm64.c
> > index 022d7ee4693a..126ea9c2555b 100644
> > --- a/kexec/arch/arm64/kexec-uImage-arm64.c
> > +++ b/kexec/arch/arm64/kexec-uImage-arm64.c
> > @@ -20,6 +20,13 @@ int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
> >   	struct Image_info img;
> >   	int ret;
> > +	if (info->file_mode) {
> > +		fprintf(stderr,
> > +			"uImage is not supported in kexec_file\n");
> > +
> > +		return EFAILED;
> > +	}
> > +
> >   	ret = uImage_load(buf, len, &img);
> >   	if (ret)
> >   		return ret;
> > diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> > index b96e02aaae13..dac1c1f7564e 100644
> > --- a/kexec/kexec-syscall.h
> > +++ b/kexec/kexec-syscall.h
> > @@ -67,6 +67,9 @@
> >   #ifdef __s390x__
> >   #define __NR_kexec_file_load	381
> >   #endif
> > +#ifdef __aarch64__
> > +#define __NR_kexec_file_load	294
> > +#endif
> >   #ifndef __NR_kexec_file_load
> >   /* system call not available for the arch */
> > 
> 
> Reviewed and Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
> 
> Thanks.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
