Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOpf3-0004VT-LY
 for kexec@lists.infradead.org; Mon, 19 Nov 2018 19:56:48 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAJJrqAG078046
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2018 14:56:37 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nv0spqqma-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2018 14:56:36 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 19 Nov 2018 19:56:34 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 3/3] x86/ima: retry detecting secure boot mode
Date: Mon, 19 Nov 2018 14:56:11 -0500
In-Reply-To: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-integrity@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, jforbes@redhat.com

The secure boot mode may not be detected on boot for some reason (eg.
buggy firmware).  This patch attempts one more time to detect the
secure boot mode.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 arch/x86/kernel/Makefile   |  2 ++
 arch/x86/kernel/ima_arch.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/ima.h        |  2 +-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f0910a1e1db7..eb51b0e1189c 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -151,4 +151,6 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-y				+= vsmp_64.o
 endif
 
+ifdef CONFIG_EFI
 obj-$(CONFIG_IMA)			+= ima_arch.o
+endif
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 6c248616ee57..e47cd9390ab4 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -7,10 +7,52 @@
 
 extern struct boot_params boot_params;
 
+static enum efi_secureboot_mode get_sb_mode(void)
+{
+	efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
+	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
+	efi_status_t status;
+	unsigned long size;
+	u8 secboot;
+
+	size = sizeof(secboot);
+
+	/* Get variable contents into buffer */
+	status = efi.get_variable(efi_SecureBoot_name, &efi_variable_guid,
+				  NULL, &size, &secboot);
+	if (status == EFI_NOT_FOUND) {
+		pr_info("ima: secureboot mode disabled\n");
+		return efi_secureboot_mode_disabled;
+	}
+
+	if (status != EFI_SUCCESS) {
+		pr_info("ima: secureboot mode unknown\n");
+		return efi_secureboot_mode_unknown;
+	}
+
+	if (secboot == 0) {
+		pr_info("ima: secureboot mode disabled\n");
+		return efi_secureboot_mode_disabled;
+	}
+
+	pr_info("ima: secureboot mode enabled\n");
+	return efi_secureboot_mode_enabled;
+}
+
 bool arch_ima_get_secureboot(void)
 {
-	if (efi_enabled(EFI_BOOT) &&
-		(boot_params.secure_boot == efi_secureboot_mode_enabled))
+	static enum efi_secureboot_mode sb_mode;
+	static bool initialized;
+
+	if (!initialized && efi_enabled(EFI_BOOT)) {
+		sb_mode = boot_params.secure_boot;
+
+		if (sb_mode == efi_secureboot_mode_unset)
+			sb_mode = get_sb_mode();
+		initialized = true;
+	}
+
+	if (sb_mode == efi_secureboot_mode_enabled)
 		return true;
 	else
 		return false;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 5ab9134d4fd7..b5e16b8c50b7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,7 +30,7 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) && defined(CONFIG_EFI)
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
 #else
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
