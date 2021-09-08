Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam08on2060.outbound.protection.outlook.com
 ([40.107.101.60] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mO6XD-007kfX-7G
 for kexec@lists.infradead.org; Wed, 08 Sep 2021 22:59:16 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 2/8] mm: Introduce a function to check for confidential
 computing features
Date: Wed, 8 Sep 2021 17:58:33 -0500
Message-ID: <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1631141919.git.thomas.lendacky@amd.com>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@infradead.org>

In prep for other confidential computing technologies, introduce a generic
helper function, cc_platform_has(), that can be used to check for specific
active confidential computing attributes, like memory encryption. This is
intended to eliminate having to add multiple technology-specific checks to
the code (e.g. if (sev_active() || tdx_active())).

Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/Kconfig                |  3 ++
 include/linux/cc_platform.h | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 include/linux/cc_platform.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 3743174da870..ca7c359e5da8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1234,6 +1234,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config ARCH_HAS_CC_PLATFORM
+	bool
+
 config HAVE_SPARSE_SYSCALL_NR
        bool
        help
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
new file mode 100644
index 000000000000..253f3ea66cd8
--- /dev/null
+++ b/include/linux/cc_platform.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _CC_PLATFORM_H
+#define _CC_PLATFORM_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+
+/**
+ * enum cc_attr - Confidential computing attributes
+ *
+ * These attributes represent confidential computing features that are
+ * currently active.
+ */
+enum cc_attr {
+	/**
+	 * @CC_ATTR_MEM_ENCRYPT: Memory encryption is active
+	 *
+	 * The platform/OS is running with active memory encryption. This
+	 * includes running either as a bare-metal system or a hypervisor
+	 * and actively using memory encryption or as a guest/virtual machine
+	 * and actively using memory encryption.
+	 *
+	 * Examples include SME, SEV and SEV-ES.
+	 */
+	CC_ATTR_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_HOST_MEM_ENCRYPT: Host memory encryption is active
+	 *
+	 * The platform/OS is running as a bare-metal system or a hypervisor
+	 * and actively using memory encryption.
+	 *
+	 * Examples include SME.
+	 */
+	CC_ATTR_HOST_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_MEM_ENCRYPT: Guest memory encryption is active
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using memory encryption.
+	 *
+	 * Examples include SEV and SEV-ES.
+	 */
+	CC_ATTR_GUEST_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_STATE_ENCRYPT: Guest state encryption is active
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using memory encryption and register state encryption.
+	 *
+	 * Examples include SEV-ES.
+	 */
+	CC_ATTR_GUEST_STATE_ENCRYPT,
+};
+
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+
+/**
+ * cc_platform_has() - Checks if the specified cc_attr attribute is active
+ * @attr: Confidential computing attribute to check
+ *
+ * The cc_platform_has() function will return an indicator as to whether the
+ * specified Confidential Computing attribute is currently active.
+ *
+ * Context: Any context
+ * Return:
+ * * TRUE  - Specified Confidential Computing attribute is active
+ * * FALSE - Specified Confidential Computing attribute is not active
+ */
+bool cc_platform_has(enum cc_attr attr);
+
+#else	/* !CONFIG_ARCH_HAS_CC_PLATFORM */
+
+static inline bool cc_platform_has(enum cc_attr attr) { return false; }
+
+#endif	/* CONFIG_ARCH_HAS_CC_PLATFORM */
+
+#endif	/* _CC_PLATFORM_H */
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
