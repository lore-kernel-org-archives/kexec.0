Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W5vUq-0001td-V4
 for kexec@lists.infradead.org; Wed, 22 Jan 2014 10:57:27 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/3] kexec: increase zImage compression ratio from 4 to 5
Date: Wed, 22 Jan 2014 18:52:04 +0800
Message-ID: <1390387924-73946-4-git-send-email-wangnan0@huawei.com>
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

Old code assume the zImage compression ration is 4, it is not enough, 5 shall be
better.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Geng Hui <hui.geng@huawei.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 6d6b239..6e5e12b 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -351,7 +351,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	} else {
 		/* Otherwise, assume the maximum kernel compression ratio
 		 * is 4, and just to be safe, place ramdisk after that */
-		initrd_base =  base + _ALIGN(len * 4, 4096);
+		initrd_base =  base + _ALIGN(len * 5, 4096);
 	}
 
 	if (use_atags) {
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
