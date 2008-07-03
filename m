Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KEXpp-0007rq-1P
	for kexec@lists.infradead.org; Thu, 03 Jul 2008 23:03:29 +0000
Date: Fri, 4 Jul 2008 09:03:27 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix 32 bit kexec binary to boot on 64 bit ppc64
Message-ID: <20080703230326.GB14449@verge.net.au>
References: <486CCF6E.2010804@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <486CCF6E.2010804@in.ibm.com>
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
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

On Thu, Jul 03, 2008 at 06:39:02PM +0530, Sachin P. Sant wrote:
> Allow 32 bit kexec binary to boot kdump kernel on
> ppc64 architecture.
>
> This problem was reported by Bernhard here.
>
> http://lists.infradead.org/pipermail/kexec/2008-June/001998.html
>

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
