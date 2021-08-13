Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1nam07on2055.outbound.protection.outlook.com
 ([40.107.212.55] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEaXO-00DBD6-MP
 for kexec@lists.infradead.org; Fri, 13 Aug 2021 17:00:10 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 02/12] mm: Introduce a function to check for virtualization
 protection features
Date: Fri, 13 Aug 2021 11:59:21 -0500
Message-Id: <482fe51f1671c1cd081039801b03db7ec0036332.1628873970.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
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
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Joerg Roedel <jroedel@suse.de>

In prep for other protected virtualization technologies, introduce a
generic helper function, prot_guest_has(), that can be used to check
for specific protection attributes, like memory encryption. This is
intended to eliminate having to add multiple technology-specific checks
to the code (e.g. if (sev_active() || tdx_active())).

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/Kconfig                    |  3 +++
 include/linux/protected_guest.h | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 include/linux/protected_guest.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 98db63496bab..bd4f60c581f1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1231,6 +1231,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config ARCH_HAS_PROTECTED_GUEST
+	bool
+
 config HAVE_SPARSE_SYSCALL_NR
        bool
        help
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
new file mode 100644
index 000000000000..43d4dde94793
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Protected Guest (and Host) Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _PROTECTED_GUEST_H
+#define _PROTECTED_GUEST_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+
+#define PATTR_MEM_ENCRYPT		0	/* Encrypted memory */
+#define PATTR_HOST_MEM_ENCRYPT		1	/* Host encrypted memory */
+#define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
+#define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
+
+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+
+#include <asm/protected_guest.h>
+
+#else	/* !CONFIG_ARCH_HAS_PROTECTED_GUEST */
+
+static inline bool prot_guest_has(unsigned int attr) { return false; }
+
+#endif	/* CONFIG_ARCH_HAS_PROTECTED_GUEST */
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* _PROTECTED_GUEST_H */
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
