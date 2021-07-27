Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com
 ([40.107.237.40] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8VXI-00GWwl-6x
 for kexec@lists.infradead.org; Tue, 27 Jul 2021 22:26:53 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 01/11] mm: Introduce a function to check for virtualization
 protection features
Date: Tue, 27 Jul 2021 17:26:04 -0500
Message-Id: <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
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
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>

In prep for other protected virtualization technologies, introduce a
generic helper function, prot_guest_has(), that can be used to check
for specific protection attributes, like memory encryption. This is
intended to eliminate having to add multiple technology-specific checks
to the code (e.g. if (sev_active() || tdx_active())).

Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/Kconfig                    |  3 +++
 include/linux/protected_guest.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 include/linux/protected_guest.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 129df498a8e1..a47cf283f2ff 100644
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
index 000000000000..f8ed7b72967b
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,32 @@
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
