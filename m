Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9vtd-0000ik-1J
 for kexec@lists.infradead.org; Tue, 09 Oct 2018 17:34:14 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w99HTf77128176
 for <kexec@lists.infradead.org>; Tue, 9 Oct 2018 13:34:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n0wtf0ymn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 09 Oct 2018 13:34:09 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <nayna@linux.vnet.ibm.com>;
 Tue, 9 Oct 2018 18:34:04 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v6 1/5] x86/ima: define arch_ima_get_secureboot
Date: Tue,  9 Oct 2018 23:00:33 +0530
In-Reply-To: <20181009173037.32630-1-nayna@linux.vnet.ibm.com>
References: <20181009173037.32630-1-nayna@linux.vnet.ibm.com>
Message-Id: <20181009173037.32630-2-nayna@linux.vnet.ibm.com>
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
Cc: linux-efi@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, pjones@redhat.com, ebiederm@xmission.com, jforbes@redhat.com, dyoung@redhat.com, vgoyal@redhat.com

From: Nayna Jain <nayna@linux.ibm.com>

Distros are concerned about totally disabling the kexec_load syscall.
As a compromise, the kexec_load syscall will only be disabled when
CONFIG_KEXEC_VERIFY_SIG is configured and the system is booted with
secureboot enabled.

This patch defines the new arch specific function called
arch_ima_get_secureboot() to retrieve the secureboot state of the system.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Suggested-by: Seth Forshee <seth.forshee@canonical.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/Makefile   |  2 ++
 arch/x86/kernel/ima_arch.c | 17 +++++++++++++++++
 include/linux/ima.h        |  9 +++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/x86/kernel/ima_arch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5cf4e70..f32406e51424 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -149,3 +149,5 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
+
+obj-$(CONFIG_IMA)			+= ima_arch.o
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
new file mode 100644
index 000000000000..bb5a88d2b271
--- /dev/null
+++ b/arch/x86/kernel/ima_arch.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 IBM Corporation
+ */
+#include <linux/efi.h>
+#include <linux/ima.h>
+
+extern struct boot_params boot_params;
+
+bool arch_ima_get_secureboot(void)
+{
+	if (efi_enabled(EFI_BOOT) &&
+		(boot_params.secure_boot == efi_secureboot_mode_enabled))
+		return true;
+	else
+		return false;
+}
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 84806b54b50a..4852255aa4f4 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,6 +30,15 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
+#ifdef CONFIG_X86
+extern bool arch_ima_get_secureboot(void);
+#else
+static inline bool arch_ima_get_secureboot(void)
+{
+	return false;
+}
+#endif
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
