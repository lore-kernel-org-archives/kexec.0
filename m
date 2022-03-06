From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Sun, 6 Mar 2022 11:21:28 -0300
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <YfPxvzSzDLjO5ldp@alley>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
Message-ID: <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 28/01/2022 10:38, Petr Mladek wrote:
> [...] 
> I think about the following solution:
> 
>     + split the notifiers into three lists:
> 
> 	+ info: stop watchdogs, provide extra info
> 	+ hypervisor: poke hypervisor
> 	+ reboot: actions needed only when crash dump did not happen
> 
>     + allow to call hypervisor notifiers before or after kdump
> 
>     + stop CPUs before kdump when either hypervisor notifiers or
>       kmsg_dump is enabled
> 
> Note that it still allows to call kdump as the first action when
> hypervisor notifiers are called after kdump and no kmsg dumper
> is registered.
> 
> 
> void panic(void)
> {
> 	[...]
> 
> 	if (crash_kexec_post_hypervisor || panic_print || enabled_kmsg_dump()) {
> 		/*
> 		 * Stop CPUs when some extra action is required before
> 		 * crash dump. We will need architecture dependent extra
> 		 * works in addition to stopping other CPUs.
> 		 */
> 		 crash_smp_send_stop();
> 		 cpus_stopped = true;
> 	}
> 
> 	if (crash_kexec_post_hypervisor) {
> 		  /* Tell hypervisor about the panic */
> 		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> 	}
> 
> 	if (enabled_kmsg_dump) {
> 		  /*
> 		   * Print extra info by notifiers.
> 		   * Prevent rumors, for example, by stopping watchdogs.
> 		   */
> 		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> 	}
> 
> 	/* Optional extra info */
> 	panic_printk_sys_info();
> 
> 	/* No dumper by default */
> 	kmsg_dump();
> 
> 	/* Used only when crash kernel loaded */
> 	__crash_kexec(NULL);
> 
> 	if (!cpus_stopped) {
> 		/*
> 		 * Note smp_send_stop is the usual smp shutdown function, which
> 		 * unfortunately means it may not be hardened to work in a
> 		 * panic situation.
> 		 */
> 		smp_send_stop();
> 	}
> 
> 	if (!crash_kexec_post_hypervisor) {
> 		  /* Tell hypervisor about the panic */
> 		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> 	}
> 
> 	if (!enabled_kmsg_dump) {
> 		  /*
> 		   * Print extra info by notifiers.
> 		   * Prevent rumors, for example, by stopping watchdogs.
> 		   */
> 		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> 	}
> 
> 	/*
> 	 * Help to reboot a safe way.
> 	 */
> 	atomic_notifier_call_chain(&panic_reboot_notifier_list, 0, buf);
> 
> 	[...]
> }
> 
> Any opinion?
> Do the notifier list names make sense?
> 
> Best Regards,
> Petr


Hi folks, I'm working on this now, and while looking into it I've
noticed that we have the concept of "priority" in the notifiers list.
Basically, you can order the calls the way it fits best, priority is an
integer and must the set in the moment of registration, it's up to the
users of the notifiers to set it and enforce the ordering.

So what I'm thinking is: currently, only 3 or 4 panic notifiers make use
of that. What if, since we're re-working this, we add a priority for
*all* notifiers and enforce its usage? This way we guarantee
consistency, it'd make debug easier and maybe even more important:
having all the notifiers and their priorities in a list present in the
header file would be great documentation about all the existing
notifiers and how they are called - today this information is quite
obscure and requires lots of code grepping!

Let me know your thoughts Petr / Baoquan - it would add slightly more
code / complexity, but in my opinion the payback is very good.
Cheers,


Guilherme

