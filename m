Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QXENB-00018T-L5
	for kexec@lists.infradead.org; Thu, 16 Jun 2011 15:20:47 +0000
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: Re: [PATCH v2] generic-ipi: Initialize call_single_queue before
	enabling interrupt
Date: Thu, 16 Jun 2011 11:19:30 -0400
MIME-Version: 1.0
In-Reply-To: <D6CBEE2F420741indou.takao@jp.fujitsu.com>
References: <D6CBEE2F420741indou.takao@jp.fujitsu.com>
Message-Id: <ABCC2C38C9CAC4indou.takao@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Milton Miller <miltonm@bga.com>, WANG Cong <xiyou.wangcong@gmail.com>, Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Just a reminder...

Thanks for acks, but I'm still waiting for inclusion.
I tested 3.0.0-rc3 and kdump still failed due to pending IPI
from 1st kernel. Need this patch to fix it.

Thanks,
Takao Indoh

On Tue, 29 Mar 2011 12:35:04 -0400, Takao Indoh wrote:

>Hi all,
>
>This patch renames init_call_single_data() to call_function_init() and
>calls it in start_kernel() so that call_single_queue can be initialized
>before enabling interrupt.
>
>There is a problem that kdump(2nd kernel) sometimes hangs up due to
>pending IPI from 1st kernel. Kernel panic occurs because IPI comes
>before call_single_queue is initialized. The details are as follows.
>(1) 2nd kernel boot up
>(2) A pending IPI from 1st kernel comes when irqs are first enabled
>    in start_kernel().
>(3) Kernel tries to handle the interrupt, but call_single_queue is not
>    initialized yet at this point. As a result, in the
>    generic_smp_call_function_single_interrupt(), NULL pointer
>    dereference occurs when list_replace_init() tries to access
>    &q->list.next.
>Therefore this patch changes the name of init_call_single_data() to
>call_function_init() and calls it before local_irq_enable() in
>start_kernel().
>
>v2:
>- Rename init_call_single_data() to call_function_init() and calls it in
>  start_kernel()
>- Change insert position in start_kernel().
>- Adjust for CONFIG_SMP/CONFIG_USE_GENERIC_SMP_HELPERS options
>- Rebased to Linus's latest tree
>
>v1:
>https://lkml.org/lkml/2011/3/25/317
>- Divide init_call_single_data() into two functions,
>   o init_call_single_data: initialize call_single_queue
>   o init_hotplug_cfd: initialize hotplug_cfd_notifier
>  And call init_call_single_data before local_irq_enable() in
>  start_kernel().
>
>v0:
>https://lkml.org/lkml/2011/3/23/417
>- In generic_smp_call_function_single_interrupt(), check if
>  call_single_queue was initialized or not, and just return if not
>  initialized.
>
>Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
>---
> include/linux/smp.h |    5 ++++-
> init/main.c         |    1 +
> kernel/smp.c        |    5 +----
> 3 files changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/smp.h b/include/linux/smp.h
>index 74243c8..4fb3eac 100644
>--- a/include/linux/smp.h
>+++ b/include/linux/smp.h
>@@ -85,12 +85,15 @@ int smp_call_function_any(const struct cpumask *mask,
>  * Generic and arch helpers
>  */
> #ifdef CONFIG_USE_GENERIC_SMP_HELPERS
>+void __init call_function_init(void);
> void generic_smp_call_function_single_interrupt(void);
> void generic_smp_call_function_interrupt(void);
> void ipi_call_lock(void);
> void ipi_call_unlock(void);
> void ipi_call_lock_irq(void);
> void ipi_call_unlock_irq(void);
>+#else
>+static inline void call_function_init(void) { }
> #endif
> 
> /*
>@@ -144,7 +147,7 @@ static inline void smp_send_reschedule(int cpu) { }
> #define smp_prepare_boot_cpu()			do {} while (0)
> #define smp_call_function_many(mask, func, info, wait) \
> 			(up_smp_call_function(func, info))
>-static inline void init_call_single_data(void) { }
>+static inline void call_function_init(void) { }
> 
> static inline int
> smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
>diff --git a/init/main.c b/init/main.c
>index 4a9479e..12821d1 100644
>--- a/init/main.c
>+++ b/init/main.c
>@@ -539,6 +539,7 @@ asmlinkage void __init start_kernel(void)
> 	timekeeping_init();
> 	time_init();
> 	profile_init();
>+	call_function_init();
> 	if (!irqs_disabled())
> 		printk(KERN_CRIT "start_kernel(): bug: interrupts were "
> 				 "enabled early\n");
>diff --git a/kernel/smp.c b/kernel/smp.c
>index 73a1951..fb67dfa 100644
>--- a/kernel/smp.c
>+++ b/kernel/smp.c
>@@ -74,7 +74,7 @@ static struct notifier_block __cpuinitdata 
>hotplug_cfd_notifier = {
> 	.notifier_call		= hotplug_cfd,
> };
> 
>-static int __cpuinit init_call_single_data(void)
>+void __init call_function_init(void)
> {
> 	void *cpu = (void *)(long)smp_processor_id();
> 	int i;
>@@ -88,10 +88,7 @@ static int __cpuinit init_call_single_data(void)
> 
> 	hotplug_cfd(&hotplug_cfd_notifier, CPU_UP_PREPARE, cpu);
> 	register_cpu_notifier(&hotplug_cfd_notifier);
>-
>-	return 0;
> }
>-early_initcall(init_call_single_data);
> 
> /*
>  * csd_lock/csd_unlock used to serialize access to per-cpu csd resources


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
