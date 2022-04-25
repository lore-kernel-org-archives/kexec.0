From: Baoquan He <bhe@redhat.com>
Date: Mon, 25 Apr 2022 09:28:01 +0800
Subject: [PATCH sysctl-testing v2] kernel/kexec_core: move kexec_core
 sysctls into its own file
In-Reply-To: <20220424025740.50371-1-yingelin@huawei.com>
References: <20220424025740.50371-1-yingelin@huawei.com>
Message-ID: <YmX5Ic8eyMQZbIxY@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/24/22 at 10:57am, yingelin wrote:
> This move the kernel/kexec_core.c respective sysctls to its own file.
> 
> kernel/sysctl.c has grown to an insane mess, We move sysctls to places
> where features actually belong to improve the readability and reduce
> merge conflicts. At the same time, the proc-sysctl maintainers can easily
> care about the core logic other than the sysctl knobs added for some feature.
> 
> We already moved all filesystem sysctls out. This patch is part of the effort
> to move kexec related sysctls out.
> 
> Signed-off-by: yingelin <yingelin@huawei.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> ---
> v2:
>   1. Add the explanation to commit log to help patch review and subsystem
>   maintainers better understand the context/logic behind the migration
>   2. Add CONFIG_SYSCTL to to isolate the sysctl
>   3. Change subject-prefix of sysctl-next to sysctl-testing
> 
> v1: https://lore.kernel.org/lkml/20220223030318.213093-1-yingelin at huawei.com/
>   1. Lack more informations in the commit log to help patch review better
>   2. Lack isolation of the sysctl
>   3. Use subject-prefix of sysctl-next
> ---
>  kernel/kexec_core.c | 22 ++++++++++++++++++++++
>  kernel/sysctl.c     | 13 -------------
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..a0456baf52cc 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -936,6 +936,28 @@ int kimage_load_segment(struct kimage *image,
>  struct kimage *kexec_image;
>  struct kimage *kexec_crash_image;
>  int kexec_load_disabled;
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table kexec_core_sysctls[] = {
> +	{
> +		.procname	= "kexec_load_disabled",
> +		.data		= &kexec_load_disabled,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		/* only handle a transition from default "0" to "1" */
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +
> +static int __init kexec_core_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", kexec_core_sysctls);
> +	return 0;
> +}
> +late_initcall(kexec_core_sysctl_init);
> +#endif
>  
>  /*
>   * No panic_cpu check version of crash_kexec().  This function is called
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index b60345cbadf0..0f3cb61a2e39 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -61,7 +61,6 @@
>  #include <linux/capability.h>
>  #include <linux/binfmts.h>
>  #include <linux/sched/sysctl.h>
> -#include <linux/kexec.h>
>  #include <linux/mount.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/pid.h>
> @@ -1712,18 +1711,6 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= tracepoint_printk_sysctl,
>  	},
>  #endif
> -#ifdef CONFIG_KEXEC_CORE
> -	{
> -		.procname	= "kexec_load_disabled",
> -		.data		= &kexec_load_disabled,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		/* only handle a transition from default "0" to "1" */
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ONE,
> -		.extra2		= SYSCTL_ONE,
> -	},
> -#endif
>  #ifdef CONFIG_MODULES
>  	{
>  		.procname	= "modprobe",
> -- 
> 2.26.2
> 
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


