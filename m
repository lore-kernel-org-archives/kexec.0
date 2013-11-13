Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bk0-x231.google.com ([2a00:1450:4008:c01::231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgcBn-0002xg-Of
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 15:17:08 +0000
Received: by mail-bk0-f49.google.com with SMTP id w14so502146bkz.22
 for <kexec@lists.infradead.org>; Wed, 13 Nov 2013 07:16:45 -0800 (PST)
From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH RESEND] arm: add command line option for the total image size
Date: Wed, 13 Nov 2013 16:16:35 +0100
Message-Id: <1384355795-20796-1-git-send-email-zonque@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linux@arm.linux.org.uk, neumann@teufel.de, Daniel Mack <zonque@gmail.com>

Currently, kexec on arm assumes that it's safe to place binary images
such as atags, dtb or initrd at an estimated offset after the load
address. That estimated offset is set to 4 times the size of the
compressed image, hence assuming a minimum compression ratio of 1:4.

While that assumption matches what the in-kernel compressors are able to
achive, it doesn't take into account the .bss section the kernel image
carries, and which can grow to arbitrary sizes while not accounting to
the compressed image size.

After decompression, and before the execution of the compressed kernel,
the .bss area is initialized to zeros, trampeling over the binary images
in case they happen to live in that piece of memory.

Unfortunately, determining the full image size is not easiliy possible
at runtime, as it would include doing all possible ways of
decompression and then walk the ELF sections by hand.

For now, allow users to override the static offset with a new, arm
specific command line argument. Users are supposed to set this, and
determine a sane value by using 'arm-linux-size vmlinux'.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 kexec/arch/arm/include/arch/options.h | 12 ++++++++----
 kexec/arch/arm/kexec-arm.c            |  8 +++++++-
 kexec/arch/arm/kexec-zImage-arm.c     | 20 ++++++++++++++++----
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/arm/include/arch/options.h b/kexec/arch/arm/include/arch/options.h
index b355c26..b68b746 100644
--- a/kexec/arch/arm/include/arch/options.h
+++ b/kexec/arch/arm/include/arch/options.h
@@ -5,8 +5,9 @@
 
 #define OPT_APPEND	'a'
 #define OPT_RAMDISK	'r'
-#define OPT_DTB     (OPT_ARCH_MAX+0)
-#define OPT_ATAGS   (OPT_ARCH_MAX+1)
+#define OPT_DTB		(OPT_ARCH_MAX+0)
+#define OPT_ATAGS	(OPT_ARCH_MAX+1)
+#define OPT_IMAGE_SIZE	(OPT_ARCH_MAX+2)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -37,8 +38,11 @@
 	{ "initrd",		1, 0, OPT_RAMDISK },	\
 	{ "ramdisk",		1, 0, OPT_RAMDISK },	\
 	{ "dtb",		1, 0, OPT_DTB }, 	\
-	{ "atags",		0, 0, OPT_ATAGS },
+	{ "atags",		0, 0, OPT_ATAGS },	\
+	{ "image-size",		1, 0, OPT_IMAGE_SIZE },
 
-#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR "a:r:"
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR "a:r:s:"
+
+extern unsigned int kexec_arm_image_size;
 
 #endif /* KEXEC_ARCH_ARM_OPTIONS_H */
diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 8646833..6e8e320 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -81,9 +81,15 @@ struct file_type file_type[] = {
 };
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
-
 void arch_usage(void)
 {
+	printf("     --image-size=<size>\n"
+	       "               Specify the assumed total image size of\n"
+	       "               the kernel that is about to be loaded,\n"
+	       "               including the .bss section, as reported\n"
+	       "               by 'arm-linux-size vmlinux'. If not\n"
+	       "               specified, this value is implicitly set\n"
+	       "               to the compressed images size * 4.\n");
 }
 
 int arch_process_options(int argc, char **argv)
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index bb1b002..792187a 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -24,6 +24,7 @@
 #define BOOT_PARAMS_SIZE 1536
 
 off_t initrd_base = 0, initrd_size = 0;
+unsigned int kexec_arm_image_size = 0;
 
 struct tag_header {
 	uint32_t size;
@@ -232,6 +233,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	off_t dtb_length;
 	char *dtb_file;
 	off_t dtb_offset;
+	char *end;
 
 	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
@@ -242,6 +244,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		{ "ramdisk",		1, 0, OPT_RAMDISK },
 		{ "dtb",		1, 0, OPT_DTB },
 		{ "atags",		0, 0, OPT_ATAGS },
+		{ "image-size",		1, 0, OPT_IMAGE_SIZE },
 		{ 0, 			0, 0, 0 },
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "a:r:";
@@ -275,6 +278,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		case OPT_ATAGS:
 			use_atags = 1;
 			break;
+		case OPT_IMAGE_SIZE:
+			kexec_arm_image_size = strtoul(optarg, &end, 0);
+			break;
 		}
 	}
 
@@ -337,10 +343,16 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	if (base == ULONG_MAX)
 		return -1;
 
-	/* assume the maximum kernel compression ratio is 4,
-	 * and just to be safe, place ramdisk after that
-	 */
-	initrd_base = base + len * 4;
+	if (kexec_arm_image_size) {
+		/* If the image size was passed as command line argument,
+		 * use that value for determining the address for initrd,
+		 * atags and dtb images. page-align the given length.*/
+		initrd_base = base + _ALIGN(kexec_arm_image_size, 4096);
+	} else {
+		/* Otherwise, assume the maximum kernel compression ratio
+		 * is 4, and just to be safe, place ramdisk after that */
+		initrd_base = base + len * 4;
+	}
 
 	if (use_atags) {
 		/*
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
