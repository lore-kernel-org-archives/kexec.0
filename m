Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0FsS-00070b-9r
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 13:35:24 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 7/8] x86: Make nmi_shootdown_cpus() available on !SMP and
	!X86_LOCAL_APIC
Date: Wed, 12 Nov 2008 11:34:43 -0200
Message-Id: <1226496884-24628-8-git-send-email-ehabkost@redhat.com>
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

The X86_LOCAL_APIC #ifdef was for kdump. For !SMP, the function simply
does nothing.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/reboot.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 82fa28f..d0c9c77 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -524,7 +524,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 #endif
 
 
-#if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
+#if defined(CONFIG_SMP)
 
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
@@ -573,6 +573,12 @@ static struct notifier_block crash_nmi_nb = {
 	.notifier_call = crash_nmi_callback,
 };
 
+/* Halt all other CPUs, calling the specified function on each of them
+ *
+ * This function can be used to halt all other CPUs on crash
+ * or emergency reboot time. The function passed as parameter
+ * will be called inside a NMI handler on all CPUs.
+ */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
 	unsigned long msecs;
@@ -601,4 +607,9 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	/* Leave the nmi callback set */
 }
+#else /* !CONFIG_SMP */
+void nmi_shootdown_cpus(nmi_shootdown_cb callback)
+{
+	/* No other CPUs to shoot down */
+}
 #endif
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
