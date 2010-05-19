Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OEX3R-00044v-KD
	for kexec@lists.infradead.org; Wed, 19 May 2010 00:22:35 +0000
Date: Wed, 19 May 2010 09:22:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec-tools, ppc64: Fix segfault parsing DR memory
	property
Message-ID: <20100519002227.GC8536@verge.net.au>
References: <4BECBE89.3020108@ozlabs.org>
 <23148.1274139032@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <23148.1274139032@neuling.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, Matt Evans <matt@ozlabs.org>

On Tue, May 18, 2010 at 09:30:32AM +1000, Michael Neuling wrote:
> 
> 
> In message <4BECBE89.3020108@ozlabs.org> you wrote:
> > add_dyn_reconf_usable_mem_property() iterates over memory spans
> > in /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory and intersects
> > these with usablemem_rgns ranges.  In doing so it used an unchecked
> > fixed-size array which will overrun on machines with lots of LMBs.
> > 
> > This patch removes the fixed-sized arrays from
> > add_dyn_reconf_usable_mem_property() and add_usable_mem_property(), in lieu o
> f
> > malloc/realloc/free.
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> 
> So this works our large P7 machine unlike the last one.
> 
> Acked-by: Michael Neuling <mikey@neuling.org>

Thanks, applied

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
