Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nz22I-0005C8-Jd
	for kexec@lists.infradead.org; Tue, 06 Apr 2010 06:13:19 +0000
Date: Tue, 6 Apr 2010 16:12:52 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/7] powerpc32: pull in libfdt
Message-ID: <20100406061251.GA10387@verge.net.au>
References: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
	<1270023858-26947-4-git-send-email-sebastian@breakpoint.cc>
	<20100331225819.GC10909@verge.net.au>
	<20100401070559.GA20047@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100401070559.GA20047@Chamillionaire.breakpoint.cc>
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
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: kexec@lists.infradead.org

On Thu, Apr 01, 2010 at 09:05:59AM +0200, Sebastian Andrzej Siewior wrote:
> * Simon Horman | 2010-04-01 09:58:19 [+1100]:
> 
> >Hi,
> Hi,
> 
> >I'm seeing some signed vs unsigned comparison warnings in this code.
> >Here is a stab that I took at fixing them. Do they seem reasonable to you?
> All but fdt_create() and fdt_strerror() look fine on the first look. The
> two mentioned don't have the .c file updated. fdt_strerror() should
> remain unsigned as the error code is negative.
> 
> >If so, we could either merge them into your patch or just apply them
> >as another patch.
> I would prefer leaving it as it. It is an external library and the time
> we update it, we lose this changes. If you are going to compile this
> with -Werror could you add -Wno-sign-compare for the libfdt part? If not
> please apply it as a separate patch and I try to forward it upstream if
> you don't.

Ok, how about we a) merge your changes as is and b) try and get a patch
upstream that we add to kexec-tools later. I understand your reasoning
behind not wanting to diverge from libfdt-upstream, but at the same
time, I'd like to get this fixed if possible.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
