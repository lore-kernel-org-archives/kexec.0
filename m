From: Baoquan He <bhe@redhat.com>
Date: Fri, 20 May 2022 07:45:02 +0800
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <d313eec2-96b6-04e3-35cd-981f103d010e@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <Yn0TnsWVxCcdB2yO@alley>
 <d313eec2-96b6-04e3-35cd-981f103d010e@igalia.com>
Message-ID: <20220519234502.GA194232@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/15/22 at 07:47pm, Guilherme G. Piccoli wrote:
> On 12/05/2022 11:03, Petr Mladek wrote:
...... 
> > OK, the question is how to make it better. Let's start with
> > a clear picture of the problem:
> > 
> > 1. panic() has basically two funtions:
> > 
> >       + show/store debug information (optional ways and amount)
> >       + do something with the system (reboot, stay hanged)
> > 
> > 
> > 2. There are 4 ways how to show/store the information:
> > 
> >       + tell hypervisor to store what it is interested about
> >       + crash_dump
> >       + kmsg_dump()
> >       + consoles
> > 
> >   , where crash_dump and consoles are special:
> > 
> >      + crash_dump does not return. Instead it ends up with reboot.
> > 
> >      + Consoles work transparently. They just need an extra flush
> >        before reboot or staying hanged.
> > 
> > 
> > 3. The various notifiers do things like:
> > 
> >      + tell hypervisor about the crash
> >      + print more information (also stop watchdogs)
> >      + prepare system for reboot (touch some interfaces)
> >      + prepare system for staying hanged (blinking)
> > 
> >    Note that it pretty nicely matches the 4 notifier lists.
> > 
> 
> I really appreciate the summary skill you have, to convert complex
> problems in very clear and concise ideas. Thanks for that, very useful!
> I agree with what was summarized above.

I want to say the similar words to Petr's reviewing comment when I went
through the patches and traced each reviewing sub-thread to try to
catch up. Petr has reivewed this series so carefully and given many
comments I want to ack immediately.

I agree with most of the suggestions from Petr to this patch, except of
one tiny concern, please see below inline comment.

> 
> 
> > Now, we need to decide about the ordering. The main area is how
> > to store the debug information. Consoles are transparent so
> > the quesition is about:
> > 
> >      + hypervisor
> >      + crash_dump
> >      + kmsg_dump
> > 
> > Some people need none and some people want all. There is a
> > risk that system might hung at any stage. This why people want to
> > make the order configurable.
> > 
> > But crash_dump() does not return when it succeeds. And kmsg_dump()
> > users havn't complained about hypervisor problems yet. So, that
> > two variants might be enough:
> > 
> >     + crash_dump (hypervisor, kmsg_dump as fallback)
> >     + hypervisor, kmsg_dump, crash_dump
> > 
> > One option "panic_prefer_crash_dump" should be enough.
> > And the code might look like:
> > 
> > void panic()
> > {
> > [...]
> > 	dump_stack();
> > 	kgdb_panic(buf);
> > 
> > 	< ---  here starts the reworked code --- >
> > 
> > 	/* crash dump is enough when enabled and preferred. */
> > 	if (panic_prefer_crash_dump)
> > 		__crash_kexec(NULL);

I like the proposed skeleton of panic() and code style suggested by
Petr very much. About panic_prefer_crash_dump which might need be added,
I hope it has a default value true. This makes crash_dump execute at
first by default just as before, unless people specify
panic_prefer_crash_dump=0|n|off to disable it. Otherwise we need add
panic_prefer_crash_dump=1 in kernel and in our distros to enable kdump,
this is inconsistent with the old behaviour.

> > 
> > 	/* Stop other CPUs and focus on handling the panic state. */
> > 	if (has_kexec_crash_image)
> > 		crash_smp_send_stop();
> > 	else
> > 		smp_send_stop()
> > 
> 
> Here we have a very important point. Why do we need 2 variants of SMP
> CPU stopping functions? I disagree with that - my understanding of this
> after some study in architectures is that the crash_() variant is
> "stronger", should work in all cases and if not, we should fix that -
> that'd be a bug.
> 
> Such variant either maps to smp_send_stop() (in various architectures,
> including XEN/x86) or overrides the basic function with more proper
> handling for panic() case...I don't see why we still need such
> distinction, if you / others have some insight about that, I'd like to
> hear =)
> 
> 
> > 	/* Notify hypervisor about the system panic. */
> > 	atomic_notifier_call_chain(&panic_hypervisor_list, 0, NULL);
> > 
> > 	/*
> > 	 * No need to risk extra info when there is no kmsg dumper
> > 	 * registered.
> > 	 */
> > 	if (!has_kmsg_dumper())
> > 		__crash_kexec(NULL);
> > 
> > 	/* Add extra info from different subsystems. */
> > 	atomic_notifier_call_chain(&panic_info_list, 0, NULL);
> > 
> > 	kmsg_dump(KMSG_DUMP_PANIC);
> > 	__crash_kexec(NULL);
> > 
> > 	/* Flush console */
> > 	unblank_screen();
> > 	console_unblank();
> > 	debug_locks_off();
> > 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > 
> > 	if (panic_timeout > 0) {
> > 		delay()
> > 	}
> > 
> > 	/*
> > 	 * Prepare system for eventual reboot and allow custom
> > 	 * reboot handling.
> > 	 */
> > 	atomic_notifier_call_chain(&panic_reboot_list, 0, NULL);
> 
> You had the order of panic_reboot_list VS. consoles flushing inverted.
> It might make sense, although I didn't do that in V1...
> Are you OK in having a helper for console flushing, as I did in V1? It
> makes code of panic() a bit less polluted / more focused I feel.
> 
> 
> > 
> > 	if (panic_timeout != 0) {
> > 		reboot();
> > 	}
> > 
> > 	/*
> > 	 * Prepare system for the infinite waiting, for example,
> > 	 * setup blinking.
> > 	 */
> > 	atomic_notifier_call_chain(&panic_loop_list, 0, NULL);
> > 
> > 	infinite_loop();
> > }
> > 
> > 
> > __crash_kexec() is there 3 times but otherwise the code looks
> > quite straight forward.
> > 
> > Note 1: I renamed the two last notifier list. The name 'post-reboot'
> > 	did sound strange from the logical POV ;-)
> > 
> > Note 2: We have to avoid the possibility to call "reboot" list
> > 	before kmsg_dump(). All callbacks providing info
> > 	have to be in the info list. It a callback combines
> > 	info and reboot functionality then it should be split.
> > 
> > 	There must be another way to calm down problematic
> > 	info callbacks. And it has to be solved when such
> > 	a problem is reported. Is there any known issue, please?
> > 
> > It is possible that I have missed something important.
> > But I would really like to make the logic as simple as possible.
> 
> OK, I agree with you! It's indeed simpler and if others agree, I can
> happily change the logic to what you proposed. Although...currently the
> "crash_kexec_post_notifiers" allows to call _all_ panic_reboot_list
> callbacks _before kdump_.
> 
> We need to mention this change in the commit messages, but I really
> would like to hear the opinions of heavy users of notifiers (as
> Michael/Hyper-V) and the kdump interested parties (like Baoquan / Dave
> Young / Hayatama). If we all agree on such approach, will change that
> for V2 =)
> 
> Thanks again Petr, for the time spent in such detailed review!
> Cheers,
> 
> 
> Guilherme
> 


