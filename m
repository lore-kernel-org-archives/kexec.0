Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KKYZo-0005vv-93
	for kexec@lists.infradead.org; Sun, 20 Jul 2008 13:03:49 +0000
Date: Sun, 20 Jul 2008 15:03:41 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: linux-next: Tree for July 18: warning at kernel/lockdep.c:2068
	trace_hardirqs_on_caller
Message-ID: <20080720150341.7cd381c2@kopernikus.site>
In-Reply-To: <1216544462.9311.20.camel@nimitz>
References: <20080718195352.e562a00f.sfr@canb.auug.org.au>
	<200807190928.33978.m.kozlowski@tuxland.pl>
	<19f34abd0807190255x304173d4wf2bfabb2d5bce511@mail.gmail.com>
	<19f34abd0807190559y2fe5ebf9h7095793e82de3122@mail.gmail.com>
	<20080719221723.GB5578@suse.de>
	<19f34abd0807191527u61c5ed61kffe2279c8d46915d@mail.gmail.com>
	<19f34abd0807191544nfd73be5nf7dde4b61992a7e8@mail.gmail.com>
	<20080719225817.GA6264@suse.de>
	<19f34abd0807191611y7cabf405iad307ba79591e04f@mail.gmail.com>
	<1216544462.9311.20.camel@nimitz>
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
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Vegard Nossum <vegard.nossum@gmail.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Greg KH <gregkh@suse.de>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

* Dave Hansen <dave@linux.vnet.ibm.com> [2008-07-20 02:01]:
>
> It is possible that it could run later.  But, I do know that there are
> at least a couple of these tables (on various arches) that we toss out
> of memory or become unavailable later in boot.  
> 
> I do this this:
> 
>     sysfs: add /sys/firmware/memmap
> 
> is really being done at the wrong level.

I posted that patches multiple times. They were reviewed by the kdump
maintainer and by the kexec maintainer. Why didn't you mention it
*there* that this is the wrong way?

> I don't, for instance, see
> *any* reference to memory hotplug in these patches.

Right. The idea was to add memory hotplugging later. I decided to
create the patch series, get some review, and then fix the rest of the
systems that use memory hot-plugging. So, do you see a problem (in
theory) to add memory and remove memory in that sysfs interface? Of
course the code must be extended to handle modifications in the linked
list afterwards. Yes, I should have made that extension just after the
patch went into tip. Unfortunately, I didn't have time so far.

> Secondly, why don't we just modify the existing /sys/devices/system/memory

Because I didn't know that interface. And because I don't see that
interface on my two systems that I just checked. i386 and x86-64. What
do I have to do to enable that interface?

Does that interface export the *used* memory or just export the memory
that is available? Because exactly that was the reason why I made that
modification -- because kexec needs to know the *available* memory even
if that memory is disabled via 'memmap' or 'mem' command line
parameters.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
