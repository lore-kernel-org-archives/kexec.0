Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpKoP-0005rN-Mm
 for kexec@lists.infradead.org; Thu, 31 Jan 2019 22:27:59 +0000
Date: Thu, 31 Jan 2019 15:27:32 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190131222732.GA946@anatevka>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131105732.GC6749@zn.tnic>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Jerry.Hoemann@hpe.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, Baoquan He <bhe@redhat.com>, yinghai@kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Thu, Jan 31, 2019 at 11:57:32AM +0100, Borislav Petkov wrote:
> On Thu, Jan 31, 2019 at 03:59:07PM +0800, Dave Young wrote:
> > As Pingfan/me mentioned in another reply, there are two reasons:
> > 1. old kexec-tools can not load kernel to high memory
> > 2. ,high will not work on some systems without some amounts of low
> > memory so it nees reserve extra low memory, it is bad for people who do
> > not want it.
> 
> Let's see: we don't enable high by default because of old kexec-tools
> and some systems which do some funky reservations.
> 
> But this patch kinda enables high by trying a couple more regions.
> 
> So we don't really need this - we simply need to tell people to use high
> if it fails with KASLR, AFAICT.

Borris,

The testing I've done shows that the allocation failure caused by KASLR 
is intermittent.  On one SUT that I've seen this issue on, the crash
kernel allocation fails less than 10% of the time.

So even if a system administrator is diligent and tests
that a chosen kdump configuration works, that configuration
might not work on some random reboot 7 months in the future.
Unfortunately, that will be the time that the system crashes
and we won't be able to collect the crash dump due to the
crashkernel allocation failure.

Jerry

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
