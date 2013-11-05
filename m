Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdclY-0003e3-GG
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 09:17:41 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] x86: make reboot task only run on the appropriate processor
Date: Tue,  5 Nov 2013 17:16:07 +0800
Message-Id: <1383642967-12595-1-git-send-email-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, mwhitehe@redhat.com, x86@kernel.org, chaowang@redhat.com, kexec@lists.infradead.org, davej@fedoraproject.org, mingo@redhat.com, holt@sgi.com, hpa@zytor.com, rmk+kernel@arm.linux.org.uk, tglx@linutronix.de, akpm@linux-foundation.org, vgoyal@redhat.com

Currently system always reboot after below message when execute "kexec -e".

[    0.572119] smpboot: Booting Node   0, Processors  #   1 OK

In commit 1b3a5d02ee070c8f9943333b9b6370f486601e0f, reboot= handling was
moved to kerne/reboot.c. However, the code to migrate current thread to
reboot cpu was removed. That cause this incorrect kexec behavior.

Now add that code block back.

Reported-by: Matthew Whitehead <mwhitehe@redhat.com>
Reported-by: Dave Young <dyoung@redhat.com>
Tested-by: WANG Chao <chaowang@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/reboot.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 7e920bf..3049de9 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -551,6 +551,21 @@ void native_machine_shutdown(void)
 {
 	/* Stop the cpus and apics */
 #ifdef CONFIG_SMP
+       /* The boot cpu is always logical cpu 0 */
+       int reboot_cpu_id = 0;
+
+       /* See if there has been given a command line override */
+       if ((reboot_cpu != -1) && (reboot_cpu < nr_cpu_ids) &&
+               cpu_online(reboot_cpu))
+               reboot_cpu_id = reboot_cpu;
+
+       /* Make certain the cpu I'm about to reboot on is online */
+       if (!cpu_online(reboot_cpu_id))
+               reboot_cpu_id = smp_processor_id();
+
+       /* Make certain I only run on the appropriate processor */
+       set_cpus_allowed_ptr(current, cpumask_of(reboot_cpu_id));
+
 	/*
 	 * Stop all of the others. Also disable the local irq to
 	 * not receive the per-cpu timer interrupt which may trigger
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
