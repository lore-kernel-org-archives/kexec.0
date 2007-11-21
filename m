Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Iuckq-0005gV-MB
	for kexec@lists.infradead.org; Tue, 20 Nov 2007 23:43:49 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [PATCH 3/3 -mm] kexec based hibernation -v6: kexec
	hibernate/resume
Date: Wed, 21 Nov 2007 01:00:35 +0100
References: <Pine.LNX.4.44L0.0711200949590.3931-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0711200949590.3931-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200711210100.36884.rjw@sisk.pl>
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
To: Alan Stern <stern@rowland.harvard.edu>, "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Tuesday, 20 of November 2007, Alan Stern wrote:
> On Tue, 20 Nov 2007, Huang, Ying wrote:
> 
> > - What is the difference between PMSG_SUSPEND and PMSG_FREEZE?
> 
> SUSPEND means that the system is about to go into a low-power state, so 
> the driver should take the appropriate action to reduce the device's 
> power consumption.  It should also stop all I/O and DMA to the device.  
> Interrupts can remain enabled if the device is supposed to be a wakeup 
> source; otherwise they should be disabled.
> 
> FREEZE means that the system is going to hibernate, and devices need to
> be quiescent (no I/O, no DMA, and no interrupts) so that an atomic
> memory snapshot can be captured.  The driver should take the
> appropriate action to quiesce the device but the power level doesn't
> need to change.
> 
> PRETHAW means that the system is going to resume from hibernation by
> loading a previously-saved memory snapshot.  The driver should take the
> appropriate action to quiesce the device (no I/O, no DMA, and no
> interrupts) so that the snapshot can be safely restored, but the power
> level doesn't need to change.  The driver may also want to put the
> device into a special state so that the saved kernel's resume method
> will recognize the device has undergone a hibernation cycle and needs
> to be reinitialized.

Exactly.

For this reason, PMSG_SUSPEND should be used right before calling
hibernation_ops->enter() .

Greetings,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
