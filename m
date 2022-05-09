From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 9 May 2022 11:13:17 -0300
Subject: [PATCH 10/30] alpha: Clean-up the panic notifier code
In-Reply-To: <20220427224924.592546-11-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-11-gpiccoli@igalia.com>
Message-ID: <f6def662-5742-b3a8-544f-bf15c636d83d@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 27/04/2022 19:49, Guilherme G. Piccoli wrote:
> The alpha panic notifier has some code issues, not following
> the conventions of other notifiers. Also, it might halt the
> machine but still it is set to run as early as possible, which
> doesn't seem to be a good idea.
> 
> This patch cleans the code, and set the notifier to run as the
> latest, following the same approach other architectures are doing.
> Also, we remove the unnecessary include of a header already
> included indirectly.
> 
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  arch/alpha/kernel/setup.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
> index b4fbbba30aa2..d88bdf852753 100644
> --- a/arch/alpha/kernel/setup.c
> +++ b/arch/alpha/kernel/setup.c
> @@ -41,19 +41,11 @@
>  #include <linux/sysrq.h>
>  #include <linux/reboot.h>
>  #endif
> -#include <linux/notifier.h>
>  #include <asm/setup.h>
>  #include <asm/io.h>
>  #include <linux/log2.h>
>  #include <linux/export.h>
>  
> -static int alpha_panic_event(struct notifier_block *, unsigned long, void *);
> -static struct notifier_block alpha_panic_block = {
> -	alpha_panic_event,
> -        NULL,
> -        INT_MAX /* try to do it first */
> -};
> -
>  #include <linux/uaccess.h>
>  #include <asm/hwrpb.h>
>  #include <asm/dma.h>
> @@ -435,6 +427,21 @@ static const struct sysrq_key_op srm_sysrq_reboot_op = {
>  };
>  #endif
>  
> +static int alpha_panic_event(struct notifier_block *this,
> +			     unsigned long event, void *ptr)
> +{
> +	/* If we are using SRM and serial console, just hard halt here. */
> +	if (alpha_using_srm && srmcons_output)
> +		__halt();
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block alpha_panic_block = {
> +	.notifier_call = alpha_panic_event,
> +	.priority = INT_MIN, /* may not return, do it last */
> +};
> +
>  void __init
>  setup_arch(char **cmdline_p)
>  {
> @@ -1427,19 +1434,6 @@ const struct seq_operations cpuinfo_op = {
>  	.show	= show_cpuinfo,
>  };
>  
> -
> -static int
> -alpha_panic_event(struct notifier_block *this, unsigned long event, void *ptr)
> -{
> -#if 1
> -	/* FIXME FIXME FIXME */
> -	/* If we are using SRM and serial console, just hard halt here. */
> -	if (alpha_using_srm && srmcons_output)
> -		__halt();
> -#endif
> -        return NOTIFY_DONE;
> -}
> -
>  static __init int add_pcspkr(void)
>  {
>  	struct platform_device *pd;


Hi folks, I'm updating Richard's email and re-sending the V1, any
reviews are greatly appreciated!

Cheers,


Guilherme

