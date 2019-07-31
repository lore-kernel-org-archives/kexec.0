Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 31 Jul 2019 17:32:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC v2 0/8] arm64: MMU enabled kexec relocation
Message-ID: <20190731163258.GH39768@lakrids.cambridge.arm.com>
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190731153857.4045-1-pasha.tatashin@soleen.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, james.morse@arm.com, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

Generally, the cover letter should state up-front what the goal is (or
what problem you're trying to solve). It would be really helpful to have
that so that we understand what you're trying to achieve, and why.

Messing with the MMU is often fraught with danger (and very painful to
debug, as you are now aware), and so far we've tried to minimize the
number of places where we have to do so.

On Wed, Jul 31, 2019 at 11:38:49AM -0400, Pavel Tatashin wrote:
> Changelog from previous RFC:
> - Added trans_table support for both hibernate and kexec.
> - Fixed performance issue, where enabling MMU did not yield the
>   actual performance improvement.
> 
> Bug:
> With the current state, this patch series works on kernels booted with EL1
> mode, but for some reason, when elevated to EL2 mode reboot freezes in
> both QEMU and on real hardware.
> 
> The freeze happens in:
> 
> arch/arm64/kernel/relocate_kernel.S
> 	turn_on_mmu()
> 
> Right after sctlr_el2 is written (MMU on EL2 is enabled)
> 
> 	msr     sctlr_el2, \tmp1
> 
> I've been studying all the relevant control registers for EL2, but do not
> see what might be causing this hang:
> 
> MAIR_EL2 is set to be exactly the same as MAIR_EL1 0xbbff440c0400
> 
> TCR_EL2        0x80843510
> Enabled bits:
> PS      Physical Address Size. (0b100   44 bits, 16TB.)
> SH0     Shareability    11 Inner Shareable
> ORGN0   Normal memory, Outer Write-Back Read-Allocate Write-Allocate Cach.
> IRGN0   Normal memory, Inner Write-Back Read-Allocate Write-Allocate Cach.
> T0SZ    01 0000
> 
> SCTLR_EL2	0x30e5183f
> RES1    : Reserve ones
> M       : MMU enabled
> A       : Align check
> C       : Cacheability control
> SA      : SP Alignment check enable
> IESB    : Implicit Error Synchronization event
> I       : Instruction access Cacheability
> 
> TTBR0_EL2      0x1b3069000 (address of trans_table)
> 
> Any suggestion of what else might be missing that causes this freeze when
> MMU is enabled in EL2?
> 
> =====

> Here is the current data from the real hardware:
> (because of bug, I forced EL1 mode by setting el2_switch always to zero in
> cpu_soft_restart()):
> 
> For this experiment, the size of kernel plus initramfs is 25M. If initramfs
> was larger, than the improvements would be even greater, as time spent in
> relocation is proportional to the size of relocation.
> 
> Previously:
> kernel shutdown	0.022131328s
> relocation	0.440510736s
> kernel startup	0.294706768s

In total this takes ~0.76s...

> 
> Relocation was taking: 58.2% of reboot time
> 
> Now:
> kernel shutdown	0.032066576s
> relocation	0.022158152s
> kernel startup	0.296055880s

... and this takes ~0.35s

So do we really need this complexity for a few blinks of an eye?

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
