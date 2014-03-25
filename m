Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSImC-0002bp-Ri
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 04:15:55 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 2/3] kexec: introduce setup_dtb_prop to make code clear
Date: Tue, 25 Mar 2014 12:09:44 +0800
Message-ID: <1395720585-76135-3-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1395720585-76135-1-git-send-email-wangnan0@huawei.com>
References: <1395720585-76135-1-git-send-email-wangnan0@huawei.com>
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

This patch introduces setup_dtb_prop(), which is used for dtb operations. The
code is extracted from zImage_arm_load, and this patch makes memory grown
computation more accurate.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Geng Hui <hui.geng@huawei.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 93 ++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 25 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 8a35018..aea1278 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -216,6 +216,67 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 	return 0;
 }
 
+static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
+		const char *prop_name, const void *val, int len)
+{
+	char *dtb_buf;
+	off_t dtb_size;
+	int off;
+	int prop_len = 0;
+	const struct fdt_property *prop;
+
+	if ((bufp == NULL) || (sizep == NULL) || (*bufp == NULL))
+		die("Internal error\n");
+
+	dtb_buf = *bufp;
+	dtb_size = *sizep;
+
+	/* check if the subnode has already exist */
+	off = fdt_path_offset(dtb_buf, node_name);
+	if (off == -FDT_ERR_NOTFOUND) {
+		dtb_size += fdt_node_len(node_name);
+		fdt_set_totalsize(dtb_buf, dtb_size);
+		dtb_buf = xrealloc(dtb_buf, dtb_size);
+		if (dtb_buf == NULL)
+			die("xrealloc failed\n");
+		off = fdt_add_subnode(dtb_buf, off, node_name);
+	}
+
+	if (off < 0) {
+		fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
+		return -1;
+	}
+
+	prop = fdt_get_property(dtb_buf, off, prop_name, &prop_len);
+	if ((prop == NULL) && (prop_len != -FDT_ERR_NOTFOUND)) {
+		die("FDT: fdt_get_property");
+	} else if (prop == NULL) {
+		/* prop_len == -FDT_ERR_NOTFOUND */
+		/* prop doesn't exist */
+		dtb_size += fdt_prop_len(prop_name, len);
+	} else {
+		if (prop_len < len)
+			dtb_size += len - prop_len;
+	}
+
+	if (fdt_totalsize(dtb_buf) < dtb_size) {
+		fdt_set_totalsize(dtb_buf, dtb_size);
+		dtb_buf = xrealloc(dtb_buf, dtb_size);
+		if (dtb_buf == NULL)
+			die("xrealloc failed\n");
+	}
+
+	if (fdt_setprop(dtb_buf, off, prop_name,
+				val, len) != 0) {
+		fprintf(stderr, "FDT: Error setting %s/%s property.\n",
+				node_name, prop_name);
+		return -1;
+	}
+	*bufp = dtb_buf;
+	*sizep = dtb_size;
+	return 0;
+}
+
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
@@ -375,32 +436,14 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
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
+				/*
+				 *  Error should have been reported so
+				 *  directly return -1
+				 */
+				if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+						"bootargs", command_line,
+						strlen(command_line) + 1))
 					return -1;
-				}
 			}
 		} else {
 			/*
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
