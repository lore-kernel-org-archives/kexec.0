Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9lS1-0001RC-KF
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 06:57:18 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 1/2 v10] x86/mm,
 resource: add a new I/O resource descriptor 'IORES_DESC_RESERVED'
Date: Fri, 29 Mar 2019 14:56:48 +0800
Message-Id: <20190329065649.12468-2-lijiang@redhat.com>
In-Reply-To: <20190329065649.12468-1-lijiang@redhat.com>
References: <20190329065649.12468-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

When doing kexec_file_load(), the first kernel needs to pass the e820
reserved ranges to the second kernel, because some devices may use it
in kdump kernel, such as PCI devices.

But, the kernel can not exactly match the e820 reserved ranges when
walking through the iomem resources via the 'IORES_DESC_NONE', because
there are several types of e820 that are described as the 'IORES_DESC_NONE'
type. Please refer to the e820_type_to_iores_desc().

Therefore, add a new I/O resource descriptor 'IORES_DESC_RESERVED' for
the iomem resources search interfaces. It is helpful to exactly match
the reserved resource ranges when walking through iomem resources.

In addition, since the new descriptor 'IORES_DESC_RESERVED' has been
created for the reserved areas, the code originally related to the
descriptor 'IORES_DESC_NONE' also need to be updated.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/e820.c |  2 +-
 arch/x86/mm/ioremap.c  | 16 ++++++++++++++--
 include/linux/ioport.h |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 2879e234e193..16fcde196243 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1050,10 +1050,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
 	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
+	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
 	case E820_TYPE_UNUSABLE:	/* Fall-through: */
-	case E820_TYPE_RESERVED:	/* Fall-through: */
 	default:			return IORES_DESC_NONE;
 	}
 }
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0029604af8a4..5671ec24df49 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -81,9 +81,21 @@ static bool __ioremap_check_ram(struct resource *res)
 	return false;
 }
 
-static int __ioremap_check_desc_other(struct resource *res)
+/*
+ * Originally, these areas described as IORES_DESC_NONE are not mapped
+ * as encrypted when using ioremap(), for example, E820_TYPE_{RESERVED,
+ * RESERVED_KERN,RAM,UNUSABLE}, etc. It checks for a resource that is
+ * not described as IORES_DESC_NONE, which can make sure the reserved
+ * areas are not mapped as encrypted when using ioremap().
+ *
+ * Now IORES_DESC_RESERVED has been created for the reserved areas so
+ * the check needs to be expanded so that these areas are not mapped
+ * encrypted when using ioremap().
+ */
+static int __ioremap_check_desc_none_and_reserved(struct resource *res)
 {
-	return (res->desc != IORES_DESC_NONE);
+	return ((res->desc != IORES_DESC_NONE) &&
+		(res->desc != IORES_DESC_RESERVED));
 }
 
 static int __ioremap_res_check(struct resource *res, void *arg)
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..6ed59de48bd5 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -133,6 +133,7 @@ enum {
 	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
+	IORES_DESC_RESERVED			= 8,
 };
 
 /* helpers to define resources */
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
