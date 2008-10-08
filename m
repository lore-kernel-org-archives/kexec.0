Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnSKm-0003ao-Tu
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 06:15:45 +0000
Date: Wed, 8 Oct 2008 17:15:43 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] cris: Add CRISv32 support
Message-ID: <20081008061541.GF22396@verge.net.au>
References: <20080904140850.GC14660@edgar.se.axis.com>
	<20080905004244.GA22365@verge.net.au>
	<20080905092557.GA12335@edgar.se.axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080905092557.GA12335@edgar.se.axis.com>
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
To: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Cc: "Edgar E. Iglesias" <edgar@axis.com>, kexec@lists.infradead.org, jespern@axis.com

On Fri, Sep 05, 2008 at 11:25:58AM +0200, Edgar E. Iglesias wrote:
> On Fri, Sep 05, 2008 at 10:42:45AM +1000, Simon Horman wrote:
> > On Thu, Sep 04, 2008 at 04:08:50PM +0200, Edgar E. Iglesias wrote:
> > > Hello,
> > > 
> > > I hope this is the correct list to which to send these patches.
> > > Comments are very welcome.
> > 
> > Hi Edgar,
> > 
> > this is the right place. And this patch looks pretty reasonable to me.
> > 
> > I am wondering if you can give any advise on setting up a crosscompiler
> > so that I can compile this code on an x86_32 box.
> 
> Hi Simon,
> 
> For the compiler tools there are basically two alternatives:
> 
> 1. The hard way is to check out binutils + gcc from the FSF svn and build them for the crisv32-axis-linux-gnu target. The GCC port for crisv32 was committed to the svn trunk fairly recently so I'm guessing you'll have to use the trunk.
> 
> I don't think the CRISv32 port of glibc is committed upstream yet so you'll have to get that from our site. See below.
> 
> 2. The recommended and easier way is to get one of the toolschains distributed with the ETRAX/CRIS sdk. Those can be found here:
> 
> ftp://ftp.axis.se/pub/axis/tools/cris/compiler-kit/

Hi Edgar,

sorry for taking a while to get to this.

I'm happy to report that the debian package, cris-dist_1.64-1_i386.deb,
at the link above works just fine for me and I have been able
to confirm that your code compiles. I have gone ahead
and merged it into the kexec-tools git tree and CRISv32 support should
appear in the next release, likely 2.0.1.

http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools.git;a=summary

I have added a few other minor patches, mainly based on your suggestions
below. I will post those patches shortly for the record.

> 
> ----
> 
> Once you've got the toolchain installed and assuming you've got them in your PATH It should be enough to build the kexec-tools like this:
> 
> $ cd /my-kexec-tools-build
> $ CC=crisv32-axis-linux-gnu-gcc /my-kexec-tools-src/configure --host=crisv32-axis-linux-gnu
> $ make
> 
> When trying this I noticed two issues with the released 3.2.1 toolchain:
> 1. The released crisv32 gcc port does not support the -fno-zero-initialized-in-bss flag so that has to be commented out from the Makefiles.
> 
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index ac58719..d3912c3 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -46,8 +46,8 @@ purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
>  
>  $(PURGATORY): CC=$(TARGET_CC)
>  $(PURGATORY): CFLAGS+=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
> -		      -Os -fno-builtin -ffreestanding \
> -		      -fno-zero-initialized-in-bss
> +		      -Os -fno-builtin -ffreestanding 
> +#		      -fno-zero-initialized-in-bss
>  
>  $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
>  			-I$(srcdir)/purgatory/include \
> 
> 2. The released toolchain had an old list of syscalls (kexec_load was missing) so I had to add a fallback definition:
> 
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index 1ca1c23..c367790 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -28,6 +28,11 @@
>  #ifdef __sh__
>  #define __NR_kexec_load		283
>  #endif
> +#ifdef __cris__
> +#ifndef __NR_kexec_load
> +#define __NR_kexec_load		283
> +#endif
> +#endif
>  #ifdef __ia64__
>  #define __NR_kexec_load		1268
>  #endif
> 
> I'm posting an updated kexec-tools CRIS port patch with this latter change included.
> 
> If you (or anyone else) would be interested in testing, I'd recommend to use qemu. You'll find a bit of info here:
> ftp://ftp.axis.se/pub/users/edgar/qemu-etrax/
> 
> The kernel image you'll find there has kexec support. I've also added a vmlinux ELF image to test with. The easiest way would be to boot up the kernel on qemu, then ftp upload the vmlinux image and your test kexec tools onto the guest's /tmp/ and run from there.
> 
> Let me know if there is something else I can help with.
> 
> Best regards

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
