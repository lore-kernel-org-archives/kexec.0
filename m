Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nue.novell.com ([195.135.221.5])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cEf45-0000bx-7M
 for kexec@lists.infradead.org; Wed, 07 Dec 2016 16:27:30 +0000
From: Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] arm64: Fix initrd requierements
Date: Wed,  7 Dec 2016 17:26:15 +0100
Message-Id: <1481127975-9156-1-git-send-email-mbrugger@suse.com>
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
To: kexec@lists.infradead.org, geoff@infradead.org
Cc: panand@redhat.com, catalin.marinas@arm.com, Matthias Brugger <mbrugger@suse.com>, ard.biesheuvel@linaro.org

The initrd doesn't need to be aligend to 1 GB, which breaks kexec for system with
RAM <= 1 GB. Instead the memory size between the kernel start rounded down to 1 GB
and the end of the initrd rounded up to 1 GB can't be bigger then 32 GB.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 kexec/arch/arm64/kexec-arm64.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 288548f..04fd396 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -327,6 +327,7 @@ int arm64_load_other_segments(struct kexec_info *info,
 	unsigned long dtb_base;
 	unsigned long hole_min;
 	unsigned long hole_max;
+	unsigned long initrd_end;
 	char *initrd_buf = NULL;
 	struct dtb dtb;
 	char command_line[COMMAND_LINE_SIZE] = "";
@@ -366,27 +367,27 @@ int arm64_load_other_segments(struct kexec_info *info,
 		if (!initrd_buf)
 			fprintf(stderr, "kexec: Empty ramdisk file.\n");
 		else {
-			/*
-			 * Put the initrd after the kernel.  As specified in
-			 * booting.txt, align to 1 GiB.
-			 */
+			/* Put the initrd after the kernel. */
 
 			initrd_base = add_buffer_phys_virt(info, initrd_buf,
-				initrd_size, initrd_size, GiB(1),
+				initrd_size, initrd_size, 0,
 				hole_min, hole_max, 1, 0);
 
-			/* initrd_base is valid if we got here. */
-
-			dbgprintf("initrd: base %lx, size %lxh (%ld)\n",
-				initrd_base, initrd_size, initrd_size);
+			initrd_end = initrd_base + initrd_size;
 
-			/* Check size limit as specified in booting.txt. */
+			/* Check limits as specified in booting.txt.
+			 * The kernel may have as little as 32 GB of address space to map
+			 * system memory and both kernel and initrd must be 1GB aligend.
+			 */
 
-			if (initrd_base - image_base + initrd_size > GiB(32)) {
+			if (_ALIGN_UP(initrd_end, GiB(1)) - _ALIGN_DOWN(image_base, GiB(1)) > GiB(32)) {
 				fprintf(stderr, "kexec: Error: image + initrd too big.\n");
 				return -EFAILED;
 			}
 
+			dbgprintf("initrd: base %lx, size %lxh (%ld)\n",
+				initrd_base, initrd_size, initrd_size);
+
 			result = dtb_set_initrd((char **)&dtb.buf,
 				&dtb.size, initrd_base,
 				initrd_base + initrd_size);
-- 
2.6.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
