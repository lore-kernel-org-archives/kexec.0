Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.22])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fnfSE-0006xw-C3
 for kexec@lists.infradead.org; Thu, 09 Aug 2018 07:33:56 +0000
Message-ID: <1533800010.5087.71.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From: Mike Galbraith <efault@gmx.de>
Date: Thu, 09 Aug 2018 09:33:30 +0200
In-Reply-To: <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>

On Thu, 2018-08-09 at 12:21 +0800, Dave Young wrote:
> Hi Mike,
> 
> Thanks for the patch!
> On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> > When booting with efi=noruntime, we call efi_runtime_map_copy() while
> > loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> > that and a useless allocation when the only mapping we can use (1:1)
> > is not available.
> 
> At first glance, efi_get_runtime_map_size should return 0 in case
> noruntime.

What efi does internally at unmap time is to leave everything except
efi.mmap.map untouched, setting it to NULL and turning off EFI_MEMMAP,
rendering efi.mmap.map accessors useless/unsafe without first checking
EFI_MEMMAP.

	-Mike

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
