Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from svenfoo.org ([82.94.215.22] helo=mail.zonque.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tj8x9-0006zR-75
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 13:35:56 +0000
From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] kexec-zImage-arm: add code to support --command-line along
 with --dtb
Date: Thu, 13 Dec 2012 14:35:34 +0100
Message-Id: <1355405734-19630-1-git-send-email-zonque@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: matthew.leach@arm.com, horms@verge.net.au, s.neumann@raumfeld.com, Daniel Mack <zonque@gmail.com>

If --dtb is called together with --command-line, we need to modify the
binary dtb buffer. Luckily, we have libfdt functions available, so this
is straight forward.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 46cedbf..0950897 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -359,6 +359,49 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		 */
 		if (dtb_file) {
 			dtb_buf = slurp_file(dtb_file, &dtb_length);
+
+			if (fdt_check_header(dtb_buf) != 0) {
+				fprintf(stderr, "Invalid FDT buffer.\n");
+				return -1;
+			}
+
+			if (command_line) {
+				const char *node_name = "/chosen";
+				const char *prop_name = "bootargs";
+				int off;
+
+				/* check if a /choosen subnode already exists */
+				off = fdt_path_offset(dtb_buf, node_name);
+
+				if (off == -FDT_ERR_NOTFOUND) {
+					dtb_length = fdt_totalsize(dtb_buf)
+							+ strlen(node_name) + 1
+							+ sizeof(struct fdt_node_header)
+							+ FDT_TAGSIZE;
+					dtb_buf = xrealloc(dtb_buf, dtb_length);
+					fdt_set_totalsize(dtb_buf, dtb_length);
+					off = fdt_add_subnode(dtb_buf, off, node_name);
+				}
+
+				if (off < 0) {
+					fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
+					return -1;
+				}
+
+				dtb_length = fdt_totalsize(dtb_buf)
+						+ strlen(prop_name)
+						+ strlen(command_line) + 1
+						+ sizeof(struct fdt_property);
+				dtb_buf = xrealloc(dtb_buf, dtb_length);
+				fdt_set_totalsize(dtb_buf, dtb_length);
+
+				if (fdt_setprop(dtb_buf, off, prop_name,
+						command_line, strlen(command_line) + 1) != 0) {
+					fprintf(stderr, "FDT: Error setting %s/%s property.\n",
+						node_name, prop_name);
+					return -1;
+				}
+			}
 		} else {
 			/*
 			 * Extract the DTB from /proc/device-tree.
@@ -366,11 +409,6 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			create_flatten_tree(&dtb_buf, &dtb_length, command_line);
 		}
 
-		if (fdt_check_header(dtb_buf) != 0) {
-			fprintf(stderr, "Invalid FDT buffer.\n");
-			return -1;
-		}
-
 		if (base + atag_offset + dtb_length > base + offset) {
 			fprintf(stderr, "DTB too large!\n");
 			return -1;
-- 
1.7.11.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
