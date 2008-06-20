Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K9iyO-0001bp-Je
	for kexec@lists.infradead.org; Fri, 20 Jun 2008 15:56:25 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 2/3] Use /proc/firmware_mem for x86 (e820)
Date: Fri, 20 Jun 2008 17:56:59 +0200
Message-Id: <1213977420-1555-3-git-send-email-bwalle@suse.de>
In-Reply-To: <1213977420-1555-1-git-send-email-bwalle@suse.de>
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
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
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

This patch copies the E820 map very early, before the kernel applies various
operations. That copy is used later to register only the BIOS-provided E820
map later in the resource tree for /proc/firmware_mem.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/x86/kernel/e820.c |   44 ++++++++++++++++++++++++++++++++++----------
 include/asm-x86/e820.h |    2 ++
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7b613d2..f5b1736 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -27,7 +27,22 @@
 #include <asm/setup.h>
 #include <asm/trampoline.h>
 
+/*
+ * The e820 map is the map that gets modified e.g. with command line parameters
+ * and that is also registered with modifications in the kernel resource tree
+ * with the iomem_resource as parent.
+ *
+ * The e820_saved is directly saved after the BIOS-provided memory map is
+ * copied. It doesn't get modified afterwards. It's registered in the
+ * resource system of the kernel with firmware_mem_resource as parent.
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
@@ -999,24 +1014,22 @@ void __init finish_e820_parsing(void)
 	}
 }
 
-/*
- * Mark e820 reserved areas as busy for the resource manager.
- */
-void __init e820_reserve_resources(void)
+static void __init e820_reserve_resources_map(struct e820map  *map,
+					      struct resource *root)
 {
 	int i;
 	struct resource *res;
 
-	res = alloc_bootmem_low(sizeof(struct resource) * e820.nr_map);
-	for (i = 0; i < e820.nr_map; i++) {
-		switch (e820.map[i].type) {
+	res = alloc_bootmem_low(sizeof(struct resource) * map->nr_map);
+	for (i = 0; i < map->nr_map; i++) {
+		switch (map->map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
 		case E820_ACPI:	res->name = "ACPI Tables"; break;
 		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
 		default:	res->name = "reserved";
 		}
-		res->start = e820.map[i].addr;
-		res->end = res->start + e820.map[i].size - 1;
+		res->start = map->map[i].addr;
+		res->end = res->start + map->map[i].size - 1;
 #ifndef CONFIG_RESOURCES_64BIT
 		if (res->end > 0x100000000ULL) {
 			res++;
@@ -1024,11 +1037,20 @@ void __init e820_reserve_resources(void)
 		}
 #endif
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		insert_resource(&iomem_resource, res);
+		insert_resource(root, res);
 		res++;
 	}
 }
 
+/*
+ * Mark e820 reserved areas as busy for the resource manager.
+ */
+void __init e820_reserve_resources(void)
+{
+	e820_reserve_resources_map(&e820, &iomem_resource);
+	e820_reserve_resources_map(&e820_saved, &firmware_mem_resource);
+}
+
 char *__init default_machine_specific_memory_setup(void)
 {
 	char *who = "BIOS-e820";
@@ -1062,6 +1084,8 @@ char *__init default_machine_specific_memory_setup(void)
 		e820_add_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
 	}
 
+	memcpy(&e820_saved, &e820, sizeof(struct e820map));
+
 	/* In case someone cares... */
 	return who;
 }
diff --git a/include/asm-x86/e820.h b/include/asm-x86/e820.h
index 668a0d7..48e7181 100644
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
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
