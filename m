Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K10S7-0007h0-Uk
	for kexec@lists.infradead.org; Tue, 27 May 2008 14:47:04 +0000
Date: Tue, 27 May 2008 07:40:04 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATCH] Cross compile?
Message-ID: <20080527144004.GA9884@nlxdcldnl2.cl.intel.com>
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
	<200805060742.45737.jk@ozlabs.org>
	<20080506133108.GB29182@nlxdcldnl2.cl.intel.com>
	<200805070842.23111.jk@ozlabs.org>
	<20080507150932.GA24429@nlxdcldnl2.cl.intel.com>
	<20080507153927.GA21888@nlxdcldnl2.cl.intel.com>
	<20080521054705.GA3714@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080521054705.GA3714@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>

On Wed, May 21, 2008 at 03:47:07PM +1000, Simon Horman wrote:
> On Wed, May 07, 2008 at 08:39:27AM -0700, Lombard, David N wrote:
> > On Wed, May 07, 2008 at 08:09:32AM -0700, Lombard, David N wrote:
> > > On Wed, May 07, 2008 at 08:42:22AM +1000, Jeremy Kerr wrote:
> > > > Hi David,
> > > > 
> > > > > Well, note the patch *does* uses those values--it's just the
> > > > > assignment doesn't work.
> > > > 
> > > > Let's fix the assignment then - it's been working fine here (build = 
> > > > i386-linux, host = powerpc-linux, target = powerpc64-linux), so I'd 
> > > > like to know what's breaking on your system.
> > 
> > More info:
> > 
> > Failure (original):
> > 
> >  mkdir -p purgatory
> >  uclibc-gcc  --no-undefined -nostartfiles -nostdlib -nodefaultlibs -e purgatory_start -r -o purgatory/purgatory.ro purgatory/purgatory.o purgatory/printf.o purgatory/string.o purgatory/arch/i386/entry32-16.o purgatory/arch/i386/entry32-16-debug.o purgatory/arch/i386/entry32.o purgatory/arch/i386/setup-x86.o purgatory/arch/i386/stack.o purgatory/arch/i386/compat_x86_64.o purgatory/arch/i386/purgatory-x86.o purgatory/arch/i386/console-x86.o purgatory/arch/i386/vga.o purgatory/arch/i386/pic.o purgatory/arch/i386/crashdump_backup.o purgatory/sha256.o
> >  uclibc-gcc   -o bin/bin-to-hex util/bin-to-hex.c
> >  mkdir -p kexec
> >  bin/bin-to-hex purgatory < purgatory/purgatory.ro > kexec/purgatory.c
> >  /bin/sh: bin/bin-to-hex: /lib/ld-uClibc.so.0: bad ELF interpreter: No such file or directory
> >  make[1]: *** [kexec/purgatory.c] Error 126
> > 
> > Success (patched):
> > 
> >  mkdir -p purgatory
> >  uclibc-gcc  --no-undefined -nostartfiles -nostdlib -nodefaultlibs -e purgatory_start -r -o purgatory/purgatory.ro purgatory/purgatory.o purgatory/printf.o purgatory/string.o purgatory/arch/i386/entry32-16.o purgatory/arch/i386/entry32-16-debug.o purgatory/arch/i386/entry32.o purgatory/arch/i386/setup-x86.o purgatory/arch/i386/stack.o purgatory/arch/i386/compat_x86_64.o purgatory/arch/i386/purgatory-x86.o purgatory/arch/i386/console-x86.o purgatory/arch/i386/vga.o purgatory/arch/i386/pic.o purgatory/arch/i386/crashdump_backup.o purgatory/sha256.o
> >  host-gcc -O2 -Wall -o bin/bin-to-hex util/bin-to-hex.c
> >  mkdir -p kexec
> >  bin/bin-to-hex purgatory < purgatory/purgatory.ro > kexec/purgatory.c
> >  uclibc-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/i386/include  -c -MD -o kexec/purgatory.o kexec/purgatory.c
> > 
> > Build distro is F7
> > Using purpose-built gcc-3.4.6 for both uclibc-gcc and host-gcc
> > Make is make-3.81-6.fc7
> 
> Hi David,
> 
> I'm a little bit confused about how you are invoking ./configure
> 
./configure --build=`uname -m`-linux-uclibc \
          --host=`uname -m` --prefix=/home/dnl/kboot-11/root \
          CC=uclibc-gcc BUILD_CC=host-gcc

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
