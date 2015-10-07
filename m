Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0118.outbound.protection.outlook.com
 ([157.56.110.118] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfj2-00018p-HX
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:49:11 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 15/18] powerpc/book3e-64/kexec: Enable SMP release
Date: Tue, 6 Oct 2015 22:48:19 -0500
Message-ID: <1444189702-17241-16-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, devicetree@vger.kernel.org, kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>

The SMP release mechanism for FSL book3e is different from when booting
with normal hardware.  In theory we could simulate the normal spin
table mechanism, but not at the addresses U-Boot put in the device tree
-- so there'd need to be even more communication between the kernel and
kexec to set that up.  Instead, kexec-tools will set a boolean property
linux,booted-from-kexec in the /chosen node.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: devicetree@vger.kernel.org
---
v2: Use a device tree property instead of a flag in the kernel image

This depends on the kexec-tools patch v2 "ppc64: Add a flag to tell the
kernel it's booting from kexec":
http://patchwork.ozlabs.org/patch/527050/
---
 Documentation/devicetree/bindings/chosen.txt |  8 ++++++++
 arch/powerpc/kernel/setup_64.c               | 17 ++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index ed838f4..6ae9d82 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -44,3 +44,11 @@ Implementation note: Linux will look for the property "linux,stdout-path" or
 on PowerPC "stdout" if "stdout-path" is not found.  However, the
 "linux,stdout-path" and "stdout" properties are deprecated. New platforms
 should only use the "stdout-path" property.
+
+linux,booted-from-kexec
+-----------------------
+
+This property is set (currently only on PowerPC, and only needed on
+book3e) by some versions of kexec-tools to tell the new kernel that it
+is being booted by kexec, as the booting environment may differ (e.g.
+a different secondary CPU release mechanism)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 505ec2c..5c03a6a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -340,11 +340,26 @@ void early_setup_secondary(void)
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
+static bool use_spinloop(void)
+{
+	if (!IS_ENABLED(CONFIG_PPC_BOOK3E))
+		return true;
+
+	/*
+	 * When book3e boots from kexec, the ePAPR spin table does
+	 * not get used.
+	 */
+	return of_property_read_bool(of_chosen, "linux,booted-from-kexec");
+}
+
 void smp_release_cpus(void)
 {
 	unsigned long *ptr;
 	int i;
 
+	if (!use_spinloop())
+		return;
+
 	DBG(" -> smp_release_cpus()\n");
 
 	/* All secondary cpus are spinning on a common spinloop, release them
@@ -524,7 +539,7 @@ void __init setup_system(void)
 	 * Freescale Book3e parts spin in a loop provided by firmware,
 	 * so smp_release_cpus() does nothing for them
 	 */
-#if defined(CONFIG_SMP) && !defined(CONFIG_PPC_FSL_BOOK3E)
+#if defined(CONFIG_SMP)
 	/* Release secondary cpus out of their spinloops at 0x60 now that
 	 * we can map physical -> logical CPU ids
 	 */
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
