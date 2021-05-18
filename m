Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
 <m1bl982m8c.fsf@fess.ebiederm.org>
 <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
 <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
Date: Tue, 18 May 2021 17:45:23 -0500
In-Reply-To: <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
 (Arnd Bergmann's message of "Tue, 18 May 2021 16:17:53 +0200")
Message-ID: <m1y2cbzmnw.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
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
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org


Arnd Bergmann <arnd@kernel.org> writes:

> On Tue, May 18, 2021 at 4:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> On Tue, May 18, 2021 at 3:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >
>> > Arnd Bergmann <arnd@kernel.org> writes:
>> >
>> > > From: Arnd Bergmann <arnd@arndb.de>KEXEC_ARCH_DEFAULT
>> > >
>> > > The compat version of sys_kexec_load() uses compat_alloc_user_space to
>> > > convert the user-provided arguments into the native format.
>> > >
>> > > Move the conversion into the regular implementation with
>> > > an in_compat_syscall() check to simplify it and avoid the
>> > > compat_alloc_user_space() call.
>> > >
>> > > compat_sys_kexec_load() now behaves the same as sys_kexec_load().
>> >
>> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> >KEXEC_ARCH_DEFAULT
>> > The patch is wrong.
>> >
>> > The logic between the compat entry point and the ordinary entry point
>> > are by necessity different.   This unifies the logic and breaks the compat
>> > entry point.
>> >
>> > The fundamentally necessity is that the code being loaded needs to know
>> > which mode the kernel is running in so it can safely transition to the
>> > new kernel.
>> >
>> > Given that the two entry points fundamentally need different logic,
>> > and that difference was not preserved and the goal of this patchset
>> > was to unify that which fundamentally needs to be different.  I don't
>> > think this patch series makes any sense for kexec.
>>
>> Sorry, I'm not following that explanation. Can you clarify what different
>> modes of the kernel you are referring to here, and how my patch
>> changes this?

I think something like the untested diff below is enough to get rid of
compat_alloc_user cleanly.

Certainly it should be enough to give any idea what I am thinking.

diff --git a/kernel/kexec.c b/kernel/kexec.c
index c82c6c06f051..ce69a5d68023 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -19,26 +19,21 @@
 
 #include "kexec_internal.h"
 
-static int copy_user_segment_list(struct kimage *image,
+static void copy_user_segment_list(struct kimage *image,
 				  unsigned long nr_segments,
-				  struct kexec_segment __user *segments)
+				  struct kexec_segment *segments)
 {
-	int ret;
 	size_t segment_bytes;
 
 	/* Read in the segments */
 	image->nr_segments = nr_segments;
 	segment_bytes = nr_segments * sizeof(*segments);
-	ret = copy_from_user(image->segment, segments, segment_bytes);
-	if (ret)
-		ret = -EFAULT;
-
-	return ret;
+	memcpy(image->segment, segments, segment_bytes);
 }
 
 static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 			     unsigned long nr_segments,
-			     struct kexec_segment __user *segments,
+			     struct kexec_segment *segments,
 			     unsigned long flags)
 {
 	int ret;
@@ -59,9 +54,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 
 	image->start = entry;
 
-	ret = copy_user_segment_list(image, nr_segments, segments);
-	if (ret)
-		goto out_free_image;
+	copy_user_segment_list(image, nr_segments, segments);
 
 	if (kexec_on_panic) {
 		/* Enable special crash kernel control page alloc policy. */
@@ -103,8 +96,8 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	return ret;
 }
 
-static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
-		struct kexec_segment __user *segments, unsigned long flags)
+static int do_kexec_load_locked(unsigned long entry, unsigned long nr_segments,
+			struct kexec_segment *segments, unsigned long flags)
 {
 	struct kimage **dest_image, *image;
 	unsigned long i;
@@ -174,6 +167,27 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	return ret;
 }
 
