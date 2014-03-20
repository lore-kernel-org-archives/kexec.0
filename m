Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQSve-0000Lj-HA
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 02:42:00 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 2/2] kexec: pass initrd position in dtb
Date: Thu, 20 Mar 2014 10:36:33 +0800
Message-ID: <1395282993-37549-3-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1395282993-37549-1-git-send-email-wangnan0@huawei.com>
References: <1395282993-37549-1-git-send-email-wangnan0@huawei.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: dyoung@redhat.com
Cc: Wang Nan <wangnan0@huawei.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

This patch append the position of initrd to dtb when loading arm kernel
and initrd without using atag.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Geng Hui <hui.geng@huawei.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 84 +++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 8a35018..15d8829 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -20,6 +20,7 @@
 #include "kexec-arm.h"
 #include "../../fs2dt.h"
 #include "crashdump-arm.h"
+#include "libfdt_internal.h"
 
 #define BOOT_PARAMS_SIZE 1536
 
@@ -216,6 +217,47 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 	return 0;
 }
 
+static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
+		const char *prop_name, const void *val, int len)
+{
+	char *dtb_buf;
+	int off;
+
+	if ((bufp == NULL) || (sizep == NULL) || (*bufp == NULL))
+		die("Internal error\n");
+
+	dtb_buf = *bufp;
+
+	*sizep = fdt_totalsize(*bufp) + FDT_TAGSIZE + len +
+		FDT_TAGALIGN(strlen(node_name) + 1) +
+		FDT_TAGALIGN(strlen(prop_name) + 1) +
+		sizeof(struct fdt_property);
+
+	dtb_buf = xrealloc(dtb_buf, *sizep);
+	if (dtb_buf == NULL)
+		die("xrealloc failed\n");
+	*bufp = dtb_buf;
+
+	fdt_set_totalsize(dtb_buf, *sizep);
+
+	/* check if the subnode already exists */
+	off = fdt_path_offset(dtb_buf, node_name);
+
+	if (off == -FDT_ERR_NOTFOUND)
+		off = fdt_add_subnode(dtb_buf, off, node_name);
+	if (off < 0) {
+		fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
+		return -1;
+	}
+	if (fdt_setprop(dtb_buf, off, prop_name,
+				val, len) != 0) {
+		fprintf(stderr, "FDT: Error setting %s/%s property.\n",
+				node_name, prop_name);
+		return -1;
+	}
+	return 0;
+}
+
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
@@ -375,32 +417,11 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			}
 
 			if (command_line) {
-				const char *node_name = "/chosen";
-				const char *prop_name = "bootargs";
-				int off;
-
-				dtb_length = fdt_totalsize(dtb_buf) + 1024 +
-					strlen(command_line);
-				dtb_buf = xrealloc(dtb_buf, dtb_length);
-				fdt_set_totalsize(dtb_buf, dtb_length);
-
-				/* check if a /choosen subnode already exists */
-				off = fdt_path_offset(dtb_buf, node_name);
-
-				if (off == -FDT_ERR_NOTFOUND)
-					off = fdt_add_subnode(dtb_buf, off, node_name);
-
-				if (off < 0) {
-					fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
+				/* Error should have been reported */
+				if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+						"bootargs", command_line,
+						strlen(command_line) + 1))
 					return -1;
-				}
-
-				if (fdt_setprop(dtb_buf, off, prop_name,
-						command_line, strlen(command_line) + 1) != 0) {
-					fprintf(stderr, "FDT: Error setting %s/%s property.\n",
-						node_name, prop_name);
-					return -1;
-				}
 			}
 		} else {
 			/*
@@ -417,6 +438,19 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		if (ramdisk) {
 			add_segment(info, ramdisk_buf, initrd_size,
 			            initrd_base, initrd_size);
+
+			unsigned long start, end;
+			start = cpu_to_be32((unsigned long)(initrd_base));
+			end = cpu_to_be32((unsigned long)(initrd_base + initrd_size));
+
+			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+					"linux,initrd-start", &start,
+					sizeof(start)))
+				return -1;
+			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+					"linux,initrd-end", &end,
+					sizeof(end)))
+				return -1;
 		}
 
 		/* Stick the dtb at the end of the initrd and page
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
