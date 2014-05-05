Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WhHVk-0004Ax-As
 for kexec@lists.infradead.org; Mon, 05 May 2014 11:56:48 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [kexec-tools][PATCH] zImage-arm: bugfix: load kernel at TEXT_OFFSET
Date: Mon, 5 May 2014 19:48:31 +0800
Message-ID: <1399290511-53398-1-git-send-email-wangnan0@huawei.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Wang Nan <wangnan0@huawei.com>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>, Sven Neumann <s.neumann@raumfeld.com>, Daniel Mack <zonque@gmail.com>

This patch fix a problem introduced by commit e5d6a55 which make ARM
kexec fails.

Due to that commit, kernel is loaded at a dynamically offset: it computes
extra_size using size of dtb, and load zImage at base + extra_size. When
dtb size small (for example, 0x3000 bytes), kernel will be loaded at
address like 0x60003000. For ARM zImage such address is incorrect.

In kernel code arch/arm/boot/compressed/head.S, zImage builds a
temporary page table at (pc & 0xf8000000) + TEXT_OFFSET - 0x4000. The
related instructions sequence is:

 mov     r4, pc
 and     r4, r4, #0xf8000000
 add     r4, r4, #TEXT_OFFSET @ (TEXT_OFFSET == 0x8000 on most platforms)
 call cache_on
   ...
   call __armv7_mmu_cache_on
     ...
     call __setup_mmu
       sub     r3, r4, #16384          @ Page directory size

r3 becomes page table pointer.

When kernel is loaded at 0x60003000, page table is still built at
0x60004000, which destroys kernel.

This patch make extra_size a fix value (0x8000) to avoid the failure.

For the problem commit e5d6a55 tries solve, this patch uses
locate_holes() to find a place can hold initrd and dtb.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Daniel Mack <zonque@gmail.com>
Cc: Sven Neumann <s.neumann@raumfeld.com>
Cc: Geng Hui <hui.geng@huawei.com>

---
 kexec/arch/arm/kexec-zImage-arm.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 4b5d3f4..539192b 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -362,11 +362,10 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 
 	if (dtb_file) {
 		dtb_buf = slurp_file(dtb_file, &dtb_length);
-		extra_size = _ALIGN(dtb_length, getpagesize());
-	} else if (use_atags) {
-		extra_size = 0x8000;	/* 32k should be plenty for ATAGs */
 	}
 
+	extra_size = 0x8000;
+
 	/*
 	 * If we are loading a dump capture kernel, we need to update kernel
 	 * command line and also add some additional segments.
@@ -460,6 +459,32 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			create_flatten_tree(&dtb_buf, &dtb_length, command_line);
 		}
 
+		/*
+		 * Search in memory to make sure there is enough memory
+		 * to hold initrd and dtb.
+		 *
+		 * Even if no initrd is used, this check is still
+		 * required for dtb.
+		 *
+		 * Crash kernel use fixed address, no check is ok.
+		 */
+		if ((info->kexec_flags & KEXEC_ON_CRASH) == 0) {
+			unsigned long page_size = getpagesize();
+			/*
+			 * DTB size may be increase a little
+			 * when setup initrd size. Add a full page
+			 * for it is enough.
+			 */
+			unsigned long hole_size = _ALIGN_UP(initrd_size, page_size) +
+				_ALIGN(dtb_length + page_size, page_size);
+			unsigned long initrd_base_new = locate_hole(info,
+					hole_size, page_size,
+					initrd_base, ULONG_MAX, INT_MAX);
+			if (base == ULONG_MAX)
+				return -1;
+			initrd_base = initrd_base_new;
+		}
+
 		if (ramdisk) {
 			add_segment(info, ramdisk_buf, initrd_size,
 			            initrd_base, initrd_size);
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
