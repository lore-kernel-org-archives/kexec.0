Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkuj0-0008Dg-Hx
 for kexec@lists.infradead.org; Tue, 09 Jul 2019 18:20:24 +0000
Received: by mail-qt1-x842.google.com with SMTP id l9so14352759qtu.6
 for <kexec@lists.infradead.org>; Tue, 09 Jul 2019 11:20:22 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [v2 4/5] kexec: use reserved memory for normal kexec reboot
Date: Tue,  9 Jul 2019 14:20:13 -0400
Message-Id: <20190709182014.16052-5-pasha.tatashin@soleen.com>
In-Reply-To: <20190709182014.16052-1-pasha.tatashin@soleen.com>
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

If memory was reserved for the given segment use it directly instead of
allocating on per-page bases. This will avoid relocating this segment to
final destination when machine is rebooted.

This is done on a per segment bases because user might decide to always
load kernel segments at the given address (i.e. non-relocatable kernel),
but load initramfs at reserved address, and thus save reboot time on
copying initramfs if it is large, and reduces reboot performance.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 932feadbeb3a..2a8d8746e0a1 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -154,6 +154,18 @@ static struct page *kimage_alloc_page(struct kimage *image,
 				       gfp_t gfp_mask,
 				       unsigned long dest);
 
+/* Check whether this segment is fully within the resource */
+static bool segment_is_reserved(struct kexec_segment *seg, struct resource *res)
+{
+	unsigned long mstart = seg->mem;
+	unsigned long mend = mstart + seg->memsz - 1;
+
+	if (mstart < phys_to_boot_phys(res->start) ||
+	    mend > phys_to_boot_phys(res->end))
+		return false;
+	return true;
+}
+
 int sanity_check_segment_list(struct kimage *image)
 {
 	int i;
@@ -246,13 +258,9 @@ int sanity_check_segment_list(struct kimage *image)
 
 	if (image->type == KEXEC_TYPE_CRASH) {
 		for (i = 0; i < nr_segments; i++) {
-			unsigned long mstart, mend;
-
-			mstart = image->segment[i].mem;
-			mend = mstart + image->segment[i].memsz - 1;
 			/* Ensure we are within the crash kernel limits */
-			if ((mstart < phys_to_boot_phys(crashk_res.start)) ||
-			    (mend > phys_to_boot_phys(crashk_res.end)))
+			if (!segment_is_reserved(&image->segment[i],
+						 &crashk_res))
 				return -EADDRNOTAVAIL;
 		}
 	}
@@ -848,12 +856,13 @@ static int kimage_load_normal_segment(struct kimage *image,
 	return result;
 }
 
-static int kimage_load_crash_segment(struct kimage *image,
-					struct kexec_segment *segment)
+static int kimage_load_crash_or_reserved_segment(struct kimage *image,
+						 struct kexec_segment *segment)
 {
-	/* For crash dumps kernels we simply copy the data from
-	 * user space to it's destination.
-	 * We do things a page at a time for the sake of kmap.
+	/*
+	 * For crash dumps and kexec-reserved kernels we simply copy the data
+	 * from user space to it's destination. We do things a page at a time
+	 * for the sake of kmap.
 	 */
 	unsigned long maddr;
 	size_t ubytes, mbytes;
@@ -923,10 +932,14 @@ int kimage_load_segment(struct kimage *image,
 
 	switch (image->type) {
 	case KEXEC_TYPE_DEFAULT:
-		result = kimage_load_normal_segment(image, segment);
+		if (segment_is_reserved(segment, &kexeck_res))
+			result = kimage_load_crash_or_reserved_segment(image,
+								       segment);
+		else
+			result = kimage_load_normal_segment(image, segment);
 		break;
 	case KEXEC_TYPE_CRASH:
-		result = kimage_load_crash_segment(image, segment);
+		result = kimage_load_crash_or_reserved_segment(image, segment);
 		break;
 	}
 
-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
