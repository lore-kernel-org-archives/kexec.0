Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]
	helo=TX2EHSOBE007.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OlpML-00056C-2l
	for kexec@lists.infradead.org; Wed, 18 Aug 2010 20:35:41 +0000
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH 3/3] Prevent initrd-start and initrd-end from appearing
	multiple times
Date: Wed, 18 Aug 2010 15:35:26 -0500
Message-ID: <1282163726-21186-4-git-send-email-msm@freescale.com>
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

We always remove the old entry, and add it back if it is needed
on for the kexec'ed kernel
---
 kexec/arch/ppc/fixup_dtb.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 8c678a6..b8e4056 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -160,7 +160,7 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf, off_t
 				goto out;
 			}
 		}
-	} else {
+	} else if (ramdisk || reuse_initrd) {
 		/* Otherwise we just add back the ramdisk and the device tree
 		 * is already in the list */
 		ret = fdt_add_mem_rsv(blob_buf, ramdisk_base, ramdisk_size);
@@ -301,13 +301,16 @@ static void fixup_initrd(char *blob_buf)
 
 	nodeoffset = fdt_path_offset(blob_buf, "/chosen");
 
-	if ((reuse_initrd || ramdisk) &&
-		((ramdisk_base != 0) && (ramdisk_size != 0))) {
-		if (nodeoffset < 0) {
-			printf("fdt_initrd: %s\n", fdt_strerror(nodeoffset));
-			return;
-		}
+	if (nodeoffset < 0) {
+		printf("fdt_initrd: %s\n", fdt_strerror(nodeoffset));
+		return;
+	}
+
+	fdt_delprop(blob_buf, nodeoffset, "linux,initrd-start");
+	fdt_delprop(blob_buf, nodeoffset, "linux,initrd-end");
 
+	if ((reuse_initrd || ramdisk) &&
+	   ((ramdisk_base != 0) && (ramdisk_size != 0))) {
 		tmp = ramdisk_base;
 		err = fdt_setprop(blob_buf, nodeoffset,
 			"linux,initrd-start", &tmp, sizeof(tmp));
@@ -326,9 +329,6 @@ static void fixup_initrd(char *blob_buf)
 				fdt_strerror(err));
 				return;
 		}
-	} else {
-		fdt_delprop(blob_buf, nodeoffset, "linux,initrd-start");
-		fdt_delprop(blob_buf, nodeoffset, "linux,initrd-end");
 	}
 }
 
-- 
1.6.0.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
