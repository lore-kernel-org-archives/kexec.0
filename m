Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZoLeF-0005Yu-Ce
 for kexec@lists.infradead.org; Tue, 20 Oct 2015 01:23:32 +0000
Date: Tue, 20 Oct 2015 10:23:06 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] util_lib: Silence ar informational message
Message-ID: <20151020012304.GD11217@verge.net.au>
References: <1444346484.29301.81.camel@infradead.org>
 <20151016013855.GC20667@verge.net.au>
 <1445283036.30908.27.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1445283036.30908.27.camel@infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

On Mon, Oct 19, 2015 at 12:30:36PM -0700, Geoff Levand wrote:
> Hi Simon,
> 
> On Fri, 2015-10-16 at 10:38 +0900, Simon Horman wrote:
> > On Thu, Oct 08, 2015 at 04:21:24PM -0700, Geoff Levand wrote:
> > > Add the -c option to ar to silence the informational
> > > message 'ar creating libutil.a'.  ar outputs this
> > > message to stderr, and some tools interpret this as
> > > a build warning.
> > 
> > I am wondering about the portability of -c.
> > I tried to find some documentation of it and drew a blank.
> > Do you have any thoughts on this?
> 
> I couldn't find any info either.  At this point I would say
> don't include this.
> 
> I'll think about something else.  Maybe capture the output
> from ar, then only print it if ar returns an error.

Sounds messy but it may be the lest-worst solution.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
