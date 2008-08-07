Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR1hi-0007Zm-Et
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 09:22:42 +0000
Date: Thu, 7 Aug 2008 11:22:42 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 4/6] kexec jump: in sync with hibernation implementation
Message-ID: <20080807092241.GE372@atrey.karlin.mff.cuni.cz>
References: <1218099932.5164.35.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218099932.5164.35.camel@caritas-dev.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

> Add device_pm_lock() and device_pm_unlock() in kernel_kexec() to be
> in sync with current hibernation implementation.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  kernel/kexec.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1457,6 +1457,7 @@ int kernel_kexec(void)
>  		error = disable_nonboot_cpus();
>  		if (error)
>  			goto Resume_devices;
> +		device_pm_lock();
>  		local_irq_disable();
>  		/* At this point, device_suspend() has been called,
>  		 * but *not* device_power_down(). We *must*
> @@ -1485,6 +1486,7 @@ int kernel_kexec(void)
>  		device_power_up(PMSG_RESTORE);
>   Enable_irqs:
>  		local_irq_enable();
> +		device_pm_unlock();
>  		enable_nonboot_cpus();
>   Resume_devices:
>  		device_resume(PMSG_RESTORE);
> 

Would it be possible to create common function for hibernation and
kexec? Keeping complex stuff like this in sync is ugly.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
