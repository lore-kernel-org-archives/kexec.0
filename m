Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR1rw-00006w-9v
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 09:33:16 +0000
Subject: Re: [PATCH 4/6] kexec jump: in sync with hibernation implementation
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080807092241.GE372@atrey.karlin.mff.cuni.cz>
References: <1218099932.5164.35.camel@caritas-dev.intel.com>
	<20080807092241.GE372@atrey.karlin.mff.cuni.cz>
Date: Thu, 07 Aug 2008 17:33:12 +0800
Message-Id: <1218101592.5164.43.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
To: Pavel Machek <pavel@suse.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2008-08-07 at 11:22 +0200, Pavel Machek wrote:
> > Add device_pm_lock() and device_pm_unlock() in kernel_kexec() to be
> > in sync with current hibernation implementation.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > 
> > ---
> >  kernel/kexec.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1457,6 +1457,7 @@ int kernel_kexec(void)
> >  		error = disable_nonboot_cpus();
> >  		if (error)
> >  			goto Resume_devices;
> > +		device_pm_lock();
> >  		local_irq_disable();
> >  		/* At this point, device_suspend() has been called,
> >  		 * but *not* device_power_down(). We *must*
> > @@ -1485,6 +1486,7 @@ int kernel_kexec(void)
> >  		device_power_up(PMSG_RESTORE);
> >   Enable_irqs:
> >  		local_irq_enable();
> > +		device_pm_unlock();
> >  		enable_nonboot_cpus();
> >   Resume_devices:
> >  		device_resume(PMSG_RESTORE);
> > 
> 
> Would it be possible to create common function for hibernation and
> kexec? Keeping complex stuff like this in sync is ugly.

Yes, it is ugly. But it is a little difficult to do that. Hibernation
one is more complex than this one.

Best Regards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
