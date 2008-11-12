Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0FsQ-000703-Im
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 13:35:22 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 5/8] x86 kdump: Make nmi_shootdown_cpus() non-static
Date: Wed, 12 Nov 2008 11:34:41 -0200
Message-Id: <1226496884-24628-6-git-send-email-ehabkost@redhat.com>
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

Add prototype to asm/reboot.h.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/reboot.h |    5 +++++
 arch/x86/kernel/crash.c       |    3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index df77103..562d4fd 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_REBOOT_H
 #define _ASM_X86_REBOOT_H
 
+#include <linux/kdebug.h>
+
 struct pt_regs;
 
 struct machine_ops {
@@ -18,4 +20,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs);
 void native_machine_shutdown(void);
 void machine_real_restart(const unsigned char *code, int length);
 
+typedef void (*nmi_shootdown_cb)(int, struct die_args*);
+void nmi_shootdown_cpus(nmi_shootdown_cb callback);
+
 #endif /* _ASM_X86_REBOOT_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f23c2be..fb298d1 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -29,7 +29,6 @@
 
 #include <mach_ipi.h>
 
-typedef void (*nmi_shootdown_cb)(int, struct die_args*);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
@@ -100,7 +99,7 @@ static struct notifier_block crash_nmi_nb = {
 	.notifier_call = crash_nmi_callback,
 };
 
-static void nmi_shootdown_cpus(nmi_shootdown_cb callback)
+void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
 	unsigned long msecs;
 
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
