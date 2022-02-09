From: bhe@redhat.com <bhe@redhat.com>
Date: Wed, 9 Feb 2022 08:31:51 +0800
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
 <YfPxvzSzDLjO5ldp@alley>
 <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
Message-ID: <YgMLd+avxyBplfk2@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/08/22 at 03:51pm, Guilherme G. Piccoli wrote:
> On 28/01/2022 10:38, Petr Mladek wrote:
> > [...] On Thu 2022-01-27 14:16:20, Guilherme G. Piccoli wrote:
> > First, I am sorry for the very long mail. But the problem is really
> > complicated. I did my best to describe it a clean way.
> > 
> > I have discussed these problems with a colleague and he had some good
> > points. And my view evolved even further.
> 
> Thanks Petr for the very comprehensive and detailed email - this helps a
> lot in shaping the future of panic notifier(s)!
> 
> 
> > [...] 
> > I think about the following solution:
> > 
> >     + split the notifiers into three lists:
> > 
> > 	+ info: stop watchdogs, provide extra info
> > 	+ hypervisor: poke hypervisor
> > 	+ reboot: actions needed only when crash dump did not happen
> > 
> >     + allow to call hypervisor notifiers before or after kdump
> > 
> >     + stop CPUs before kdump when either hypervisor notifiers or
> >       kmsg_dump is enabled
> > 
> > Note that it still allows to call kdump as the first action when
> > hypervisor notifiers are called after kdump and no kmsg dumper
> > is registered.
> > 
> > 
> > void panic(void)
> > {
> > 	[...]
> > 
> > 	if (crash_kexec_post_hypervisor || panic_print || enabled_kmsg_dump()) {
> > 		/*
> > 		 * Stop CPUs when some extra action is required before
> > 		 * crash dump. We will need architecture dependent extra
> > 		 * works in addition to stopping other CPUs.
> > 		 */
> > 		 crash_smp_send_stop();
> > 		 cpus_stopped = true;
> > 	}
> > 
> > 	if (crash_kexec_post_hypervisor) {
> > 		  /* Tell hypervisor about the panic */
> > 		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> > 	}
> > 
> > 	if (enabled_kmsg_dump) {
> > 		  /*
> > 		   * Print extra info by notifiers.
> > 		   * Prevent rumors, for example, by stopping watchdogs.
> > 		   */
> > 		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> > 	}
> > 
> > 	/* Optional extra info */
> > 	panic_printk_sys_info();
> > 
> > 	/* No dumper by default */
> > 	kmsg_dump();
> > 
> > 	/* Used only when crash kernel loaded */
> > 	__crash_kexec(NULL);
> > 
> > 	if (!cpus_stopped) {
> > 		/*
> > 		 * Note smp_send_stop is the usual smp shutdown function, which
> > 		 * unfortunately means it may not be hardened to work in a
> > 		 * panic situation.
> > 		 */
> > 		smp_send_stop();
> > 	}
> > 
> > 	if (!crash_kexec_post_hypervisor) {
> > 		  /* Tell hypervisor about the panic */
> > 		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> > 	}
> > 
> > 	if (!enabled_kmsg_dump) {
> > 		  /*
> > 		   * Print extra info by notifiers.
> > 		   * Prevent rumors, for example, by stopping watchdogs.
> > 		   */
> > 		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> > 	}
> > 
> > 	/*
> > 	 * Help to reboot a safe way.
> > 	 */
> > 	atomic_notifier_call_chain(&panic_reboot_notifier_list, 0, buf);
> > 
> > 	[...]
> > }
> > 
> > Any opinion?
> > Do the notifier list names make sense?
> > 
> 
> This was exposed very clearly, thanks. I agree with you, it's a good
> approach, and we can evolve that during the implementation phase, like
> "function A is not good in the hypervisor list because of this and
> that", so we move it to the reboot list. Also, name of the lists is not
> so relevant, might evolve in the implementation phase - I personally
> liked them, specially the "info" and "hypervisor" ones (reboot seems
> good but not great heh).
> 
> So, what are the opinions from kdump maintainers about this idea?
> Baoquan / Vivek / Dave, does it make sense to you? Do you have any
> suggestions/concerns to add on top of Petr draft?

Yeah, it's reasonable. As I replied to Michael in another thread, I
think splitting the current notifier list is a good idea. At least the
code to archieve hyper-V's goal with panic_notifier is a little odd and
should be taken out and execute w/o conditional before kdump, and maybe
some others Petr has combed out.

For those which will be switched on with the need of adding panic_notifier
or panic_print into cmdline, the heavy users like HATAYAMA and Masa can
help check.

For Petr's draft code, does it mean hyper-V need another knob to trigger
the needed notifiers? Will you go with the draft direclty? Hyper-V now
runs panic notifiers by default, just a reminder.

> 
> I prefer this refactor than the filter, certainly. If nobody else
> working on that, I can try implementing that - it's very interesting.
> The only thing I'd like to have first is an ACK from the kdump
> maintainers about the general idea.
> 
> Cheers,
> 
> 
> Guilherme
> 


