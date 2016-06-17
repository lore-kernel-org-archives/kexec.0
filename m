Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDzjU-0006Tw-Ov
 for kexec@lists.infradead.org; Fri, 17 Jun 2016 19:47:13 +0000
In-Reply-To: <20160617194405.GN1041@n2100.armlinux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
From: Russell King <rmk@armlinux.org.uk>
Subject: [PATCH 1/2] arm: take account of TEXT_OFFSET for subsequent images
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1bDzgz-0006Zy-1g@e0050434b2927.dyn.armlinux.org.uk>
Date: Fri, 17 Jun 2016 20:44:37 +0100
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

The ARM kexec code was not taking account of the 32k text offset when
applying the size(s) of the kernel image.  We need to take account of
this so when we decide to place the initrd at 4x the compressed image
length, it is appropriately placed.

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index aab0c861..297b7fd8 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -340,7 +340,7 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, int parentoffset,
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
-	unsigned long base;
+	unsigned long base, kernel_base;
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
 	const char *command_line;
@@ -517,15 +517,17 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	if (base == ULONG_MAX)
 		return -1;
 
+	kernel_base = base + extra_size;
+
 	if (kexec_arm_image_size) {
 		/* If the image size was passed as command line argument,
 		 * use that value for determining the address for initrd,
 		 * atags and dtb images. page-align the given length.*/
-		initrd_base = base + _ALIGN(kexec_arm_image_size, getpagesize());
+		initrd_base = kernel_base + _ALIGN(kexec_arm_image_size, getpagesize());
 	} else {
 		/* Otherwise, assume the maximum kernel compression ratio
 		 * is 4, and just to be safe, place ramdisk after that */
-		initrd_base = base + _ALIGN(len * 4, getpagesize());
+		initrd_base = kernel_base + _ALIGN(len * 4, getpagesize());
 	}
 
 	if (use_atags) {
@@ -617,9 +619,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		            dtb_offset, dtb_length);
 	}
 
-	add_segment(info, buf, len, base + extra_size, len);
+	add_segment(info, buf, len, kernel_base, len);
 
-	info->entry = (void*)base + extra_size;
+	info->entry = (void*)kernel_base;
 
 	return 0;
 }
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
