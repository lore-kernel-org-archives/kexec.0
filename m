Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]
	helo=VA3EHSOBE010.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OZ3x3-0007LP-8h
	for kexec@lists.infradead.org; Wed, 14 Jul 2010 15:32:51 +0000
Received: from mail7-va3 (localhost.localdomain [127.0.0.1])	by
	mail7-va3-R.bigfish.com (Postfix) with ESMTP id 8D6891030417	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 15:32:44 +0000 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.237])	by
	mail7-va3.bigfish.com (Postfix) with ESMTP id 455B78A8050	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 15:32:42 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6EFWdVK012991	for <kexec@lists.infradead.org>;
	Wed, 14 Jul 2010 08:32:39 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH] Add support for reworking flat device tree support
Date: Wed, 14 Jul 2010 10:32:36 -0500
Message-ID: <1279121556-8069-5-git-send-email-msm@freescale.com>
In-Reply-To: <1279121556-8069-4-git-send-email-msm@freescale.com>
References: <1279121556-8069-1-git-send-email-msm@freescale.com>
	<1279121556-8069-2-git-send-email-msm@freescale.com>
	<1279121556-8069-3-git-send-email-msm@freescale.com>
	<1279121556-8069-4-git-send-email-msm@freescale.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Matthew McClintock <msm@freescale.com>

Currently, the device tree is passed as is. You can optionally
update the command line and specifically listed nodes but nothing
is updated automatically.

This patch updates the memreserve regions, memory node, initrd
nodes and attempts to make the device tree look as it should. Some
code is borrowed from the u-boot routines which do similiar things

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/fixup_dtb.c        |  237 ++++++++++++++++++++++++++++++++++++-
 kexec/arch/ppc/fixup_dtb.h        |    3 +-
 kexec/arch/ppc/kexec-elf-ppc.c    |    5 +-
 kexec/arch/ppc/kexec-ppc.h        |    1 +
 kexec/arch/ppc/kexec-uImage-ppc.c |    3 +-
 kexec/arch/ppc/ops.h              |    1 -
 6 files changed, 243 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 40e9350..3cb66cf 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -8,13 +8,34 @@
 #include <sys/stat.h>
 
 #include "../../kexec.h"
+#include "../../kexec-syscall.h"
 #include <libfdt.h>
 #include "ops.h"
 #include "page.h"
 #include "fixup_dtb.h"
+#include "kexec-ppc.h"
 
 const char proc_dts[] = "/proc/device-tree";
 
+static void print_fdt_reserve_regions(char *blob_buf)
+{
+	int i, num;
+
+	/* Print out a summary of the final reserve regions */
+	num =  fdt_num_mem_rsv(blob_buf);
+	printf ("reserve regions: %d\n", num);
+	for (i = 0; i < num; i++)
+	{
+		uint64_t offset, size;
+
+		if (fdt_get_mem_rsv(blob_buf, i, &offset, &size) == 0) {
+			printf("%d: offset: %llx, size: %llx\n", i, offset, size);
+		} else {
+			printf("Error retreiving reserved region\n");
+		}
+	}
+}
+
 static void fixup_nodes(char *nodes[])
 {
 	int index = 0;
@@ -92,12 +113,226 @@ static void fixup_cmdline(const char *cmdline)
 	return;
 }
 
