Return-path: <kexec-bounces@lists.infradead.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IkcAF-0000lv-8T
	for kexec@lists.infradead.org; Wed, 24 Oct 2007 10:04:39 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9O91M2S000392
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 05:01:22 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9O91L32136588
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 05:01:21 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9O91LK7011341
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 05:01:21 -0400
Date: Wed, 24 Oct 2007 14:31:28 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 2/3] x86: add safe_smp_processor_id for x86_64
Message-ID: <20071024090128.GA4809@in.ibm.com>
References: <47195763.1090803@ct.jp.nec.com> <47195876.7080208@ct.jp.nec.com>
	<20071024063141.GB4622@in.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071024063141.GB4622@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces@lists.infradead.org
To: h-shimamoto@ct.jp.nec.com
Cc: hbabu@us.ibm.com, tglx@linutronix.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>

On Wed, Oct 24, 2007 at 12:01:41PM +0530, Vivek Goyal wrote:
> On Fri, Oct 19, 2007 at 06:23:02PM -0700, Hiroshi Shimamoto wrote:
> > From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> > 
> > Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> > ---
> >  include/asm-x86/smp_64.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/asm-x86/smp_64.h b/include/asm-x86/smp_64.h
> > index 6f0e027..ab612b0 100644
> > --- a/include/asm-x86/smp_64.h
> > +++ b/include/asm-x86/smp_64.h
> > @@ -76,6 +76,8 @@ extern unsigned __cpuinitdata disabled_cpus;
> > 
> >  #endif /* CONFIG_SMP */
> > 
> > +#define safe_smp_processor_id()		smp_processor_id()
> > +
> 
> Can you please implement a patch for safe_smp_processor_id() instead of
> using smp_processor_id(). safe_smp_processor_id() was introduced to make
> sure that we are not dependent on the stack of threads after kernel has
> crashed instead read the apic id and convert it to cpu id with other
> data structures. This helped in stack overflow case.
> 
> Hardcoding it to smp_processor_id() will give the false impression.
> 

Just now Aneesh pointed that x86_64 using pda for retrieving processor id
and not kernel stack.

I think it is fine then.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
