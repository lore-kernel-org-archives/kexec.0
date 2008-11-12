Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0FsM-0006z8-Gt
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 13:35:18 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 4/8] x86 kdump: Make kdump_nmi_callback() a function ptr on
	crash_nmi_callback()
Date: Wed, 12 Nov 2008 11:34:40 -0200
Message-Id: <1226496884-24628-5-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
References: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

The reboot code will use a different function on crash_nmi_callback().
Adding a function pointer parameter to nmi_shootdown_cpus() for that.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/crash.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 75c468c..f23c2be 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -29,10 +29,13 @@
 
 #include <mach_ipi.h>
 
+typedef void (*nmi_shootdown_cb)(int, struct die_args*);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
+static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
 
@@ -74,7 +77,7 @@ static int crash_nmi_callback(struct notifier_block *self,
 		return NOTIFY_STOP;
 	local_irq_disable();
 
-	kdump_nmi_callback(cpu, (struct die_args *)data);
+	shootdown_callback(cpu, (struct die_args *)data);
 
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -97,13 +100,15 @@ static struct notifier_block crash_nmi_nb = {
 	.notifier_call = crash_nmi_callback,
 };
 
-static void nmi_shootdown_cpus(void)
+static void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
 	unsigned long msecs;
 
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
 	crashing_cpu = safe_smp_processor_id();
 
+	shootdown_callback = callback;
+
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
 	/* Would it be better to replace the trap vector here? */
 	if (register_die_notifier(&crash_nmi_nb))
@@ -126,7 +131,7 @@ static void nmi_shootdown_cpus(void)
 
 static void kdump_nmi_shootdown_cpus(void)
 {
-	nmi_shootdown_cpus();
+	nmi_shootdown_cpus(kdump_nmi_callback);
 
 	disable_local_APIC();
 }
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
