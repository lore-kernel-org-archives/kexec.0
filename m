Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSImC-0002bo-Rg
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 04:15:53 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 1/3] kexec: introduce helpers for computing dtb size
Date: Tue, 25 Mar 2014 12:09:43 +0800
Message-ID: <1395720585-76135-2-git-send-email-wangnan0@huawei.com>
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

This patch introduce fdt_node_len and fdt_prop_len to help for computing
memory requirement when operating dtb.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Geng Hui <hui.geng@huawei.com>
---
 kexec/libfdt/libfdt.h          | 24 ++++++++++++++++++++++++
 kexec/libfdt/libfdt_internal.h |  3 ---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/kexec/libfdt/libfdt.h b/kexec/libfdt/libfdt.h
index ce80e4f..87a24ab 100644
--- a/kexec/libfdt/libfdt.h
+++ b/kexec/libfdt/libfdt.h
@@ -1073,4 +1073,28 @@ int fdt_del_node(void *fdt, int nodeoffset);
 
 const char *fdt_strerror(int errval);
 
+#define FDT_ALIGN(x, a)		(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)		(FDT_ALIGN((x), FDT_TAGSIZE))
+
+/*
+ * if add a new subnode:
+ * see: fdt_add_subnode -> fdt_add_subnode_namelen
+ */
+static inline int fdt_node_len(const char* node_name)
+{
+	return sizeof(struct fdt_node_header) +
+		FDT_TAGALIGN(strlen(node_name) + 1) + FDT_TAGSIZE;
+}
+
+/*
+ * if add a new prop: (assume prop_name not exist in strtab)
+ * see: fdt_setprop -> _fdt_add_property
+ */
+static inline int fdt_prop_len(const char* prop_name, int len)
+{
+	return (strlen(prop_name) + 1) +
+		sizeof(struct fdt_property) +
+		FDT_TAGALIGN(len);
+}
+
 #endif /* _LIBFDT_H */
diff --git a/kexec/libfdt/libfdt_internal.h b/kexec/libfdt/libfdt_internal.h
index 46eb93e..7e6c4c8 100644
--- a/kexec/libfdt/libfdt_internal.h
+++ b/kexec/libfdt/libfdt_internal.h
@@ -52,9 +52,6 @@
  */
 #include <fdt.h>
 
-#define FDT_ALIGN(x, a)		(((x) + (a) - 1) & ~((a) - 1))
-#define FDT_TAGALIGN(x)		(FDT_ALIGN((x), FDT_TAGSIZE))
-
 #define FDT_CHECK_HEADER(fdt) \
 	{ \
 		int err; \
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
