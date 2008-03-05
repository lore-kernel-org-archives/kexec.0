Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx.4pi.com ([24.172.19.59])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JWv4D-00019y-Pq
	for kexec@lists.infradead.org; Wed, 05 Mar 2008 14:58:02 +0000
Received: from [192.168.9.5] (rbl.4pi.com [24.172.19.62])
	by mx.4pi.com (Postfix) with ESMTP id 6BB9F3A30C7B
	for <kexec@lists.infradead.org>; Wed,  5 Mar 2008 09:58:00 -0500 (EST)
Mime-Version: 1.0
Message-Id: <p06230912c3f45f4beeb8@[192.168.9.5]>
Date: Wed, 5 Mar 2008 09:57:17 -0500
From: "Scott D. Davilla" <davilla@4pi.com>
Subject: [PATCH] kexec: fix i386 EFI boot using efifb
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Problem:
	kexec fails under i386 EFI boot for hardware that does not 
have a VGA bios or PC bios present. The EFI bootloader properly set 
the initial screen_info boot params but kexec assumes an 
orig_video_isVGA type of 1. This causes the kexec'd kernel assume the 
presence of both VGA bios and normal PC BIOS and starts probing which 
then panics somewhere I can't see because I have no console output 
nor serial ports.

Solution:
	For EFI, efifb is a linear VGA framebuffer and can handle the 
kexec kernel switch, kexec just has to setup the kernel boot params 
properly. The below patch fixes this issue and allow a i386 EFI 
booted kernel with no VGA bios/PC bios to kexec to another kernel.

Questions:
	Why is kexec assuming i386 x86 == VGA bios in the first 
place. The existing kernel has a perfectly good screen_info stucture 
that is an exported symbol by the kernel and could be accessed by 
kexec. Since kexec is just pretending to be a boot loader, why does 
it ignore information that the real bootloader (which knows a lot 
more about the hardware) has passed? The below patch just hacks in a 
trap for efifb and will fail in the future as other x86 hardware 
without VGA bios/PC bios become available.

diff -rup 
kexec-tools-testing-20080227-org/kexec/arch/i386/x86-linux-setup.c 
kexec-tools-testing-20080227/kexec/arch/i386/x86-linux-setup.c
--- kexec-tools-testing-20080227-org/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools-testing-20080227/kexec/arch/i386/x86-linux-setup.c
@@ -104,7 +104,6 @@ int setup_linux_vesafb(struct x86_linux_
{
	struct fb_fix_screeninfo fix;
	struct fb_var_screeninfo var;
-	static char *magic = "VESA VGA";
	int fd;

	fd = open("/dev/fb0", O_RDONLY);
@@ -115,11 +114,18 @@ int setup_linux_vesafb(struct x86_linux_
		goto out;
	if (-1 == ioctl(fd, FBIOGET_VSCREENINFO, &var))
		goto out;
-	if (0 != strcmp(fix.id, magic))
+	if (0 == strcmp(fix.id, "VESA VGA")) {
+		/* VIDEO_TYPE_VLFB */
+		real_mode->orig_video_isVGA = 0x23;
+	} else if (0 == strcmp(fix.id, "EFI VGA")) {
+		/* VIDEO_TYPE_EFI */
+		real_mode->orig_video_isVGA = 0x70;
+	} else {
+		/* cannot handle and other types */
		goto out;
+	}
	close(fd);

-	real_mode->orig_video_isVGA = 0x23 /* VIDEO_TYPE_VLFB */;
	real_mode->lfb_width      = var.xres;
	real_mode->lfb_height     = var.yres;
	real_mode->lfb_depth      = var.bits_per_pixel;


Signed-off-by: Scott D Davilla <davilla@4pi.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