+static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
+			struct kexec_segment *segments, unsigned long flags)
+{
+	int result;
+
+	/* Because we write directly to the reserved memory
+	 * region when loading crash kernels we need a mutex here to
+	 * prevent multiple crash  kernels from attempting to load
+	 * simultaneously, and to prevent a crash kernel from loading
+	 * over the top of a in use crash kernel.
+	 *
+	 * KISS: always take the mutex.
+	 */
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
+
+	result = do_kexec_load_locked(entry, nr_segments, segments, flags);
+	mutex_unlock(&kexec_mutex);
+	return result;
+}
+
 /*
  * Exec Kernel system call: for obvious reasons only root may call it.
  *
@@ -224,6 +238,11 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if ((flags & KEXEC_FLAGS) != (flags & ~KEXEC_ARCH_MASK))
 		return -EINVAL;
 
+	/* Verify we are on the appropriate architecture */
+	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
+	    ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
+		return -EINVAL;
+
 	/* Put an artificial cap on the number
 	 * of segments passed to kexec_load.
 	 */
@@ -236,33 +255,29 @@ static inline int kexec_load_check(unsigned long nr_segments,
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	int result;
+	struct kexec_segment *ksegments;
+	unsigned long bytes, result;
 
 	result = kexec_load_check(nr_segments, flags);
 	if (result)
 		return result;
 
-	/* Verify we are on the appropriate architecture */
-	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
-		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
-		return -EINVAL;
-
-	/* Because we write directly to the reserved memory
-	 * region when loading crash kernels we need a mutex here to
-	 * prevent multiple crash  kernels from attempting to load
-	 * simultaneously, and to prevent a crash kernel from loading
-	 * over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
-	 */
-	if (!mutex_trylock(&kexec_mutex))
-		return -EBUSY;
+	bytes = nr_segments * sizeof(ksegments[0]);
+	ksegments = kmalloc(bytes, GFP_KERNEL);
+	if (!ksegments)
+		return -ENOMEM;
 
+	result = copy_from_user(ksegments, segments, bytes);
+	if (result)
+		goto fail;
+	
 	result = do_kexec_load(entry, nr_segments, segments, flags);
+	kfree(ksegments);
 
-	mutex_unlock(&kexec_mutex);
-
+fail:
+	kfree(ksegments);
 	return result;
+	
 }
 
 #ifdef CONFIG_COMPAT
@@ -272,9 +287,9 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 		       compat_ulong_t, flags)
 {
 	struct compat_kexec_segment in;
-	struct kexec_segment out, __user *ksegments;
-	unsigned long i, result;
-
+	struct kexec_segment *ksegments;
+	unsigned long bytes, i, result;
+ 
 	result = kexec_load_check(nr_segments, flags);
 	if (result)
 		return result;
@@ -285,37 +300,26 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
 		return -EINVAL;
 
-	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
+	bytes = nr_segments * sizeof(ksegments[0]);
+	ksegments = kmalloc(bytes, GFP_KERNEL);
+	if (!ksegments)
+		return -ENOMEM;
+
 	for (i = 0; i < nr_segments; i++) {
 		result = copy_from_user(&in, &segments[i], sizeof(in));
 		if (result)
-			return -EFAULT;
-
-		out.buf   = compat_ptr(in.buf);
-		out.bufsz = in.bufsz;
-		out.mem   = in.mem;
-		out.memsz = in.memsz;
+			goto fail;
 
-		result = copy_to_user(&ksegments[i], &out, sizeof(out));
-		if (result)
-			return -EFAULT;
+		ksegments[i].buf   = compat_ptr(in.buf);
+		ksegments[i].bufsz = in.bufsz;
+		ksegments[i].mem   = in.mem;
+		ksegments[i].memsz = in.memsz;
 	}
 
-	/* Because we write directly to the reserved memory
-	 * region when loading crash kernels we need a mutex here to
-	 * prevent multiple crash  kernels from attempting to load
-	 * simultaneously, and to prevent a crash kernel from loading
-	 * over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
-	 */
-	if (!mutex_trylock(&kexec_mutex))
-		return -EBUSY;
-
 	result = do_kexec_load(entry, nr_segments, ksegments, flags);
 
-	mutex_unlock(&kexec_mutex);
-
+fail:
+	kfree(ksegments);
 	return result;
 }
 #endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
