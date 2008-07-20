Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KKb5u-0003hL-Pu
	for kexec@lists.infradead.org; Sun, 20 Jul 2008 15:45:07 +0000
Date: Sun, 20 Jul 2008 17:44:56 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: linux-next: Tree for July 18: warning at kernel/lockdep.c:2068
	trace_hardirqs_on_caller
Message-ID: <20080720174456.55e41e8b@kopernikus.site>
In-Reply-To: <20080720150341.7cd381c2@kopernikus.site>
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
	<20080720150341.7cd381c2@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Vegard Nossum <vegard.nossum@gmail.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Greg KH <gregkh@suse.de>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

* Bernhard Walle <bwalle@suse.de> [2008-07-20 15:03]:
> 
> Because I didn't know that interface. And because I don't see that
> interface on my two systems that I just checked. i386 and x86-64. What
> do I have to do to enable that interface?

That interface depends on CONFIG_MEMORY_HOTPLUG. But given to that
dependency list,

128 config MEMORY_HOTPLUG
129         bool "Allow for memory hot-add"
130         depends on SPARSEMEM || X86_64_ACPI_NUMA
131         depends on HOTPLUG && !HIBERNATION && ARCH_ENABLE_MEMORY_HOTPLUG
132         depends on (IA64 || X86 || PPC64 || SUPERH || S390)

that interface is off on *many* systems (i386, x86_64), so we can't rely
on that interface in kexec. I think on POWER it's much more common than
on PC architectures.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
