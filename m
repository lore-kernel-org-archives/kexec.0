Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIGsu-0002dv-6F
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 05:46:04 +0000
Date: Mon, 14 Jul 2008 07:46:44 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Message-ID: <20080714054644.GC20258@elf.ucw.cz>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080708145051.GA14745@redhat.com>
	<20080711122131.b6461ab1.akpm@linux-foundation.org>
	<20080711201149.GB3298@redhat.com>
	<1215824537.7319.7.camel@nigel-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1215824537.7319.7.camel@nigel-laptop>
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
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Horms <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Sat 2008-07-12 11:02:17, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2008-07-11 at 16:11 -0400, Vivek Goyal wrote:
> > Hi Andrew,
> > 
> > We can use this patchset for hibernation, but can it be a better way of doing
> > things than what we already have, I don't know. Last time I had raised
> > this question and power people had various views. In the end, Pavel wanted
> > this patchset to be in.  Pavel, can tell more here...
> > 
> > To me this patchset looks interesting for couple of reasons.
> > 
> > - Looks like an interesting feature where one can have a separate kernel
> >   in memory and one can switch between the kernels on the fly. It can
> >   be modified to have more than one kernel in memory at a time.
> 
> I'm not sure how useful that would be, though. I already have
> functionality in TuxOnIce which allows you to resume a different image
> instead of powering off (roughly the same thing when combined with not
> removing the image after resuming). It was neat when testing to be
> able

Beaty of kjump is that it is supposed to used on half-broken system,
so it is useful for debugging.

> > - So far kexec was one directional. One can only kexec to new kernel and
> >   old kernel was gone. Now this patchset makes kexec functionality kind
> >   of bidirectional and this looks like logical extension and can lead
> >   to intersting use cases in future.
> 
> Ah. You mean keeping both kernels in memory at the same time? In the
> above, I was replacing one image with another.

Yep, kjump keeps both kernels loaded at the same time.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
