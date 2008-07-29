Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KNfrI-0001fn-K5
	for kexec@lists.infradead.org; Tue, 29 Jul 2008 03:26:45 +0000
Date: Tue, 29 Jul 2008 13:26:41 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5] Move elfcorehdr_addr out of vmcore.c (Was: Re:
	[patch] crashdump: fix undefined reference to `elfcorehdr_addr')
Message-ID: <20080729032639.GA4356@verge.net.au>
References: <20080727234529.GM6175@verge.net.au>
	<20080728015117.GA12055@verge.net.au>
	<20080728024526.GB3334@verge.net.au>
	<20080728034007.GA30450@verge.net.au>
	<20080728211025.GA9985@redhat.com>
	<m1vdypfwxe.fsf@frodo.ebiederm.org>
	<20080729012245.GI10434@verge.net.au>
	<20080729022822.GA25975@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080729022822.GA25975@redhat.com>
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
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Terry Loftin <terry.loftin@hp.com>, Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Mon, Jul 28, 2008 at 10:28:22PM -0400, Vivek Goyal wrote:
> On Tue, Jul 29, 2008 at 11:22:48AM +1000, Simon Horman wrote:
> > On Mon, Jul 28, 2008 at 03:47:41PM -0700, Eric W. Biederman wrote:
> > > Vivek Goyal <vgoyal@redhat.com> writes:
> > > 
> > > > Hi All,
> > > >
> > > > How does following series of patches look like. I have moved
> > > > elfcorehdr_addr out of vmcore.c and pushed it to arch dependent section 
> > > > of crash dump to make sure that it can be worked with even when
> > > > CONFIG_PROC_VMCORE is disabled and CONFIG_CRASH_DUMP is enabled.
> > > >
> > > > I tested it on x86_64. Compile tested it on i386 and ppc64. ia64 and
> > > > sh versions are completely untested.
> > > 
> > > Given the current state of the code:
> > > Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > > 
> > > To process a kernel crash dump we pass the kernel elfcorehdr option,
> > > so testing to see if it was passed seems reasonable.
> > > 
> > > In general I think this method of handling the problems with kdump is
> > > too brittle to live, but in the case of iommus we certainly need to do
> > > something different, and unfortunately iommus were not common on x86
> > > when the original code was merged so we have not handled them well.
> > 
> > Agreed, however these patches look like they really ought to be merged
> > into a single patch for the sake of bisect. As things stand, applying
> > the first patch will break the build on each architecture with an
> > architecture specific until the latter is applied.
> 
> That's a good point. I was not very sure because changes were in 
> different arches and I broke the patch. At the same time changes are
> really miniscule in each arch. 

I guessed that was why you split them up. But really the
per-arch change is very small.

> So, for the sake of not breaking compilation for git-bisect, I will
> generate a single patch tomorrow. (Until and unless somebody has an
> objection).

For combiled patch:

Acked-by: Simon Horman <horms@verge.net.au>

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
