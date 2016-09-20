Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmFeU-0001mq-BX
 for kexec@lists.infradead.org; Tue, 20 Sep 2016 07:39:39 +0000
Received: by mail-pf0-x22f.google.com with SMTP id z123so4574428pfz.2
 for <kexec@lists.infradead.org>; Tue, 20 Sep 2016 00:39:17 -0700 (PDT)
Date: Tue, 20 Sep 2016 16:46:23 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v26 3/7] arm64: kdump: add kdump support
Message-ID: <20160920074622.GD30248@linaro.org>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-4-takahiro.akashi@linaro.org>
 <57DC06B0.8030504@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57DC06B0.8030504@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 16, 2016 at 03:50:24PM +0100, James Morse wrote:
> On 07/09/16 05:29, AKASHI Takahiro wrote:
> > On crash dump kernel, all the information about primary kernel's system
> > memory (core image) is available in elf core header.
> > The primary kernel will set aside this header with reserve_elfcorehdr()
> > at boot time and inform crash dump kernel of its location via a new
> > device-tree property, "linux,elfcorehdr".
> > 
> > Please note that all other architectures use traditional "elfcorehdr="
> > kernel parameter for this purpose.
> > 
> > Then crash dump kernel will access the primary kernel's memory with
> > copy_oldmem_page(), which reads one page by ioremap'ing it since it does
> > not reside in linear mapping on crash dump kernel.
> > 
> > We also need our own elfcorehdr_read() here since the header is placed
> > within crash dump kernel's usable memory.
> 
> One nit below, looks good.

Fixed.

Thanks,
-Takahiro AKASHI

> Reviewed-by: James Morse <james.morse@arm.com>
> 
> 
> Thanks,
> 
> James
> 
> 
> > diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
> 
> > +/**
> > + * copy_oldmem_page() - copy one page from old kernel memory
> > + * @pfn: page frame number to be copied
> > + * @buf: buffer where the copied page is placed
> > + * @csize: number of bytes to copy
> > + * @offset: offset in bytes into the page
> > + * @userbuf: if set, @buf is in a user address space
> > + *
> > + * This function copies one page from old kernel memory into buffer pointed by
> > + * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
> > + * copied or negative error in case of failure.
> > + */
> > +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> > +			 size_t csize, unsigned long offset,
> > +			 int userbuf)
> > +{
> > +	void *vaddr;
> > +
> > +	if (!csize)
> > +		return 0;
> > +
> > +	vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
> > +	if (!vaddr)
> > +		return -ENOMEM;
> > +
> > +	if (userbuf) {
> 
> > +		if (copy_to_user(buf, vaddr + offset, csize)) {
> 
> If you re-cast buf with (char __user *), it should stop sparse complaining:
> > ../arch/arm64/kernel/crash_dump.c:45:34: warning: incorrect type in argument 1
> (different address spaces)
> > ../arch/arm64/kernel/crash_dump.c:45:34:    expected void [noderef] <asn:1>*to
> > ../arch/arm64/kernel/crash_dump.c:45:34:    got char *buf
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
