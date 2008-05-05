Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jt8SS-0004Fj-6P
	for kexec@lists.infradead.org; Mon, 05 May 2008 21:42:52 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] Cross compile?
Date: Tue, 6 May 2008 07:42:45 +1000
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
In-Reply-To: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200805060742.45737.jk@ozlabs.org>
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
Cc: "Lombard, David N" <dnlombar@ichips.intel.com>

David,

> In util/Makefile, the bin-to-hex utility was being built with the
> cross-compiler, not the host compiler.  This patch fixes that.

We set the CC to BUILD_CC for the bin-to-hex target so it should use the 
host compiler currently.

What are your BUILD_CC, BUILD_CFLAGS and LDFLAGS?

Cheers,

Jeremy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
