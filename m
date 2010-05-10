Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OBP9M-0005Nu-OH
	for kexec@lists.infradead.org; Mon, 10 May 2010 09:19:45 +0000
Date: Mon, 10 May 2010 18:19:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools, ppc64: Fix segfault on parsing of large
	device trees.
Message-ID: <20100510091940.GA16856@verge.net.au>
References: <4BE78E06.6080601@ozlabs.org>
 <31392.1273467303@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31392.1273467303@neuling.org>
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

On Mon, May 10, 2010 at 02:55:03PM +1000, Michael Neuling wrote:
> 
> 
> In message <4BE78E06.6080601@ozlabs.org> you wrote:
> > 
> > ppc64's fs2dt used to use a fixed-size array into which the device tree
> > was parsed.  There was no bounds checking, so with a large device tree other
> > heap data ended up getting stomped -- SIGSEGV time.
> > 
> > This patch adds a function, 'dt_reserve', to check whether there's enough spa
> ce
> > left prior to writing data to the array.  If not, the array is realloced.
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> 
> FWIW...
> 
> Ack-by: Michael Neuling <mikey@neuling.org>
> 
> (also added linuxppc-dev@ozlabs.org to CC list)

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
