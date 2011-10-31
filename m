Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RKlXs-0008Fh-Qm
	for kexec@lists.infradead.org; Mon, 31 Oct 2011 06:40:33 +0000
Date: Mon, 31 Oct 2011 15:40:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: s390: Fix memory detection for memory hotplug
Message-ID: <20111031064023.GB13246@verge.net.au>
References: <1319563037.3056.30.camel@br98xy6r>
	<20111026223126.GA9754@verge.net.au>
	<1319808935.4558.2.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1319808935.4558.2.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Fri, Oct 28, 2011 at 03:35:35PM +0200, Michael Holzheu wrote:
> Hello Simon,
> 
> Here comes the patch...
> 
> On Thu, 2011-10-27 at 07:31 +0900, Simon Horman wrote:
> > On Tue, Oct 25, 2011 at 07:17:17PM +0200, Michael Holzheu wrote:
> > > To fix this I could parse /sys/devices/system/memory and exclude each
> > > memory chunk that in not online from the /proc/iomem info. Do you think
> > > that this approach is fine or is there a better solution?
> > 
> > Hi Michael,
> > 
> > that sounds like a reasonable approach to me.
> > IIRC, kexec xen on ia64 makes use of an alternate iomem file,
> > and this seems to be another example of /proc/iomem not being
> > the right source of information.
> 
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> Currently on s390 for memory detection only the "/proc/iomem" file is used.
> This file does not include information on offlined memory chunks. With this
> patch the memory hotplug information is read from "/sys/devices/system/memory"
> and is added to the "/proc/iomem" info.
> 
> Also the MAX_MEMORY_RANGES count is increased to 1024 in order to support
> systems with many memory holes.

Thanks Michael, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
