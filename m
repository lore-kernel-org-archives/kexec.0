Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYwO6-00008L-VS
	for kexec@lists.infradead.org; Fri, 29 Aug 2008 05:19:11 +0000
Date: Fri, 29 Aug 2008 15:19:09 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: How do i see printf output from the purgatory code?
Message-ID: <20080829051907.GA25758@verge.net.au>
References: <48B73F4C.5030206@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48B73F4C.5030206@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org

On Thu, Aug 28, 2008 at 05:14:04PM -0700, Jay Lan wrote:
> Specifically, an ia64.
> 
> I added printf() to purgatory-ia64.c, compiled, and executed
> the kexec command from a shell window (ie, not from a script), but
> i still did not see the printf i put in.
> 
> Thanks for help in advance!

IIRC, the printf output in purgatory only shows on the VGA console.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
