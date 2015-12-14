Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-am1on0120.outbound.protection.outlook.com
 ([157.56.112.120] helo=emea01-am1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a8T1y-0003Yp-S5
 for kexec@lists.infradead.org; Mon, 14 Dec 2015 13:19:13 +0000
From: Michele Dionisio <michele.dionisio@powersoft.it>
Subject: uboot ramdisk image support for arm
Message-ID: <566EC1B0.3020604@powersoft.it>
Date: Mon, 14 Dec 2015 14:18:40 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080000050309030607050609"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--------------080000050309030607050609
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, I have add support for uboot ramdisk support in the patch attached.

the new features is implemented in:
kexec/arch/arm/kexec-uImage-arm.c
kexec/arch/arm/kexec-zImage-arm.c

but there is also a fix in
kexec/kexec-uImage.c where there is a endianes bug.

If someone can review the patch I think that it can be usefull to be 
added in the next version.

Regards.

--------------080000050309030607050609
Content-Type: text/x-patch; name="0000-fix-ramdisk-uimage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0000-fix-ramdisk-uimage.patch"

diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index 03c2f4d..20d71a2 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -17,6 +17,12 @@ int uImage_arm_probe(const char *buf, off_t len)
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
-	return zImage_arm_load(argc, argv, buf + sizeof(struct image_header),
-	                       len - sizeof(struct image_header), info);
+    struct Image_info img;
+	int ret;
+
+	ret = uImage_load(buf, len, &img);
+	if (ret)
+		return ret;
+    
+	return zImage_arm_load(argc, argv, img.buf, img.len, info);
 }
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index d85ab9b..fda30f8 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -14,6 +14,8 @@
 #include <getopt.h>
 #include <unistd.h>
 #include <libfdt.h>
+#include <image.h>
+#include <kexec-uImage.h>
 #include <arch/options.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
@@ -318,6 +320,36 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
 	return 0;
 }
 
+/*
+ * Load the ramdisk into buffer.
+ *  If the supplied image is in uImage format use
+ *  uImage_load() to read the payload from the image.
+ */
+char *slurp_ramdisk_arm(const char *filename, off_t *r_size)
+{
+	struct Image_info img;
+	off_t size;
+	const unsigned char *buf = slurp_file(filename, &size);
+	int rc;
+
+	/* Check if this is a uImage RAMDisk */
+	if (!buf)
+		return buf;
+	rc = uImage_probe_ramdisk(buf, size, IH_ARCH_ARM); 
+	if (rc < 0)
+		die("uImage: Corrupted ramdisk file %s\n", filename);
+	else if (rc == 0) {
+		if (uImage_load(buf, size, &img) != 0)
+			die("uImage: Reading %ld bytes from %s failed\n",
+				size, filename);
+		buf = img.buf;
+		size = img.len;
+	}
+
+	*r_size = size;
+	return buf;
+}
+
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
@@ -410,7 +442,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			command_line_len = COMMAND_LINE_SIZE;
 	}
 	if (ramdisk)
-		ramdisk_buf = slurp_file(ramdisk, &initrd_size);
+		ramdisk_buf = slurp_ramdisk_arm(ramdisk, &initrd_size);
 
 	if (dtb_file)
 		dtb_buf = slurp_file(dtb_file, &dtb_length);
diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 9df601b..5b85e86 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -235,7 +235,7 @@ int uImage_load(const unsigned char *buf, off_t len, struct Image_info *image)
 {
 	const struct image_header *header = (const struct image_header *)buf;
 	const unsigned char *img_buf = buf + sizeof(struct image_header);
-	off_t img_len = header->ih_size;
+	off_t img_len =  cpu_to_be32(header->ih_size);
 
 	/*
 	 * Prevent loading a modified image.

--------------080000050309030607050609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------080000050309030607050609--

