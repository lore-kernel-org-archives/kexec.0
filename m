From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 7 Jan 2022 14:08:22 +0200
Subject: [PATCH V2] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <20220106200007.112357-1-gpiccoli@igalia.com>
References: <20220106200007.112357-1-gpiccoli@igalia.com>
Message-ID: <YdgtNvd68kWakErr@smile.fi.intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Jan 06, 2022 at 05:00:07PM -0300, Guilherme G. Piccoli wrote:
> The kernel notifier infrastructure allows function callbacks to be
> added in multiple lists, which are then called in the proper time,
> like in a reboot or panic event. The panic_notifier_list specifically
> contains the callbacks that are executed during a panic event. As any
> other notifier list, the panic one has no filtering and all functions
> previously registered are executed.
> 
> The kdump infrastructure, on the other hand, enables users to set
> a crash kernel that is kexec'ed in a panic event, and vmcore/logs
> are collected in such crash kernel. When kdump is set, by default
> the panic notifiers are ignored - the kexec jumps to the crash kernel
> before the list is checked and callbacks executed.
> 
> There are some cases though in which kdump users might want to
> allow panic notifier callbacks to execute _before_ the kexec to
> the crash kernel, for a variety of reasons - for example, users
> may think kexec is very prone to fail and want to give a chance
> to kmsg dumpers to run (and save logs using pstore), or maybe
> some panic notifier is required to properly quiesce some hardware
> that must be used to the crash kernel. For these cases, we have
> the kernel parameter "crash_kexec_post_notifiers".
> 
> But there's a problem: currently it's an "all-or-nothing" situation,
> the kdump user choice is either to execute all panic notifiers or
> none of them. Given that panic notifiers may increase the risk of a
> kdump failure, this is a tough decision and may affect the debug of
> hard to reproduce bugs, if for some reason the user choice is to
> enable panic notifiers, but kdump then fails.
> 
> So, this patch aims to ease this decision: we hereby introduce a filter
> for the panic notifier list, in which users may select specifically
> which callbacks they wish to run, allowing a safer kdump. The allowlist
> should be provided using the parameter "panic_notifier_filter=a,b,..."
> where a, b are valid callback names. Invalid symbols are discarded.
> 
> Currently up to 16 symbols may be passed in this list, we consider
> that this numbers allows enough flexibility (and no matter what
> architecture is used, at most 30 panic callbacks are registered).
> In an experiment using a qemu x86 virtual machine, by default only
> six callbacks are registered in the panic notifier list.
> Once a valid callback name is provided in the list, such function
> is allowed to be registered/unregistered in the panic_notifier_list;
> all other panic callbacks are ignored. Notice that this filter is
> only for the panic notifiers and has no effect in the other notifiers.

...

> +static int __init panic_notifier_filter_setup(char *buf)
> +{
> +	char *func;
> +	unsigned long addr;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	while (buf) {
> +		func = strsep(&buf, ",");

Don't we have a parser of this format already?
Anyway, you may reduce code by

	unsigned long addr;
	char *func = buf;

	while ((func = strsep(&func, ",")) {

> +		addr = kallsyms_lookup_name(func);
> +
> +		if (!addr) {
> +			pr_info("panic_notifier_filter: invalid symbol %s\n", func);
> +			continue;
> +		}
> +
> +		if (panic_nf_count < PANIC_NF_MAX) {
> +			panic_nf_functions[panic_nf_count] = addr;
> +			panic_nf_count++;
> +			pr_debug("panic_notifier_filter: added symbol %s\n", func);
> +		} else {
> +			pr_warn("panic_notifier_filter: exceeded maximum notifiers (%d), aborting\n",
> +				PANIC_NF_MAX);
> +			panic_nf_count = 0;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +early_param("panic_notifier_filter", panic_notifier_filter_setup);

-- 
With Best Regards,
Andy Shevchenko



