Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R0QlR-0007Et-Uq
	for kexec@lists.infradead.org; Mon, 05 Sep 2011 04:26:32 +0000
Date: Mon, 5 Sep 2011 13:25:50 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [RFC] sh: kexec: Register crashk_res
Message-ID: <20110905042547.GA22069@verge.net.au>
References: <1314935232-1545-1-git-send-email-horms@verge.net.au>
	<20110905032352.GA22142@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110905032352.GA22142@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: kexec@lists.infradead.org, linux-sh@vger.kernel.org

On Mon, Sep 05, 2011 at 12:23:53PM +0900, Paul Mundt wrote:
> On Fri, Sep 02, 2011 at 12:47:12PM +0900, Simon Horman wrote:
> > Register crashk_res so that it can be used by kexec-tools
> > via /proc/iomem.
> > 
> > On x86 the registration occurs using
> > insert_resource(&iomem_resource, &crashk_res).
> > However that approach seems to result in the boot hanging on SH.
> > 
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> x86 has a slightly more straightforward registration method. We end up
> going through the same path for all memory ranges, which also
> encapsulates the NUMA case. As such, we don't necessarily know which
> range will contain the resource in question, so it's attempted on each
> range addition, expecting the resource manager to work things out for us.
> 
> With the request_resource() in place you presumably see the crash kernel
> resource where you expect it to in /proc/iomem?

Yes. With this patch in place the crash kernel resource
shows up in /proc/iomem in a sensible way.

# cat /proc/iomem 
40000000-4effffff : System RAM
 40001000-402dbfc7 : Kernel code
 402dbfc8-403cd51f : Kernel data
 40553000-40568c5b : Kernel bss
 4d000000-4effffff : Crash kernel
...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
