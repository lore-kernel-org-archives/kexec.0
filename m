Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4KAa-00085V-U0
	for kexec@lists.infradead.org; Mon, 28 Mar 2011 21:40:18 +0000
Date: Tue, 29 Mar 2011 06:40:12 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec, x86: fix kexec when
	boot_params.hardware_subarch != 0
Message-ID: <20110328214012.GH4716@verge.net.au>
References: <20110328194049.32626.74038.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110328194049.32626.74038.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: kexec@lists.infradead.org

On Mon, Mar 28, 2011 at 12:40:49PM -0700, Chris Leech wrote:
> kexec needs to keep the subarch setting the same as the running kernel
> in the boot parameters, or the kernel will die in early setup.  I ran
> into this with X86_SUBARCH_MRST, but it should apply to CE4100 and any
> future subarch that uses non-default early setup code.
> 
> This patch requires debugfs mounted at /sys/kernel/debug, as that's
> the only way I know of to get at the running kernels boot_params.
> Without debugfs mounted it falls back to the current behavior of
> assuming subarch 0.
> 
> Signed-off-by: Chris Leech <christopher.leech@linux.intel.com>
> ---
>  kexec/arch/i386/x86-linux-setup.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index f843ca4..b7f8bd8 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -20,6 +20,7 @@
>  #include <string.h>
>  #include <stdarg.h>
>  #include <stdlib.h>
> +#include <stddef.h>
>  #include <errno.h>
>  #include <limits.h>
>  #include <sys/types.h>
> @@ -396,12 +397,32 @@ out:
>  		real_mode->eddbuf_entries);
>  }
>  
> +#define BOOT_PARAMS_DBGFS	"/sys/kernel/debug/boot_params/data"
> +
> +void setup_subarch(struct x86_linux_param_header *real_mode)
> +{
> +	int data_file;
> +	const off_t offset = offsetof(typeof(*real_mode), hardware_subarch);
> +
> +	data_file = open(BOOT_PARAMS_DBGFS, O_RDONLY);
> +	if (data_file < 0)
> +		return;
> +	if (lseek(data_file, offset, SEEK_SET) < 0)
> +		goto close;
> +	read(data, &real_mode->hardware_subarch, sizeof(uint32_t));

Should data be data_file?

> +close:
> +	close(data_file);
> +}
> +
>  void setup_linux_system_parameters(struct x86_linux_param_header *real_mode,
>  					unsigned long kexec_flags)
>  {
>  	/* Fill in information the BIOS would usually provide */
>  	struct memory_range *range;
>  	int i, ranges;
> +
> +	/* get subarch from running kernel */
> +	setup_subarch(real_mode);
>  	
>  	/* Default screen size */
>  	real_mode->orig_x = 0;
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
