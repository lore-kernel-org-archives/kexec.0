Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W5vUq-0001tf-V0
 for kexec@lists.infradead.org; Wed, 22 Jan 2014 10:57:26 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 1/3] kexec: align initrd when no --image-size
Date: Wed, 22 Jan 2014 18:52:02 +0800
Message-ID: <1390387924-73946-2-git-send-email-wangnan0@huawei.com>
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

Before this patch, when no --image-size passed, initrd_base is caculated using
base + len * 4, which is unaligned, and unable to pass check in
add_segment_phys_virt():

	if (base & (pagesize -1)) {
		die("Base address: 0x%lx is not page aligned\n", base);
	}

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Geng Hui <hui.geng@huawei.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 792187a..4547765 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -351,7 +351,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	} else {
 		/* Otherwise, assume the maximum kernel compression ratio
 		 * is 4, and just to be safe, place ramdisk after that */
-		initrd_base = base + len * 4;
+		initrd_base =  base + _ALIGN(len * 4, 4096);
 	}
 
 	if (use_atags) {
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
