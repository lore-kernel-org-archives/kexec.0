Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jyhtz-0006Os-2T
	for kexec@lists.infradead.org; Wed, 21 May 2008 06:34:19 +0000
Date: Wed, 21 May 2008 16:34:11 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Factor uname-based native architecture detection into
	a common function.
Message-ID: <20080521063410.GL3714@verge.net.au>
References: <20080516054210.GA21189@oh.minilop.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080516054210.GA21189@oh.minilop.net>
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
To: Jamey Sharp <jamey@thetovacompany.com>
Cc: kexec@lists.infradead.org

On Thu, May 15, 2008 at 10:42:10PM -0700, Jamey Sharp wrote:
> This code was copy-pasted into every architecture and was basically
> identical.
> 
> Besides producing a nice net reduction in code, this factors a
> portability challenge into a single function that can be easily replaced
> at build-time.
> 
> Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
> ---
> This would allow arch_compat_trampoline to be simplified, since every
> architecture besides i386 has only "return 0;" in the function body now.
> 
> Note: I can't confirm that this works on any architecture but i386.

Hi Jamey,

I have been able to confirm that the code at least builds on every
architecture that kexec-tools supports. I have committed it to the tree
as a way of expsosing it to further testing.

Thanks

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
