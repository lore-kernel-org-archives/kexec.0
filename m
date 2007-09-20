Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYHC3-0001oj-Lp
	for kexec@lists.infradead.org; Thu, 20 Sep 2007 04:15:31 -0400
Date: Thu, 20 Sep 2007 10:15:24 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/2 -mm] kexec based hibernation -v3: kexec restore
Message-ID: <20070920081524.GA8732@atrey.karlin.mff.cuni.cz>
References: <1190266450.21818.18.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1190266450.21818.18.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

> This patch adds writing support for /dev/oldmem. This is used to
> restore the memory contents of hibernated system.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>

ACK. (And this can even go in before the patch #1, right?)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
