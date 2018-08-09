Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fnh0z-0007W7-OV
 for kexec@lists.infradead.org; Thu, 09 Aug 2018 09:13:56 +0000
Date: Thu, 9 Aug 2018 17:13:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
Message-ID: <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
 <1533800010.5087.71.camel@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1533800010.5087.71.camel@gmx.de>
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
To: Mike Galbraith <efault@gmx.de>
Cc: linux-efi@vger.kernel.org, Baoquan He <bhe@redhat.com>, ard.biesheuvel@linaro.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>

On 08/09/18 at 09:33am, Mike Galbraith wrote:
> On Thu, 2018-08-09 at 12:21 +0800, Dave Young wrote:
> > Hi Mike,
> > 
> > Thanks for the patch!
> > On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> > > When booting with efi=noruntime, we call efi_runtime_map_copy() while
> > > loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> > > that and a useless allocation when the only mapping we can use (1:1)
> > > is not available.
> > 
> > At first glance, efi_get_runtime_map_size should return 0 in case
> > noruntime.
> 
> What efi does internally at unmap time is to leave everything except
> efi.mmap.map untouched, setting it to NULL and turning off EFI_MEMMAP,
> rendering efi.mmap.map accessors useless/unsafe without first checking
> EFI_MEMMAP.

Probably the x86 efi_init should reset nr_map to zero in case runtime is
disabled.  But let's see how Ard thinks about this and cc linux-efi.

As for efi_get_runtime_map_size, it was introduced for x86 kexec use.
for copying runtime maps,  so I think it is reasonable this function
return zero in case no runtime.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
