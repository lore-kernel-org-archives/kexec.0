Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from secvs04.rockwellcollins.com ([205.175.225.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iT8h7-0004c7-0T
 for kexec@lists.infradead.org; Fri, 08 Nov 2019 18:09:14 +0000
From: Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH] ARM: Use mmap for zImage initrd
Date: Fri,  8 Nov 2019 12:08:54 -0600
Message-Id: <20191108180854.126452-1-brandon.maier@rockwellcollins.com>
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
Cc: Brandon Maier <brandon.maier@rockwellcollins.com>

We use a large initrd that maxes out our available RAM when loading
kexec. The problem can be mitigated by using slurp_file_mmap(), which
avoids creating a copy of the initrd. The initrd does not use free,
realloc, etc, so it should be safe to use.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
 kexec/arch/arm/kexec-zImage-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 2a7eea9..f9d452f 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -478,7 +478,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			command_line_len = COMMAND_LINE_SIZE;
 	}
 	if (ramdisk)
-		ramdisk_buf = slurp_file(ramdisk, &initrd_size);
+		ramdisk_buf = slurp_file_mmap(ramdisk, &initrd_size);
 
 	if (dtb_file)
 		dtb_buf = slurp_file(dtb_file, &dtb_length);
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
