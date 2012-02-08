Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RvDro-0007My-VO
 for kexec@lists.infradead.org; Wed, 08 Feb 2012 20:11:51 +0000
Date: Wed, 8 Feb 2012 15:11:45 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86, kdump: No need to disable ioapic in crash path
Message-ID: <20120208201145.GX5650@redhat.com>
References: <1328206323-25580-1-git-send-email-dzickus@redhat.com>
 <m1r4ycsts1.fsf@fess.ebiederm.org>
 <20120207215741.GD5650@redhat.com>
 <20120207221924.GH6346@redhat.com>
 <m1r4y6i5cw.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1r4y6i5cw.fsf@fess.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: x86@kernel.org, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Feb 07, 2012 at 03:35:59PM -0800, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Tue, Feb 07, 2012 at 04:57:41PM -0500, Don Zickus wrote:
> >> On Thu, Feb 02, 2012 at 03:24:46PM -0800, Eric W. Biederman wrote:
> >> > > Eric, brought up a point that because the boot code was restructured we may
> >> > > not need to disable the io apic any more in the crash path.  The original
> >> > > concern that led to the development of disable_IO_APIC, was that the TSC
> >> > > calibration on boot up relied on the PIT timer for reference.  Access
> >> > > to the PIT required 8259 interrupts to be working.  This wouldn't work
> >> > > if the ioapic needed to be configured.  So on panic path, the ioapic was
> >> > > reconfigured to use virtual wire mode to allow the 8259 to passthrough.
> >> > 
> >> > A small clarification originally it was the jiffies calibration that
> >> > would fail if we could cause the PIT to generate interrupts through the
> >> > 8259.  The boot would then hang at calibrating jiffies.
> >> 
> >> Ok.  Thanks!
> >
> > So now what has changed? Do we setup LAPIC and IOAPIC early enough to
> > receive PIT interrupts in regular mode (non-virtual wire mode) or
> > something else?
> 
> Yes.  Part of the Moorstown work required that this be done because
> moorsetown did not support legacy mode.  Last I looked the code hadn't
> been generalized beyond Moorsetown but empirically it works now.
> 
> Don as to what to test the only case I can think of that might be spooky
> is a screaming interrupt during the handover.  You might want to try
> playing with lkcdtm to try some of the more exotic crash scenarios.  But
> all I expect further testing might reveal are places where we are not
> as robust in initializing the hardware as we might be.  Things that
> might have been papered over by the ioapic shutdown.

I ran lkdtm by panic'ing in the interrupt handle thus leaving device
interrupt un-ack'd and the apic might have been un-ack'd too (jprobes
hooked in at do_IRQ).  3 out 3 times the second kernel came up on my core2
quad.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
