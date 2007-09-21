Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYfAz-0007z0-El
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 05:52:00 -0400
Date: Fri, 21 Sep 2007 11:49:08 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
Message-ID: <20070921094908.GB20149@elf.ucw.cz>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<20070920100941.GA12157@atrey.karlin.mff.cuni.cz>
	<200709211024.35991.nigel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200709211024.35991.nigel@nigel.suspend2.net>
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
To: nigel@suspend2.net
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> > Seems like good enough for -mm to me.

(For the record, I do not think this is going to be
hibernation-replacement any time soon. But it is functionality useful
for other stuff -- dump memory and continue -- and yes it may be able
to do hibernation in the long term.

It really comes from the other side of reliability:

* swsusp is "if your kernel is perfectly healthy, it will work"

while this, coming from kdump is

* "if your kernel is not completely trashed, it should work"

...which is why can't use swsusp to do dump memory and continue -- you
want to do dumps on "slightly broken" systems. And yes, as a
sideeffect it may be able to do hibernation... why not, lets see how
it works out).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
