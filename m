Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRC98-00062V-8h
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 20:31:47 +0000
Date: Thu, 7 Aug 2008 22:31:30 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/6] kexec jump: check code size in control page
Message-ID: <20080807203130.GA10331@ucw.cz>
References: <1218099926.5164.33.camel@caritas-dev.intel.com>
	<20080807131557.GB27783@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080807131557.GB27783@redhat.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

Hi!

> > PAGE_SIZE/2. This patch adds runtime checking for this.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
...

> >  {
> >  	if (nx_enabled)
> >  		set_pages_x(image->control_code_page, 1);
> > +
> > +	BUG_ON((unsigned long)kexec_control_page_code_end - \
> > +	       (unsigned long)relocate_kernel >= PAGE_SIZE/2);
> > +
> 

> Run time check is better than nothing but I think in this case it would
> be better if we can catch it at compile time. 
> 
> One of the methods will be to write a small program of your own and
> put in script/ and at build time check for the size and flag error. May
> be there are other better ways to do this.

BUILD_BUG_ON()?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
