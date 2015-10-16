Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zmu7M-0000cK-AY
 for kexec@lists.infradead.org; Fri, 16 Oct 2015 01:47:36 +0000
Date: Fri, 16 Oct 2015 10:47:06 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/3] ppc64: Fix warnings
Message-ID: <20151016014706.GE20667@verge.net.au>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
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
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>

On Tue, Oct 06, 2015 at 05:55:48PM -0500, Scott Wood wrote:
> Produce a warning-free build on ppc64 (at least, when built as 64-bit
> userspace -- if a 64-bit binary for ppc64 is a requirement, why is -m64
> set only on purgatory?).  Mostly unused (or write-only) variable
> warnings, but also one nasty one where reserve() was used without a
> prototype, causing long long arguments to be passed as int.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Thanks, applied.

I would have slightly preferred one-patch per problem.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
