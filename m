From: Petr Mladek <pmladek@suse.com>
Date: Fri, 28 Jan 2022 14:38:07 +0100
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
Message-ID: <YfPxvzSzDLjO5ldp@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu 2022-01-27 14:16:20, Guilherme G. Piccoli wrote:
> On 25/01/2022 10:06, d.hatayama at fujitsu.com wrote:
> > 
> > But the pre_dump cannot avoid calling multiple unnecessary handlers, right?
> > It's more risky than the previous idea...
> > 
> 
> I think we could have 2 kernel parameters then:
> 
> crash_kernel_disable_pre_notitifers (of course we can think in some
> better name here heh)
> 
> crash_kernel_enable_post_notifiers (which is the same as the current
> "crash_kernel_post_notifiers", we can keep it)
> 
> The point being (if I understand correctly): some callbacks are really
> simple and don't introduce risks for kdump, like the RCU; a bunch of
> them just set one variable. Those could be enable by default, before the
> kdump.
> 
> The majority would fit in the 2nd group, meaning they are not enabled by
> default, requiring some parameter for that.
> 
> Petr, let me know if that makes sense and is aligned with your suggestion.

First, I am sorry for the very long mail. But the problem is really
complicated. I did my best to describe it a clean way.

I have discussed these problems with a colleague and he had some good
points. And my view evolved even further.

There are two groups of people interested in panic() behavior:

1. Users wants to get as reliable as possible: kdump, kmsg_dump,
   console log, useful last message on screen, reboot, hypervisor
   notification.

   Different users have different priorities according to the use case.


2. Subsystem maintainers and developers that need to do something
   special in panic(). They have to deal with the user requirements
   and bug reports.

   Most operations in panic() have unclear results because the system
   is in unclear state. Maintainers and developers wants to make their
   life easier. They do not want to deal with problems caused by
   others. So that they want to disable others or run as early as
   possible.

   It is nicely visible. kdump maintainer is afraid of calling
   anything before kdump. Many people support the idea of filtering
   because it moves problems to the user side.


I see two basic problems here: ordering and reliability:

1. Ordering problems are partly solved by configuration and partly by
   definition. I mean that:

      + kdump, kmsg_dump, panic_print_sys_info() are optional
      + console output is the best effort; more risky in final flush
      + reboot, infinite loop are the very last step

   IMHO, the ordering should be pretty clear:

      + panic_print_sys_info(), kmsg_dump(), kdump(), console flush, reboot

   Why?

      + panic_print_sys_info(), kmsg_dump(), kdump() are all optional
	   and disabled by default
      + Users might want panic_print_sys_info() in kmsg_dump() and kdump()
      + Users might prefer kmsg_dump() over kdump()
      + kdump() is the last operation when enabled

   Where are panic notifiers in this picture?
   Where are CPUs stopped?


2. Reliability is the best effort and any subsystem should do its
   best.

   Users need to be aware (documentation, warning) that:

      + kmsg_dump() is less reliable when panic_print_sys_info() is enabled
      + kdump() is less reliable when panic_print_sys_info() and/or
	kmsg_dump() is enabled.

   Where are panic notifiers in this picture?
   How stopped CPUs affect reliability?


Regarding panic notifiers. They look like a problematic black box:

    + ordering against other operations is not clear
    + are not safe enough
    + various users require some and do not need others
    + some are too complex so that only few people know what
      they do


So far, we have two proposals how to handle panic notifiers:

1. Allow to filter them with parameter:

     + pros:
	+ it allows users to customize and work around problems

     + cons:
	+ ordering is still not clear

	+ user has to know what he does; note that sometimes only
	  few people know what their notifier does

	+ hard to use in the long term; callbacks names are
	  implementation detail; new notifiers are added

	+ lower motivation to solve problems; easy to wave them with
	  "just disable it when it does not work for you..."


2. Split notifiers into more lists:

    + pros:
	+ might solve ordering problems

	+ subsystem maintainers could find the proper and more safe
	  location


    + cons:
	+ subsystem maintainers tend to think that their problem is
	  the most important one; they will tend to do the operation
	  as early as possible; so that even dangerous operations
	  might be done early  => the original problem is still there

	+ it might not motivate developers enough to make the notifiers as
	  safe as possible

	+ some might still need to be optional; for example, it should
	  be possible to disable hypervisor notifier when it breaks
	  kdump


Regarding stopped CPUs, it looks like a good idea most of the time:

    + They should stop all tasks and reduce further damage of the
      system.

    + It should also reduce noise (messages) produced by other CPUs.

    + But a special handling is needed when it is done before crash
      dump.


Sigh, it looks really really complicated. We should be careful.

OK, the original problems are:

   + allow to call this order: panic_print_sys_info(), kmsg_dump(), kdump()
   + make it more safe with problematic notifiers


My opinion:

   + allow the desired ordering makes sense

   + something should be done with notifiers:

       + adding filer looks like a workaround that is not much
	 usable; it is not easy to use; it does not motivate people
	 fix problems so that is might make things worse in
	 the long term

       + splitting might make sense but it is not clear how

       + some notifiers make always sense before kmsg_dump;
	 some should be optional

   + we need a compromise to keep the panic() code sane and can't
     support all combinations


I think about the following solution:

    + split the notifiers into three lists:

	+ info: stop watchdogs, provide extra info
	+ hypervisor: poke hypervisor
	+ reboot: actions needed only when crash dump did not happen

    + allow to call hypervisor notifiers before or after kdump

    + stop CPUs before kdump when either hypervisor notifiers or
      kmsg_dump is enabled

Note that it still allows to call kdump as the first action when
hypervisor notifiers are called after kdump and no kmsg dumper
is registered.


void panic(void)
{
	[...]

	if (crash_kexec_post_hypervisor || panic_print || enabled_kmsg_dump()) {
		/*
		 * Stop CPUs when some extra action is required before
		 * crash dump. We will need architecture dependent extra
		 * works in addition to stopping other CPUs.
		 */
		 crash_smp_send_stop();
		 cpus_stopped = true;
	}

	if (crash_kexec_post_hypervisor) {
		  /* Tell hypervisor about the panic */
		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
	}

	if (enabled_kmsg_dump) {
		  /*
		   * Print extra info by notifiers.
		   * Prevent rumors, for example, by stopping watchdogs.
		   */
		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
	}

	/* Optional extra info */
	panic_printk_sys_info();

	/* No dumper by default */
	kmsg_dump();

	/* Used only when crash kernel loaded */
	__crash_kexec(NULL);

	if (!cpus_stopped) {
		/*
		 * Note smp_send_stop is the usual smp shutdown function, which
		 * unfortunately means it may not be hardened to work in a
		 * panic situation.
		 */
		smp_send_stop();
	}

	if (!crash_kexec_post_hypervisor) {
		  /* Tell hypervisor about the panic */
		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
	}

	if (!enabled_kmsg_dump) {
		  /*
		   * Print extra info by notifiers.
		   * Prevent rumors, for example, by stopping watchdogs.
		   */
		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
	}

	/*
	 * Help to reboot a safe way.
	 */
	atomic_notifier_call_chain(&panic_reboot_notifier_list, 0, buf);

	[...]
}

Any opinion?
Do the notifier list names make sense?

Best Regards,
Petr

PS: I have vacation the following week. I'll continue in the
    discussion when I am back.

