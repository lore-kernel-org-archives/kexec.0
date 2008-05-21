Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JymV4-0000Cq-IX
	for kexec@lists.infradead.org; Wed, 21 May 2008 11:28:55 +0000
Date: Wed, 21 May 2008 13:29:28 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Update 32 bit boot protocol
Message-ID: <20080521132928.29df44e5@halley.suse.de>
In-Reply-To: <20080521061225.GG3714@verge.net.au>
References: <20080509164355.GA16830@suse.de>
	<20080521061225.GG3714@verge.net.au>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

* Simon Horman [2008-05-21 16:12]:
>
> On Fri, May 09, 2008 at 06:43:55PM +0200, Bernhard Walle wrote:
> > This patch updates the boot protocol to match with the kernel. See
> > Documentation/i386/zero-page.txt in kernel.
> > 
> > The number of E820 map entries have been increased from 32 to 128. The update
> > is necessary for the next patch that implements EDD support for kexec.
> > when using the default 32 bit mode.
> > 
> > 
> > Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> Thanks, I have applied this change, though I
> am a little confused about the relationship between
> the information in (kernel/)Documentation/i386/zero-page.txt and
> (kexec-tools-testing/)doc/linux-i386-zero-page.txt.

Well, it's supposed to contain the same information. I think the 32 bit
boot protocol, i.e. the communication between the "setup" part of
bzImage and the real Linux kernel, was "explored" and used by kexec
first and then "standardised" by Linux developers. Therefore, the
documentation appeared first in kexec-tools and then some kernel
developer put it into documentation tree of the kernel.

Maybe it would make also sense to remove that part of documentation
from kexec and just refer to the (more up to date) Linux documentation.
But I leave this up to your decision. I just discovered that mistake.


	Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
