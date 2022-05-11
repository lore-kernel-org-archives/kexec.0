From: Petr Mladek <pmladek@suse.com>
Date: Wed, 11 May 2022 13:45:41 +0200
Subject: [PATCH 17/30] tracing: Improve panic/die notifiers
In-Reply-To: <20220427224924.592546-18-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-18-gpiccoli@igalia.com>
Message-ID: <20220511114541.GC26047@pathway.suse.cz>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:49:11, Guilherme G. Piccoli wrote:
> Currently the tracing dump_on_oops feature is implemented
> through separate notifiers, one for die/oops and the other
> for panic. With the addition of panic notifier "id", this
> patch makes use of such "id" to unify both functions.
> 
> It also comments the function and changes the priority of the
> notifier blocks, in order they run early compared to other
> notifiers, to prevent useless trace data (like the callback
> names for the other notifiers). Finally, we also removed an
> unnecessary header inclusion.
> 
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9767,38 +9766,46 @@ static __init int tracer_init_tracefs(void)
>  
>  fs_initcall(tracer_init_tracefs);
>  
> -static int trace_panic_handler(struct notifier_block *this,
> -			       unsigned long event, void *unused)
> +/*
> + * The idea is to execute the following die/panic callback early, in order
> + * to avoid showing irrelevant information in the trace (like other panic
> + * notifier functions); we are the 2nd to run, after hung_task/rcu_stall
> + * warnings get disabled (to prevent potential log flooding).
> + */
> +static int trace_die_panic_handler(struct notifier_block *self,
> +				unsigned long ev, void *unused)
>  {
> -	if (ftrace_dump_on_oops)
> +	int do_dump;
> +
> +	if (!ftrace_dump_on_oops)
> +		return NOTIFY_DONE;
> +
> +	switch (ev) {
> +	case DIE_OOPS:
> +		do_dump = 1;
> +		break;
> +	case PANIC_NOTIFIER:
> +		do_dump = 1;
> +		break;

DIE_OOPS and PANIC_NOTIFIER are from different enum.
It feels like comparing apples with oranges here.

IMHO, the proper way to unify the two notifiers is
a check of the @self parameter. Something like:

static int trace_die_panic_handler(struct notifier_block *self,
				unsigned long ev, void *unused)
{
	if (self == trace_die_notifier && val != DIE_OOPS)
		goto out;

	ftrace_dump(ftrace_dump_on_oops);
out:
	return NOTIFY_DONE;
}

Best Regards,
Petr

