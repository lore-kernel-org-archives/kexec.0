Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwQgv-0005VC-US
	for kexec@lists.infradead.org; Wed, 14 May 2008 23:47:26 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 01:47:23 +0200
References: <Pine.LNX.4.44L0.0803221645190.27399-100000@netrider.rowland.org>
	<200803222229.45673.rjw@sisk.pl>
	<m1k5hwzf2z.fsf@frodo.ebiederm.org>
In-Reply-To: <m1k5hwzf2z.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200805150147.24968.rjw@sisk.pl>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Thursday, 15 of May 2008, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Saturday, 22 of March 2008, Alan Stern wrote:
> 
> > The spec doesn't say much about that, so we'll need to carry out some
> > experiments.
> 
> > Still, as far as I can figure out what the spec authors _might_ mean, I think
> > that it would be inappropriate to restore the ACPI NVS area if S5 was entered
> > on "power off".  The idea seems to be that the restoration of the ACPI NVS area
> > should complement whatever has been preserved by the platform over the
> > hibernation/resume cycle.
> 
> > IMO, if S5 was entered on "powe off", there are two possible ways to go.
> > Either ACPI is initialized by the boot kernel, in which case the image kernel
> > should not touch things like _WAK and similar, just throw away whatever
> > ACPI-related state it got from the image and try to rebuild the ACPI-related
> > data from scratch.  Or the boot kernel doesn't touch ACPI and the image kernel
> > initializes it in the same way as during a fresh boot (that might be difficult,
> > though).
> 
> Just an added data partial point.  In the kexec case I have had not heard
> anyone screaming to me that ACPI doesn't work after we switch kernels.

You don't remove power from devices while doing that.

> So I expect shutting down ACPI and restarting it should work reliably
> and that is easy to test as that is already implemented with kexec.

You can't program devices to generate wakeup events without ACPI, among
other things.

Anyway, I don't think you should focus on replacing the current hibernation
code entirely so much.

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
