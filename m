Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fKeFd-0003W2-RO
 for kexec@lists.infradead.org; Mon, 21 May 2018 06:24:59 +0000
Date: Mon, 21 May 2018 14:24:40 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec/s390: Add support for kexec_file_load
Message-ID: <20180521062440.GB6036@dhcp-128-65.nay.redhat.com>
References: <20180516122718.15440-1-prudo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180516122718.15440-1-prudo@linux.ibm.com>
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
To: Philipp Rudo <prudo@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 05/16/18 at 02:27pm, Philipp Rudo wrote:
> Since kernel 4.17-rc2 s390 supports the kexec_file_load system call. Add
> the new system call to kexec-tools and provide the -s (--kexec-file-syscall)
> option for s390 to support this new feature.
> 
> Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
> ---
>  kexec/arch/s390/kexec-image.c | 46 +++++++++++++++++++++++++++++++++++++++++++
>  kexec/kexec-syscall.h         |  3 +++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
> index 0c8937b..8b39566 100644
> --- a/kexec/arch/s390/kexec-image.c
> +++ b/kexec/arch/s390/kexec-image.c
> @@ -22,6 +22,7 @@
>  #include "../../kexec/crashdump.h"
>  #include "kexec-s390.h"
>  #include <arch/options.h>
> +#include <fcntl.h>
>  
>  static uint64_t crash_base, crash_end;
>  static char command_line[COMMAND_LINESIZE];
> @@ -45,6 +46,48 @@ int command_line_add(const char *str)
>  	return 0;
>  }
>  
> +int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
> +{
> +	const char *ramdisk = NULL;
> +	int opt;
> +
> +	static const struct option options[] =
> +		{
> +			KEXEC_OPTIONS
> +			{"command-line",     1, 0, OPT_APPEND},
> +			{"append",           1, 0, OPT_APPEND},
> +			{"initrd",           1, 0, OPT_RAMDISK},
> +			{0,                  0, 0, 0},
> +		};
> +	static const char short_options[] = KEXEC_OPT_STR "";
> +
> +	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
> +		switch(opt) {
> +		case OPT_APPEND:
> +			if (command_line_add(optarg))
> +				return -1;
> +			break;
> +		case OPT_RAMDISK:
> +			ramdisk = optarg;
> +			break;
> +		}
> +	}
> +
> +	if (ramdisk) {
> +		info->initrd_fd = open(ramdisk, O_RDONLY);
> +		if (info->initrd_fd == -1) {
> +			fprintf(stderr, "Could not open initrd file %s:%s\n",
> +					ramdisk, strerror(errno));
> +			return -1;
> +		}
> +	}
> +
> +	info->command_line = command_line;
> +	info->command_line_len = strlen (command_line) + 1;
> +
> +	return 0;
> +}
> +
>  int
>  image_s390_load(int argc, char **argv, const char *kernel_buf,
>  		off_t kernel_size, struct kexec_info *info)
> @@ -56,6 +99,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>  	unsigned int ramdisk_origin;
>  	int opt;
>  
> +	if (info->file_mode)
> +		return image_s390_load_file(argc, argv, info);
> +
>  	static const struct option options[] =
>  		{
>  			KEXEC_OPTIONS
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index 33638c2..b96e02a 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -64,6 +64,9 @@
>  #ifdef __powerpc64__
>  #define __NR_kexec_file_load	382
>  #endif
> +#ifdef __s390x__
> +#define __NR_kexec_file_load	381
> +#endif
>  
>  #ifndef __NR_kexec_file_load
>  /* system call not available for the arch */
> -- 
> 2.16.3
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
