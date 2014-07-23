Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X9ulb-0006ib-NE
 for kexec@lists.infradead.org; Wed, 23 Jul 2014 11:31:29 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [PATCH] kexec: align the extended size of dtb
Date: Wed, 23 Jul 2014 19:20:34 +0800
Message-ID: <1406114434-77987-1-git-send-email-sdu.liu@huawei.com>
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
To: horms@verge.net.au
Cc: wangnan0@huawei.com, kexec@lists.infradead.org, peifeiyue@huawei.com, Liu Hua <sdu.liu@huawei.com>

When loading dtb on arm platform, we may need change strings in dtb
in function setup_dtb_prop. If length of new string is larger than that
of the old one. We should extend the dtb by "FDT_TAGALIGN"ed size.
If not, kexec may fail to load the capture kernel.

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 44b87bb..ff4e38d 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -259,7 +259,7 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
 		dtb_size += fdt_prop_len(prop_name, len);
 	} else {
 		if (prop_len < len)
-			dtb_size += len - prop_len;
+			dtb_size += FDT_TAGALIGN(len - prop_len);
 	}
 
 	if (fdt_totalsize(dtb_buf) < dtb_size) {
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
