Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IsEUa-00009Q-Pq
	for kexec@lists.infradead.org; Wed, 14 Nov 2007 04:25:11 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAE9P3EH019692
	for <kexec@lists.infradead.org>; Wed, 14 Nov 2007 04:25:03 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lAE9P3SZ069832
	for <kexec@lists.infradead.org>; Wed, 14 Nov 2007 02:25:03 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAE9P3kN005903
	for <kexec@lists.infradead.org>; Wed, 14 Nov 2007 02:25:03 -0700
Date: Wed, 14 Nov 2007 12:09:39 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Timer interrupt lost on some x86_64 systems
Message-ID: <20071114063939.GA4349@in.ibm.com>
References: <20071107140006.GC14371@hmsendeavour.rdu.redhat.com>
	<20071112044903.GA6433@in.ibm.com>
	<20071112151721.GB11751@hmsendeavour.rdu.redhat.com>
	<20071112154119.GC11751@hmsendeavour.rdu.redhat.com>
	<20071113073128.GB24067@in.ibm.com>
	<20071113143330.GA16830@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071113143330.GA16830@hmsendeavour.rdu.redhat.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org

On Tue, Nov 13, 2007 at 09:33:30AM -0500, Neil Horman wrote:

[..]
> > In the past I have found issues with interrupt routing on IOPAPIC and
> > interrupt lockup on LAPIC. But these issues are already solved. I would
> > also think of priting LAPIC and IOAPIC entries to see how timer interrupt
> > routing changes from first kernel to second.
> > 
> I recently read the ioapic section in the opteron processor guide and noted the
> ioapic routing field in the config registers, so I'll be looking at that.  We
> also not that in the failing case on the systems in question the boot cpu is
> _not_ the cpu that boots the kdump kernel, and its APIC ID is 1 not 0, IIRC
> 

Failing on non-boot cpu should not be an issue. I had fixed an issue in the
past where non-boot cpu was not receiving the timer interrupts because of
IOAPIC settings where timer interrupts were always routed to boot cpu (cpu0).

Now it has been modified and while going down we determine which cpu we
are crashing on and setup IOAPIC entry accordingly. See disable_IO_APIC().

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
