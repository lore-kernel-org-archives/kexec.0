Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from barikada.upol.cz ([158.194.242.200])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IaeXb-0000Kr-AR
	for kexec@lists.infradead.org; Wed, 26 Sep 2007 17:35:40 -0400
Date: Wed, 26 Sep 2007 23:32:20 +0200
Subject: reviewed (Re: [patch 1/7] Extended crashkernel command line)
Message-ID: <20070926213220.GH28809@flower.upol.cz>
References: <20070925182257.900701776@strauss.suse.de>
	<20070925182258.175348676@strauss.suse.de>
	<E1IaHPU-00089b-Bc@flower> <20070926161602.GA26909@suse.de>
	<20070926181843.GB24301@flower.upol.cz>
	<20070926210533.GA1299@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070926210533.GA1299@suse.de>
From: Oleg Verych <olecom@flower.upol.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Bernhard Walle (in kexec list)" <kexec@lists.infradead.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Wed, Sep 26, 2007 at 11:05:33PM +0200, Bernhard Walle:
> * Oleg Verych <olecom@flower.upol.cz> [2007-09-26 20:18]:
> > > 
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -1172,33 +1172,50 @@ static int __init parse_crashkernel_mem(
> > >  	do {
> > >  		unsigned long long start = 0, end = ULLONG_MAX;
> > >  		unsigned long long size = -1;
> > 
> > no need in assigning values here, unless you plan to use them in case
> > of `return -EINVAL', but i can not see that,
> 
> What about this (and yes, I tested with some wrong strings with Qemu):

Reviewed-by: Oleg Verych <olecom@flower.upol.cz>

Thanks :D

> ----
> 
> This patch improves error handling in parse_crashkernel_mem() by comparing
> the return pointer of memparse() with the input pointer and also replaces
> all printk(KERN_WARNING msg) with pr_warning(msg).
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
_____

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
