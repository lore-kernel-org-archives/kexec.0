Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]
	helo=TX2EHSOBE004.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OlpMD-00052B-BO
	for kexec@lists.infradead.org; Wed, 18 Aug 2010 20:35:35 +0000
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH 2/3] Prevent multiple reservations for cpu-release-addr
Date: Wed, 18 Aug 2010 15:35:25 -0500
Message-ID: <1282163726-21186-3-git-send-email-msm@freescale.com>
In-Reply-To: <1282163726-21186-1-git-send-email-msm@freescale.com>
References: <1282163726-21186-1-git-send-email-msm@freescale.com>
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
Cc: muvarov@gmail.com, Matthew McClintock <msm@freescale.com>, Kumar Gala <kumar.gala@freescale.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

Currently, we can add a lot of reservations over a small range, this
does a simple check to verify the previous entry is not the same
as the current one and skips it if so
---
 kexec/arch/ppc/fixup_dtb.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 09f9ac1..8c678a6 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -139,6 +139,7 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf, off_t
 {
 	int ret, i;
 	int nodeoffset;
+	u64 val = 0;
 
 	/* If this is a KEXEC kernel we add all regions since they will
 	 * all need to be saved */
@@ -171,24 +172,30 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf, off_t
 	}
 
 	/* Add reserve regions for cpu-release-addr */
+	val = 0;
 	nodeoffset = fdt_node_offset_by_prop_value(blob_buf, -1, "device_type", "cpu", 4);
 	while (nodeoffset != -FDT_ERR_NOTFOUND) {
 		const void *buf;
 		int sz, ret;
-		u64 val = 0;
+		u64 tmp;
 
 		buf = fdt_getprop(blob_buf, nodeoffset, "cpu-release-addr", &sz);
-		if (sz == 4) {
-			val = *(u32 *)buf;
-		} else if (sz == 8) {
-			val = *(u64 *)buf;
-		}
 
-		if (val) {
-			ret = fdt_add_mem_rsv(blob_buf, PAGE_ALIGN(val-PAGE_SIZE), PAGE_SIZE);
-			if (ret)
-				printf("%s: Unable to add reserve for cpu-release-addr!\n",
-					fdt_strerror(ret));
+		if (buf) {
+			if (sz == 4) {
+				tmp = *(u32 *)buf;
+			} else if (sz == 8) {
+				tmp = *(u64 *)buf;
+			}
+
+			/* crude check to see if last value is repeated */
+			if (_ALIGN_DOWN(tmp, PAGE_SIZE) != _ALIGN_DOWN(val, PAGE_SIZE)) {
+				val = tmp;
+				ret = fdt_add_mem_rsv(blob_buf, _ALIGN_DOWN(val, PAGE_SIZE), PAGE_SIZE);
+				if (ret)
+					printf("%s: Unable to add reserve for cpu-release-addr!\n",
+						fdt_strerror(ret));
+			}
 		}
 
 		nodeoffset = fdt_node_offset_by_prop_value(blob_buf, nodeoffset,
-- 
1.6.0.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
