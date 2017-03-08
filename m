Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 6/7] arm64: add uImage support
Date: Wed,  8 Mar 2017 22:41:13 +0000
Message-Id: <20170308224114.49729-6-dwmw2@infradead.org>
In-Reply-To: <20170308224114.49729-1-dwmw2@infradead.org>
References: <20170308224114.49729-1-dwmw2@infradead.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: David Woodhouse <dwmw@amazon.co.uk>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 kexec/arch/arm64/Makefile             |  3 +++
 kexec/arch/arm64/kexec-arm64.c        |  1 +
 kexec/arch/arm64/kexec-arm64.h        |  4 ++++
 kexec/arch/arm64/kexec-uImage-arm64.c | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 kexec/arch/arm64/kexec-uImage-arm64.c

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index 74b677f..a931f0e 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -12,8 +12,11 @@ arm64_KEXEC_SRCS += \
 	kexec/arch/arm64/crashdump-arm64.c \
 	kexec/arch/arm64/kexec-arm64.c \
 	kexec/arch/arm64/kexec-elf-arm64.c \
+	kexec/arch/arm64/kexec-uImage-arm64.c \
 	kexec/arch/arm64/kexec-image-arm64.c
 
+arm64_UIMAGE = kexec/kexec-uImage.c
+
 arm64_ARCH_REUSE_INITRD =
 arm64_ADD_SEGMENT =
 arm64_VIRT_TO_PHYS =
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 04fd396..c822939 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -40,6 +40,7 @@ const struct arch_map_entry arches[] = {
 struct file_type file_type[] = {
 	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
+	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index bd4c20e..bf724ef 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -30,6 +30,10 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size);
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void image_arm64_usage(void);
+int uImage_arm64_probe(const char *buf, off_t len);
+int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
+		      struct kexec_info *info);
+void uImage_arm64_usage(void);
 
 off_t initrd_base;
 off_t initrd_size;
diff --git a/kexec/arch/arm64/kexec-uImage-arm64.c b/kexec/arch/arm64/kexec-uImage-arm64.c
new file mode 100644
index 0000000..022d7ee
--- /dev/null
+++ b/kexec/arch/arm64/kexec-uImage-arm64.c
@@ -0,0 +1,34 @@
+/*
+ * uImage support added by David Woodhouse <dwmw2@infradead.org>
+ */
+#include <stdint.h>
+#include <string.h>
+#include <sys/types.h>
+#include <image.h>
+#include <kexec-uImage.h>
+#include "../../kexec.h"
+#include "kexec-arm64.h"
+
+int uImage_arm64_probe(const char *buf, off_t len)
+{
+	return uImage_probe_kernel(buf, len, IH_ARCH_ARM64);
+}
+
+int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info)
+{
+	struct Image_info img;
+	int ret;
+
+	ret = uImage_load(buf, len, &img);
+	if (ret)
+		return ret;
+
+	return image_arm64_load(argc, argv, img.buf, img.len, info);
+}
+
+void uImage_arm64_usage(void)
+{
+	printf(
+"     An ARM64 U-boot uImage file, compressed or not, big or little endian.\n\n");
+}
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
