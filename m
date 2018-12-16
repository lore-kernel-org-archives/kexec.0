Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYbuw-00085H-SV
 for kexec@lists.infradead.org; Sun, 16 Dec 2018 19:17:36 +0000
Received: by mail-pl1-f196.google.com with SMTP id g9so5057806plo.3
 for <kexec@lists.infradead.org>; Sun, 16 Dec 2018 11:17:24 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 4/4] kexec/dt-ops.c: Fix '/chosen' v/s 'chosen' node being
 passed to fdt helper functions
Date: Mon, 17 Dec 2018 00:46:55 +0530
Message-Id: <1544987815-19527-5-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1544987815-19527-1-git-send-email-bhsharma@redhat.com>
References: <1544987815-19527-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: takahiro.akashi@linaro.org, bhsharma@redhat.com, bhupesh.linux@gmail.com, vicencb@gmail.com, horms@verge.net.au

This patch fixes the incorrect 'chosen' node name being passed to
various fdt helper functions inside 'kexec/dt-ops.c'

As we can see from the Linux kernel usage inside
'drivers/firmware/efi/libstub/fdt.c', we pass '/chosen' node names to
fdt helper function like 'fdt_path_offset()' whereas 'chosen' to the
rest of the fdt helper functions like 'fdt_subnode_offset()'.

We need to replicate the same in 'kexec-tools' to fix issues being
reported when we use --dtb option while invoking 'kexec'.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/dt-ops.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
index bdc16dc87642..5626c47981c4 100644
--- a/kexec/dt-ops.c
+++ b/kexec/dt-ops.c
@@ -8,7 +8,7 @@
 #include "kexec.h"
 #include "dt-ops.h"
 
-static const char n_chosen[] = "/chosen";
+static const char n_chosen[] = "chosen";
 
 static const char p_bootargs[] = "bootargs";
 static const char p_initrd_start[] = "linux,initrd-start";
@@ -58,6 +58,7 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
 	int nodeoffset;
 	void *new_dtb;
 	int new_size;
+	char *new_node = NULL;
 
 	value_len = FDT_TAGALIGN(value_len);
 
@@ -79,7 +80,16 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
 		goto on_error;
 	}
 
-	nodeoffset = fdt_path_offset(new_dtb, node);
+	new_node = malloc(strlen("/") + strlen(node) + 1);
+	if (!new_node) {
+		dbgprintf("%s: malloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	strcpy(new_node, "/");
+	strcat(new_node, node);
+	
+	nodeoffset = fdt_path_offset(new_dtb, new_node);
 
 	if (nodeoffset == -FDT_ERR_NOTFOUND) {
 		result = fdt_add_subnode(new_dtb, 0, node);
@@ -122,17 +132,29 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
 
 on_error:
 	free(new_dtb);
+	free(new_node);
 	return result;
 }
 
 int dtb_delete_property(char *dtb, const char *node, const char *prop)
 {
-	int result;
-	int nodeoffset = fdt_path_offset(dtb, node);
+	int result, nodeoffset;
+	char *new_node = NULL;
+
+	new_node = malloc(strlen("/") + strlen(node) + 1);
+	if (!new_node) {
+		dbgprintf("%s: malloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	strcpy(new_node, "/");
+	strcat(new_node, node);
 
+	nodeoffset = fdt_path_offset(dtb, new_node);
 	if (nodeoffset < 0) {
 		dbgprintf("%s: fdt_path_offset failed: %s\n", __func__,
 			fdt_strerror(nodeoffset));
+		free(new_node);
 		return nodeoffset;
 	}
 
@@ -142,5 +164,6 @@ int dtb_delete_property(char *dtb, const char *node, const char *prop)
 		dbgprintf("%s: fdt_delprop failed: %s\n", __func__,
 			fdt_strerror(nodeoffset));
 
+	free(new_node);
 	return result;
 }
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
