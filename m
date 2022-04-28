From: Xiaoming Ni <nixiaoming@huawei.com>
Date: Thu, 28 Apr 2022 09:01:13 +0800
Subject: [PATCH 18/30] notifier: Show function names on notifier routines
 if DEBUG_NOTIFIERS is set
In-Reply-To: <20220427224924.592546-19-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-19-gpiccoli@igalia.com>
Message-ID: <9f44aae6-ec00-7ede-ec19-6e67ceb74510@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 2022/4/28 6:49, Guilherme G. Piccoli wrote:
> Currently we have a debug infrastructure in the notifiers file, but
> it's very simple/limited. This patch extends it by:
> 
> (a) Showing all registered/unregistered notifiers' callback names;
> 
> (b) Adding a dynamic debug tuning to allow showing called notifiers'
> function names. Notice that this should be guarded as a tunable since
> it can flood the kernel log buffer.
> 
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> We have some design decisions that worth discussing here:
> 
> (a) First of call, using C99 helps a lot to write clear and concise code, but
> due to commit 4d94f910e79a ("Kbuild: use -Wdeclaration-after-statement") we
> have a warning if mixing variable declarations with code. For this patch though,
> doing that makes the code way clear, so decision was to add the debug code
> inside brackets whenever this warning pops up. We can change that, but that'll
> cause more ifdefs in the same function.
> 
> (b) In the symbol lookup helper function, we modify the parameter passed but
> even more, we return it as well! This is unusual and seems unnecessary, but was
> the strategy taken to allow embedding such function in the pr_debug() call.
> 
> Not doing that would likely requiring 3 symbol_name variables to avoid
> concurrency (registering notifier A while calling notifier B) - we rely in
> local variables as a serialization mechanism.
> 
> We're open for suggestions in case this design is not appropriate;
> thanks in advance!
> 
>   kernel/notifier.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index ba005ebf4730..21032ebcde57 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -7,6 +7,22 @@
>   #include <linux/vmalloc.h>
>   #include <linux/reboot.h>
>   
> +#ifdef CONFIG_DEBUG_NOTIFIERS
> +#include <linux/kallsyms.h>
> +
> +/*
> + *	Helper to get symbol names in case DEBUG_NOTIFIERS is set.
> + *	Return the modified parameter is a strategy used to achieve
> + *	the pr_debug() functionality - with this, function is only
> + *	executed if the dynamic debug tuning is effectively set.
> + */
> +static inline char *notifier_name(struct notifier_block *nb, char *sym_name)
> +{
> +	lookup_symbol_name((unsigned long)(nb->notifier_call), sym_name);
> +	return sym_name;
> +}
> +#endif
> +
>   /*
>    *	Notifier list for kernel code which wants to be called
>    *	at shutdown. This is used to stop any idling DMA operations
> @@ -34,20 +50,41 @@ static int notifier_chain_register(struct notifier_block **nl,
>   	}
>   	n->next = *nl;
>   	rcu_assign_pointer(*nl, n);
> +
> +#ifdef CONFIG_DEBUG_NOTIFIERS
> +	{
> +		char sym_name[KSYM_NAME_LEN];
> +
> +		pr_info("notifiers: registered %s()\n",
> +			notifier_name(n, sym_name));
> +	}

Duplicate Code.

Is it better to use __func__ and %pS?

pr_info("%s: %pS\n", __func__, n->notifier_call);


> +#endif
>   	return 0;
>   }
>   
>   static int notifier_chain_unregister(struct notifier_block **nl,
>   		struct notifier_block *n)
>   {
> +	int ret = -ENOENT;
> +
>   	while ((*nl) != NULL) {
>   		if ((*nl) == n) {
>   			rcu_assign_pointer(*nl, n->next);
> -			return 0;
> +			ret = 0;
> +			break;
>   		}
>   		nl = &((*nl)->next);
>   	}
> -	return -ENOENT;
> +
> +#ifdef CONFIG_DEBUG_NOTIFIERS
> +	if (!ret) {
> +		char sym_name[KSYM_NAME_LEN];
> +
> +		pr_info("notifiers: unregistered %s()\n",
> +			notifier_name(n, sym_name));
> +	}
Duplicate Code.

Is it better to use __func__ and %pS?

pr_info("%s: %pS\n", __func__, n->notifier_call);
> +#endif
> +	return ret;
>   }
>   
>   /**
> @@ -80,6 +117,13 @@ static int notifier_call_chain(struct notifier_block **nl,
>   			nb = next_nb;
>   			continue;
>   		}
> +
Is the "#ifdef" missing here?
> +		{
> +			char sym_name[KSYM_NAME_LEN];
> +
> +			pr_debug("notifiers: calling %s()\n",
> +				 notifier_name(nb, sym_name));
Duplicate Code.

Is it better to use __func__ and %pS?

pr_info("%s: %pS\n", __func__, n->notifier_call);
> +		}
>   #endif
>   		ret = nb->notifier_call(nb, val, v);
>   
> 

Thanks
Xiaoming Ni

