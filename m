Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from iolanthe.rowland.org ([192.131.102.54])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYoR6-0006Li-PZ
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 15:45:16 -0400
Date: Fri, 21 Sep 2007 15:45:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
In-Reply-To: <200709212100.11050.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Fri, 21 Sep 2007, Rafael J. Wysocki wrote:

> > > Well, the problem is that apparently some systems (eg. my HP nx6325) expect us
> > > to execute the _PTS ACPI global control method before creating the image _and_
> > > to execute acpi_enter_sleep_state(ACPI_STATE_S4) in order to finally put the
> > > system into the sleep state.  In particular, on nx6325, if we don't do that,
> > > then after the restore the status of the AC power will not be reported
> > > correctly (and if you replace the battery while in the sleep state, the
> > > battery status will not be updated correctly after the restore).  Similar
> > > issues have been reported for other machines.
> > 
> > Suppose that instead of using ACPI S4 state at all, you instead just
> > power off.  Yes, you'll lose wakeup event functionality, and flashy
> > LEDs, but doesn't this take care of the problem?
> 
> Nope.
> 
> > The firmware shouldn't see the hibernate as anything other than a shutdown
> > and reboot.
> 
> Actually, this assumption is apparently wrong.

One gets the impression that the hibernation image includes a memory 
area used by the firmware.  That could explain why devices need to be 
in a low-power state when the image is created -- so that when the 
image is restored, the firmware doesn't get confused about the device 
states.

It would also explain why the firmware sees
resume-from-power-off-hibernation as different from a regular reboot:
because its data area gets overwritten as part of the resume.

In reality it's probably more complicated than this, with weird 
interactions between the firmware and the various ACPI methods.  
Nevertheless, the main idea seems valid.

Alan Stern


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
