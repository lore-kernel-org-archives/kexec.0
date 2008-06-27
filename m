Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCBsJ-0004YP-BQ
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 11:12:19 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 2/2] Use FIRMWARE_MEMMAP on x86/E820
Date: Fri, 27 Jun 2008 13:12:55 +0200
Message-Id: <1214565175-21512-3-git-send-email-bwalle@suse.de>
In-Reply-To: <1214565175-21512-1-git-send-email-bwalle@suse.de>
References: <1214565175-21512-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org
Cc: Bernhard Walle <bwalle@suse.de>, gregkh@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com, vgoyal@redhat.com

This patch uses the /sys/firmware/memmap interface provided in the last patch
on the x86 architecture when E820 is used. The patch copies the E820
memory map very early, and registers the E820 map afterwards via
firmware_map_add_early().


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/x86/kernel/e820.c |   42 ++++++++++++++++++++++++++++++++++++------
 include/asm-x86/e820.h |    2 ++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 1dcb665..e48eb10 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/suspend.h>
+#include <linux/firmware-map.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -27,7 +28,22 @@
 #include <asm/setup.h>
 #include <asm/trampoline.h>
 
+/*
+ * The e820 map is the map that gets modified e.g. with command line parameters
+ * and that is also registered with modifications in the kernel resource tree
+ * with the iomem_resource as parent.
+ *
+ * The e820_saved is directly saved after the BIOS-provided memory map is
+ * copied. It doesn't get modified afterwards. It's registered for the
+ * /sys/firmware/memmap interface.
+ *
+ * That memory map is not modified and is used as base for kexec. The kexec'd
+ * kernel should get the same memory map as the firmware provides. Then the
+ * user can e.g. boot the original kernel with mem=1G while still booting the
+ * next kernel with full memory.
+ */
 struct e820map e820;
+struct e820map e820_saved;
 
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0xaeedbabe;
@@ -1180,6 +1196,16 @@ void __init finish_e820_parsing(void)
 	}
 }
 
+static inline const char *e820_type_to_string(int e820_type)
+{
+	switch (e820_type) {
+	case E820_RAM:	return "System RAM";
+	case E820_ACPI:	return "ACPI Tables";
+	case E820_NVS:	return "ACPI Non-volatile Storage";
+	default:	return "reserved";
+	}
+}
+
 /*
  * Mark e820 reserved areas as busy for the resource manager.
  */
@@ -1190,12 +1216,7 @@ void __init e820_reserve_resources(void)
 
 	res = alloc_bootmem_low(sizeof(struct resource) * e820.nr_map);
 	for (i = 0; i < e820.nr_map; i++) {
-		switch (e820.map[i].type) {
-		case E820_RAM:	res->name = "System RAM"; break;
-		case E820_ACPI:	res->name = "ACPI Tables"; break;
-		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
-		default:	res->name = "reserved";
-		}
+		res->name = e820_type_to_string(e820.map[i].type);
 		res->start = e820.map[i].addr;
 		res->end = res->start + e820.map[i].size - 1;
 #ifndef CONFIG_RESOURCES_64BIT
@@ -1208,6 +1229,13 @@ void __init e820_reserve_resources(void)
 		insert_resource(&iomem_resource, res);
 		res++;
 	}
+
+	for (i = 0; i < e820_saved.nr_map; i++) {
+		struct e820entry *entry = &e820_saved.map[i];
+		firmware_map_add_early(entry->addr,
+			entry->addr + entry->size - 1,
+			e820_type_to_string(entry->type));
+	}
 }
 
 char *__init default_machine_specific_memory_setup(void)
@@ -1243,6 +1271,8 @@ char *__init default_machine_specific_memory_setup(void)
 		e820_add_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
 	}
 
+	memcpy(&e820_saved, &e820, sizeof(struct e820map));
+
 	/* In case someone cares... */
 	return who;
 }
diff --git a/include/asm-x86/e820.h b/include/asm-x86/e820.h
index f622685..64ce6f8 100644
--- a/include/asm-x86/e820.h
+++ b/include/asm-x86/e820.h
@@ -56,7 +56,9 @@ struct e820map {
 	struct e820entry map[E820_X_MAX];
 };
 
+/* see comment in arch/x86/kernel/e820.c */
 extern struct e820map e820;
+extern struct e820map e820_saved;
 
 extern int e820_any_mapped(u64 start, u64 end, unsigned type);
 extern int e820_all_mapped(u64 start, u64 end, unsigned type);
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
