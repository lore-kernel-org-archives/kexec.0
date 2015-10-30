Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zs4nz-0002cU-Ji
 for kexec@lists.infradead.org; Fri, 30 Oct 2015 08:13:00 +0000
Date: Fri, 30 Oct 2015 17:12:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.11-rc1
Message-ID: <20151030081236.GH31252@verge.net.au>
References: <20151029234849.GA28689@verge.net.au>
 <1446164604.22185.19.camel@freescale.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1446164604.22185.19.camel@freescale.com>
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
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

On Thu, Oct 29, 2015 at 07:23:24PM -0500, Scott Wood wrote:
> On Fri, 2015-10-30 at 08:48 +0900, Simon Horman wrote:
> > Hi all,
> > 
> > I am happy to announce the release of kexec-tools 2.0.11-rc1.
> > 
> > This is an incremental feature pre-release.
> > 
> > So long as no serious problems arise I intend to release kexec-tools 2.0.11
> > shortly after the release of the v4.3 kernel, which I expect to occur in
> > the next week or so.  As such testing of 2.0.11-rc1 would be greatly
> > appreciated.
> > 
> > I do not have any outstanding changes for 2.0.11 at this time.
> > And I would like to only accept bug fixes at this time and take take
> > features patches once 2.0.11 has been released.
> 
> As I previously reported, "ppc64: purgatory: Reset primary cpu endian to big-
> endian" breaks book3e, so can http://patchwork.ozlabs.org/patch/527048/ be 
> considered for this release?

Yes of course, sorry for not taking more note of that.

Would it be possible to get a review, e.g. from Michael?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
