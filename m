Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjwfQ-0006zM-Ge
 for kexec@lists.infradead.org; Tue, 01 Dec 2020 03:49:29 +0000
From: qiuguorui1 <qiuguorui1@huawei.com>
Subject: [PATCH v2] dt-ops: fix memory leak when new_node malloc fails
Date: Tue, 1 Dec 2020 12:06:16 +0800
Message-ID: <20201201040616.18618-1-qiuguorui1@huawei.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, bhsharma@redhat.com
Cc: qiuguorui1@huawei.com, horms@verge.net.au, leeyou.li@huawei.com, zengweilin@huawei.com

In function dtb_set_property, when malloc new_node fails,
we need to free new_dtb before return.

Fixes: f56cbcf4c2766 ("kexec/dt-ops.c: Fix '/chosen' v/s 'chosen' node
being passed to fdt helper functions")
Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>

v2:
  use goto instead of free here,based on Simon Horman's advice:
  "Can we use the goto idiom here, as is used elsewhere in this function?"

v1: http://lists.infradead.org/pipermail/kexec/2020-November/021809.html
---
 kexec/dt-ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
index dd2feaa..0a96b75 100644
--- a/kexec/dt-ops.c
+++ b/kexec/dt-ops.c
@@ -89,7 +89,8 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
 	new_node = malloc(strlen("/") + strlen(node) + 1);
 	if (!new_node) {
 		dbgprintf("%s: malloc failed\n", __func__);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto on_error;
 	}
 
 	strcpy(new_node, "/");
-- 
2.12.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
