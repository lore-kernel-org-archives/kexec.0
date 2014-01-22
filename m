Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W5vTd-0001qm-S1
 for kexec@lists.infradead.org; Wed, 22 Jan 2014 10:56:11 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 2/3] kexec: pass initrd position in dtb
Date: Wed, 22 Jan 2014 18:52:03 +0800
Message-ID: <1390387924-73946-3-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1390387924-73946-1-git-send-email-wangnan0@huawei.com>
References: <1390387924-73946-1-git-send-email-wangnan0@huawei.com>
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
To: kexec@lists.infradead.org
Cc: Wang Nan <wangnan0@huawei.com>, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Geng Hui <hui.geng@huawei.com>

This patch append the position of initrd to dtb when loading arm kernel and
initrd without using atag.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Geng Hui <hui.geng@huawei.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 4547765..6d6b239 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -417,6 +417,41 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		if (ramdisk) {
 			add_segment(info, ramdisk_buf, initrd_size,
 			            initrd_base, initrd_size);
+			const char *node_name = "/chosen";
+			const char *prop_start_name = "linux,initrd-start";
+			const char *prop_end_name = "linux,initrd-end";
+			int off;
+
+			dtb_length = fdt_totalsize(dtb_buf) + 1024 + 8;
+			dtb_buf = xrealloc(dtb_buf, dtb_length);
+			fdt_set_totalsize(dtb_buf, dtb_length);
+
+			/* check if a /choosen subnode already exists */
+			off = fdt_path_offset(dtb_buf, node_name);
+
+			if (off == -FDT_ERR_NOTFOUND)
+				off = fdt_add_subnode(dtb_buf, off, node_name);
+
+			if (off < 0) {
+				fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
+				return -1;
+			}
+
+			unsigned long start, end;
+			start = cpu_to_be32((unsigned long)(initrd_base));
+			end = cpu_to_be32((unsigned long)(initrd_base + initrd_size));
+			if (fdt_setprop(dtb_buf, off, prop_start_name,
+						&start, sizeof(start)) != 0) {
+				fprintf(stderr, "FDT: Error setting %s/%s property.\n",
+						node_name, prop_start_name);
+				return -1;
+			}
+			if (fdt_setprop(dtb_buf, off, prop_end_name,
+						&end, sizeof(end)) != 0) {
+				fprintf(stderr, "FDT: Error setting %s/%s property.\n",
+						node_name, prop_end_name);
+				return -1;
+			}
 		}
 
 		/* Stick the dtb at the end of the initrd and page
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
