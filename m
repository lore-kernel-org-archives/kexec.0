Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a0lBG-0007gM-TD
 for kexec@lists.infradead.org; Mon, 23 Nov 2015 07:04:55 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id 1B79BA063B
 for <kexec@lists.infradead.org>; Mon, 23 Nov 2015 07:04:33 +0000 (UTC)
Date: Mon, 23 Nov 2015 15:04:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] arm: use /sys/firmware/fdt in case without --atags and --dtb
Message-ID: <20151123070423.GA3972@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

Latest linux kernel will create /sys/firmware/fdt file. It will be convenient
to use it in case one does not specify --atags and --dtb options.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/arm/kexec-arm.c        |    7 +++++++
 kexec/arch/arm/kexec-arm.h        |    2 ++
 kexec/arch/arm/kexec-zImage-arm.c |    8 ++++++++
 3 files changed, 17 insertions(+)

--- kexec-tools.orig/kexec/arch/arm/kexec-arm.c
+++ kexec-tools/kexec/arch/arm/kexec-arm.c
@@ -12,6 +12,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
+#include <unistd.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-arm.h"
@@ -137,3 +138,9 @@ int arch_compat_trampoline(struct kexec_
 void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
+
+/* return 1 if /sys/firmware/fdt exists, otherwise return 0 */
+int have_sysfs_fdt(void)
+{
+	return !access(SYSFS_FDT, F_OK);
+}
--- kexec-tools.orig/kexec/arch/arm/kexec-arm.h
+++ kexec-tools/kexec/arch/arm/kexec-arm.h
@@ -3,6 +3,7 @@
 
 #include <sys/types.h>
 
+#define SYSFS_FDT "/sys/firmware/fdt"
 #define BOOT_BLOCK_VERSION 17
 #define BOOT_BLOCK_LAST_COMP_VERSION 16
 
@@ -16,5 +17,6 @@ void zImage_arm_usage(void);
 int uImage_arm_probe(const char *buf, off_t len);
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		        struct kexec_info *info);
+extern int have_sysfs_fdt(void);
 
 #endif /* KEXEC_ARM_H */
--- kexec-tools.orig/kexec/arch/arm/kexec-zImage-arm.c
+++ kexec-tools/kexec/arch/arm/kexec-zImage-arm.c
@@ -358,6 +358,14 @@ int zImage_arm_load(int argc, char **arg
 		return -1;
 	}
 
+	if (!use_atags && !dtb_file) {
+		int f;
+
+		f = have_sysfs_fdt();
+		if (f)
+			dtb_file = SYSFS_FDT;
+	}
+
 	if (command_line) {
 		command_line_len = strlen(command_line) + 1;
 		if (command_line_len > COMMAND_LINE_SIZE)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
