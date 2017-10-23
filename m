Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e6Zch-00060C-RT
 for kexec@lists.infradead.org; Mon, 23 Oct 2017 10:06:23 +0000
Date: Mon, 23 Oct 2017 11:05:48 +0100
From: Russell King <rmk@armlinux.org.uk>
Subject: [PATCH 1/2] ARM: cleanup initrd and dtb handing
Message-ID: <20171023100547.GA5431@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

There is no difference in the way the initrd is handled between an
ATAG-based kernel and a DTB-based kernel.  Therefore, this should be
handled identically in both cases.

Rearrange the code to achieve this.

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 116 +++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 59 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 7f02b93..c6ecb04 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -24,7 +24,7 @@
 
 #define BOOT_PARAMS_SIZE 1536
 
-off_t initrd_base = 0, initrd_size = 0;
+off_t initrd_base, initrd_size;
 unsigned int kexec_arm_image_size = 0;
 unsigned long long user_page_offset = (-1ULL);
 
@@ -200,14 +200,12 @@ int create_mem32_tag(struct tag_mem32 *tag_mem32)
 
 static
 int atag_arm_load(struct kexec_info *info, unsigned long base,
-	const char *command_line, off_t command_line_len,
-	const char *initrd, off_t initrd_len, off_t initrd_off)
+	const char *command_line, off_t command_line_len, const char *initrd)
 {
 	struct tag *saved_tags = atag_read_tags();
 	char *buf;
 	off_t len;
 	struct tag *params;
-	uint32_t *initrd_start = NULL;
 	
 	buf = xmalloc(getpagesize());
 	if (!buf) {
@@ -251,8 +249,8 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 	if (initrd) {
 		params->hdr.size = tag_size(tag_initrd);
 		params->hdr.tag = ATAG_INITRD2;
-		initrd_start = &params->u.initrd.start;
-		params->u.initrd.size = initrd_len;
+		params->u.initrd.start = initrd_base;
+		params->u.initrd.size = initrd_size;
 		params = tag_next(params);
 	}
 
@@ -272,14 +270,6 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 
 	add_segment(info, buf, len, base, len);
 
-	if (initrd) {
-		*initrd_start = locate_hole(info, initrd_len, getpagesize(),
-				initrd_off, ULONG_MAX, INT_MAX);
-		if (*initrd_start == ULONG_MAX)
-			return -1;
-		add_segment(info, initrd, initrd_len, *initrd_start, initrd_len);
-	}
-
 	return 0;
 }
 
@@ -348,6 +338,7 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, int parentoffset,
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
+	unsigned long page_size = getpagesize();
 	unsigned long base, kernel_base;
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
@@ -513,6 +504,14 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	kernel_mem_size = len + 4;
 
 	/*
+	 * If the user didn't specify the size of the image, assume the
+	 * maximum kernel compression ratio is 4.  Note that we must
+	 * include space for the compressed image here as well.
+	 */
+	if (!kexec_arm_image_size)
+		kexec_arm_image_size = len * 5;
+
+	/*
 	 * If we are loading a dump capture kernel, we need to update kernel
 	 * command line and also add some additional segments.
 	 */
@@ -562,17 +561,28 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 
 	kernel_base = base + extra_size;
 
-	if (kexec_arm_image_size) {
-		/* If the image size was passed as command line argument,
-		 * use that value for determining the address for initrd,
-		 * atags and dtb images. page-align the given length.*/
-		initrd_base = kernel_base + _ALIGN(kexec_arm_image_size, getpagesize());
-	} else {
-		/* Otherwise, assume the maximum kernel compression ratio
-		 * is 4, and just to be safe, place ramdisk after that.
-		 * Note that we must include space for the compressed
-		 * image here as well. */
-		initrd_base = kernel_base + _ALIGN(len * 5, getpagesize());
+	/*
+	 * Calculate the minimum address of the initrd, which must be
+	 * above the memory used by the zImage while it runs.  This
+	 * needs to be page-size aligned.
+	 */
+	initrd_base = kernel_base + _ALIGN(kexec_arm_image_size, page_size);
+
+	if (ramdisk_buf) {
+		/*
+		 * Find a hole to place the initrd. The crash kernel use
+		 * fixed address, so no check is ok.
+		 */
+		if (!(info->kexec_flags & KEXEC_ON_CRASH)) {
+			initrd_base = locate_hole(info, initrd_size, page_size,
+						  initrd_base,
+						  ULONG_MAX, INT_MAX);
+			if (initrd_base == ULONG_MAX)
+				return -1;
+		}
+
+		add_segment(info, ramdisk_buf, initrd_size, initrd_base,
+			    initrd_size);
 	}
 
 	if (use_atags) {
@@ -581,7 +591,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		 */
 		if (atag_arm_load(info, base + atag_offset,
 		                  command_line, command_line_len,
-		                  ramdisk_buf, initrd_size, initrd_base) == -1)
+		                  ramdisk_buf) == -1)
 			return -1;
 	} else {
 		/*
@@ -611,36 +621,11 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		}
 
 		/*
-		 * Search in memory to make sure there is enough memory
-		 * to hold initrd and dtb.
-		 *
-		 * Even if no initrd is used, this check is still
-		 * required for dtb.
-		 *
-		 * Crash kernel use fixed address, no check is ok.
+		 * Add the initrd parameters to the dtb
 		 */
-		if ((info->kexec_flags & KEXEC_ON_CRASH) == 0) {
-			unsigned long page_size = getpagesize();
-			/*
-			 * DTB size may be increase a little
-			 * when setup initrd size. Add a full page
-			 * for it is enough.
-			 */
-			unsigned long hole_size = _ALIGN_UP(initrd_size, page_size) +
-				_ALIGN(dtb_length + page_size, page_size);
-			unsigned long initrd_base_new = locate_hole(info,
-					hole_size, page_size,
-					initrd_base, ULONG_MAX, INT_MAX);
-			if (initrd_base_new == ULONG_MAX)
-				return -1;
-			initrd_base = initrd_base_new;
-		}
-
 		if (ramdisk_buf) {
-			add_segment(info, ramdisk_buf, initrd_size,
-			            initrd_base, initrd_size);
-
 			unsigned long start, end;
+
 			start = cpu_to_be32((unsigned long)(initrd_base));
 			end = cpu_to_be32((unsigned long)(initrd_base + initrd_size));
 
@@ -654,14 +639,27 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 				return -1;
 		}
 
-		/* Stick the dtb at the end of the initrd and page
-		 * align it.
+		/*
+		 * The dtb must also be placed above the memory used by
+		 * the zImage.  We don't care about its position wrt the
+		 * ramdisk, but we might as well place it after the initrd.
+		 * We leave a buffer page between the initrd and the dtb.
 		 */
-		dtb_offset = initrd_base + initrd_size + getpagesize();
-		dtb_offset = _ALIGN_DOWN(dtb_offset, getpagesize());
+		dtb_offset = initrd_base + initrd_size + page_size;
+		dtb_offset = _ALIGN_DOWN(dtb_offset, page_size);
+
+		/*
+		 * Find a hole to place the dtb above the initrd.
+		 * Crash kernel use fixed address, no check is ok.
+		 */
+		if (!(info->kexec_flags & KEXEC_ON_CRASH)) {
+			dtb_offset = locate_hole(info, dtb_length, page_size,
+						 dtb_offset, ULONG_MAX, INT_MAX);
+			if (dtb_offset == ULONG_MAX)
+				return -1;
+		}
 
-		add_segment(info, dtb_buf, dtb_length,
-		            dtb_offset, dtb_length);
+		add_segment(info, dtb_buf, dtb_length, dtb_offset, dtb_length);
 	}
 
 	add_segment(info, buf, len, kernel_base, kernel_mem_size);
-- 
2.7.4


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
