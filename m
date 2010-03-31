Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nx2tT-0003Q0-7D
	for kexec@lists.infradead.org; Wed, 31 Mar 2010 18:44:00 +0000
Subject: Re: [PATCH] amd iommu: force flush of iommu prior during shutdown
References: <20100331152417.GB13406@hmsreliant.think-freely.org>
	<20100331155430.GF14011@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 31 Mar 2010 11:43:33 -0700
In-Reply-To: <20100331155430.GF14011@redhat.com> (Vivek Goyal's message of
	"Wed\, 31 Mar 2010 11\:54\:30 -0400")
Message-ID: <m1d3ykwcve.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, joerg.roedel@amd.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Wed, Mar 31, 2010 at 11:24:17AM -0400, Neil Horman wrote:
>> Flush iommu during shutdown
>> 
>> When using an iommu, its possible, if a kdump kernel boot follows a primary
>> kernel crash, that dma operations might still be in flight from the previous
>> kernel during the kdump kernel boot.  This can lead to memory corruption,
>> crashes, and other erroneous behavior, specifically I've seen it manifest during
>> a kdump boot as endless iommu error log entries of the form:
>> AMD-Vi: Event logged [IO_PAGE_FAULT device=00:14.1 domain=0x000d
>> address=0x000000000245a0c0 flags=0x0070]
>> 
>> Followed by an inability to access hard drives, and various other resources.
>> 
>> I've written this fix for it.  In short it just forces a flush of the in flight
>> dma operations on shutdown, so that the new kernel is certain not to have any
>> in-flight dmas trying to complete after we've reset all the iommu page tables,
>> causing the above errors.  I've tested it and it fixes the problem for me quite
>> well.
>
> CCing Eric also.

Thanks.

> Neil, this is interesting. In the past we noticed similar issues,
> especially on PPC. But I was told that we could not clear the iommu
> mapping entries as we had no control on in flight DMA and if a DMA comes
> later after clearing an entry and entry is not present, it is an error.

Which is exactly what the reported error looks like.

> Hence one of the suggestions was not to clear iommu mapping entries but
> reserve some for kdump operation and use those in kdump kernel.
>
> So this call amd_iommu_flush_all_devices() will be able to tell devices
> that don't do any more DMAs and hence it is safe to reprogram iommu
> mapping entries.

I took a quick look at our crash shutdown path and I am very disappointed
with the way it has gone lately.

Regardless of the merits flushing an iommu versus doing things with an
iommu I don't see how we are in any better position in the crash kernel
then we are in the kdump kernel.  So what are we doing touching it
in the kdump path?

Likewise for the hpet.

We also seem to be at a point where if we have a tsc we don't need to
enable interrupts until we are ready to enable them in native mode.  And
except for a few weird SMP 486's tsc and apics came in at the same time.

So my grumpy code review says we should gut crash.c (like below) and
fix the initialization paths so they do the right thing.

---
 arch/x86/kernel/crash.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a4849c1..8e33c50 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -22,12 +22,10 @@
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
-#include <asm/hpet.h>
 #include <linux/kdebug.h>
 #include <asm/cpu.h>
 #include <asm/reboot.h>
 #include <asm/virtext.h>
-#include <asm/x86_init.h>
 
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
@@ -56,15 +54,11 @@ static void kdump_nmi_callback(int cpu, struct die_args *args)
 	 */
 	cpu_emergency_vmxoff();
 	cpu_emergency_svm_disable();
-
-	disable_local_APIC();
 }
 
 static void kdump_nmi_shootdown_cpus(void)
 {
 	nmi_shootdown_cpus(kdump_nmi_callback);
-
-	disable_local_APIC();
 }
 
 #else
@@ -96,17 +90,5 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	cpu_emergency_vmxoff();
 	cpu_emergency_svm_disable();
 
-	lapic_shutdown();
-#if defined(CONFIG_X86_IO_APIC)
-	disable_IO_APIC();
-#endif
-#ifdef CONFIG_HPET_TIMER
-	hpet_disable();
-#endif
-
-#ifdef CONFIG_X86_64
-	x86_platform.iommu_shutdown();
-#endif
-
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
-- 
1.6.5.2.143.g8cc62






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
