Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IHlBH-0001Lm-Kp
	for kexec@lists.infradead.org; Sun, 05 Aug 2007 14:50:29 -0400
Date: Sun, 5 Aug 2007 20:50:08 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Message-ID: <20070805185008.GD1758@elf.ucw.cz>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
	<1185954978.1363.23.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1185954978.1363.23.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> > > This patch implement the functionality of jumping from kexeced kernel
> > > to original kernel.
> > > 
> > > A new reboot command named LINUX_REBOOT_CMD_KJUMP is defined to
> > > trigger the jumping to (executing) the new kernel or jumping back to
> > > the original kernel.
> > 
> > Could we get two reboot commands? Exec loaded kernel seems to be quite
> > different operation than "jump back".
> 
> Exec loaded kernel for jumping back is also different from exec loaded
> kernel normally.
> 
> Maybe the two reboot operations in kexec jump can be seen as "jump to"
> and "jump back"?

Yes, that would be better.

> Document will be added in next version too.
> 
> This parameter is used for kernel-to-kernel communication. But now, it
> must be setup by user, as in usage guide.

Thanks for your help :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
