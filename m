Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVIUl-008bHl-4e
 for kexec@lists.infradead.org; Tue, 28 Sep 2021 19:10:31 +0000
From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
Date: Tue, 28 Sep 2021 21:10:05 +0200
Message-Id: <20210928191009.32551-5-bp@alien8.de>
In-Reply-To: <20210928191009.32551-1-bp@alien8.de>
References: <20210928191009.32551-1-bp@alien8.de>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Young <dyoung@redhat.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <hca@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Paul Mackerras <paulus@samba.org>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@infradead.org>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Introduce a powerpc version of the cc_platform_has() function. This will
be used to replace the powerpc mem_encrypt_active() implementation, so
the implementation will initially only support the CC_ATTR_MEM_ENCRYPT
attribute.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig       |  1 +
 arch/powerpc/platforms/pseries/Makefile      |  2 ++
 arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5e037df2a3a1..2e57391e0778 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -159,6 +159,7 @@ config PPC_SVM
 	select SWIOTLB
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_CC_PLATFORM
 	help
 	 There are certain POWER platforms which support secure guests using
 	 the Protected Execution Facility, with the help of an Ultravisor
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 4cda0ef87be0..41d8aee98da4 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -31,3 +31,5 @@ obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o
+
+obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
diff --git a/arch/powerpc/platforms/pseries/cc_platform.c b/arch/powerpc/platforms/pseries/cc_platform.c
new file mode 100644
index 000000000000..e8021af83a19
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/cc_platform.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#include <linux/export.h>
+#include <linux/cc_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/svm.h>
+
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_secure_guest();
+
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
