Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K5j6n-0001Dl-EY
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 15:16:33 +0000
Date: Mon, 9 Jun 2008 08:17:02 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATCH] Cross compile?
Message-ID: <20080609151702.GB10743@nlxdcldnl2.cl.intel.com>
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
	<20080521054705.GA3714@verge.net.au>
	<20080527144004.GA9884@nlxdcldnl2.cl.intel.com>
	<200806041042.06607.jk@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200806041042.06607.jk@ozlabs.org>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: "Lombard, David N" <dnlombar@plxs0284.pdx.intel.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Wed, Jun 04, 2008 at 10:42:06AM +0800, Jeremy Kerr wrote:
> Hi David,
> 
> (sorry about the late reply, been on holidays for the last 3 weeks..)
> 
> > ./configure --build=`uname -m`-linux-uclibc \
> >           --host=`uname -m` --prefix=/home/dnl/kboot-11/root \
> >           CC=uclibc-gcc BUILD_CC=host-gcc
> 
> Ah, there's the problem. You're specifying CC on the configure line, 
> which is overriding it for *everything*. Which is why the 
> CC=$(BUILD_CC) assignment in util/Makefile isn't working for you.

I'm perfectly happy to admit I've horked this...

> I'll see if I can work out a proper fix...
> 
> Also, why are you setting --build to -uclibc?

Some of the above came from kboot; everything else is my own fault :)

kexec is being built on a glibc-based x86 for use on a uclibc-based
x86.

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