-char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline)
+#define EXPAND_GRANULARITY     1024
+
+static char *expand_buf(int minexpand, char *blob_buf, off_t *blob_size)
+{
+	int size = fdt_totalsize(blob_buf);
+	int rc;
+
+	size = _ALIGN(size + minexpand, EXPAND_GRANULARITY);
+	blob_buf = realloc(blob_buf, size);
+	if (!blob_buf)
+		fatal("Couldn't find %d bytes to expand device tree\n\r", size);
+	rc = fdt_open_into(blob_buf, blob_buf, size);
+	if (rc != 0)
+		fatal("Couldn't expand fdt into new buffer: %s\n\r",
+			fdt_strerror(rc));
+
+	*blob_size = fdt_totalsize(blob_buf);
+
+	return blob_buf;
+}
+
+static char *fixup_reserve_regions(struct kexec_info *info, char *blob_buf, off_t *blob_size,
+			unsigned long hole_addr)
+{
+	int ret;
+	int i, num = fdt_num_mem_rsv(blob_buf);
+	unsigned long dtb_future_addr;
+
+	/* Remove the existing reserve regions as they will no longer
+	 * be valid after we reboot */
+	for (i = num - 1; i >= 0; i--)
+	{
+		uint64_t address, size;
+
+		ret = fdt_get_mem_rsv(blob_buf, i, &address, &size);
+		if (ret) {
+			printf("%s: Error getting old memory reserve regions %d\n",
+					fdt_strerror(ret), i);
+		}
+
+		/* TODO: What else do we remove? */
+		if ( (address == initrd_base && PAGE_ALIGN(size) == PAGE_ALIGN(initrd_size)) ||
+		     (address == devicetree_base && PAGE_ALIGN(size) == PAGE_ALIGN(devicetree_size)) ) {
+			ret = fdt_del_mem_rsv(blob_buf, i);
+			if (ret) {
+				printf("%s: Error deleting memory reserve region %d from device tree!\n",
+						fdt_strerror(ret), i);
+			}
+		}
+	}
+
+	num = fdt_num_mem_rsv(blob_buf);
+
+	/* Pack the FDT first, so we don't grow excessively if there is already free space */
+	ret = fdt_pack(blob_buf);
+	if (ret)
+		printf("%s: Unable to pack flat device tree\n", fdt_strerror(ret));
+	blob_buf = expand_buf(info->nr_segments, blob_buf, blob_size);
+
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		/* Add reserve regions for all segments since it's not too important to add
+		 * extra stuff, we just need to make sure we get the elf headers reserved */
+		for (i = 0; i < info->nr_segments; i++)
+		{
+			uint64_t address, size;
+
+			address = (size_t)info->segment[i].mem;
+			size = info->segment[i].memsz;
+
+			/* check for overlapping segments */
+			while (((i + 1) < info->nr_segments) &&
+				((info->segment[i].mem + info->segment[i].memsz) == info->segment[i+1].mem))
+			{
+				size += info->segment[i+1].memsz;
+				i++; /* skip next item as well */
+			}
+
+			ret = fdt_add_mem_rsv(blob_buf, address, size);
+			if (ret)
+			printf("%s: Unable to add new reserved memory\n",
+				fdt_strerror(ret));
+		}
+	}
+	else {
+		/* Otherwise we just add back the ramdisk and device tree regions */
+		ret = fdt_add_mem_rsv(blob_buf, ramdisk_base, ramdisk_size);
+		if (ret) {
+			printf("%s: Unable to add new reserved memory for initrd flat device tree\n",
+				fdt_strerror(ret));
+		}
+	}
+
+	/* add reserve region for *THIS* fdt */
+	dtb_future_addr = locate_hole(info, PAGE_ALIGN(*blob_size), 0,
+				hole_addr, hole_addr+KERNEL_ACCESS_TOP, -1);
+
+	ret = fdt_add_mem_rsv(blob_buf, dtb_future_addr, PAGE_ALIGN(*blob_size));
+	if (ret) {
+		printf("%s: Unable to add new reserved memory for the flat device tree\n",
+			fdt_strerror(ret));
+	}
+
+#if DEBUG
+	print_fdt_reserve_regions(blob_buf);
+#endif
+
+	return blob_buf;
+}
+
+static void fixup_memory(struct kexec_info *info, char *blob_buf)
+{
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		int nodeoffset, len = 0;
+		u8 tmp[16];
+		const unsigned long *addrcell, *sizecell;
+
+		nodeoffset = fdt_path_offset(blob_buf, "/memory");
+
+		if (nodeoffset < 0)
+			printf("Error searching for memory node!\n");
+
+		addrcell = fdt_getprop(blob_buf, 0, "#address-cells", NULL);
+		/* use shifts and mask to ensure endianness */
+		if ((addrcell) && (*addrcell == 2)) {
+			tmp[0] = (crash_base >> 56) & 0xff;
+			tmp[1] = (crash_base >> 48) & 0xff;
+			tmp[2] = (crash_base >> 40) & 0xff;
+			tmp[3] = (crash_base >> 32) & 0xff;
+			tmp[4] = (crash_base >> 24) & 0xff;
+			tmp[5] = (crash_base >> 16) & 0xff;
+			tmp[6] = (crash_base >>  8) & 0xff;
+			tmp[7] = (crash_base      ) & 0xff;
+			len = 8;
+		} else {
+			tmp[0] = (crash_base >> 24) & 0xff;
+			tmp[1] = (crash_base >> 16) & 0xff;
+			tmp[2] = (crash_base >>  8) & 0xff;
+			tmp[3] = (crash_base      ) & 0xff;
+			len = 4;
+		}
+
+		sizecell = fdt_getprop(blob_buf, 0, "#size-cells", NULL);
+		/* use shifts and mask to ensure endianness */
+		if ((sizecell) && (*sizecell == 2)) {
+			tmp[0+len] = (crash_size >> 56) & 0xff;
+			tmp[1+len] = (crash_size >> 48) & 0xff;
+			tmp[2+len] = (crash_size >> 40) & 0xff;
+			tmp[3+len] = (crash_size >> 32) & 0xff;
+			tmp[4+len] = (crash_size >> 24) & 0xff;
+			tmp[5+len] = (crash_size >> 16) & 0xff;
+			tmp[6+len] = (crash_size >>  8) & 0xff;
+			tmp[7+len] = (crash_size      ) & 0xff;
+			len += 8;
+		} else {
+			tmp[0+len] = (crash_size >> 24) & 0xff;
+			tmp[1+len] = (crash_size >> 16) & 0xff;
+			tmp[2+len] = (crash_size >>  8) & 0xff;
+			tmp[3+len] = (crash_size      ) & 0xff;
+			len += 4;
+		}
+
+		if (fdt_setprop(blob_buf, nodeoffset, "reg", tmp, len) != 0) {
+			printf ("Error setting memory node!\n");
+		}
+	}
+}
+
+/* remove the old chosen nodes if they exist and add correct chosen
+ * nodes if we have an initd
+ */
+static void fixup_initrd(char *blob_buf)
+{
+	int err, nodeoffset;
+	unsigned long tmp;
+
+	nodeoffset = fdt_path_offset(blob_buf, "/chosen");
+
+	if ((reuse_initrd || ramdisk) &&
+		((ramdisk_base != 0) && (ramdisk_size != 0)))
+	{
+		if (nodeoffset < 0)
+		{
+			printf("fdt_initrd: %s\n", fdt_strerror(nodeoffset));
+			return;
+		}
+
+		tmp = ramdisk_base;
+		err = fdt_setprop(blob_buf, nodeoffset,
+			"linux,initrd-start", &tmp, sizeof(tmp));
+		if (err < 0) {
+			printf("WARNING: "
+				"could not set linux,initrd-start %s.\n",
+				fdt_strerror(err));
+				return;
+		}
+
+		tmp = ramdisk_base + ramdisk_size + 1;
+		err = fdt_setprop(blob_buf, nodeoffset,
+			"linux,initrd-end", &tmp, sizeof(tmp));
+		if (err < 0) {
+			printf("WARNING: could not set linux,initrd-end %s.\n",
+				fdt_strerror(err));
+				return;
+		}
+	} else {
+		fdt_delprop(blob_buf, nodeoffset, "linux,initrd-start");
+		fdt_delprop(blob_buf, nodeoffset, "linux,initrd-end");
+	}
+}
+
+char *fixup_dtb_nodes(struct kexec_info *info, char *blob_buf, off_t *blob_size,
+			char *nodes[], char *cmdline, unsigned long hole_addr)
 {
 	fdt_init(blob_buf);
 
 	fixup_nodes(nodes);
 	fixup_cmdline(cmdline);
+	blob_buf = fixup_reserve_regions(info, blob_buf, blob_size, hole_addr);
+	fixup_memory(info, blob_buf);
+	fixup_initrd(blob_buf);
 
 	blob_buf = (char *)dt_ops.finalize();
 	*blob_size = fdt_totalsize(blob_buf);
diff --git a/kexec/arch/ppc/fixup_dtb.h b/kexec/arch/ppc/fixup_dtb.h
index 0ff981e..5e3abc8 100644
--- a/kexec/arch/ppc/fixup_dtb.h
+++ b/kexec/arch/ppc/fixup_dtb.h
@@ -1,6 +1,7 @@
 #ifndef __FIXUP_DTB_H
 #define __FIXUP_DTB_H
 
-char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline);
+char *fixup_dtb_nodes(struct kexec_info *info, char *blob_buf, off_t *blob_size,
+			char *nodes[], char *cmdline, unsigned long hole_addr);
 
 #endif
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 58bba54..aa96475 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -385,9 +385,8 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		blob_buf = slurp_file(dtb, &blob_size);
 		if (!blob_buf || !blob_size)
 			die("Device tree seems to be an empty file.\n");
