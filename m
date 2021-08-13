Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com
 ([40.107.212.62] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEaXX-00DBFd-4h
 for kexec@lists.infradead.org; Fri, 13 Aug 2021 17:00:16 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Date: Fri, 13 Aug 2021 11:59:22 -0500
Message-Id: <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
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
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>

Introduce an x86 version of the prot_guest_has() function. This will be
used in the more generic x86 code to replace vendor specific calls like
sev_active(), etc.

While the name suggests this is intended mainly for guests, it will
also be used for host memory encryption checks in place of sme_active().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/mem_encrypt.h     |  2 ++
 arch/x86/include/asm/protected_guest.h | 29 ++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c              | 25 ++++++++++++++++++++++
 include/linux/protected_guest.h        |  5 +++++
 5 files changed, 62 insertions(+)
 create mode 100644 arch/x86/include/asm/protected_guest.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 421fa9e38c60..82e5fb713261 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1514,6 +1514,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68d75b5..a46d47662772 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -53,6 +53,7 @@ void __init sev_es_init_vc_handling(void);
 bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
+bool amd_prot_guest_has(unsigned int attr);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -78,6 +79,7 @@ static inline void sev_es_init_vc_handling(void) { }
 static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
+static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
new file mode 100644
index 000000000000..51e4eefd9542
--- /dev/null
+++ b/arch/x86/include/asm/protected_guest.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Protected Guest (and Host) Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _X86_PROTECTED_GUEST_H
+#define _X86_PROTECTED_GUEST_H
+
+#include <linux/mem_encrypt.h>
+
+#ifndef __ASSEMBLY__
+
+static inline bool prot_guest_has(unsigned int attr)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if (sme_me_mask)
+		return amd_prot_guest_has(attr);
+#endif
+
+	return false;
+}
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* _X86_PROTECTED_GUEST_H */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc463634..edc67ddf065d 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/virtio_config.h>
+#include <linux/protected_guest.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -389,6 +390,30 @@ bool noinstr sev_es_active(void)
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
+bool amd_prot_guest_has(unsigned int attr)
+{
+	switch (attr) {
+	case PATTR_MEM_ENCRYPT:
+		return sme_me_mask != 0;
+
+	case PATTR_SME:
+	case PATTR_HOST_MEM_ENCRYPT:
+		return sme_active();
+
+	case PATTR_SEV:
+	case PATTR_GUEST_MEM_ENCRYPT:
+		return sev_active();
+
+	case PATTR_SEV_ES:
+	case PATTR_GUEST_PROT_STATE:
+		return sev_es_active();
+
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(amd_prot_guest_has);
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index 43d4dde94793..5ddef1b6a2ea 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -20,6 +20,11 @@
 #define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
 #define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
 
+/* 0x800 - 0x8ff reserved for AMD */
+#define PATTR_SME			0x800
+#define PATTR_SEV			0x801
+#define PATTR_SEV_ES			0x802
+
 #ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
 
 #include <asm/protected_guest.h>
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
