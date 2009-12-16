Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NKouw-0005AI-RM
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 08:07:34 +0000
Date: Wed, 16 Dec 2009 19:07:28 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: uImage tidying and SH support.
Message-ID: <20091216080724.GA19585@verge.net.au>
References: <20091216073932.GB32515@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091216073932.GB32515@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: kexec@lists.infradead.org, Marc Andre Tanner <mat@brain-dump.org>

On Wed, Dec 16, 2009 at 04:39:32PM +0900, Paul Mundt wrote:
> Here is a trivial patch series for tidying up the uImage support a bit
> as well as wiring it up on SH. Nothing terribly exciting, just a bit of
> refactoring and updating. In addition to testing on SH, it's also been
> compile tested on ARM, which at present is the only other platform that
> makes use of this code.
> 
> The patch series can be pulled directly from:
> 
> 	git://github.com/pmundt/kexec-tools-sh.git sh/uImage
> 
> Which contains:
> 
> Paul Mundt (3):
>       kexec: Move the uImage header to a better place.
>       kexec: Bring the uImage definitions in sync with upstream.
>       kexec-sh: uImage support.

Thanks Paul, pulled and pushed up to kernel.org.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
