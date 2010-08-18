Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]
	helo=TX2EHSOBE001.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OlpMH-00053f-IS
	for kexec@lists.infradead.org; Wed, 18 Aug 2010 20:35:38 +0000
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH 1/3] Ramdisk address was not copied correctly on kexec'ed
	kernel
Date: Wed, 18 Aug 2010 15:35:24 -0500
Message-ID: <1282163726-21186-2-git-send-email-msm@freescale.com>
In-Reply-To: <1282163726-21186-1-git-send-email-msm@freescale.com>
References: <1282163726-21186-1-git-send-email-msm@freescale.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: muvarov@gmail.com, Matthew McClintock <msm@freescale.com>, Kumar Gala <kumar.gala@freescale.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

---
 kexec/arch/ppc/fixup_dtb.c |    2 +-
 kexec/arch/ppc/kexec-ppc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 26c23a3..09f9ac1 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -311,7 +311,7 @@ static void fixup_initrd(char *blob_buf)
 				return;
 		}
 
-		tmp = ramdisk_base + ramdisk_size + 1;
+		tmp = ramdisk_base + ramdisk_size;
 		err = fdt_setprop(blob_buf, nodeoffset,
 			"linux,initrd-end", &tmp, sizeof(tmp));
 		if (err < 0) {
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index c36c7b3..ab76d6f 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -481,7 +481,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 
 			if ((initrd_end - initrd_start) != 0 ) {
 				initrd_base = initrd_start;
-				initrd_size = initrd_end - initrd_start + 1;
+				initrd_size = initrd_end - initrd_start;
 			}
 
 			if (reuse_initrd) {
-- 
1.6.0.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
