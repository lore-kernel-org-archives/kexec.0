Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QlJbF-0004pG-09
	for kexec@lists.infradead.org; Mon, 25 Jul 2011 11:45:29 +0000
Date: Mon, 25 Jul 2011 20:45:21 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: powerpc: dt_reserve doesn't allocate enough
	memory for large properties
Message-ID: <20110725114521.GD7390@verge.net.au>
References: <20110725173542.2abe960e@kryten>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110725173542.2abe960e@kryten>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Anton Blanchard <anton@samba.org>
Cc: kexec@lists.infradead.org

On Mon, Jul 25, 2011 at 05:35:42PM +1000, Anton Blanchard wrote:
> 
> On a large ppc64 box I got the following error from kexec -l: 
> 
> unrecoverable error: could not read "/proc/device-tree/ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory": Bad address
> 
> dt_reserve was assuming a property was never larger than
> INIT_TREE_WORDS (65536), but on this box ibm,dynamic-memory is
> 119995 words.
> 
> Allocate INIT_TREE_WORDS or the number of words requested, whatever

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
