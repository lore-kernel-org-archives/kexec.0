Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IQPGC-0007x4-1c
	for kexec@lists.infradead.org; Wed, 29 Aug 2007 11:15:14 -0400
Date: Wed, 29 Aug 2007 17:15:08 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/2 -mm] kexec based hibernation: kexec restore
Message-ID: <20070829151508.GA11179@atrey.karlin.mff.cuni.cz>
References: <1188177296.3247.38.camel@caritas-dev.intel.com>
	<20070827213134.GE3398@elf.ucw.cz>
	<1188263677.2050.8.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1188263677.2050.8.camel@caritas-dev.intel.com>
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

> On Mon, 2007-08-27 at 23:31 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > This patch adds writing support for /dev/oldmem. This is used to
> > > restore the memory contents of hibernated system.
> > > 
> > > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > 
> > > +ssize_t write_oldmem_page(unsigned long pfn, const char *buf,
> > > +			  size_t csize, unsigned long offset, int userbuf)
> > 
> > Hmm, int userbuf is only ever set to one... Does it make sense to have
> > write_oldmem_page in the separate file? The onl user is mem.c, perhaps
> > it should go there?
> > 
> 
> write_oldmem_page is kept to be consistent with copy_oldmem_page as much
> as possible. The userbuf is used by copy_oldmem_page too, and
> write_oldmem_page is in the same file as copy_oldmem_page. I think the
> consistence between them is reasonable.
> 
> And the copy_oldmem_page/write_oldmem_page is considered to be
> architecture dependent. Now, there are different implementations for
> copy_oldmem_page on different architectures. So I think the
> copy_oldmem_page/write_oldmem_page should be kept in separate file
> instead of go mem.c.

I thought it may have something to do with consistency. ACK on that
one. Perhaps it should be pushed to akpm?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
