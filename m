Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KKwrm-00055b-Lh
	for kexec@lists.infradead.org; Mon, 21 Jul 2008 14:59:59 +0000
Date: Mon, 21 Jul 2008 17:00:37 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: linux-next: Tree for July 18: warning at kernel/lockdep.c:2068
	trace_hardirqs_on_caller
Message-ID: <20080721170037.1a0046b1@halley.suse.de>
In-Reply-To: <20080721133937.GC4451@redhat.com>
References: <19f34abd0807190255x304173d4wf2bfabb2d5bce511@mail.gmail.com>
	<19f34abd0807190559y2fe5ebf9h7095793e82de3122@mail.gmail.com>
	<20080719221723.GB5578@suse.de>
	<19f34abd0807191527u61c5ed61kffe2279c8d46915d@mail.gmail.com>
	<19f34abd0807191544nfd73be5nf7dde4b61992a7e8@mail.gmail.com>
	<20080719225817.GA6264@suse.de>
	<19f34abd0807191611y7cabf405iad307ba79591e04f@mail.gmail.com>
	<1216544462.9311.20.camel@nimitz>
	<20080721131721.GB4451@redhat.com>
	<20080721152539.3d8684f9@halley.suse.de>
	<20080721133937.GC4451@redhat.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Vegard Nossum <vegard.nossum@gmail.com>, Greg KH <gregkh@suse.de>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org

* Vivek Goyal [2008-07-21 09:39]:
>
> On Mon, Jul 21, 2008 at 03:25:39PM +0200, Bernhard Walle wrote:
> > * Vivek Goyal [2008-07-21 09:17]:
> > > 
> > > Is /proc/iomem updated upon memory hotplug event.
> > 
> > Yes. I just checked that (yesterday).
> > 
> > I think it would make sense to extend /sys/firmware/memmap on
> > hot-plugging. Just because on reboot, the firmware will see that
> > memory, too, and report it. However, we need a way to discriminate the
> > originally firmware-provided memory map with later added memory. I'm
> > not sure how that can be done, I have to think about it.
> 
> Probably use another type of RAM identifier (System RAM (hotplug)).
> 
> But the point is, if /sys/devices/system/memory also represents all
> the physical memory present in the system then it might be not be
> justified to create another similar interface. (Until and unless there
> is something unique about /sys/firmware/memmap).

But I don't see anything like a physical address there:

  /sys/devices/system/memory/memory2:
  -r--r--r-- 1 root root 4096 2008-07-21 15:45 phys_device
  -r--r--r-- 1 root root 4096 2008-07-21 15:45 phys_index
  -rw-r--r-- 1 root root 4096 2008-07-21 15:45 state

(on a PPC64 machine where SUSE kernel has that interface enabled by
default).


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
