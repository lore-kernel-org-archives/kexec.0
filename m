From: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Fri, 29 Apr 2022 22:45:14 +0100
Subject: [PATCH 02/30] ARM: kexec: Disable IRQs/FIQs also on crash CPUs
 shutdown path
In-Reply-To: <71d829c4-b280-7d6e-647d-79a1baf9408b@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-3-gpiccoli@igalia.com>
 <87mtg392fm.wl-maz@kernel.org>
 <71d829c4-b280-7d6e-647d-79a1baf9408b@igalia.com>
Message-ID: <Ymxcaqy6DwhoQrZT@shell.armlinux.org.uk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Apr 29, 2022 at 06:38:19PM -0300, Guilherme G. Piccoli wrote:
> Thanks Marc and Michael for the review/discussion.
> 
> On 29/04/2022 15:20, Marc Zyngier wrote:
> > [...]
> 
> > My expectations would be that, since we're getting here using an IPI,
> > interrupts are already masked. So what reenabled them the first place?
> > 
> > Thanks,
> > 
> > 	M.
> > 
> 
> Marc, I did some investigation in the code (and tried/failed in the ARM
> documentation as well heh), but this is still not 100% clear for me.
> 
> You're saying IPI calls disable IRQs/FIQs by default in the the target
> CPUs? Where does it happen? I'm a bit confused if this a processor
> mechanism, or it's in code.

When we taken an IRQ, IRQs will be masked, FIQs will not. IPIs are
themselves interrupts, so IRQs will be masked while the IPI is being
processed. Therefore, there should be no need to re-disable the
already disabled interrupts.

> But crash_smp_send_stop() is different, it seems to IPI the other CPUs
> with the flag IPI_CALL_FUNC, which leads to calling
> generic_smp_call_function_interrupt() - does it disable interrupts/FIQs
> as well? I couldn't find it.

It's buried in the architecture behaviour. When the CPU takes an
interrupt and jumps to the interrupt vector in the vectors page, it is
architecturally defined that interrupts will be disabled. If they
weren't architecturally disabled at this point, then as soon as the
first instruction is processed (at the interrupt vector, likely a
branch) the CPU would immediately take another jump to the interrupt
vector, and this process would continue indefinitely, making interrupt
handling utterly useless.

So, you won't find an explicit instruction in the code path from the
vectors to the IPI handler that disables interrupts - because it's
written into the architecture that this is what must happen.

IRQs are a lower priority than FIQs, so FIQs remain unmasked.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

