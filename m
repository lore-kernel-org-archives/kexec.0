From: Baoquan He <bhe@redhat.com>
Date: Tue, 24 May 2022 16:32:03 +0800
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <ded31ec0-076b-2c5b-0fe6-0c274954821f@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <Yn0TnsWVxCcdB2yO@alley>
 <d313eec2-96b6-04e3-35cd-981f103d010e@igalia.com>
 <20220519234502.GA194232@MiWiFi-R3L-srv>
 <ded31ec0-076b-2c5b-0fe6-0c274954821f@igalia.com>
Message-ID: <YoyYAz6jOShsfzbM@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/20/22 at 08:23am, Guilherme G. Piccoli wrote:
> On 19/05/2022 20:45, Baoquan He wrote:
> > [...]
> >> I really appreciate the summary skill you have, to convert complex
> >> problems in very clear and concise ideas. Thanks for that, very useful!
> >> I agree with what was summarized above.
> > 
> > I want to say the similar words to Petr's reviewing comment when I went
> > through the patches and traced each reviewing sub-thread to try to
> > catch up. Petr has reivewed this series so carefully and given many
> > comments I want to ack immediately.
> > 
> > I agree with most of the suggestions from Petr to this patch, except of
> > one tiny concern, please see below inline comment.
> 
> Hi Baoquan, thanks! I'm glad you're also reviewing that =)
> 
> 
> > [...]
> > 
> > I like the proposed skeleton of panic() and code style suggested by
> > Petr very much. About panic_prefer_crash_dump which might need be added,
> > I hope it has a default value true. This makes crash_dump execute at
> > first by default just as before, unless people specify
> > panic_prefer_crash_dump=0|n|off to disable it. Otherwise we need add
> > panic_prefer_crash_dump=1 in kernel and in our distros to enable kdump,
> > this is inconsistent with the old behaviour.
> 
> I'd like to understand better why the crash_kexec() must always be the
> first thing in your use case. If we keep that behavior, we'll see all
> sorts of workarounds - see the last patches of this series, Hyper-V and
> PowerPC folks hardcoded "crash_kexec_post_notifiers" in order to force
> execution of their relevant notifiers (like the vmbus disconnect,
> specially in arm64 that has no custom machine_crash_shutdown, or the
> fadump case in ppc). This led to more risk in kdump.

Firstly, kdump is not always the first thing. In any use case, if kdump
kernel is not loaded, it's not the first thing at all. Not to mention
if crash_kexec_post_notifiers is specified.

if kdump kernel is loaded, kdump has been executing firslty, since it
was added into kenrel/panic(); Until 2014, Masa added crash_kexec_post_notifiers
kernel parameter to make panic notifiers be able to execute before kdump
if specified.

	commit dc009d92435f99498cbc579ce76bf28e837e2c14
	Author: Eric W. Biederman <ebiederm@xmission.com>
	Date:   Sat Jun 25 14:57:52 2005 -0700
	
	    [PATCH] kexec: add kexec syscalls
 
	commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
	Date:   Fri Jun 6 14:37:07 2014 -0700
	
	    kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers

Changing this will cause regression. During these years, nobody ever doubt
kdump should execute firstly if crashkernel is reserved and kdump kernel is
loaded. That's not saying we can't change
this, but need a convincing justification.

Secondly, even with the notifiers' split, we can't guarantee people will
absolutely add notifiers into right list in the future. Letting kdump
execute behind lists by default will put kdump into risk.

For example, you replied to Hatamata saying you have been working with
kdump in the last 3, 4 years, and you have have been working on these
panic notifiers refactoring issue in the recent months. However, in your
refactoring patches of introducing hypervisor/info/pre-reboot, I noticed
you acked the suggestion from Petr that several notifiers need be moved to
correct position. So even you can't make sure these, how can other people
be able to recognize which list should be 100% appropriate when they try
to register one notifier for their sub-component?

At last, I am wondering why fadump matters. I don't know in which case
people wants to load kdump kernel, but expect to trigger crash fadump.
Power people need consider this carefully and makes some change. Fadump
just borrows the crashkernel reservation mechanism. If fadump would rather
take risk to run all panic notifiers, whether fadump really needs them
or not, then execute crash_fadump(), that's powerpc's business.

As for Hyper-V, if it enforces to terminate VMbus connection, no matter
it's kdump or not, why not taking it out of panic notifiers list and
execute it before kdump unconditionally. Below is abstracted from
Michael's words.

https://lore.kernel.org/all/MWHPR21MB15933573F5C81C5250BF6A1CD75E9 at MWHPR21MB1593.namprd21.prod.outlook.com/T/#u
=======
I looked at the code again, and should revise my previous comments
somewhat.   The Hyper-V resets that I described indeed must be done
prior to kexec'ing the kdump kernel.   Most such resets are actually
done via __crash_kexec() -> machine_crash_shutdown(), not via the
panic notifier. However, the Hyper-V panic notifier must terminate the
VMbus connection, because that must be done even if kdump is not
being invoked.  See commit 74347a99e73.
=======

> 
> The thing is: with the notifiers' split, we tried to keep only the most
> relevant/necessary stuff in this first list, things that ultimately
> should improve kdump reliability or if not, at least not break it. My
> feeling is that, with this series, we should change the idea/concept
> that kdump must run first nevertheless, not matter what. We're here
> trying to accommodate the antagonistic goals of hypervisors that need
> some clean-up (even for kdump to work) VS. kdump users, that wish a
> "pristine" system reboot ASAP after the crash.
> 
> Cheers,
> 
> 
> Guilherme
> 


