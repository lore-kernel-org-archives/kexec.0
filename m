Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZqqz-00084M-9d
	for kexec@lists.infradead.org; Thu, 13 Mar 2008 17:04:30 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
Date: Thu, 13 Mar 2008 18:03:29 +0100
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803122253.07631.rjw@sisk.pl>
	<m1iqzrxy26.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1iqzrxy26.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200803131803.31120.rjw@sisk.pl>
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

On Thursday, 13 of March 2008, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > Yes, it ought to be possible.
> >
> > Ultimately, IMHO, we should put all devices unnecessary for saving the image
> > (and doing some eye-candy work) into low power states before the image is
> > created and keep them in low power states until the system is eventually
> > powered off.
> 
> Why?  I guess I don't see why we care what power state the devices are in.
> Especially since we should be able to quickly save the image.
> 
> We need to disconnect the drivers from the hardware yes.  So filesystems
> still work and applications that do direct hardware access still work
> and don't need to reopen their connections.
> 
> I'm leery of low power states as they don't always work, and bringing
> low power states seems to confuse hibernation to disk with suspend to
> ram.

From the ACPI compliance point of view it's better to do it this way.  We need
to put the devices into low power states anyway before "powering off" the
system and we won't need to touch them for the second time if we do that
in advance.

Still, it would be sufficient if we disconnected the drivers from the hardware
and thus prevented applications from accessing that hardware.

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
