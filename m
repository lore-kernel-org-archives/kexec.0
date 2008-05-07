Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JtlKw-0004Ib-0h
	for kexec@lists.infradead.org; Wed, 07 May 2008 15:13:42 +0000
Date: Wed, 7 May 2008 08:09:32 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATCH] Cross compile?
Message-ID: <20080507150932.GA24429@nlxdcldnl2.cl.intel.com>
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
	<200805060742.45737.jk@ozlabs.org>
	<20080506133108.GB29182@nlxdcldnl2.cl.intel.com>
	<200805070842.23111.jk@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200805070842.23111.jk@ozlabs.org>
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
Cc: kexec@lists.infradead.org

On Wed, May 07, 2008 at 08:42:22AM +1000, Jeremy Kerr wrote:
> Hi David,
> 
> > Well, note the patch *does* uses those values--it's just the
> > assignment doesn't work.
> 
> Let's fix the assignment then - it's been working fine here (build = 
> i386-linux, host = powerpc-linux, target = powerpc64-linux), so I'd 
> like to know what's breaking on your system.
> 
> What are you using for CC, BUILD_CC and LDFLAGS?

  # Compiler for building kexec
  CC              = uclibc-gcc
  CPP             = uclibc-gcc -E
  LD              = ld
  AS              = as
  OBJCOPY         = objcopy
  AR              = ar

  # C compiler for binaries to run during the build
  BUILD_CC        = host-gcc
  BUILD_CFLAGS    = -O2 -Wall
  TARGET_CC       = uclibc-gcc
  TARGET_CFLAGS   = -O2 -Wall

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
