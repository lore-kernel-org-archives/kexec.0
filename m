From: Baoquan He <bhe@redhat.com>
Date: Tue, 24 May 2022 18:18:55 +0800
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <YoyQyHHfhIIXSX0U@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <Yn0TnsWVxCcdB2yO@alley>
 <d313eec2-96b6-04e3-35cd-981f103d010e@igalia.com>
 <20220519234502.GA194232@MiWiFi-R3L-srv>
 <ded31ec0-076b-2c5b-0fe6-0c274954821f@igalia.com>
 <YoyQyHHfhIIXSX0U@alley>
Message-ID: <YoyxD3WApHpa/N1n@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/24/22 at 10:01am, Petr Mladek wrote:
> On Fri 2022-05-20 08:23:33, Guilherme G. Piccoli wrote:
> > On 19/05/2022 20:45, Baoquan He wrote:
> > > [...]
> > >> I really appreciate the summary skill you have, to convert complex
> > >> problems in very clear and concise ideas. Thanks for that, very useful!
> > >> I agree with what was summarized above.
> > > 
> > > I want to say the similar words to Petr's reviewing comment when I went
> > > through the patches and traced each reviewing sub-thread to try to
> > > catch up. Petr has reivewed this series so carefully and given many
> > > comments I want to ack immediately.
> > > 
> > > I agree with most of the suggestions from Petr to this patch, except of
> > > one tiny concern, please see below inline comment.
> > 
> > Hi Baoquan, thanks! I'm glad you're also reviewing that =)
> > 
> > 
> > > [...]
> > > 
> > > I like the proposed skeleton of panic() and code style suggested by
> > > Petr very much. About panic_prefer_crash_dump which might need be added,
> > > I hope it has a default value true. This makes crash_dump execute at
> > > first by default just as before, unless people specify
> > > panic_prefer_crash_dump=0|n|off to disable it. Otherwise we need add
> > > panic_prefer_crash_dump=1 in kernel and in our distros to enable kdump,
> > > this is inconsistent with the old behaviour.
> > 
> > I'd like to understand better why the crash_kexec() must always be the
> > first thing in your use case. If we keep that behavior, we'll see all
> > sorts of workarounds - see the last patches of this series, Hyper-V and
> > PowerPC folks hardcoded "crash_kexec_post_notifiers" in order to force
> > execution of their relevant notifiers (like the vmbus disconnect,
> > specially in arm64 that has no custom machine_crash_shutdown, or the
> > fadump case in ppc). This led to more risk in kdump.
> > 
> > The thing is: with the notifiers' split, we tried to keep only the most
> > relevant/necessary stuff in this first list, things that ultimately
> > should improve kdump reliability or if not, at least not break it. My
> > feeling is that, with this series, we should change the idea/concept
> > that kdump must run first nevertheless, not matter what. We're here
> > trying to accommodate the antagonistic goals of hypervisors that need
> > some clean-up (even for kdump to work) VS. kdump users, that wish a
> > "pristine" system reboot ASAP after the crash.
> 
> Good question. I wonder if Baoquan knows about problems caused by the
> particular notifiers that will end up in the hypervisor list. Note
> that there will be some shuffles and the list will be slightly
> different in V2.

Yes, I knew some of them. Please check my response to Guilherme.

We have bug to track the issue on Hyper-V in which failure happened
during panic notifiers running, haven't come to kdump. Seems both of
us sent mail replying to Guilherme at the same time. 

> 
> Anyway, I see four possible solutions:
> 
>   1. The most conservative approach is to keep the current behavior
>      and call kdump first by default.
> 
>   2. A medium conservative approach to change the default default
>      behavior and call hypervisor and eventually the info notifiers
>      before kdump. There still would be the possibility to call kdump
>      first by the command line parameter.
> 
>   3. Remove the possibility to call kdump first completely. It would
>      assume that all the notifiers in the info list are super safe
>      or that they make kdump actually more safe.
> 
>   4. Create one more notifier list for operations that always should
>      be called before crash_dump.

I would vote for 1 or 4 without any hesitation, and prefer 4. I ever
suggest the variant of solution 4 in v1 reviewing. That's taking those
notifiers out of list and enforcing to execute them before kdump. E.g
the one on HyperV to terminate VMbus connection. Maybe solution 4 is
better to provide a determinate way for people to add necessary code
at the earliest part.

> 
> Regarding the extra notifier list (4th solution). It is not clear to
> me whether it would be always called even before hypervisor list or
> when kdump is not enabled. We must not over-engineer it.

One thing I would like to notice is, no matter how perfect we split the
lists this time, we can't gurantee people will add notifiers reasonablly
in the future. And people from different sub-component may not do
sufficient investigation and add them to fulfil their local purpose.

The current panic notifers list is the best example. Hyper-V actually
wants to run some necessary code before kdump, but not all of them, they
just add it, ignoring the original purpose of
crash_kexec_post_notifiers. I guess they do like this just because it's
easy to do, no need to bother changing code in generic place.

Solution 4 can make this no doubt, that's why I like it better.

> 
> 2nd proposal looks like a good compromise. But maybe we could do
> this change few releases later. The notifiers split is a big
> change on its own.

As I replied to Guilherme, solution 2 will cause regression if not
calling kdump firstly. Solution 3 leaves people space to make mistake,
they could add nontifier into wrong list.

I would like to note again that the panic notifiers are optional to run,
while kdump is expectd once loaded, from the original purpose. I guess
people I know will still have this thought, e.g Hatayama, Masa, they are
truly often use panic notifiers like this on their company's system.


