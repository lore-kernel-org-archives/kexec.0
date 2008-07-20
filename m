Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KKUn1-0000LW-CH
	for kexec@lists.infradead.org; Sun, 20 Jul 2008 09:01:11 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6K917mq022903
	for <kexec@lists.infradead.org>; Sun, 20 Jul 2008 05:01:07 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6K916tK175498
	for <kexec@lists.infradead.org>; Sun, 20 Jul 2008 05:01:07 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6K916LW003725
	for <kexec@lists.infradead.org>; Sun, 20 Jul 2008 05:01:06 -0400
Subject: Re: linux-next: Tree for July 18: warning at kernel/lockdep.c:2068
	trace_hardirqs_on_caller
From: Dave Hansen <dave@linux.vnet.ibm.com>
In-Reply-To: <19f34abd0807191611y7cabf405iad307ba79591e04f@mail.gmail.com>
References: <20080718195352.e562a00f.sfr@canb.auug.org.au>
	<200807190928.33978.m.kozlowski@tuxland.pl>
	<19f34abd0807190255x304173d4wf2bfabb2d5bce511@mail.gmail.com>
	<19f34abd0807190559y2fe5ebf9h7095793e82de3122@mail.gmail.com>
	<20080719221723.GB5578@suse.de>
	<19f34abd0807191527u61c5ed61kffe2279c8d46915d@mail.gmail.com>
	<19f34abd0807191544nfd73be5nf7dde4b61992a7e8@mail.gmail.com>
	<20080719225817.GA6264@suse.de>
	<19f34abd0807191611y7cabf405iad307ba79591e04f@mail.gmail.com>
Date: Sun, 20 Jul 2008 02:01:02 -0700
Message-Id: <1216544462.9311.20.camel@nimitz>
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
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Pekka Enberg <penberg@cs.helsinki.fi>, Greg KH <gregkh@suse.de>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@redhat.com>

On Sun, 2008-07-20 at 01:11 +0200, Vegard Nossum wrote:
> Maybe the firmware memmap code can simply run a little later in the
> boot sequence?

Heh, I'm catching up on this thread...

It is possible that it could run later.  But, I do know that there are
at least a couple of these tables (on various arches) that we toss out
of memory or become unavailable later in boot.  

I do this this:

    sysfs: add /sys/firmware/memmap

is really being done at the wrong level.  I don't, for instance, see
*any* reference to memory hotplug in these patches.  That's because
they're done against firmware structures, and memory hotplug doesn't
update firmware structures on the two architectures that I can remember
(ppc64 and x86).

In other words, kexec using this probably won't work on a memory hotplug
machine.

Secondly, why don't we just modify the
existing /sys/devices/system/memory things to properly export what exec
needs?  They're already cross-platform *and* they're updated with memory
hotplug events.  

-- Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
