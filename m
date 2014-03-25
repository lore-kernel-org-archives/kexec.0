Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSImC-0002bh-Rd
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 04:15:53 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/3] kexec: pass initrd position by dtb
Date: Tue, 25 Mar 2014 12:09:45 +0800
Message-ID: <1395720585-76135-4-git-send-email-wangnan0@huawei.com>
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

This patch append the position of initrd to dtb when loading arm kernel
and initrd without using atag.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Geng Hui <hui.geng@huawei.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index aea1278..bfbf290 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -460,6 +460,19 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		if (ramdisk) {
 			add_segment(info, ramdisk_buf, initrd_size,
 			            initrd_base, initrd_size);
+
+			unsigned long start, end;
+			start = cpu_to_be32((unsigned long)(initrd_base));
+			end = cpu_to_be32((unsigned long)(initrd_base + initrd_size));
+
+			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+					"linux,initrd-start", &start,
+					sizeof(start)))
+				return -1;
+			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
+					"linux,initrd-end", &end,
+					sizeof(end)))
+				return -1;
 		}
 
 		/* Stick the dtb at the end of the initrd and page
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
