Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OZHIg-00054j-7h
	for kexec@lists.infradead.org; Thu, 15 Jul 2010 05:48:03 +0000
Date: Thu, 15 Jul 2010 14:47:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix case where phys_addr_t != unsigned long when
	reading proc entries
Message-ID: <20100715054754.GA24267@verge.net.au>
References: <1279121556-8069-1-git-send-email-msm@freescale.com>
	<1279121958.13098.1.camel@localhost>
	<20100715030748.GA11508@verge.net.au>
	<1279167765.26744.1.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1279167765.26744.1.camel@localhost>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: kexec@lists.infradead.org

On Wed, Jul 14, 2010 at 11:22:45PM -0500, Matthew McClintock wrote:
> On Thu, 2010-07-15 at 12:07 +0900, Simon Horman wrote:
> > The list below is sufficient, but could you cc the patches to
> > linuxppc-dev@lists.ozlabs.org?
> > 
> 
> Yes of course, I'm also trying to find some people to review/test these
> as well.

Excellent, thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
