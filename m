Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aleZM-0007hE-61
 for kexec@lists.infradead.org; Thu, 31 Mar 2016 15:31:37 +0000
From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: [PATCH 3/3] zImage-arm: Add support for booting android images
Date: Thu, 31 Mar 2016 17:31:00 +0200
Message-Id: <1459438260-8205-3-git-send-email-alban.bedel@avionic-design.de>
In-Reply-To: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
References: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
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
Cc: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>, horms@verge.net.au, Alban Bedel <alban.bedel@avionic-design.de>

Add very basic support for booting an android image. The ramdisk and
command line from the image are only used if none has been given on
the command line.

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 kexec/arch/arm/kexec-zImage-arm.c | 56 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index c436b83..6b548c3 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -27,6 +27,23 @@ off_t initrd_base = 0, initrd_size = 0;
 unsigned int kexec_arm_image_size = 0;
 unsigned long long user_page_offset = (-1ULL);
 
+struct android_image {
+	char magic[8];
+	uint32_t kernel_size;
+	uint32_t kernel_addr;
+	uint32_t ramdisk_size;
+	uint32_t ramdisk_addr;
+	uint32_t stage2_size;
+	uint32_t stage2_addr;
+	uint32_t tags_addr;
+	uint32_t page_size;
+	uint32_t reserved1;
+	uint32_t reserved2;
+	char name[16];
+	char command_line[512];
+	uint32_t chksum[8];
+};
+
 struct tag_header {
 	uint32_t size;
 	uint32_t tag;
@@ -329,7 +346,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	char *modified_cmdline = NULL;
 	off_t command_line_len;
 	const char *ramdisk;
-	char *ramdisk_buf;
+	const char *ramdisk_buf;
 	int opt;
 	int use_atags;
 	char *dtb_buf;
@@ -416,6 +433,41 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	if (dtb_file)
 		dtb_buf = slurp_file(dtb_file, &dtb_length);
 
+	/* Handle android images, 2048 is the minimum page size */
+	if (len > 2048 && !strncmp(buf, "ANDROID!", 8)) {
+		const struct android_image *aimg = (const void *)buf;
+		uint32_t page_size = le32_to_cpu(aimg->page_size);
+		uint32_t kernel_size = le32_to_cpu(aimg->kernel_size);
+		uint32_t ramdisk_size = le32_to_cpu(aimg->ramdisk_size);
+		uint32_t stage2_size = le32_to_cpu(aimg->stage2_size);
+		off_t aimg_size = page_size + _ALIGN(kernel_size, page_size) +
+			_ALIGN(ramdisk_size, page_size) + stage2_size;
+
+		if (len < aimg_size) {
+			fprintf(stderr, "Android image size is incorrect\n");
+			return -1;
+		}
+
+		/* Get the kernel */
+		buf = buf + page_size;
+		len = kernel_size;
+
+		/* And the ramdisk if none was given on the command line */
+		if (!ramdisk && ramdisk_size) {
+			initrd_size = ramdisk_size;
+			ramdisk_buf = buf + _ALIGN(kernel_size, page_size);
+		}
+
+		/* Likewise for the command line */
+		if (!command_line && aimg->command_line[0]) {
+			command_line = aimg->command_line;
+			if (command_line[sizeof(aimg->command_line) - 1])
+				command_line_len = sizeof(aimg->command_line);
+			else
+				command_line_len = strlen(command_line) + 1;
+		}
+	}
+
 	/*
 	 * If we are loading a dump capture kernel, we need to update kernel
 	 * command line and also add some additional segments.
@@ -535,7 +587,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			initrd_base = initrd_base_new;
 		}
 
-		if (ramdisk) {
+		if (ramdisk_buf) {
 			add_segment(info, ramdisk_buf, initrd_size,
 			            initrd_base, initrd_size);
 
-- 
2.8.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
