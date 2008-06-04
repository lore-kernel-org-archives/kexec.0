Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K3izR-0006gl-3x
	for kexec@lists.infradead.org; Wed, 04 Jun 2008 02:44:41 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] Cross compile?
Date: Wed, 4 Jun 2008 10:42:06 +0800
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
	<20080521054705.GA3714@verge.net.au>
	<20080527144004.GA9884@nlxdcldnl2.cl.intel.com>
In-Reply-To: <20080527144004.GA9884@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200806041042.06607.jk@ozlabs.org>
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
To: kexec@lists.infradead.org
Cc: "Lombard, David N" <dnlombar@ichips.intel.com>, Simon Horman <horms@verge.net.au>

Hi David,

(sorry about the late reply, been on holidays for the last 3 weeks..)

> ./configure --build=`uname -m`-linux-uclibc \
>           --host=`uname -m` --prefix=/home/dnl/kboot-11/root \
>           CC=uclibc-gcc BUILD_CC=host-gcc

Ah, there's the problem. You're specifying CC on the configure line, 
which is overriding it for *everything*. Which is why the 
CC=$(BUILD_CC) assignment in util/Makefile isn't working for you.

I'll see if I can work out a proper fix...

Also, why are you setting --build to -uclibc?

Cheers,


Jeremy



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
