Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vi1eur04on0717.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::717]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fb3nr-0005oG-FN
 for kexec@lists.infradead.org; Thu, 05 Jul 2018 12:56:12 +0000
From: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
Subject: [PATCH 3/3] kexec: arm64: Add fitImage support
Date: Thu,  5 Jul 2018 14:55:35 +0200
Message-Id: <1530795335-20867-4-git-send-email-arnaud.ferraris.external@sigfox.com>
In-Reply-To: <1530795335-20867-1-git-send-email-arnaud.ferraris.external@sigfox.com>
References: <1530795335-20867-1-git-send-email-arnaud.ferraris.external@sigfox.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org

Signed-off-by: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
---
 kexec/arch/arm64/Makefile               |  2 ++
 kexec/arch/arm64/kexec-arm64.c          | 15 +++++++++++--
 kexec/arch/arm64/kexec-arm64.h          |  4 ++++
 kexec/arch/arm64/kexec-fitImage-arm64.c | 40 +++++++++++++++++++++++++++++++++
 kexec/kexec.h                           |  4 ++++
 5 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 kexec/arch/arm64/kexec-fitImage-arm64.c

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index 9d9111c..e33209e 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -15,9 +15,11 @@ arm64_KEXEC_SRCS += \
 	kexec/arch/arm64/kexec-arm64.c \
 	kexec/arch/arm64/kexec-elf-arm64.c \
 	kexec/arch/arm64/kexec-uImage-arm64.c \
+	kexec/arch/arm64/kexec-fitImage-arm64.c \
 	kexec/arch/arm64/kexec-image-arm64.c
 
 arm64_UIMAGE = kexec/kexec-uImage.c
+arm64_FITIMAGE = kexec/kexec-fitImage.c
 
 arm64_ARCH_REUSE_INITRD =
 arm64_ADD_SEGMENT =
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 7a12479..344037c 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -55,6 +55,8 @@ struct file_type file_type[] = {
 	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
 	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
+	{"fitImage", fitImage_arm64_probe, fitImage_arm64_load,
+		fitImage_arm64_usage},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
@@ -613,6 +615,10 @@ int arm64_load_other_segments(struct kexec_info *info,
 	if (arm64_opts.dtb) {
 		dtb.name = "dtb_user";
 		dtb.buf = slurp_file(arm64_opts.dtb, &dtb.size);
+	} else if (info->dtb) {
+		dtb.name = "dtb_user";
+		dtb.buf = info->dtb;
+		dtb.size = info->dtb_size;
 	} else {
 		result = read_1st_dtb(&dtb);
 
@@ -637,8 +643,13 @@ int arm64_load_other_segments(struct kexec_info *info,
 	else
 		hole_max = ULONG_MAX;
 
-	if (arm64_opts.initrd) {
-		initrd_buf = slurp_file(arm64_opts.initrd, &initrd_size);
+	if (arm64_opts.initrd || info->initrd) {
+		if (arm64_opts.initrd)
+			initrd_buf = slurp_file(arm64_opts.initrd, &initrd_size);
+		else {
+			initrd_buf = info->initrd;
+			initrd_size = info->initrd_size;
+		}
 
 		if (!initrd_buf)
 			fprintf(stderr, "kexec: Empty ramdisk file.\n");
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 22e4b69..cd05b0b 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -34,6 +34,10 @@ int uImage_arm64_probe(const char *buf, off_t len);
 int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
 		      struct kexec_info *info);
 void uImage_arm64_usage(void);
+int fitImage_arm64_probe(const char *buf, off_t len);
+int fitImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
+		      struct kexec_info *info);
+void fitImage_arm64_usage(void);
 
 off_t initrd_base;
 off_t initrd_size;
diff --git a/kexec/arch/arm64/kexec-fitImage-arm64.c b/kexec/arch/arm64/kexec-fitImage-arm64.c
new file mode 100644
index 0000000..1085f1b
--- /dev/null
+++ b/kexec/arch/arm64/kexec-fitImage-arm64.c
@@ -0,0 +1,40 @@
+/*
+ * fitImage support for ARM64
+ */
+
+#include <stdint.h>
+#include <string.h>
+#include <sys/types.h>
+#include <image.h>
+#include <kexec-fitImage.h>
+#include "../../kexec.h"
+#include "kexec-arm64.h"
+
+int fitImage_arm64_probe(const char *buf, off_t len)
+{
+	return fitImage_probe(buf, len, IH_ARCH_ARM64);
+}
+
+int fitImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info)
+{
+	struct FitImage_contents img;
+	int ret;
+
+	ret = fitImage_load(buf, len, &img);
+	if (ret)
+		return ret;
+
+	info->initrd = img.initrd;
+	info->initrd_size = img.initrd_size;
+	info->dtb = img.dtb;
+	info->dtb_size = img.dtb_size;
+
+	return image_arm64_load(argc, argv, img.kernel, img.kernel_size, info);
+}
+
+void fitImage_arm64_usage(void)
+{
+	printf(
+"     An ARM64 fitImage file, compressed or not, big or little endian.\n\n");
+}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index a97b9ce..19a807a 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -166,6 +166,10 @@ struct kexec_info {
 	int initrd_fd;
 	char *command_line;
 	int command_line_len;
+	const char *initrd;
+	off_t initrd_size;
+	const char *dtb;
+	off_t dtb_size;
 
 	int skip_checks;
 };
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
