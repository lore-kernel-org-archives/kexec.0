Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam01on0049.outbound.protection.outlook.com
 ([104.47.32.49] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dPrvx-0004oj-P8
 for kexec@lists.infradead.org; Tue, 27 Jun 2017 14:57:45 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v8 06/38] x86/mm: Add Secure Memory Encryption (SME) support
Date: Tue, 27 Jun 2017 09:57:13 -0500
Message-ID: <20170627145713.15908.42762.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170627145607.15908.26571.stgit@tlendack-t1.amdoffice.net>
References: <20170627145607.15908.26571.stgit@tlendack-t1.amdoffice.net>
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
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, "Michael S. Tsirkin" <mst@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

Add support for Secure Memory Encryption (SME). This initial support
provides a Kconfig entry to build the SME support into the kernel and
defines the memory encryption mask that will be used in subsequent
patches to mark pages as encrypted.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/Kconfig                   |   25 +++++++++++++++++++++++++
 arch/x86/include/asm/mem_encrypt.h |   30 ++++++++++++++++++++++++++++++
 arch/x86/mm/Makefile               |    1 +
 arch/x86/mm/mem_encrypt.c          |   21 +++++++++++++++++++++
 include/linux/mem_encrypt.h        |   35 +++++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+)
 create mode 100644 arch/x86/include/asm/mem_encrypt.h
 create mode 100644 arch/x86/mm/mem_encrypt.c
 create mode 100644 include/linux/mem_encrypt.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 72028a1..3a59e9c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1409,6 +1409,31 @@ config X86_DIRECT_GBPAGES
 	  supports them), so don't confuse the user by printing
 	  that we have them enabled.
 
+config ARCH_HAS_MEM_ENCRYPT
+	def_bool y
+
+config AMD_MEM_ENCRYPT
+	bool "AMD Secure Memory Encryption (SME) support"
+	depends on X86_64 && CPU_SUP_AMD
+	---help---
+	  Say yes to enable support for the encryption of system memory.
+	  This requires an AMD processor that supports Secure Memory
+	  Encryption (SME).
+
+config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
+	bool "Activate AMD Secure Memory Encryption (SME) by default"
+	default y
+	depends on AMD_MEM_ENCRYPT
+	---help---
+	  Say yes to have system memory encrypted by default if running on
+	  an AMD processor that supports Secure Memory Encryption (SME).
+
+	  If set to Y, then the encryption of system memory can be
+	  deactivated with the mem_encrypt=off command line option.
+
+	  If set to N, then the encryption of system memory can be
+	  activated with the mem_encrypt=on command line option.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
new file mode 100644
index 0000000..a105796
--- /dev/null
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -0,0 +1,30 @@
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __X86_MEM_ENCRYPT_H__
+#define __X86_MEM_ENCRYPT_H__
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+
+extern unsigned long sme_me_mask;
+
+#else	/* !CONFIG_AMD_MEM_ENCRYPT */
+
+#define sme_me_mask	0UL
+
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 0fbdcb6..a94a7b6 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_X86_INTEL_MPX)	+= mpx.o
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS) += pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY) += kaslr.o
 
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
new file mode 100644
index 0000000..b99d469
--- /dev/null
+++ b/arch/x86/mm/mem_encrypt.c
@@ -0,0 +1,21 @@
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+/*
+ * Since SME related variables are set early in the boot process they must
+ * reside in the .data section so as not to be zeroed out when the .bss
+ * section is later cleared.
+ */
+unsigned long sme_me_mask __section(.data) = 0;
+EXPORT_SYMBOL_GPL(sme_me_mask);
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
new file mode 100644
index 0000000..59769f7
--- /dev/null
+++ b/include/linux/mem_encrypt.h
@@ -0,0 +1,35 @@
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MEM_ENCRYPT_H__
+#define __MEM_ENCRYPT_H__
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_ARCH_HAS_MEM_ENCRYPT
+
+#include <asm/mem_encrypt.h>
+
+#else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
+
+#define sme_me_mask	0UL
+
+#endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
+
+static inline bool sme_active(void)
+{
+	return !!sme_me_mask;
+}
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __MEM_ENCRYPT_H__ */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
