Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Iwy5r-0005Ue-JR
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 10:55:13 +0000
Date: Tue, 27 Nov 2007 11:55:03 +0100
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071127105503.GD24223@one.firstfloor.org>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071127014740.GA28622@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, ebiederm@xmission.com

On Mon, Nov 26, 2007 at 08:47:40PM -0500, Neil Horman wrote:
> Hey all-
> 	I've been working on an issue lately involving multi socket x86_64
> systems connected via hypertransport bridges.  It appears that some systems,
> disable the hypertransport connections during a kdump operation when all but the
> crashing processor gets halted in machine_crash_shutdown.  This becomes a

That would be hard to believe. Linux cannot shut down CPUs
completely (put them back to SINIT state) because there is no generic
interface for this and it might be impossible. They just get put 
into a HLT loop.

And even if they were in SINIT they would still need the HT connections
otherwise it would be impossible to ever wake them up.

The way HT setup is normally done is that the BIOS sets it all up
and then it never changes (except for some error conditions that 
may cause SYNC flood) 


> problem when the ioapic attempts to route interrupts to the only remaining
> processor.  Even though the active processor is targeted for interrupt
> reception, the fact that the hypertransport connections are inactive result in
> interrupts not getting delivered.  The effective result is that timer interrupts
> are not delivered to the running cpu, and the system hangs on reboot into the
> kdump kernel during calibrate_delay.  I've found that I've been able to avoid
> this hang, by forcing a transition to the bios defined boot cpu during the
> crashing kernel shutdown.  This patch accomplished that.  Tested by myself and
> the origional reporter with successful results.

While that may help I doubt your analysis of the source of the problem
is correct. Most likely something is broken with the IO-APIC, but not
related to HyperTransport.

It would be better to properly root cause before applying.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
