From: Baoquan He <bhe@redhat.com>
Date: Wed, 26 Jan 2022 11:29:19 +0800
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
In-Reply-To: <ed18ba1e-4792-22c5-3ece-4d518a8a4a2d@igalia.com>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <c7796467-ee32-942f-6011-860a3600f4ef@igalia.com>
 <20220122103121.GB2596@MiWiFi-R3L-srv>
 <ed18ba1e-4792-22c5-3ece-4d518a8a4a2d@igalia.com>
Message-ID: <20220126032919.GB2086@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/22/22 at 10:49am, Guilherme G. Piccoli wrote:
> On 22/01/2022 07:31, Baoquan He wrote:
> > [...]
> > From my old POV, I took pstore as a necessity on handheld devices or
> > embeded system, e.g on Andriod. In that case, reserving crashkernel
> > memory to enable kdump to save kernel log, it sounds not so
> > cost-effective, since memory on those systems is usually not big.
> > I am also interested in any new use case where people deploy these
> > and why it's needed, to widen my view.
> 
> Hi Baoquan, that's great to hear. Indeed, I feel pstore is unfortunately
> not very used in non-embedded devices - if you see kdump/error-report
> userspace tooling, like on Red Hat/Fedora, Debian/Ubuntu and so on, they
> never rely on pstore. And the configuration is not straightforward for
> the users...I think that's a good thing to change, since pstore is much
> less resource consuming than kdump.
> But of course, not a discussion related to this patch specifically, just
> me thinking out loud heh
> 
> 
> > [...] 
> > It's my bad. My thought is panic_print and kmsg_dump can be coupled, but
> > they should decouple with panic_notifier. When panic_print is enabled,
> > we do not expect to execute panic_notifier? My personal opinion.
> > 
> > I missed the change at line 8, sorry for the caused misunderstanding. 
> > Now the chance of holding C-programmer-prize of the year comes back
> > again.
> > 
> >   void panic()
> >   {
> > 1         if (!_crash_kexec_post_notifiers && !panic_print) {
> > 2                 __crash_kexec(NULL);
> > 3                 smp_send_stop();
> > 4         } else {
> > 5                 crash_smp_send_stop();
> > 6         }
> >   
> >   	if (_crash_kexec_post_notifiers)
> > 8  		atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> > 9  	panic_print_sys_info(false);
> > 10  	kmsg_dump(KMSG_DUMP_PANIC);
> > 11  	if (_crash_kexec_post_notifiers || panic_print)
> > 12                 __crash_kexec(NULL);
> >   	...
> >   	debug_locks_off();
> >           console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> >           panic_print_sys_info(true);
> 
> Hmm, yeah, I still don't think I'm a brilliant C programmer heh
> Again, in the code above, I can't see how we would reach
> "__crash_kexec(NULL)" after printing the extra info of panic_print, if
> we don't have panic notifiers enabled.

Missed this one.

Above code will allow any of _crash_kexec_post_notifiers and panic_print
to execute, then crash dump in L11.
   L5 -> L11

Since you have posted v4, let's ignore it anyway.

> 
> So, indeed the code currently don't really tightly couple "panic_print"
> with the panic notifiers. We could change that in another patch series,
> based on what Petr suggested in the filter thread (I know you're
> following there as well, thanks bu the way!), but for now, they are
> completely independent. My plan, following Petr suggestions here and if
> you agree, is to re-submit this patch with some changes, but in the end
> the code will allow users that have kdump enabled + panic_print
> -"crash_kexec_post_notifiers" to have "panic_print_sys_info(false)"
> executing before the "__crash_kexec(NULL)".
> 
> But also, we can add "crash_kexec_post_notifiers" and it will still
> work; finally, pstore is gonna be able to collect the logs from
> "panic_print" as well (the main purpose of this patch).
> 
> Once that's all resolved, my goal is to jump into the panic notifiers
> refactor suggested in the other thread. Let me know if you agree with
> these steps/plans, and I'll work them.

I am glad to see any improvement from refactory. As for panic_notifier,
I have expressed my concern and worry about the plan. So, if no any
new action added before kdump switching, it's welcomed.


