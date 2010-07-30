Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Oeg46-00005A-SW
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 03:15:21 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2] powerpc/kexec: Fix orphaned offline CPUs across kexec
In-reply-to: <4C521FD2.4050301@ozlabs.org>
References: <4C511216.30109@ozlabs.org> <3296.1280448512@neuling.org>
	<4C521FD2.4050301@ozlabs.org>
Date: Fri, 30 Jul 2010 13:15:14 +1000
Message-ID: <20694.1280459714@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matt Evans <matt@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>

(adding kexec list to CC)

In message <4C521FD2.4050301@ozlabs.org> you wrote:
> Michael Neuling wrote:
> > In message <4C511216.30109@ozlabs.org> you wrote:
> >> When CPU hotplug is used, some CPUs may be offline at the time a kexec is
> >> performed.  The subsequent kernel may expect these CPUs to be already runn
ing
> > ,
> >> and will declare them stuck.  On pseries, there's also a soft-offline (ced
e)
> >> state that CPUs may be in; this can also cause problems as the kexeced ker
nel
> >> may ask RTAS if they're online -- and RTAS would say they are.  Again, stu
ck.
> >>
> >> This patch kicks each present offline CPU awake before the kexec, so that
> >> none are lost to these assumptions in the subsequent kernel.
> > 
> > There are a lot of cleanups in this patch.  The change you are making
> > would be a lot clearer without all the additional cleanups in there.  I
> > think I'd like to see this as two patches.  One for cleanups and one for
> > the addition of wake_offline_cpus().
> 
> Okay, I can split this.  Typofixy-add-debug in one, wake_offline_cpus
> in another. 

Thanks.

> 
> > Other than that, I'm not completely convinced this is the functionality
> > we want.  Do we really want to online these cpus?  Why where they
> > offlined in the first place?  I understand the stuck problem, but is the
> > solution to online them, or to change the device tree so that the second
> > kernel doesn't detect them as stuck?
> 
> Well... There are two cases.  If a CPU is soft-offlined on pseries, it
> must b e woken from that cede loop (in
> platforms/pseries/hotplug-cpu.c) as we're repla cing code under its
> feet.  We could either special-case the wakeup from this ce de loop to
> get that CPU to RTAS "stop-self" itself properly.  (Kind of like a "
> wake to die".)

Makes sense.  

> So that leaves hard-offline CPUs (perhaps including the above): I
> don't know why they might have been offlined.  If it's something
> serious, like fire, they'd be removed from the present set too (and
> thus not be considered in this restarting case).  We could add a mask
> to the CPU node to show which of the threads (if any) are running, and
> alter the startup code to start everything if this mask doesn't exist
> (non-kexec) or only online currently-running threads if the mask is
> present.  That feels a little weird.
> 
> My reasoning for restarting everything was: The first time you boot,
> all of your present CPUs are started up.  When you reboot, any CPUs
> you offlined for fun are restarted.  Kexec is (in this non-crash
> sense) a user-initiated 'quick reboot', so I reasoned that it should
> look the same as a 'hard reboot' and your new invocation would have
> all available CPUs running as is usual.

OK, I like this justification.  Would be good to include it in the
checkin comment since we're changing functionality somewhat.

Mikey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
