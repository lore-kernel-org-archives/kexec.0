Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XZKLD-0006SA-U6
 for kexec@lists.infradead.org; Wed, 01 Oct 2014 13:53:16 +0000
Date: Wed, 1 Oct 2014 09:52:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [resend Patch v3 1/2] kaslr: check if kernel location is changed
Message-ID: <20141001135237.GA13689@redhat.com>
References: <1412060896-1902-1-git-send-email-bhe@redhat.com>
 <542B1EC1.8090502@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <542B1EC1.8090502@zytor.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: whissi@whissi.de, ak@linux.intel.com, keescook@chromium.org, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, tglx@linutronix.de

On Tue, Sep 30, 2014 at 02:21:05PM -0700, H. Peter Anvin wrote:
> On 09/30/2014 12:08 AM, Baoquan He wrote:
> > Function handle_relocations() is used to do the relocations handling
> > for i686 and kaslr of x86_64. For 32 bit the relocation handling is
> > mandotary to perform. For x86_64 only when kaslr is enabled and a
> > random kernel location is chosen successfully the relocation handling
> > shound be done. However previous implementation only compared the
> > kernel loading address and LOAD_PHYSICAL_ADDR where kernel were
> > compiled to run at. This would casue system to be exceptional in
> > few conditions like when delta between load address and compiled
> > address is bigger than what 32bit signed relocations can handle.
> > Also there will be limitations that delta can't be too big otherwise
> > kernel text virtual addresses will overflow in module address space.
> > 
> > So in this patch check if kernel location is changed after
> > choose_kernel_location() when x86_64. If and only if in x86_64
> > and kernel location is changed, we say a kaslr random kernel
> > location is chosen, then the relocation handling is needed.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > Tested-by: Thomas D. <whissi@whissi.de>
> > Cc: stable@vger.kernel.org
> 
> Could you clarify under what conditions we may end up with 32-bit signed
> overflow, and yet have a functional kernel?


Hi Peter,

I think there is some confusion. I will try to clarify.

If we have 32bit signed overflow, we will not have a functional kernel.
And that's the message we get when we try to kexec with
CONFIG_RANDOMIZE_BASE=y.

**********************************************************************
[  340.709078] kexec: Starting new kernel
early console in decompress_kernel
KASLR disabled by default...

Decompressing Linux... Parsing ELF...

Performing relocations...
32-bit relocation outside of kernel!


 -- System halted
*****************************************************************

We realized that kexec tries to load kernel at higher physical addresses
and that can lead to problmes.

Currently for x86_64, handle_relocations() will perform relocations if
kernel is not loaded at LOAD_PHYSICAL_ADDR. I think this does not work for
all the cases and kerenl can not be loaded anywhere in the physical address
space. And that's why we run into issues with kexec.

My understanding is that we introduce handle_relcoations() i386 style
because of RANDOMIZE_BASE. If that's the case, one possible solution
is that perform relocations only if ranodmize base logic has chosen
a different load location for kernel than where boot loader loaded
it. Otherwise don't do anything.

In case of kexec/kdump, we will pass "nokaslr" to second kernel forcing
it to do nothing and let the kernel run where it was loaded by bootloader.
And in that case handle_relocations() should not do any relocations and
that should allow kernel to be loaded anywhere in physical memory on
x86_64.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
