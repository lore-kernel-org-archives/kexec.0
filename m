Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RuuXg-0000Io-Oj
 for kexec@lists.infradead.org; Tue, 07 Feb 2012 23:33:46 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] x86, kdump: No need to disable ioapic in crash path
References: <1328206323-25580-1-git-send-email-dzickus@redhat.com>
 <m1r4ycsts1.fsf@fess.ebiederm.org> <20120207215741.GD5650@redhat.com>
 <20120207221924.GH6346@redhat.com>
Date: Tue, 07 Feb 2012 15:35:59 -0800
In-Reply-To: <20120207221924.GH6346@redhat.com> (Vivek Goyal's message of
 "Tue, 7 Feb 2012 17:19:24 -0500")
Message-ID: <m1r4y6i5cw.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>, x86@kernel.org, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Feb 07, 2012 at 04:57:41PM -0500, Don Zickus wrote:
>> On Thu, Feb 02, 2012 at 03:24:46PM -0800, Eric W. Biederman wrote:
>> > > Eric, brought up a point that because the boot code was restructured we may
>> > > not need to disable the io apic any more in the crash path.  The original
>> > > concern that led to the development of disable_IO_APIC, was that the TSC
>> > > calibration on boot up relied on the PIT timer for reference.  Access
>> > > to the PIT required 8259 interrupts to be working.  This wouldn't work
>> > > if the ioapic needed to be configured.  So on panic path, the ioapic was
>> > > reconfigured to use virtual wire mode to allow the 8259 to passthrough.
>> > 
>> > A small clarification originally it was the jiffies calibration that
>> > would fail if we could cause the PIT to generate interrupts through the
>> > 8259.  The boot would then hang at calibrating jiffies.
>> 
>> Ok.  Thanks!
>
> So now what has changed? Do we setup LAPIC and IOAPIC early enough to
> receive PIT interrupts in regular mode (non-virtual wire mode) or
> something else?

Yes.  Part of the Moorstown work required that this be done because
moorsetown did not support legacy mode.  Last I looked the code hadn't
been generalized beyond Moorsetown but empirically it works now.

Don as to what to test the only case I can think of that might be spooky
is a screaming interrupt during the handover.  You might want to try
playing with lkcdtm to try some of the more exotic crash scenarios.  But
all I expect further testing might reveal are places where we are not
as robust in initializing the hardware as we might be.  Things that
might have been papered over by the ioapic shutdown.

I think we are good to remove my ancient hack of disabling the ioapics,
and putting the system into PIT during the crash kernel switchover.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
