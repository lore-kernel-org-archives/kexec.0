Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q2SzD-0001Gg-Sj
	for kexec@lists.infradead.org; Wed, 23 Mar 2011 18:40:53 +0000
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH][KDUMP] Ignore spurious IPI
Date: Wed, 23 Mar 2011 14:40:12 -0400
MIME-Version: 1.0
Message-Id: <C3CBE989BE8833indou.takao@jp.fujitsu.com>
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

Hi all,

I found a problem that kdump(2nd kernel) sometimes hangs up. It seems
that system panic occurs as follows.

(1)
2nd kernel boot up

(2)
A pending IPI from 1st kernel comes after unmasking interrupts at the
following point.

asmlinkage void __init start_kernel(void)
{
(snip)
    time_init();
    profile_init();
    if (!irqs_disabled())
            printk(KERN_CRIT "start_kernel(): bug: interrupts were "
                             "enabled early\n");
    early_boot_irqs_disabled = false;
    local_irq_enable(); <=======================================HERE

(3)
Kernel tries to handle the interrupt, but some data structures are not
initialized yet at this point. As a result, in the
generic_smp_call_function_single_interrupt(), NULL pointer dereference
occurs when list_replace_init() tries to access &q->list.next.

I took a look at local_apic_timer_interrupt() and found a few lines to
handle such a pending LAPIC interrupt(in this case, timer interrupt).
Therefore I made a patch to ignore spurious IPI in the same manner. I
confirmed this problem does not occur with this patch.

Any comments?

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 kernel/smp.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 9910744..f2f561b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -260,6 +260,12 @@ void generic_smp_call_function_single_interrupt(void)
 	 */
 	WARN_ON_ONCE(!cpu_online(smp_processor_id()));
 
+	if (unlikely(!q->list.next)) {
+		/* Pending interrupt from previous kernel(e.g. kdump), just ignore */
+		pr_warning("Spurious IPI on cpu %d\n", smp_processor_id());
+		return;
+	}
+
 	raw_spin_lock(&q->lock);
 	list_replace_init(&q->list, &list);
 	raw_spin_unlock(&q->lock);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
