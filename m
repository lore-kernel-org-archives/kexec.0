Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQXZM-0005Ti-Od
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 07:39:18 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH v3 2/2] kexec: pass initrd position by dtb
Date: Thu, 20 Mar 2014 07:33:57 +0000
Message-ID: <1395300837-18687-3-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1395300837-18687-1-git-send-email-wangnan0@huawei.com>
References: <1395300837-18687-1-git-send-email-wangnan0@huawei.com>
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
index 977254e..886a718 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -461,6 +461,19 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
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
1.8.3.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
