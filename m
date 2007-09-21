Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYpI6-0006mA-3f
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 16:40:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 22:53:00 +0200
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<200709212215.26978.rjw@sisk.pl> <87hcln69zv.fsf@jbms.ath.cx>
In-Reply-To: <87hcln69zv.fsf@jbms.ath.cx>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709212253.02158.rjw@sisk.pl>
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
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

On Friday, 21 September 2007 22:26, Jeremy Maitin-Shepard wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> [snip]
> 
> > The ACPI NVS area is explicitly marked as reserved and we don't save it.
> > On x86_64 we don't save any memory areas marked as reserved and yet the above
> > happens.
> 
> I think you have mentioned before, though, that ACPI is first
> initialized by the boot kernel, before it is later initialized by
> resuming kernel.  This could well be the source of the problem.

No, it's not.  I have tested that too with an ACPI-less boot kernel.

Greetings,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
