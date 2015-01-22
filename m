Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YEFH7-0007DO-Tt
 for kexec@lists.infradead.org; Thu, 22 Jan 2015 10:46:11 +0000
Message-ID: <54C0D3AE.9040405@huawei.com>
Date: Thu, 22 Jan 2015 16:10:46 +0530
From: Anurup M <anurup.m@huawei.com>
MIME-Version: 1.0
Subject: Fwd: [PATCH] arm64: Read reg property based on address-cells value.
References: <1421913506-18587-1-git-send-email-anurup.m@huawei.com>
In-Reply-To: <1421913506-18587-1-git-send-email-anurup.m@huawei.com>
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
To: geoff@infradead.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, "sanil.kumar@hisilicon.com" <sanil.kumar@hisilicon.com>, kexec@lists.infradead.org, dingtianhong@huawei.com

Hi Geoff,

    I have faced an issue during dtb file matching for CPU reg property. The dtb file which
I use has 32 bit value in the reg property as the #address-cells is 1. The kexec-tools code
reads the reg as a 64bit values and reads a invalid value and hence the below comparison in
the function fixup_cpu_nodes fails.

449         result = read_cpu_info(&info_2, dtb_2);
-----------------------
463
464                         if (cp_1->hwid != cp_2->hwid)
465                                 continue;
466
467                         to_process--;
-----------------------
476         if (to_process) {
477                 fprintf(stderr, "kexec: %s:%d: Warning: Failed to process %u CPUs.\n",
478                         __func__, __LINE__, to_process);
479                 result = -EINVAL;
480                 goto on_exit;

I have written a patch to read the value based on the #address-cells. Please find the patch
below. Please share your comments.

Regards,
Anurup

 Signed-off-by: Anurup M <anurup.m@huawei.com>

---
 kexec/arch/arm64/kexec-arm64.c |   29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index c1577be..e9c92ba 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -141,7 +141,7 @@ struct cpu_properties {
  */

 static int read_cpu_properties(struct cpu_properties *cp,
-	const struct dtb *dtb, int node_offset)
+	const struct dtb *dtb, int node_offset, int address_cells)
 {
 	int result;
 	const void *data;
@@ -158,7 +158,18 @@ static int read_cpu_properties(struct cpu_properties *cp,
 		return result;
 	}

-	cp->hwid = fdt64_to_cpu(*(uint64_t *)data);
+	/* Read the value based on the #address-cells */
+	if (1 == address_cells) {
+		cp->hwid = fdt32_to_cpu(*(uint32_t *)data);
+	}
+	else if (2 == address_cells) {
+		cp->hwid = fdt64_to_cpu(*(uint64_t *)data);
+	}
+	else {
+		fprintf(stderr, "kexec: %s:%d: Invalid #address-cells value: %d\n",
+                        __func__, __LINE__, address_cells);
+                return -1;
+	}

 	result = fdt_get_path(dtb->buf, node_offset, cp->node_path,
 		sizeof(cp->node_path));
@@ -361,6 +372,8 @@ static int read_cpu_info(struct cpu_info *info, const struct dtb *dtb)
 	int offset;
 	int result;
 	int depth;
+	const void *data;
+	int address_cells = -1;

 	offset = fdt_subnode_offset(dtb->buf, 0, "cpus");

@@ -370,6 +383,16 @@ static int read_cpu_info(struct cpu_info *info, const struct dtb *dtb)
 		return offset;
 	}

+	/* Read the #address-cells to read the CPU address from the reg property */
+	data = fdt_getprop(dtb->buf, offset, "#address-cells", &result);
+
+	if (!data) {
+		fprintf(stderr, "kexec: %s:%d: read #address-cells failed: %s\n",
+			__func__, __LINE__, fdt_strerror(result));
+		return result;
+	}
+       address_cells = fdt32_to_cpu(*(uint32_t *)data);
+
 	for (i = 0, depth = 0; ; i++) {

 		offset = fdt_next_node(dtb->buf, offset, &depth);
@@ -395,7 +418,7 @@ static int read_cpu_info(struct cpu_info *info, const struct dtb *dtb)
 			goto on_error;
 		}

-		result = read_cpu_properties(&info->cp[i], dtb, offset);
+		result = read_cpu_properties(&info->cp[i], dtb, offset, address_cells);

 		if (result)
 			goto on_error;
-- 
1.7.9.5


.





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