-
-		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes,
-				cmdline_buf);
+		blob_buf = fixup_dtb_nodes(info, blob_buf, &blob_size, fixup_nodes,
+				cmdline_buf, kernel_addr);
 		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, kernel_addr,
 				kernel_addr + KERNEL_ACCESS_TOP, -1);
 	} else {
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index 5ad3575..029a656 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -64,6 +64,7 @@ typedef struct mem_rgns {
 } mem_rgns_t;
 extern mem_rgns_t usablemem_rgns;
 extern int max_memory_ranges;
+extern unsigned long long crash_base, crash_size;
 extern unsigned long long initrd_base, initrd_size;
 extern unsigned long long ramdisk_base, ramdisk_size;
 extern unsigned long long devicetree_base, devicetree_size;
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 310d6c3..a70ebb7 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -189,7 +189,8 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		blob_buf = slurp_file(dtb, &blob_size);
 		if (!blob_buf || !blob_size)
 			die("Device tree seems to be an empty file.\n");
-		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes, cmdline_buf);
+		blob_buf = fixup_dtb_nodes(info, blob_buf, &blob_size, fixup_nodes, cmdline_buf,
+						load_addr);
 		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, load_addr,
 				load_addr + KERNEL_ACCESS_TOP, -1);
 	} else {
diff --git a/kexec/arch/ppc/ops.h b/kexec/arch/ppc/ops.h
index f33e941..a2eb140 100644
--- a/kexec/arch/ppc/ops.h
+++ b/kexec/arch/ppc/ops.h
@@ -147,5 +147,4 @@ static inline char *get_path(const void *phandle, char *buf, int len)
 
 #define fatal(args...) { printf(args); exit(1); }
 
-char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline);
 #endif /* _PPC_BOOT_OPS_H_ */
-- 
1.6.0.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
