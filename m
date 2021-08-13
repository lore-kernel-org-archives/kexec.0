Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com
 ([40.107.93.54] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEaXh-00DBLd-4f
 for kexec@lists.infradead.org; Fri, 13 Aug 2021 17:00:28 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 04/12] powerpc/pseries/svm: Add a powerpc version of
 prot_guest_has()
Date: Fri, 13 Aug 2021 11:59:23 -0500
Message-Id: <000f627ce20c6504dd8d118d85bd69e7717b752f.1628873970.git.thomas.lendacky@amd.com>
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
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

Introduce a powerpc version of the prot_guest_has() function. This will
be used to replace the powerpc mem_encrypt_active() implementation, so
the implementation will initially only support the PATTR_MEM_ENCRYPT
attribute.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/powerpc/include/asm/protected_guest.h | 30 ++++++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig     |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 arch/powerpc/include/asm/protected_guest.h

diff --git a/arch/powerpc/include/asm/protected_guest.h b/arch/powerpc/include/asm/protected_guest.h
new file mode 100644
index 000000000000..ce55c2c7e534
--- /dev/null
+++ b/arch/powerpc/include/asm/protected_guest.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Protected Guest (and Host) Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _POWERPC_PROTECTED_GUEST_H
+#define _POWERPC_PROTECTED_GUEST_H
+
+#include <asm/svm.h>
+
+#ifndef __ASSEMBLY__
+
+static inline bool prot_guest_has(unsigned int attr)
+{
+	switch (attr) {
+	case PATTR_MEM_ENCRYPT:
+		return is_secure_guest();
+
+	default:
+		return false;
+	}
+}
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* _POWERPC_PROTECTED_GUEST_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5e037df2a3a1..8ce5417d6feb 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -159,6 +159,7 @@ config PPC_SVM
 	select SWIOTLB
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	 There are certain POWER platforms which support secure guests using
 	 the Protected Execution Facility, with the help of an Ultravisor
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
