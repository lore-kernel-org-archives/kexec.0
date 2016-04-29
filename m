Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw9K4-0008LN-6d
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 14:23:13 +0000
From: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
Subject: [PATCH v2 3/3] arm: Change setup_dtb_prop to create nodes by offset
 and node name
Date: Fri, 29 Apr 2016 16:22:23 +0200
Message-Id: <1461939743-21775-4-git-send-email-nikolaus.schulz@avionic-design.de>
In-Reply-To: <1461939743-21775-1-git-send-email-nikolaus.schulz@avionic-design.de>
References: <1461939743-21775-1-git-send-email-nikolaus.schulz@avionic-design.de>
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
To: Simon Horman <horms@verge.net.au>
Cc: Alban Bedel <alban.bedel@avionic-design.de>, kexec@lists.infradead.org, Nikolaus Schulz <nikolaus.schulz@avionic-design.de>

setup_dtb_prop looks like a generic function that can find and add any
nodes, which need not be top-level in the DT.  In practice though, the
function is only used for the top-level /chosen node, and it can't add
nodes for which the parent doesn't exist.

So far, so good - but for adding a new node to the DT, the parent offset
need be passed to fdt_add_subnode.  Currently in setup_dtb_prop the
parent offset is unknown, and instead a bogus error code is passed to
fdt_add_subnode.

Fix that by adding the parent offset as an extra function argument to
setup_dtb_prop, and change the handling of the /chosen node to operate
on a relative path plus (zero) offset instead of an absolute path. This
aligns setup_dtb_prop to the libfdt API, where functions commonly
operate with a parent offset plus child node name.

Signed-off-by: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
---
 kexec/arch/arm/kexec-zImage-arm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 3222dd3..6b548c3 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -274,8 +274,9 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 	return 0;
 }
 
-static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
-		const char *prop_name, const void *val, int len)
+static int setup_dtb_prop(char **bufp, off_t *sizep, int parentoffset,
+		const char *node_name, const char *prop_name,
+		const void *val, int len)
 {
 	char *dtb_buf;
 	off_t dtb_size;
@@ -290,14 +291,14 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
 	dtb_size = *sizep;
 
 	/* check if the subnode has already exist */
-	off = fdt_path_offset(dtb_buf, node_name);
+	off = fdt_subnode_offset(dtb_buf, parentoffset, node_name);
 	if (off == -FDT_ERR_NOTFOUND) {
 		dtb_size += fdt_node_len(node_name);
 		fdt_set_totalsize(dtb_buf, dtb_size);
 		dtb_buf = xrealloc(dtb_buf, dtb_size);
 		if (dtb_buf == NULL)
 			die("xrealloc failed\n");
-		off = fdt_add_subnode(dtb_buf, off, node_name);
+		off = fdt_add_subnode(dtb_buf, parentoffset, node_name);
 	}
 
 	if (off < 0) {
@@ -548,7 +549,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 				 *  Error should have been reported so
 				 *  directly return -1
 				 */
-				if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+				if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
 						"bootargs", command_line,
 						strlen(command_line) + 1))
 					return -1;
@@ -594,11 +595,11 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			start = cpu_to_be32((unsigned long)(initrd_base));
 			end = cpu_to_be32((unsigned long)(initrd_base + initrd_size));
 
-			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+			if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
 					"linux,initrd-start", &start,
 					sizeof(start)))
 				return -1;
-			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+			if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
 					"linux,initrd-end", &end,
 					sizeof(end)))
 				return -1;
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
