Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TdppL-0004K0-2H
 for kexec@lists.infradead.org; Wed, 28 Nov 2012 22:09:58 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v5 4/5] kexec,
 x86: put ramdisk/cmd_line above 4G for 64bit bzImage
Date: Wed, 28 Nov 2012 14:09:53 -0800
Message-Id: <1354140594-3686-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1354140594-3686-1-git-send-email-yinghai@kernel.org>
References: <1354140594-3686-1-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

We could put ramdisk/cmdline above for bzImage on 64bit for protocol 2.12.

-v2: change ext_... handling to way that eric like.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/i386/x86-linux-setup.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index b7ab8ea..840bc88 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -64,7 +64,12 @@ void setup_linux_bootloader_parameters(
 	/* Find the maximum initial ramdisk address */
 	initrd_addr_max = DEFAULT_INITRD_ADDR_MAX;
 	if (real_mode->protocol_version >= 0x0203) {
-		initrd_addr_max = real_mode->initrd_addr_max;
+		if (real_mode->protocol_version >= 0x020c &&
+		    real_mode->xloadflags & (1<<0) && /* CAN_BE_LOADED_ABOVE_4G */
+		    real_mode->xloadflags & (1<<15)) /* USE_EXT_BOOT_PARAMS */
+			initrd_addr_max = ULONG_MAX;
+		else
+			initrd_addr_max = real_mode->initrd_addr_max;
 		dbgprintf("initrd_addr_max is 0x%lx\n", initrd_addr_max);
 	}
 
@@ -81,8 +86,16 @@ void setup_linux_bootloader_parameters(
 	}
 
 	/* Ramdisk address and size */
-	real_mode->initrd_start = initrd_base;
-	real_mode->initrd_size  = initrd_size;
+	real_mode->initrd_start = initrd_base & 0xffffffffUL;
+	real_mode->initrd_size  = initrd_size & 0xffffffffUL;
+
+	if (real_mode->protocol_version >= 0x020c &&
+	    (initrd_base & 0xffffffffUL) != initrd_base)
+		real_mode->ext_ramdisk_image = initrd_base >> 32;
+
+	if (real_mode->protocol_version >= 0x020c &&
+	    (initrd_size & 0xffffffffUL) != initrd_size)
+		real_mode->ext_ramdisk_size = initrd_size >> 32;
 
 	/* The location of the command line */
 	/* if (real_mode_base == 0x90000) { */
@@ -91,7 +104,12 @@ void setup_linux_bootloader_parameters(
 		/* setup_move_size */
 	/* } */
 	if (real_mode->protocol_version >= 0x0202) {
-		real_mode->cmd_line_ptr = real_mode_base + cmdline_offset;
+		unsigned long cmd_line_ptr = real_mode_base + cmdline_offset;
+
+		real_mode->cmd_line_ptr = cmd_line_ptr & 0xffffffffUL;
+		if ((real_mode->protocol_version >= 0x020c) &&
+		    ((cmd_line_ptr & 0xffffffffUL) != cmd_line_ptr))
+			real_mode->ext_cmd_line_ptr = cmd_line_ptr >> 32;
 	}
 
 	/* Fill in the command line */
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
