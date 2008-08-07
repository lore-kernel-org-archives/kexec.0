Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR1nv-00086C-BF
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 09:29:07 +0000
Subject: Re: [PATCH 1/6] kexec jump: clean up #ifdef and comments
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080807092058.GB372@atrey.karlin.mff.cuni.cz>
References: <1218099923.5164.32.camel@caritas-dev.intel.com>
	<20080807092058.GB372@atrey.karlin.mff.cuni.cz>
Date: Thu, 07 Aug 2008 17:29:04 +0800
Message-Id: <1218101344.5164.38.camel@caritas-dev.intel.com>
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

On Thu, 2008-08-07 at 11:20 +0200, Pavel Machek wrote:
> Hi!
> 
> > CONFIG_KEXEC_JUMP to make code looks cleaner.
> > 
> > Fix no longer correct comments of kernel_kexec().
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > 
> > ---
> >  kernel/kexec.c |   11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1427,8 +1427,6 @@ static int __init crash_save_vmcoreinfo_
> >  module_init(crash_save_vmcoreinfo_init)
> >  
> >  /**
> > - *	kernel_kexec - reboot the system
> > - *
> >   *	Move into place and start executing a preloaded standalone
> >   *	executable.  If nothing was preloaded return an error.
> >   */
> 
> If it is not kerneldoc, it should not be /** .

OK. I will fix it.

Best Regards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
