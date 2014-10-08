Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XbstB-0002fp-CZ
 for kexec@lists.infradead.org; Wed, 08 Oct 2014 15:10:53 +0000
Message-ID: <543553C7.9010906@zytor.com>
Date: Wed, 08 Oct 2014 08:09:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [resend Patch v3 1/2] kaslr: check if kernel location is changed
References: <1412060896-1902-1-git-send-email-bhe@redhat.com>
 <542B1EC1.8090502@zytor.com> <20141001135237.GA13689@redhat.com>
In-Reply-To: <20141001135237.GA13689@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: whissi@whissi.de, ak@linux.intel.com, keescook@chromium.org, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, tglx@linutronix.de

On 10/01/2014 06:52 AM, Vivek Goyal wrote:
> 
> Hi Peter,
> 
> I think there is some confusion. I will try to clarify.
> 
> If we have 32bit signed overflow, we will not have a functional kernel.
> And that's the message we get when we try to kexec with
> CONFIG_RANDOMIZE_BASE=y.
> 

And how does that happen?

> **********************************************************************
> [  340.709078] kexec: Starting new kernel
> early console in decompress_kernel
> KASLR disabled by default...
> 
> Decompressing Linux... Parsing ELF...
> 
> Performing relocations...
> 32-bit relocation outside of kernel!
> 
> 
>  -- System halted
> *****************************************************************
> 
> We realized that kexec tries to load kernel at higher physical addresses
> and that can lead to problmes.
> 
> Currently for x86_64, handle_relocations() will perform relocations if
> kernel is not loaded at LOAD_PHYSICAL_ADDR. I think this does not work for
> all the cases and kerenl can not be loaded anywhere in the physical address
> space. And that's why we run into issues with kexec.
> 
> My understanding is that we introduce handle_relcoations() i386 style
> because of RANDOMIZE_BASE. If that's the case, one possible solution
> is that perform relocations only if ranodmize base logic has chosen
> a different load location for kernel than where boot loader loaded
> it. Otherwise don't do anything.
> 
> In case of kexec/kdump, we will pass "nokaslr" to second kernel forcing
> it to do nothing and let the kernel run where it was loaded by bootloader.
> And in that case handle_relocations() should not do any relocations and
> that should allow kernel to be loaded anywhere in physical memory on
> x86_64.
> 

Sorry... this makes no sense.

For x86-64, there is no direct connection between the physical and
virtual address spaces that the kernel runs in...

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
