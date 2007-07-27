Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IEI88-0005Ld-BH
	for kexec@lists.infradead.org; Fri, 27 Jul 2007 01:12:50 -0400
Date: Fri, 27 Jul 2007 14:12:37 +0900
From: Horms <horms@verge.net.au>
Subject: Re: [PATCH] Determine ELF32/ELF64 automatically on i386
Message-ID: <20070727051235.GA26198@verge.net.au>
References: <20070702131541.GA6084@suse.de> <20070703161207.GA5070@suse.de>
	<20070710055259.GA5471@in.ibm.com> <20070710082316.GA17090@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070710082316.GA17090@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Vivek Goyal <vgoyal@in.ibm.com>

On Tue, Jul 10, 2007 at 10:23:16AM +0200, Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@in.ibm.com> [2007-07-10 07:52]:
> > On Tue, Jul 03, 2007 at 06:12:07PM +0200, Bernhard Walle wrote:
> > > On i386, kexec generates ELF64 core headers by default if the user doesn't
> > > override this via a command line option. Because GDB cannot analyse
> > > ELF64 core dumps on 32 bit platforms, it's a bad idea to use ELF64 if it's not
> > > needed.
> > > 
> > > This patch selects ELF32 if the biggest memory address fits in 32 bit address
> > > space, which should be the case on non PAE systems. If the user specifies
> > > a command line option, that option overrides the detection.
> > > 
> > 
> > Makes sense to me. No need to generate 64bit ELF headers on systems
> > having less than 4G of memory. gdb runs into issues with 64bit ELF headers
> > on 32bit machines.
> 
> Exaclty that was my point.
> 
> > I think we can avoid mixed case in "CoreType" and use something like
> > "coretype".
> 
> Of course:
> 
> ----
> 
> [PATCH] Determine ELF32/ELF64 automatically on i386
> 
> On i386, kexec generates ELF64 core headers by default if the user doesn't
> override this via a command line option. Because GDB cannot analyse
> ELF64 core dumps on 32 bit platforms, it's a bad idea to use ELF64 if it's not
> needed.
> 
> This patch selects ELF32 if the biggest memory address fits in 32 bit address
> space, which should be the case on non PAE systems. If the user specifies
> a command line option, that option overrides the detection.

Sorry for being slow, I missed the patch earlier as it wasn't CCed to me.
I have applied it now.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
