Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x244.google.com ([2607:f8b0:400e:c03::244])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aafGi-00079R-OS
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 08:02:58 +0000
Received: by mail-pa0-x244.google.com with SMTP id a7so8677000pax.3
 for <kexec@lists.infradead.org>; Tue, 01 Mar 2016 00:02:39 -0800 (PST)
From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH V2 2/2] kexec: Do a cleanup for function kexec_load
Date: Tue,  1 Mar 2016 16:02:29 +0800
Message-Id: <1456819349-8650-3-git-send-email-mnfhuang@gmail.com>
In-Reply-To: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
References: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
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
To: ebiederm@xmission.com, akpm@linux-foundation.org
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>

There are a lof of work to be done in function kexec_load, not only for
allocating structs and loading initram, but also for some misc.

To make it more clear, wrap a new function do_kexec_load which is used
to allocate structs and load initram. And the pre-work will be done in
kexec_load.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
---
 kernel/kexec.c | 116 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 53 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 5cd60c4..48cf69c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -103,6 +103,68 @@ out_free_image:
 	return ret;
 }
 
+static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
+		struct kexec_segment __user *segments, unsigned long flags)
+{
+	struct kimage **dest_image, *image;
+	unsigned long i;
+	int ret;
+
+	if (flags & KEXEC_ON_CRASH)
+		dest_image = &kexec_crash_image;
+	else
+		dest_image = &kexec_image;
+
+	if (nr_segments == 0) {
+		/* Uninstall image */
+		kimage_free(xchg(dest_image, NULL));
+		return 0;
+	}
+	if (flags & KEXEC_ON_CRASH) {
+		/*
+		 * Loading another kernel to switch to if this one
+		 * crashes.  Free any current crash dump kernel before
+		 * we corrupt it.
+		 */
+		kimage_free(xchg(&kexec_crash_image, NULL));
+	}
+
+	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
+	if (ret)
+		return ret;
+
+	if (flags & KEXEC_ON_CRASH)
+		crash_map_reserved_pages();
+
+	if (flags & KEXEC_PRESERVE_CONTEXT)
+		image->preserve_context = 1;
+
+	ret = machine_kexec_prepare(image);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < nr_segments; i++) {
+		ret = kimage_load_segment(image, &image->segment[i]);
+		if (ret)
+			goto out;
+	}
+
+	kimage_terminate(image);
+
+	/* Install the new kernel and uninstall the old */
+	image = xchg(dest_image, image);
+
+out:
+	/*
+	 * Once the reserved memory is mapped, we should unmap this memory
+	 * before returning
+	 */
+	if (flags & KEXEC_ON_CRASH)
+		crash_unmap_reserved_pages();
+	kimage_free(image);
+	return ret;
+}
+
 /*
  * Exec Kernel system call: for obvious reasons only root may call it.
  *
@@ -127,7 +189,6 @@ out_free_image:
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	struct kimage **dest_image, *image;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
@@ -152,9 +213,6 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
-	image = NULL;
-	result = 0;
-
 	/* Because we write directly to the reserved memory
 	 * region when loading crash kernels we need a mutex here to
 	 * prevent multiple crash  kernels from attempting to load
@@ -166,57 +224,9 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
-	dest_image = &kexec_image;
-	if (flags & KEXEC_ON_CRASH)
-		dest_image = &kexec_crash_image;
-
-	if (nr_segments > 0) {
-		unsigned long i;
-
-		if (flags & KEXEC_ON_CRASH) {
-			/*
-			 * Loading another kernel to switch to if this one
-			 * crashes.  Free any current crash dump kernel before
-			 * we corrupt it.
-			 */
-
-			kimage_free(xchg(&kexec_crash_image, NULL));
-			result = kimage_alloc_init(&image, entry, nr_segments,
-						   segments, flags);
-			crash_map_reserved_pages();
-		} else {
-			/* Loading another kernel to reboot into. */
-
-			result = kimage_alloc_init(&image, entry, nr_segments,
-						   segments, flags);
-		}
-		if (result)
-			goto unmap_page;
-
-		if (flags & KEXEC_PRESERVE_CONTEXT)
-			image->preserve_context = 1;
-		result = machine_kexec_prepare(image);
-		if (result)
-			goto unmap_page;
-
-		for (i = 0; i < nr_segments; i++) {
-			result = kimage_load_segment(image, &image->segment[i]);
-			if (result)
-				goto unmap_page;
-		}
-		kimage_terminate(image);
-unmap_page:
-		if (flags & KEXEC_ON_CRASH)
-			crash_unmap_reserved_pages();
-		if (result)
-			goto out;
-	}
-	/* Install the new kernel, and  Uninstall the old */
-	image = xchg(dest_image, image);
+	result = do_kexec_load(entry, nr_segments, segments, flags);
 
-out:
 	mutex_unlock(&kexec_mutex);
-	kimage_free(image);
 
 	return result;
 }
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
