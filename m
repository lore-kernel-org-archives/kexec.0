Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a272L-00052l-Po
 for kexec@lists.infradead.org; Fri, 27 Nov 2015 00:37:18 +0000
Date: Fri, 27 Nov 2015 09:36:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec: fix mmap return code handling
Message-ID: <20151127003649.GF2394@verge.net.au>
References: <20151125134741.55c7e21c@holzheu> <20151126183231.33da064b@holzheu>
 <20151126190228.47e4213a@hananiah.suse.cz>
 <20151126200235.5450c397@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151126200235.5450c397@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>

On Thu, Nov 26, 2015 at 08:02:35PM +0100, Michael Holzheu wrote:
> On Thu, 26 Nov 2015 19:02:28 +0100
> Petr Tesarik <ptesarik@suse.cz> wrote:
> 
> > On Thu, 26 Nov 2015 18:32:31 +0100
> > Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> > 
> > > Hi Simon again,
> > > 
> > > After a bit more thinking: In theory mmap() could also return NULL.
> > > Therefore the following fix is probably the better one ...
> > 
> > No, if you let the kernel choose the address (i.e. call mmap with NULL
> > addr), it will return at least PAGE_SIZE (and a higher limit is usually
> > enforced by sys.vm.mmap_min_addr sysctl). Admittedly the limit is set
> > in arch-specific code, so theoretically there can be an architecture
> > which sets the limit to 0, but I doubt it, because it would break too
> > many assumptions in user space (for example gcc assumes that
> > dereferencing a NULL pointer terminates a process).
> >
> > In short, this other fix is just as good as the previous one.
> 
> Hi Petr,
> 
> Thanks for clarification! I still would vote for the second one ;-)

Thanks, I have applied that version.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
