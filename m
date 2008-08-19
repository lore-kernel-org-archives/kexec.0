Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KVTQF-0006Ki-EY
	for kexec@lists.infradead.org; Tue, 19 Aug 2008 15:47:03 +0000
Date: Tue, 19 Aug 2008 08:38:16 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATCH] Explicitly use BUILD_CC and TARGET_CC
Message-ID: <20080819153816.GB22382@nlxdcldnl2.cl.intel.com>
References: <1219030410.884068.167991623519.1.gpush@pingu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1219030410.884068.167991623519.1.gpush@pingu>
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
Cc: "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Sun, Aug 17, 2008 at 08:33:30PM -0700, Jeremy Kerr wrote:
> Currently, we override CC for build and target compiles:
> 
> $(BIN_TO_HEX): CC=$(BUILD_CC)
> 
> However, this breaks when a user does something like:
> 
>  make CC=host-arch-gcc
> 
> - since command-line parameter overrides all makefile variables, so
> we end up using host-arch-gcc for *all* compiles, including those for
> target and build.
> 
> This change explicitly uses BUILD_CC and TARGET_CC where necessary,
> so that the CC variable isn't used for build and target compiles.

Thanks!

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
