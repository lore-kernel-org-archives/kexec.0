Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RJC0T-000583-VP
	for kexec@lists.infradead.org; Wed, 26 Oct 2011 22:31:34 +0000
Date: Thu, 27 Oct 2011 07:31:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kdump: A memory hotplug issue on s390
Message-ID: <20111026223126.GA9754@verge.net.au>
References: <1319563037.3056.30.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1319563037.3056.30.camel@br98xy6r>
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

On Tue, Oct 25, 2011 at 07:17:17PM +0200, Michael Holzheu wrote:
> Hello Simon and Vivek,
> 
> For s390 we currently use /proc/iomem for defining the memory layout in
> the kexec elfcore header. Unfortunately this is not correct, when using
> memory hotplug. When a memory chunk is set offline (e.g. with "echo
> offline > /sys/devices/system/memory/memoryX/state") this is not
> reflected in /proc/iomem.
> 
> To fix this I could parse /sys/devices/system/memory and exclude each
> memory chunk that in not online from the /proc/iomem info. Do you think
> that this approach is fine or is there a better solution?

Hi Michael,

that sounds like a reasonable approach to me.
IIRC, kexec xen on ia64 makes use of an alternate iomem file,
and this seems to be another example of /proc/iomem not being
the right source of information.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
