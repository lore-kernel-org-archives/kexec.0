Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga12.intel.com ([143.182.124.36] helo=azsmga102.ch.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K1Ous-0003NV-GS
	for kexec@lists.infradead.org; Wed, 28 May 2008 16:54:22 +0000
Date: Wed, 28 May 2008 09:47:15 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATCH] Cross compile?
Message-ID: <20080528164715.GA13422@nlxdcldnl2.cl.intel.com>
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
	<200805060742.45737.jk@ozlabs.org>
	<20080506133108.GB29182@nlxdcldnl2.cl.intel.com>
	<200805070842.23111.jk@ozlabs.org>
	<20080507150932.GA24429@nlxdcldnl2.cl.intel.com>
	<20080507153927.GA21888@nlxdcldnl2.cl.intel.com>
	<20080521054705.GA3714@verge.net.au>
	<20080527144004.GA9884@nlxdcldnl2.cl.intel.com>
	<e2ed954f0805271758m5f124316y4343c9540a0d2ae5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e2ed954f0805271758m5f124316y4343c9540a0d2ae5@mail.gmail.com>
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

On Tue, May 27, 2008 at 05:58:11PM -0700, Jamey Sharp wrote:
> On Tue, May 27, 2008 at 7:40 AM, Lombard, David N
> <dnlombar@ichips.intel.com> wrote:
> > ./configure --build=`uname -m`-linux-uclibc \
> >          --host=`uname -m` --prefix=/home/dnl/kboot-11/root \
> >          CC=uclibc-gcc BUILD_CC=host-gcc
> 
> Isn't this backwards? BUILD_CC ought to match --build, and CC ought to
> match --host. If you wanted a kexec binary to put in a uClibc initramfs,
> you should set --host for that, not --build. Right?

Here's util/Makefile, which wants bin/bin-to-hex to run on the build
platform:

  BIN_TO_HEX:= bin/bin-to-hex

  $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
        @$(MKDIR) -p $(@D)
        $(LINK.o) -o $@ $^

  $(BIN_TO_HEX): CC=$(BUILD_CC)
  $(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)

  dist += util/Makefile util/bin-to-hex.c
  clean += util/bin-to-hex.o $(BIN_TO_HEX)

Unless I am mistaken, this uses BUILD_CC and BIULD_CFLAGS for
bin/bin-to-hex, which is run on the build platform. I patched that to:

  BIN_TO_HEX:= bin/bin-to-hex

  $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
        @$(MKDIR) -p $(@D)
        $(BUILD_CC) $(BUILD_CFLAGS) -o $@ $<

  dist += util/Makefile util/bin-to-hex.c
  clean += util/bin-to-hex.o $(BIN_TO_HEX)

otherwise it used the uClibc-based tools, which cannot run on the current
glibc-based platform (F7).

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
