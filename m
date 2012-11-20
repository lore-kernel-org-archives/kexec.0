Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TapPT-0007Uh-MV
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 15:06:49 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:35419 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1634381Ab2KTPEy
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Tue, 20 Nov 2012 16:04:54 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 09/11] x86/xen/enlighten: Add init and crash kexec/kdump
 hooks
Date: Tue, 20 Nov 2012 16:04:51 +0100
Message-Id: <1353423893-23125-10-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1353423893-23125-9-git-send-email-daniel.kiper@oracle.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-3-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-4-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-5-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-6-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-7-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-8-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-9-git-send-email-daniel.kiper@oracle.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Add init and crash kexec/kdump hooks.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/xen/enlighten.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 586d838..e5b4d0d 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
+#include <linux/kexec.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -67,6 +68,7 @@
 #include <asm/hypervisor.h>
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
+#include <asm/xen/kexec.h>
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
@@ -1254,6 +1256,12 @@ static void xen_machine_power_off(void)
 
 static void xen_crash_shutdown(struct pt_regs *regs)
 {
+#ifdef CONFIG_KEXEC
+	if (kexec_crash_image) {
+		crash_save_cpu(regs, safe_smp_processor_id());
+		return;
+	}
+#endif
 	xen_reboot(SHUTDOWN_crash);
 }
 
@@ -1331,6 +1339,10 @@ asmlinkage void __init xen_start_kernel(void)
 
 	xen_init_mmu_ops();
 
+#ifdef CONFIG_KEXEC
+	xen_init_kexec_ops();
+#endif
+
 	/* Prevent unwanted bits from being set in PTEs. */
 	__supported_pte_mask &= ~_PAGE_GLOBAL;
 #if 0
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
