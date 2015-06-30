Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x236.google.com ([2607:f8b0:400e:c03::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z9oM5-0007Zr-L8
 for kexec@lists.infradead.org; Tue, 30 Jun 2015 05:45:14 +0000
Received: by pabvl15 with SMTP id vl15so116919755pab.1
 for <kexec@lists.infradead.org>; Mon, 29 Jun 2015 22:44:51 -0700 (PDT)
From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH v2] kexec: Make a pair of map and unmap reserved pages when
 kdump fails to start
Date: Tue, 30 Jun 2015 13:44:46 +0800
Message-Id: <1435643086-8555-1-git-send-email-mnfhuang@gmail.com>
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
To: ebiederm@xmission.com, vgoyal@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, holzheu@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>

For some arch, kexec shall map the reserved pages, then use them, when
we try to start the kdump service.

Now kexec will never unmap the reserved pages, once it fails to continue
starting the kdump service.

Make a pair of reserved pages in kdump starting path, whatever kexec
fails or not.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
---
 kernel/kexec.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 4589899..68f6dfb 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1291,35 +1291,37 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 			 */
 
 			kimage_free(xchg(&kexec_crash_image, NULL));
-			result = kimage_alloc_init(&image, entry, nr_segments,
-						   segments, flags);
-			crash_map_reserved_pages();
-		} else {
-			/* Loading another kernel to reboot into. */
-
-			result = kimage_alloc_init(&image, entry, nr_segments,
-						   segments, flags);
 		}
+
+		result = kimage_alloc_init(&image, entry, nr_segments,
+				segments, flags);
 		if (result)
 			goto out;
 
+		if (flags & KEXEC_ON_CRASH)
+			crash_map_reserved_pages();
+
 		if (flags & KEXEC_PRESERVE_CONTEXT)
 			image->preserve_context = 1;
 		result = machine_kexec_prepare(image);
 		if (result)
-			goto out;
+			goto failure;
 
 		for (i = 0; i < nr_segments; i++) {
 			result = kimage_load_segment(image, &image->segment[i]);
 			if (result)
-				goto out;
+				goto failure;
 		}
 		kimage_terminate(image);
+
+failure:
 		if (flags & KEXEC_ON_CRASH)
 			crash_unmap_reserved_pages();
 	}
-	/* Install the new kernel, and  Uninstall the old */
-	image = xchg(dest_image, image);
+
+	if (result == 0)
+		/* Install the new kernel, and  Uninstall the old */
+		image = xchg(dest_image, image);
 
 out:
 	mutex_unlock(&kexec_mutex);
-- 
2.2.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
