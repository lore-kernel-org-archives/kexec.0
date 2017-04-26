Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3HNx-0005wv-4j
 for kexec@lists.infradead.org; Wed, 26 Apr 2017 07:29:18 +0000
Date: Wed, 26 Apr 2017 15:28:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] memmap: Parse "Reserved" together with "reserved"
Message-ID: <20170426072846.GA7344@dhcp-128-65.nay.redhat.com>
References: <20170426005526.27313-1-yinghai@kernel.org>
 <20170426062247.fbl62xrkrm7tvnga@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170426062247.fbl62xrkrm7tvnga@gmail.com>
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
To: Ingo Molnar <mingo@kernel.org>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org

On 04/26/17 at 08:22am, Ingo Molnar wrote:
> 
> * Yinghai Lu <yinghai@kernel.org> wrote:
> 
> > For x86 with recent kernel after
> >  commit 640e1b38b0 ("x86/boot/e820: Basic cleanup of e820.c")
> > change "reserved" to "Reserved" in /sys firmware memmap and /proc/iomem.
> > 
> > So here, we add handling for that too.
> > 
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > 
> > ---
> >  kexec/arch/i386/crashdump-x86.c |    2 ++
> >  kexec/arch/ia64/kexec-ia64.c    |    2 ++
> >  kexec/arch/mips/kexec-mips.c    |    2 ++
> >  kexec/firmware_memmap.c         |    2 ++
> >  4 files changed, 8 insertions(+)
> 
> I'd rather fix the bug I introduced and undo the reserved->Reserved string change 

This patch parses both 'reserved' and 'Reserved' it should be fine, but
reverting the change in kernel sounds better..

> in e820.c: I didn't realize that it's exposed in sysfs and had quasi-ABI 
> consequences for kexec.
> 
> Agreed?
> 
> Thanks,
> 
> 	Ingo
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
