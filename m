Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KT9GX-0007pS-Nq
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 05:51:26 +0000
Date: Wed, 13 Aug 2008 15:51:24 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec jump: fix code size checking
Message-ID: <20080813055122.GB30294@verge.net.au>
References: <1218589475.24951.59.camel@caritas-dev.intel.com>
	<20080813024701.GA19201@verge.net.au>
	<1218596715.24951.69.camel@caritas-dev.intel.com>
	<m1d4kdk2fw.fsf@frodo.ebiederm.org>
	<1218604692.24951.92.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218604692.24951.92.camel@caritas-dev.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

On Wed, Aug 13, 2008 at 01:18:12PM +0800, Huang Ying wrote:
> On Tue, 2008-08-12 at 20:40 -0700, Eric W. Biederman wrote:
> [...]
> > 4) Put the code is a special section .text.kexec? and have the linker
> >    always do the size comparison and the computation of the section size.
> > 
> > The fewer conditionals we have the less likely something is to break.
> 
> Yes. This one is good. But I think current one is acceptable too.

If you really think that 1) is the best way

Acked-by: Simon Horman <horms@verge.net.au>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
