Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1efftd-00011y-0F
 for kexec@lists.infradead.org; Sun, 28 Jan 2018 05:52:55 +0000
Date: Sun, 28 Jan 2018 13:52:31 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH kexec-tools] x86: use old screen_info if needed
Message-ID: <20180128055231.GA1744@dhcp-128-65.nay.redhat.com>
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

With modern drm/kms graphic driver kexec-tools does not setup screen_info
correctly so one will only see screen output after those drm drivers
reinitializing after rebooting. Copying the old screen info from original
boot_params will help during my test, although it could not work for some
potential cases, but it is not worse than before.  This has been used in
the kernel kexec_file_load.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -27,6 +27,7 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <linux/fb.h>
+#include <linux/screen_info.h>
 #include <unistd.h>
 #include <dirent.h>
 #include <mntent.h>
@@ -122,7 +123,7 @@ void setup_linux_bootloader_parameters_h
 	cmdline_ptr[cmdline_len - 1] = '\0';
 }
 
-int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
+static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
 {
 	struct fb_fix_screeninfo fix;
 	struct fb_var_screeninfo var;
@@ -826,6 +827,8 @@ out:
 void setup_linux_system_parameters(struct kexec_info *info,
 				   struct x86_linux_param_header *real_mode)
 {
+	int err;
+
 	/* get subarch from running kernel */
 	setup_subarch(real_mode);
 	if (bzImage_support_efi_boot && !arch_options.noefi)
@@ -841,8 +844,22 @@ void setup_linux_system_parameters(struc
 	real_mode->orig_video_ega_bx = 0;
 	real_mode->orig_video_isVGA = 1;
 	real_mode->orig_video_points = 16;
-	setup_linux_vesafb(real_mode);
 
+	/* setup vesa fb if possible, or just use original screen_info */
+	err = setup_linux_vesafb(real_mode);
+	if (err) {
+		uint16_t cl_magic, cl_offset;
+
+		/* save and restore the old cmdline param if needed */
+		cl_magic = real_mode->cl_magic;
+		cl_offset = real_mode->cl_offset;
+
+		err = get_bootparam(real_mode, 0, sizeof(struct screen_info));
+		if (!err) {
+			real_mode->cl_magic = cl_magic;
+			real_mode->cl_offset = cl_offset;
+		}
+	}
 	/* Fill in the memsize later */
 	real_mode->ext_mem_k = 0;
 	real_mode->alt_mem_k = 0;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
