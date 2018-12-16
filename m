Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYbus-000834-ES
 for kexec@lists.infradead.org; Sun, 16 Dec 2018 19:17:31 +0000
Received: by mail-pg1-f195.google.com with SMTP id d72so5024785pga.9
 for <kexec@lists.infradead.org>; Sun, 16 Dec 2018 11:17:20 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 3/4] kexec/dt-ops.c: Fix adding '/chosen' node for cases
 where it is not available in dtb passed via --dtb option
Date: Mon, 17 Dec 2018 00:46:54 +0530
Message-Id: <1544987815-19527-4-git-send-email-bhsharma@redhat.com>
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

While calling 'kexec -l', in case we are passed a .dtb using --dtb
option which doesn't contain a '/chosen' node, we try to create the
'/chosen' node and add bootargs to this node.

Currently the 'dt-ops.c' code is buggy as it passes '-FDT_ERR_NOTFOUND'
to 'fdt_add_subnode()', which leads to the following error:

  # kexec -d --load Image --append 'debug' --dtb rk3399-sapphire.dtb

  <..snip..>
  dtb_set_property: fdt_add_subnode failed: FDT_ERR_NOTFOUND
  kexec: Set device tree bootargs failed.
  get_cells_size: #address-cells:2 #size-cells:2
  cells_size_fitted: 0-0
  cells_size_fitted: 0-0
  setup_2nd_dtb: no kaslr-seed found

This patch passes the correct nodeoffset value to 'fdt_add_subnode()',
which fixes this issue:

  # kexec -d -l Image --append 'debug' --dtb rk3399-sapphire.dtb

  <..snip..>
  get_cells_size: #address-cells:2 #size-cells:2
  cells_size_fitted: 0-0
  cells_size_fitted: 0-0
  setup_2nd_dtb: no kaslr-seed found

Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/dt-ops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
index f15174c3c74e..bdc16dc87642 100644
--- a/kexec/dt-ops.c
+++ b/kexec/dt-ops.c
@@ -80,15 +80,16 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
 	}
 
 	nodeoffset = fdt_path_offset(new_dtb, node);
-	
+
 	if (nodeoffset == -FDT_ERR_NOTFOUND) {
-		result = fdt_add_subnode(new_dtb, nodeoffset, node);
+		result = fdt_add_subnode(new_dtb, 0, node);
 
 		if (result < 0) {
 			dbgprintf("%s: fdt_add_subnode failed: %s\n", __func__,
 				fdt_strerror(result));
 			goto on_error;
 		}
+		nodeoffset = result;
 	} else if (nodeoffset < 0) {
 		dbgprintf("%s: fdt_path_offset failed: %s\n", __func__,
 			fdt_strerror(nodeoffset));
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
