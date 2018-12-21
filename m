Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFDt-0001eB-6M
 for kexec@lists.infradead.org; Fri, 21 Dec 2018 07:27:55 +0000
Date: Fri, 21 Dec 2018 15:27:36 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCHv2] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20181221072736.GB2526@MiWiFi-R3L-srv>
References: <1544760446-506-1-git-send-email-kernelfans@gmail.com>
 <20181221071823.GA2526@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221071823.GA2526@MiWiFi-R3L-srv>
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
To: Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: yinghai@kernel.org, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, vgoyal@redhat.com, kexec@lists.infradead.org

On 12/21/18 at 03:18pm, Baoquan He wrote:
> On 12/14/18 at 12:07pm, Pingfan Liu wrote:
> > Customer reported a bug on a high end server with many pcie devices, where
> > kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> > though we still see much memory under 896 MB, the finding still failed
> > intermittently. Because currently we can only find region under 896 MB,
> > if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> > randomly, and crashkernel reservation need be aligned to 128 MB, that's
> > why failure is found. It raises confusion to the end user that sometimes
> > crashkernel=X works while sometimes fails.
> > If want to make it succeed, customer can change kernel option to
> > "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> > limited space to behave even though its grammer looks more generic.
> > And we can't answer questions raised from customer that confidently:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> > 
> > This patch simplifies the method suggested in the mail [1]. It just goes
> > bottom-up to find a candidate region for crashkernel. The bottom-up may be
> > better compatible with the old reservation style, i.e. still want to get
> > memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.
> > 
> > There is one trivial thing about the compatibility with old kexec-tools:
> > if the reserved region is above 896M, then old tool will fail to load
> > bzImage. But without this patch, the old tool also fail since there is no
> > memory below 896M can be reserved for crashkernel.
> > 
> > [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: kexec@lists.infradead.org
> > 
> > ---
> > v1->v2:
> >   improve commit log
> >  arch/x86/kernel/setup.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> This is a bug fix and urged by our customer.
> 
> I personally think crashkernel=xx@ is a generic synctax, the current
                                 ~~ s/@/M
> code making it search only under 896 MB seems not so reasonable.
> 
> Ack this patch.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks
> Baoquan
> 
> > 
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index d494b9b..60f12c4 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
> >  
> >  	/* 0 means: find the address automatically */
> >  	if (crash_base <= 0) {
> > +		if (!memblock_bottom_up())
> > +			memblock_set_bottom_up(true);
> >  		/*
> >  		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> >  		 * as old kexec-tools loads bzImage below that, unless
> >  		 * "crashkernel=size[KMG],high" is specified.
> >  		 */
> >  		crash_base = memblock_find_in_range(CRASH_ALIGN,
> > -						    high ? CRASH_ADDR_HIGH_MAX
> > -							 : CRASH_ADDR_LOW_MAX,
> > -						    crash_size, CRASH_ALIGN);
> > +			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
> > +		if (!memblock_bottom_up())
> > +			memblock_set_bottom_up(false);
> > +
> >  		if (!crash_base) {
> >  			pr_info("crashkernel reservation failed - No suitable area found.\n");
> >  			return;
> > -- 
> > 2.7.4
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
