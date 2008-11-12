Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0FsX-0007Ge-QB
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 13:35:30 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 2/8] x86 kdump: Move crashing_cpu assignment to
	nmi_shootdown_cpus()
Date: Wed, 12 Nov 2008 11:34:38 -0200
Message-Id: <1226496884-24628-3-git-send-email-ehabkost@redhat.com>
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

This variable will be moved to non-kdump-specific code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/crash.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 6047542..ed2f0f9 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -29,10 +29,11 @@
 
 #include <mach_ipi.h>
 
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
+
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
-#if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 static atomic_t waiting_for_crash_ipi;
 
 static void kdump_nmi_callback(int cpu, struct die_args *args)
@@ -100,6 +101,9 @@ static void nmi_shootdown_cpus(void)
 {
 	unsigned long msecs;
 
+	/* Make a note of crashing cpu. Will be used in NMI callback.*/
+	crashing_cpu = safe_smp_processor_id();
+
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
 	/* Would it be better to replace the trap vector here? */
 	if (register_die_notifier(&crash_nmi_nb))
@@ -140,8 +144,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	/* The kernel is broken so disable interrupts */
 	local_irq_disable();
 
-	/* Make a note of crashing cpu. Will be used in NMI callback.*/
-	crashing_cpu = safe_smp_processor_id();
 	nmi_shootdown_cpus();
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
