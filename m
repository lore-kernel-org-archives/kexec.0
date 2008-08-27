Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYAjn-0003qW-Lw
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 02:26:24 +0000
Date: Wed, 27 Aug 2008 12:26:21 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch] fix compilation on arm
Message-ID: <20080827022621.GK19066@verge.net.au>
References: <48B1B4C0.3070209@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48B1B4C0.3070209@pengutronix.de>
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
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kexec@lists.infradead.org

On Sun, Aug 24, 2008 at 09:21:36PM +0200, Marc Kleine-Budde wrote:
> Hi,
> 
> cross compilation to arm fails with toolchain based on recent new kernel
> headers, due to mussing asm/page.h, This patch fixes the problem.

Thanks, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
