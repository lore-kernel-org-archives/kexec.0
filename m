Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDzjZ-0006Uh-2a
 for kexec@lists.infradead.org; Fri, 17 Jun 2016 19:47:18 +0000
In-Reply-To: <20160617194405.GN1041@n2100.armlinux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
From: Russell King <rmk@armlinux.org.uk>
Subject: [PATCH 2/2] arm: fix kernel image size
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
Date: Fri, 17 Jun 2016 20:44:42 +0100
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
To: Kees Cook <keescook@google.com>, Simon Horman <horms@verge.net.au>, Baoquan He <bhe@redhat.com>, Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

If we want to assume that the compressed image will expand by a maximum
of 4x, we actually need to reserve 5x the space, since we need to keep
a copy of the compessed image around while decompressing.

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 297b7fd8..9400d1f4 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -526,8 +526,10 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		initrd_base = kernel_base + _ALIGN(kexec_arm_image_size, getpagesize());
 	} else {
 		/* Otherwise, assume the maximum kernel compression ratio
-		 * is 4, and just to be safe, place ramdisk after that */
-		initrd_base = kernel_base + _ALIGN(len * 4, getpagesize());
+		 * is 4, and just to be safe, place ramdisk after that.
+		 * Note that we must include space for the compressed
+		 * image here as well. */
+		initrd_base = kernel_base + _ALIGN(len * 5, getpagesize());
 	}
 
 	if (use_atags) {
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
