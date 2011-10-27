Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RJTku-0005Rn-W2
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 17:28:43 +0000
Date: Thu, 27 Oct 2011 13:28:22 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kdump: A memory hotplug issue on s390
Message-ID: <20111027172822.GI7491@redhat.com>
References: <1319563037.3056.30.camel@br98xy6r>
	<20111026223126.GA9754@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111026223126.GA9754@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org

On Thu, Oct 27, 2011 at 07:31:26AM +0900, Simon Horman wrote:
> On Tue, Oct 25, 2011 at 07:17:17PM +0200, Michael Holzheu wrote:
> > Hello Simon and Vivek,
> > 
> > For s390 we currently use /proc/iomem for defining the memory layout in
> > the kexec elfcore header. Unfortunately this is not correct, when using
> > memory hotplug. When a memory chunk is set offline (e.g. with "echo
> > offline > /sys/devices/system/memory/memoryX/state") this is not
> > reflected in /proc/iomem.
> > 
> > To fix this I could parse /sys/devices/system/memory and exclude each
> > memory chunk that in not online from the /proc/iomem info. Do you think
> > that this approach is fine or is there a better solution?
> 
> Hi Michael,
> 
> that sounds like a reasonable approach to me.
> IIRC, kexec xen on ia64 makes use of an alternate iomem file,
> and this seems to be another example of /proc/iomem not being
> the right source of information.

Agree that it sounds reasonable. I have never used /sys/devices/memory/
interface. So does it work realiably and how long has it been working
reliably?

Secondly we should do this only for kdump and not for kexec. If some
memory is offlined, then we still want to use it in case of kexec.

What's the meaning of various entries. I see lots of memory[1-n] entries
in my system and under memory0/ dir I see following.

[memory0]# grep ".*" *
end_phys_index:00000000
phys_device:0
phys_index:00000000
removable:0
state:online

What does it mean. Is memory0 representing a chunk of physical memory? If
yes, then where does the segment start and where does it end. Everything
seems to be zero.

So is it representing chunk0 of memory. So both starting and end index
are 0. But where is the chunk size mentioned?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
