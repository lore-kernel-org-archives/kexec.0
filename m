Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwyZF-0001Lv-Mf
	for kexec@lists.infradead.org; Fri, 16 May 2008 11:57:46 +0000
Date: Fri, 16 May 2008 13:58:33 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec
	multi-stage load
Message-ID: <20080516115833.GB22264@elf.ucw.cz>
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080513053408.GA5870@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>

Hi!

> > During loading, a hash table mapped from destination page to source
> > page is used instead of original linear mapping
> > implementation. Because the hibernated image may be very large (up to
> > near the size of physical memory), it is very time-consuming to search
> > a source page given the destination page, which is used to check
> > whether an newly allocated page is in the range of allocated
> > destination pages.
> 
> This seems to be an optimization of kexec so that it becomes efficient
> in loading large images (containing large number of segments). Probably
> this can be a separate patch.
> 
> IMHO, we can just first write a minimal patch where one can just switch
> between kernels. Once that patch is upstream, we can enhance

Yes, please.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
