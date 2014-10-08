Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xbwtz-00009w-Sb
 for kexec@lists.infradead.org; Wed, 08 Oct 2014 19:28:01 +0000
Date: Wed, 8 Oct 2014 15:27:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [resend Patch v3 1/2] kaslr: check if kernel location is changed
Message-ID: <20141008192728.GA26517@redhat.com>
References: <1412060896-1902-1-git-send-email-bhe@redhat.com>
 <542B1EC1.8090502@zytor.com> <20141001135237.GA13689@redhat.com>
 <543553C7.9010906@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <543553C7.9010906@zytor.com>
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

On Wed, Oct 08, 2014 at 08:09:59AM -0700, H. Peter Anvin wrote:
> On 10/01/2014 06:52 AM, Vivek Goyal wrote:
> > 
> > Hi Peter,
> > 
> > I think there is some confusion. I will try to clarify.
> > 
> > If we have 32bit signed overflow, we will not have a functional kernel.
> > And that's the message we get when we try to kexec with
> > CONFIG_RANDOMIZE_BASE=y.
> > 
> 
> And how does that happen?

I compile a kernel for physical address 16MB (CONFIG_PHYSICAL_START=0x1000000).
And kexec loads this kernel at physical address above 16GB (0x000000042e000000).

When we boot into second kernel it tries to perform relocations and fails
as follows. I have printed bunch of variables in handle_relocations(), so
referring to code will help.

min_addr=0x000000042e000000 (Physical address where decompressed kernel is
			     loaded).

delta=0x000000042d000000  (Difference between load and compile addr).

map=0x00000004ad000000	 (map = delta - __START_KERNEL_map)

Now we start processing 32bit relocations and read first reloc.

extended=0x81e819c2	(extended = *reloc)

We add map to it and new value of extended is.

extended=0x2ee819c2	(extended += map)

Now we convert this to actual 64bit address which relocation needs to be
applied and ptr value is.

ptr = 0x000000002ee819c2 (ptr = (unsigned long)extended;)

And this address is outside the range of where kernel is actually loaded.
(0x000000042e000000). So we ended up with a wrong address to patch hence
following check fails.

if (ptr < min_addr || ptr > max_addr)
	error("32-bit relocation outside of kernel!\n");


> 
> > **********************************************************************
> > [  340.709078] kexec: Starting new kernel
> > early console in decompress_kernel
> > KASLR disabled by default...
> > 
> > Decompressing Linux... Parsing ELF...
> > 
> > Performing relocations...
> > 32-bit relocation outside of kernel!
> > 
> > 
> >  -- System halted
> > *****************************************************************
> > 
> > We realized that kexec tries to load kernel at higher physical addresses
> > and that can lead to problmes.
> > 
> > Currently for x86_64, handle_relocations() will perform relocations if
> > kernel is not loaded at LOAD_PHYSICAL_ADDR. I think this does not work for
> > all the cases and kerenl can not be loaded anywhere in the physical address
> > space. And that's why we run into issues with kexec.
> > 
> > My understanding is that we introduce handle_relcoations() i386 style
> > because of RANDOMIZE_BASE. If that's the case, one possible solution
> > is that perform relocations only if ranodmize base logic has chosen
> > a different load location for kernel than where boot loader loaded
> > it. Otherwise don't do anything.
> > 
> > In case of kexec/kdump, we will pass "nokaslr" to second kernel forcing
> > it to do nothing and let the kernel run where it was loaded by bootloader.
> > And in that case handle_relocations() should not do any relocations and
> > that should allow kernel to be loaded anywhere in physical memory on
> > x86_64.
> > 
> 
> Sorry... this makes no sense.
> 
> For x86-64, there is no direct connection between the physical and
> virtual address spaces that the kernel runs in...

I am sorry I did not understand this one. I thought that initial
relocatable kernel implementaion did not have any direct connection
between virtual and physical address. One could load kernel anywhere
and kernel virtual address will not change and we will just adjust
page tables to map virtual address to right physical address.

Now handle_relocation() stuff seems to introduce a close coupling
between physical and virtual address. So if kernel shifts by 16MB
in physical address space, then it will shift by equal amount
in virtual address space. So there seems to be a direct connection
between virtual and physical address space in this case.

What am I missing?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
