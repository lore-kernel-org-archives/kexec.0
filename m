From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 29 Apr 2022 18:56:24 -0300
Subject: [PATCH 02/30] ARM: kexec: Disable IRQs/FIQs also on crash CPUs
 shutdown path
In-Reply-To: <Ymxcaqy6DwhoQrZT@shell.armlinux.org.uk>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-3-gpiccoli@igalia.com> <87mtg392fm.wl-maz@kernel.org>
 <71d829c4-b280-7d6e-647d-79a1baf9408b@igalia.com>
 <Ymxcaqy6DwhoQrZT@shell.armlinux.org.uk>
Message-ID: <32495ca6-d79a-a932-a8e3-19ef54c44c48@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 29/04/2022 18:45, Russell King (Oracle) wrote:
> [...]
>> Marc, I did some investigation in the code (and tried/failed in the ARM
>> documentation as well heh), but this is still not 100% clear for me.
>>
>> You're saying IPI calls disable IRQs/FIQs by default in the the target
>> CPUs? Where does it happen? I'm a bit confused if this a processor
>> mechanism, or it's in code.
> 
> When we taken an IRQ, IRQs will be masked, FIQs will not. IPIs are
> themselves interrupts, so IRQs will be masked while the IPI is being
> processed. Therefore, there should be no need to re-disable the
> already disabled interrupts.
> 
>> But crash_smp_send_stop() is different, it seems to IPI the other CPUs
>> with the flag IPI_CALL_FUNC, which leads to calling
>> generic_smp_call_function_interrupt() - does it disable interrupts/FIQs
>> as well? I couldn't find it.
> 
> It's buried in the architecture behaviour. When the CPU takes an
> interrupt and jumps to the interrupt vector in the vectors page, it is
> architecturally defined that interrupts will be disabled. If they
> weren't architecturally disabled at this point, then as soon as the
> first instruction is processed (at the interrupt vector, likely a
> branch) the CPU would immediately take another jump to the interrupt
> vector, and this process would continue indefinitely, making interrupt
> handling utterly useless.
> 
> So, you won't find an explicit instruction in the code path from the
> vectors to the IPI handler that disables interrupts - because it's
> written into the architecture that this is what must happen.
> 
> IRQs are a lower priority than FIQs, so FIQs remain unmasked.
> 

Thanks a lot for the *great* explanation Russell, much appreciated.
So, this leads to the both following questions:

a) Shall we then change the patch to only disable FIQs, since it's panic
path and we don't want secondary CPUs getting interrupted, but only
spinning quietly "forever"?

b) How about cleaning ipi_cpu_stop() then, by dropping the call to
local_irq_disable() there, to avoid the double IRQ disabling?

Thanks,


Guilherme

