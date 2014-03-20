Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQXZM-0005Th-OZ
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 07:39:19 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH v3 1/2] kexec: introduce setup_dtb_prop to make code clear
Date: Thu, 20 Mar 2014 07:33:56 +0000
Message-ID: <1395300837-18687-2-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1395300837-18687-1-git-send-email-wangnan0@huawei.com>
References: <1395300837-18687-1-git-send-email-wangnan0@huawei.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

This patch introduces setup_dtb_prop(), which is used for dtb
operations. The code is extracted from zImage_arm_load, and this patch
makes memory grown computation more accurate.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Geng Hui <hui.geng@huawei.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 96 ++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 26 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 8a35018..977254e 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -216,6 +216,68 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
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
+	/* 
+	 * Potential memory usage grown:
+	 *
+	 * 1. if fdt_add_subnode is called:
+	 *    sizeof(struct fdt_node_header) + FDT_TAGALIGN(nodename+1) + FDT_TAGSIZE
+	 *       // see fdt_add_subnode_namelen()
+	 *
+	 * 2. in fdt_setprop, if _fdt_add_property is called:
+	 *  a) strlen(prop_name) + 1  // see _fdt_find_add_string()
+	 *  b) sizeof(struct fdt_property) + FDT_TAGALIGN(len) 
+	 *        // see _fdt_add_property()
+	 *
+	 * FDT_TAGALIGN is (FDT_ALIGN((x), FDT_TAGSIZE)), which is same
+	 * to _ALIGN(x, FDT_TAGSIZE).
+	 */
+
+	*sizep = fdt_totalsize(*bufp) +
+		/* fdt_add_subnode -> fdt_add_subnode_namelen */
+		sizeof(struct fdt_node_header) +
+		_ALIGN(strlen(node_name) + 1, FDT_TAGSIZE) +
+		FDT_TAGSIZE +
+		/* fdt_setprop -> _fdt_add_property -> _fdt_find_add_string */
+		strlen(prop_name) + 1 +
+		/* fdt_setprop -> _fdt_add_property */
+		sizeof(struct fdt_property) + _ALIGN(len, FDT_TAGSIZE);
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
@@ -375,32 +437,14 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
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
-					return -1;
-				}
-
-				if (fdt_setprop(dtb_buf, off, prop_name,
-						command_line, strlen(command_line) + 1) != 0) {
-					fprintf(stderr, "FDT: Error setting %s/%s property.\n",
-						node_name, prop_name);
-					return -1;
-				}
+				/*  
+				 *  Error should have been reported so
+				 *  directly return -1
+				 */
+				if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+						"bootargs", command_line,
+						strlen(command_line) + 1))
+ 					return -1;
 			}
 		} else {
 			/*
-- 
1.8.3.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
