Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZyml-0004pL-8t
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 01:32:39 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
Date: Fri, 14 Mar 2008 02:31:38 +0100
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803131803.31120.rjw@sisk.pl>
	<m1ejaew7dm.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejaew7dm.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200803140231.39282.rjw@sisk.pl>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Friday, 14 of March 2008, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > From the ACPI compliance point of view it's better to do it this way.  We need
> > to put the devices into low power states anyway before "powering off" the
> > system and we won't need to touch them for the second time if we do that
> > in advance.
> 
> Interesting.  From a kexec jump where we exit the kernel and then return
> to it seem all that is required.
> 
> I will have to look at the ACPI case.  That seems to be the lynch pin
> of a couple of arguments for doing strange things: ACPI requires it.

Yes and that's because ACPI regards hibernation as a _sleep_ state, something
more like S3 (suspend to RAM) than S5 (power off).

In fact even now we're doing things that are strange from the ACPI standpoint.
For example, we should really execute _PTS once during the entire transition
and we shouldn't call _WAK after we've created the image.  We're doing that
now due to some design limitations, but in fact we shouldn't.

> > Still, it would be sufficient if we disconnected the drivers from the hardware
> > and thus prevented applications from accessing that hardware.
> 
> My gut feeling is that except for a handful of drivers we could even
> get away with simply implementing hot unplug and hot replug.  Disks
> are the big exception here.
> 
> Which suggests to me that it is at least possible that the methods we
> want for a kexec jump hibernation may be different from an in-kernel
> hibernation and quite possibly are easier to implement.

I'm not sure about the "easier" part, quite frankly.  Also, with our current
ordering of code the in-kernel hibernation will need the same callbacks
as the kexec-based thing.  However, with the in-kernel approach we can
attempt (in the future) to be more ACPI compliant, so to speak, but with the
kexec-based approach that won't be possible.

Whether it's a good idea to follow ACPI, as far as hibernation is concerned, is
a separate question, but IMO we won't be able to answer it without _lots_ of
testing on vaious BIOS/firmware configurations.  Our experience so far
indicates that at least some BIOSes expect us to follow ACPI and misbehave
otherwise, so for those systems there should be an "ACPI way" available.
[Others just don't work well if we try to follow ACPI and those may be handled
using the kexec-based approach, but that doesn't mean that we can just ignore
the ACPI compliance issue, at least for now.]

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
