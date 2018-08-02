Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from duke.felloff.net ([216.126.196.34])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flEEd-0001jp-Nq
 for kexec@lists.infradead.org; Thu, 02 Aug 2018 14:05:51 +0000
Message-ID: <69E6683EA6F9200C6AE6CDD7F567E6D0@felloff.net>
Subject: [PATCH] multiboot-x86: pass framebuffer information when requested
Date: Thu, 2 Aug 2018 16:05:30 +0200
From: cinap_lenrek@felloff.net
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

When the kernel requests video information, pass it the
framebuffer information in the multiboot header from
the linux framebuffer ioctl's.

With the arch specific --reset-vga or --consolve-vga
options, purgatory will reset the framebuffer so pass
information for standard ega text mode.

Signed-off-by: Friedemann Gerold <cinap_lenrek@felloff.net>
---
diff --git a/include/x86/mb_info.h b/include/x86/mb_info.h
index 317bdfa..fd1bb1d 100644
--- a/include/x86/mb_info.h
+++ b/include/x86/mb_info.h
@@ -172,6 +172,28 @@ struct multiboot_info
 	uint16_t vbe_interface_seg;
 	uint16_t vbe_interface_off;
 	uint16_t vbe_interface_len;
+
+	uint64_t framebuffer_addr;
+	uint32_t framebuffer_pitch;
+	uint32_t framebuffer_width;
+	uint32_t framebuffer_height;
+	uint8_t  framebuffer_bpp;
+	uint8_t	 framebuffer_type;
+
+	union {
+		struct {
+			uint32_t	framebuffer_palette_addr;
+			uint16_t	framebuffer_palette_num_color;
+		};
+		struct {
+			uint8_t		framebuffer_red_field_position;
+			uint8_t		framebuffer_red_mask_size;
+			uint8_t		framebuffer_green_field_position;
+			uint8_t		framebuffer_green_mask_size;
+			uint8_t		framebuffer_blue_field_position;
+			uint8_t		framebuffer_blue_mask_size;
+		};
+	};
 };
 
 /*
@@ -211,6 +233,11 @@ struct multiboot_info
 
 /* Is there video information?  */
 #define MB_INFO_VIDEO_INFO		0x00000800
+#define MB_INFO_FRAMEBUFFER_INFO	0x00001000
+
+#define MB_FRAMEBUFFER_TYPE_INDEXED	0
+#define MB_FRAMEBUFFER_TYPE_RGB		1
+#define MB_FRAMEBUFFER_TYPE_EGA_TEXT	2
 
 /*
  *  The following value must be present in the EAX register.
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 69027e2..e566be7 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -56,6 +55,12 @@
 #include <x86/mb_header.h>
 #include <x86/mb_info.h>
 
+/* Framebuffer */
+#include <sys/ioctl.h>
+#include <linux/fb.h>
+
+extern struct arch_options_t arch_options;
+
 /* Static storage */
 static char headerbuf[MULTIBOOT_SEARCH];
 static struct multiboot_header *mbh = NULL;
@@ -107,16 +112,6 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
 				"don't understand.  Sorry.\n");
 			return -1;
 		} 
-		if (mbh->flags & MULTIBOOT_VIDEO_MODE) { 
-			/* Asked for screen mode information */
-			/* XXX carry on regardless */
-			fprintf(stderr, 
-				"BEWARE!  Found a multiboot header which asks "
-				"for screen mode information.\n"
-				"BEWARE!  I am NOT supplying screen mode "
-                                "information, but loading it regardless.\n");
-			
-		}
 		/* Bootable */
 		return 0;
 	}
@@ -134,6 +129,76 @@ void multiboot_x86_usage(void)
 	printf("                                 (can be used multiple times).\n");
 }
 
+
+static int framebuffer_info(struct multiboot_info *mbi)
+{
+	struct fb_fix_screeninfo info;
+	struct fb_var_screeninfo mode;
+	int fd;
+
+	/* check if purgatory will reset to standard ega text mode */
+	if (arch_options.reset_vga || arch_options.console_vga) {
+		mbi->framebuffer_type = MB_FRAMEBUFFER_TYPE_EGA_TEXT;
+		mbi->framebuffer_addr = 0xb8000;
+		mbi->framebuffer_pitch = 80*2;
+		mbi->framebuffer_width = 80;
+		mbi->framebuffer_height = 25;
+		mbi->framebuffer_bpp = 16;
+
+		mbi->flags |= MB_INFO_FRAMEBUFFER_INFO;
+		return 0;
+	}
+
+	/* use current graphics framebuffer settings */
+	fd = open("/dev/fb0", O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "can't open /dev/fb0: %s\n", strerror(errno));
+		return -1;
+	}
+	if (ioctl(fd, FBIOGET_FSCREENINFO, &info) < 0){
+		fprintf(stderr, "can't get screeninfo: %s\n", strerror(errno));
+		close(fd);
+		return -1;
+	}
+	if (ioctl(fd, FBIOGET_VSCREENINFO, &mode) < 0){
+		fprintf(stderr, "can't get modeinfo: %s\n", strerror(errno));
+		close(fd);
+		return -1;
+	}
+	close(fd);
+
+	if (info.smem_start == 0 || info.smem_len == 0) {
+		fprintf(stderr, "can't get linerar framebuffer address\n");
+		return -1;
+	}
+
+	if (info.type != FB_TYPE_PACKED_PIXELS) {
+		fprintf(stderr, "unsupported framebuffer type\n");
+		return -1;
+	}
+
+	if (info.visual != FB_VISUAL_TRUECOLOR) {
+		fprintf(stderr, "unsupported framebuffer visual\n");
+		return -1;
+	}
+
+	mbi->framebuffer_type = MB_FRAMEBUFFER_TYPE_RGB;
+	mbi->framebuffer_addr = info.smem_start;
+	mbi->framebuffer_pitch = info.line_length;
+	mbi->framebuffer_width = mode.xres;
+	mbi->framebuffer_height = mode.yres;
+	mbi->framebuffer_bpp = mode.bits_per_pixel;
+	mbi->framebuffer_red_field_position = mode.red.offset;
+	mbi->framebuffer_red_mask_size = mode.red.length;
+	mbi->framebuffer_green_field_position = mode.green.offset;
+	mbi->framebuffer_green_mask_size = mode.green.length;
+	mbi->framebuffer_blue_field_position = mode.blue.offset;
+	mbi->framebuffer_blue_mask_size = mode.blue.length;
+
+	mbi->flags |= MB_INFO_FRAMEBUFFER_INFO;
+	return 0;
+}
+
 int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 /* Marshal up a multiboot-style kernel */
@@ -302,6 +367,12 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		/* done */
 	}
 
+	/* Video */
+	if (mbh->flags & MULTIBOOT_VIDEO_MODE) {
+		if (framebuffer_info(mbi) < 0)
+			fprintf(stderr, "not providing framebuffer information.\n");
+	}
+
 	/* Load modules */
 	if (modules) {
 		char *mod_filename, *mod_command_line, *mod_clp, *buf;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
