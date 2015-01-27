Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 27 Jan 2015 16:46:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/8] arm64: Add EL2 switch to soft_restart
Message-ID: <20150127164619.GL17721@leverpostej>
References: <cover.1421449714.git.geoff@infradead.org>
 <bb44d4eee4fab15278e4a8829a0981878bc9acd7.1421449714.git.geoff@infradead.org>
 <20150126190223.GO23313@leverpostej>
 <1422308928.21823.16.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422308928.21823.16.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jan 26, 2015 at 09:48:48PM +0000, Geoff Levand wrote:
> Hi Mark,
> 
> On Mon, 2015-01-26 at 19:02 +0000, Mark Rutland wrote:
> > On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> > > When a CPU is reset it needs to be put into the exception level it had when it
> > > entered the kernel.  Update cpu_reset() to accept an argument el2_switch which
> > > signals cpu_reset() to enter the soft reset address at EL2.  If el2_switch is
> > > not set the soft reset address will be entered at EL1.
> > > 
> > > Update cpu_soft_restart() and soft_restart() to pass the return of
> > > is_hyp_mode_available() as the el2_switch value to cpu_reset().  Also update the
> > > comments of cpu_reset(), cpu_soft_restart() and soft_restart() to reflect this
> > > change.
> > > 
> > > Signed-off-by: Geoff Levand <geoff@infradead.org>
> > > ---
> > >  arch/arm64/include/asm/proc-fns.h |  4 ++--
> > >  arch/arm64/kernel/process.c       | 10 ++++++++-
> > >  arch/arm64/mm/proc.S              | 47 +++++++++++++++++++++++++++++----------
> > >  3 files changed, 46 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
> > > index 9a8fd84..339394d 100644
> > > --- a/arch/arm64/include/asm/proc-fns.h
> > > +++ b/arch/arm64/include/asm/proc-fns.h
> > > @@ -32,8 +32,8 @@ extern void cpu_cache_off(void);
> > >  extern void cpu_do_idle(void);
> > >  extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
> > >  extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
> > > -void cpu_soft_restart(phys_addr_t cpu_reset,
> > > -		unsigned long addr) __attribute__((noreturn));
> > > +void cpu_soft_restart(phys_addr_t cpu_reset, unsigned long el2_switch,
> > > +		      unsigned long addr) __attribute__((noreturn));
> > >  extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
> > >  extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
> > >  
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index fde9923..371bbf1 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -50,6 +50,7 @@
> > >  #include <asm/mmu_context.h>
> > >  #include <asm/processor.h>
> > >  #include <asm/stacktrace.h>
> > > +#include <asm/virt.h>
> > >  
> > >  #ifdef CONFIG_CC_STACKPROTECTOR
> > >  #include <linux/stackprotector.h>
> > > @@ -60,7 +61,14 @@ EXPORT_SYMBOL(__stack_chk_guard);
> > >  void soft_restart(unsigned long addr)
> > >  {
> > >  	setup_mm_for_reboot();
> > > -	cpu_soft_restart(virt_to_phys(cpu_reset), addr);
> > > +
> > > +	/* TODO: Remove this conditional when KVM can support CPU restart. */
> > > +	if (IS_ENABLED(CONFIG_KVM))
> > > +		cpu_soft_restart(virt_to_phys(cpu_reset), 0, addr);
> > 
> > If we haven't torn down KVM, doesn't that mean that KVM is active at EL2
> > (with MMU and caches on) at this point?
> > 
> > If that's the case then we cannot possibly try to call kexec(), because
> > we cannot touch the memory used by the page tables for those EL2
> > mappings. Things will explode if we do.
> 
> This conditional is just if KVM, do things the old way (don't try to
> switch exception levels).  It is to handle the system shutdown case.

Having grepped treewide for soft_restart, other than kexec there are no
users for arm64. So surely kexec is the only case to cater for at the
moment?

> Another patch in this series '[PATCH 7/8] arm64/kexec: Add checks for
> KVM' assures kexec cannot happen when KVM is configured.

It would be better to just move this earlier (or event better, implement
kvm teardown).

Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
