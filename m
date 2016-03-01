Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aasQp-0008Lm-0g
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 22:06:20 +0000
Date: Tue, 1 Mar 2016 14:05:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2 2/2] kexec: Do a cleanup for function kexec_load
Message-Id: <20160301140553.423a14fe91990cfafccd9bba@linux-foundation.org>
In-Reply-To: <1456819349-8650-3-git-send-email-mnfhuang@gmail.com>
References: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
 <1456819349-8650-3-git-send-email-mnfhuang@gmail.com>
Mime-Version: 1.0
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
To: Minfei Huang <mnfhuang@gmail.com>
Cc: mhuang@redhat.com, kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On Tue,  1 Mar 2016 16:02:29 +0800 Minfei Huang <mnfhuang@gmail.com> wrote:

> There are a lof of work to be done in function kexec_load, not only for
> allocating structs and loading initram, but also for some misc.
> 
> To make it more clear, wrap a new function do_kexec_load which is used
> to allocate structs and load initram. And the pre-work will be done in
> kexec_load.
> 

This patch needed quite a few changes to accommodate
http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory.patch.
The resulting code and the resulting diff are below.  Please test and
check carefully.

static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
		struct kexec_segment __user *segments, unsigned long flags)
{
	struct kimage **dest_image, *image;
	unsigned long i;
	int ret;

	if (flags & KEXEC_ON_CRASH) {
		dest_image = &kexec_crash_image;
		if (kexec_crash_image)
			arch_kexec_unprotect_crashkres();
	} else {
		dest_image = &kexec_image;
	}

	if (nr_segments == 0) {
		/* Uninstall image */
		kimage_free(xchg(dest_image, NULL));
		return 0;
	}
	if (flags & KEXEC_ON_CRASH) {
		/*
		 * Loading another kernel to switch to if this one
		 * crashes.  Free any current crash dump kernel before
		 * we corrupt it.
		 */
		kimage_free(xchg(&kexec_crash_image, NULL));
	}

	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
	if (ret)
		return ret;

	if (flags & KEXEC_ON_CRASH)
		crash_map_reserved_pages();

	if (flags & KEXEC_PRESERVE_CONTEXT)
		image->preserve_context = 1;

	ret = machine_kexec_prepare(image);
	if (ret)
		goto out;

	for (i = 0; i < nr_segments; i++) {
		ret = kimage_load_segment(image, &image->segment[i]);
		if (ret)
			goto out;
	}

	kimage_terminate(image);

	/* Install the new kernel and uninstall the old */
	image = xchg(dest_image, image);

out:
	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
		arch_kexec_protect_crashkres();

	/*
	 * Once the reserved memory is mapped, we should unmap this memory
	 * before returning
	 */
	if (flags & KEXEC_ON_CRASH)
		crash_unmap_reserved_pages();
	kimage_free(image);
	return ret;
}

/*
 * Exec Kernel system call: for obvious reasons only root may call it.
 *
 * This call breaks up into three pieces.
 * - A generic part which loads the new kernel from the current
 *   address space, and very carefully places the data in the
 *   allocated pages.
 *
 * - A generic part that interacts with the kernel and tells all of
 *   the devices to shut down.  Preventing on-going dmas, and placing
 *   the devices in a consistent state so a later kernel can
 *   reinitialize them.
 *
 * - A machine specific part that includes the syscall number
 *   and then copies the image to it's final destination.  And
 *   jumps into the image at entry.
 *
 * kexec does not sync, or unmount filesystems so if you need
 * that to happen you need to do that yourself.
 */

SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
		struct kexec_segment __user *, segments, unsigned long, flags)
{
	int result;

	/* We only trust the superuser with rebooting the system. */
	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
		return -EPERM;

	/*
	 * Verify we have a legal set of flags
	 * This leaves us room for future extensions.
	 */
	if ((flags & KEXEC_FLAGS) != (flags & ~KEXEC_ARCH_MASK))
		return -EINVAL;

	/* Verify we are on the appropriate architecture */
	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
		return -EINVAL;

	/* Put an artificial cap on the number
	 * of segments passed to kexec_load.
	 */
	if (nr_segments > KEXEC_SEGMENT_MAX)
		return -EINVAL;

	/* Because we write directly to the reserved memory
	 * region when loading crash kernels we need a mutex here to
	 * prevent multiple crash  kernels from attempting to load
	 * simultaneously, and to prevent a crash kernel from loading
	 * over the top of a in use crash kernel.
	 *
	 * KISS: always take the mutex.
	 */
	if (!mutex_trylock(&kexec_mutex))
		return -EBUSY;

	result = do_kexec_load(entry, nr_segments, segments, flags);

	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
		arch_kexec_protect_crashkres();

	mutex_unlock(&kexec_mutex);

	return result;
}


From: Minfei Huang <mnfhuang@gmail.com>
Subject: kexec: do a cleanup for function kexec_load

There are a lof of work to be done in function kexec_load, not only for
allocating structs and loading initram, but also for some misc.

To make it more clear, wrap a new function do_kexec_load which is used to
allocate structs and load initram.  And the pre-work will be done in
kexec_load.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/kexec.c |  125 +++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 56 deletions(-)

diff -puN kernel/kexec.c~kexec-do-a-cleanup-for-function-kexec_load kernel/kexec.c
--- a/kernel/kexec.c~kexec-do-a-cleanup-for-function-kexec_load
+++ a/kernel/kexec.c
@@ -103,6 +103,74 @@ out_free_image:
 	return ret;
 }
 
+static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
+		struct kexec_segment __user *segments, unsigned long flags)
+{
+	struct kimage **dest_image, *image;
+	unsigned long i;
+	int ret;
+
+	if (flags & KEXEC_ON_CRASH) {
+		dest_image = &kexec_crash_image;
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
+	} else {
+		dest_image = &kexec_image;
+	}
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
+	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
+		arch_kexec_protect_crashkres();
+
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
@@ -127,7 +195,6 @@ out_free_image:
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	struct kimage **dest_image, *image;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
@@ -152,9 +219,6 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
-	image = NULL;
-	result = 0;
-
 	/* Because we write directly to the reserved memory
 	 * region when loading crash kernels we need a mutex here to
 	 * prevent multiple crash  kernels from attempting to load
@@ -166,63 +230,12 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
-	dest_image = &kexec_image;
-	if (flags & KEXEC_ON_CRASH) {
-		dest_image = &kexec_crash_image;
-		if (kexec_crash_image)
-			arch_kexec_unprotect_crashkres();
-	}
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
 	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
 		arch_kexec_protect_crashkres();
 
 	mutex_unlock(&kexec_mutex);
-	kimage_free(image);
 
 	return result;
 }
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
