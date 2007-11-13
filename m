Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IrqF0-0002JB-Hb
	for kexec@lists.infradead.org; Tue, 13 Nov 2007 02:31:29 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAD7VLBk025501
	for <kexec@lists.infradead.org>; Tue, 13 Nov 2007 02:31:21 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAD7VLNX493530
	for <kexec@lists.infradead.org>; Tue, 13 Nov 2007 02:31:21 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAD7VLvZ009953
	for <kexec@lists.infradead.org>; Tue, 13 Nov 2007 02:31:21 -0500
Date: Tue, 13 Nov 2007 13:01:28 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Timer interrupt lost on some x86_64 systems
Message-ID: <20071113073128.GB24067@in.ibm.com>
References: <20071107140006.GC14371@hmsendeavour.rdu.redhat.com>
	<20071112044903.GA6433@in.ibm.com>
	<20071112151721.GB11751@hmsendeavour.rdu.redhat.com>
	<20071112154119.GC11751@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071112154119.GC11751@hmsendeavour.rdu.redhat.com>
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

On Mon, Nov 12, 2007 at 10:41:19AM -0500, Neil Horman wrote:
[..]
> 
> 
> Although, as I look at it, it would appear that time_init from start_kernel does
> seem to init the hpet if its available, and it silently fails if that doesn't
> work, moving on to the pmtimer and pit.  I wonder if there is some extra magic
> to resetting the hpet to run on a different cpu for some systems...
> Neil
> 

Any idea what kind of timer devices this motherborad has got? Which timer
device gets activated in first kernel? Then we can focus on why the
interrupts from same device are not coming in second kernel.

In the past I have found issues with interrupt routing on IOPAPIC and
interrupt lockup on LAPIC. But these issues are already solved. I would
also think of priting LAPIC and IOAPIC entries to see how timer interrupt
routing changes from first kernel to second.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
