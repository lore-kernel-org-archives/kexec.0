Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1To35F-0006fX-1j
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 02:20:34 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:41014 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1645340Ab2L0CTB
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Thu, 27 Dec 2012 03:19:01 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v3 09/11] x86/xen/enlighten: Add init and crash kexec/kdump
 hooks
Date: Thu, 27 Dec 2012 03:18:58 +0100
Message-Id: <1356574740-6806-10-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1356574740-6806-9-git-send-email-daniel.kiper@oracle.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-5-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-6-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-7-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-8-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-9-git-send-email-daniel.kiper@oracle.com>
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
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, maxim.uvarov@oracle.com, mingo@redhat.com, tglx@linutronix.de, vgoyal@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Add init and crash kexec/kdump hooks.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/xen/enlighten.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 138e566..5025bba 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
+#include <linux/kexec.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -1276,6 +1277,12 @@ static void xen_machine_power_off(void)
 
 static void xen_crash_shutdown(struct pt_regs *regs)
 {
+#ifdef CONFIG_KEXEC_FIRMWARE
+	if (kexec_crash_image) {
+		crash_save_cpu(regs, safe_smp_processor_id());
+		return;
+	}
+#endif
 	xen_reboot(SHUTDOWN_crash);
 }
 
@@ -1353,6 +1360,10 @@ asmlinkage void __init xen_start_kernel(void)
 
 	xen_init_mmu_ops();
 
+#ifdef CONFIG_KEXEC_FIRMWARE
+	kexec_use_firmware = true;
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
