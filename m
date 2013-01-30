Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0aD3-0002AZ-Il
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 16:08:26 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] x86: Introduce Linux kernel specific E820_RESERVED_KDUMP
 e820 memory range type
Date: Wed, 30 Jan 2013 17:08:15 +0100
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
 <201301301703.42601.trenn@suse.de>
In-Reply-To: <201301301703.42601.trenn@suse.de>
MIME-Version: 1.0
Message-Id: <201301301708.15967.trenn@suse.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: yinghai@kernel.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, x86@kernel.org, vgoyal@redhat.com

This functionality will be picked up by later memmap= boot
parameter options. Originally E820_USABLE declared memory (used by the
productive, but crashed kernel) will get converted to the new
E820_RESERVED_KDUMP type.
The memory area where the kdump kernel resides (passed via memmap=X@Y
by kexec-tools) will be set usable again.

Also include a tiny whitespace to tab cleanup.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 arch/x86/include/uapi/asm/e820.h |    9 ++++++++-
 arch/x86/kernel/e820.c           |   14 +++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/uapi/asm/e820.h b/arch/x86/include/uapi/asm/e820.h
index bbae024..2171ca5 100644
--- a/arch/x86/include/uapi/asm/e820.h
+++ b/arch/x86/include/uapi/asm/e820.h
@@ -45,7 +45,14 @@
  * included in the S3 integrity calculation and so should not include
  * any memory that BIOS might alter over the S3 transition
  */
-#define E820_RESERVED_KERN        128
+#define E820_RESERVED_KERN	128
+
+/*
+ * Kdump kernel will use this type for formerly usable memory
+ * the crashed kernel used (and as defined by the original e820 map).
+ * It will then only set the memory area it resides in to usable memory
+ */
+#define E820_RESERVED_KDUMP	129
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index d32abea..e3c5b7f 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -149,6 +149,9 @@ static void __init e820_print_type(u32 type)
 	case E820_UNUSABLE:
 		printk(KERN_CONT "unusable");
 		break;
+	case E820_RESERVED_KDUMP:
+		printk(KERN_CONT "kdump reserved");
+		break;
 	default:
 		printk(KERN_CONT "type %u", type);
 		break;
@@ -911,11 +914,12 @@ static inline const char *e820_type_to_string(int e820_type)
 {
 	switch (e820_type) {
 	case E820_RESERVED_KERN:
-	case E820_RAM:	return "System RAM";
-	case E820_ACPI:	return "ACPI Tables";
-	case E820_NVS:	return "ACPI Non-volatile Storage";
-	case E820_UNUSABLE:	return "Unusable memory";
-	default:	return "reserved";
+	case E820_RAM:			return "System RAM";
+	case E820_ACPI:			return "ACPI Tables";
+	case E820_NVS:			return "ACPI Non-volatile Storage";
+	case E820_UNUSABLE:		return "Unusable memory";
+	case E820_RESERVED_KDUMP:	return "Kdump reserved";
+	default:			return "reserved";
 	}
 }
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
