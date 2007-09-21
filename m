Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYh8g-0000Q9-6Z
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 07:57:45 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 14:10:44 +0200
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211024.35991.nigel@nigel.suspend2.net>
	<20070921094908.GB20149@elf.ucw.cz>
In-Reply-To: <20070921094908.GB20149@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709211410.45248.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Friday, 21 September 2007 11:49, Pavel Machek wrote:
> Hi!
> 
> > > Seems like good enough for -mm to me.
> 
> (For the record, I do not think this is going to be
> hibernation-replacement any time soon. But it is functionality useful
> for other stuff -- dump memory and continue -- and yes it may be able
> to do hibernation in the long term.
> 
> It really comes from the other side of reliability:
> 
> * swsusp is "if your kernel is perfectly healthy, it will work"
> 
> while this, coming from kdump is
> 
> * "if your kernel is not completely trashed, it should work"
> 
> ...which is why can't use swsusp to do dump memory and continue -- you
> want to do dumps on "slightly broken" systems. And yes, as a
> sideeffect it may be able to do hibernation... why not, lets see how
> it works out).

I generally agree. :-)

Greetings,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
