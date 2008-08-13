Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTMHK-000896-O9
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 19:45:07 +0000
Date: Wed, 13 Aug 2008 12:44:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
Message-Id: <20080813124406.21091eae.akpm@linux-foundation.org>
In-Reply-To: <m1r68shjhb.fsf@frodo.ebiederm.org>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0808130956360.3462@nehalem.linux-foundation.org>
	<m1r68shjhb.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, pavel@ucw.cz, ying.huang@intel.com, mingo@elte.hu, torvalds@linux-foundation.org, vgoyal@redhat.com

On Wed, 13 Aug 2008 11:12:48 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Wed, 13 Aug 2008, Huang Ying wrote:
> >>
> >> -	xchg(&kexec_lock, 0);
> >> +	locked = xchg(&kexec_lock, 0);
> >> +	BUG_ON(!locked);
> >
> > Why do you want to do this at all? 
> >
> > And why do you implement your locks with xchg() in the first place? That's 
> > total and utter crap.
> >
> > Hint: we have _real_ locking primitives in the kernel.
> 
> This part certainly.
> 
> The way the code should work, and the way it has in the past is:
> image = xchg(&kexec_image, NULL)
> if (!image)
>    return -EINVAL;
> 
> Very simple and very obvious and very easy to get right, and it has
> been that way for years.
> 

- We're talking about kexec_lock here, not kexec_image

- afacit all manipulations of kexec_image happen under kexec_lock, so
  they don't need to be atomic, do they?

- Is xchg() guaranteed to be atomic?  That's what atomic_xchg() is for.

- xchg() isn't guaranteed to exist on all architectures.  atomic_xchg() is.


Could someone please review and test this?  It's on top of 

kexec-jump-clean-up-ifdef-and-comments.patch
kexec-jump-rename-kexec_control_code_size-to-kexec_control_page_size.patch
kexec-jump-check-code-size-in-control-page.patch
kexec-jump-check-code-size-in-control-page-fix.patch
kexec-jump-remove-duplication-of-kexec_restart_prepare.patch
kexec-jump-in-sync-with-hibernation-implementation.patch
kexec-jump-__ftrace_enabled_save-restore.patch
kexec-jump-fix-for-ftrace.patch



Subject: kexec: use a bitop for locking rather than xchg()
From: Andrew Morton <akpm@linux-foundation.org>

Functionally the same, but more conventional.

Cc: Huang Ying <ying.huang@intel.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/kexec.c |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff -puN kernel/kexec.c~kexec-use-a-bitop-for-locking-rather-than-xchg kernel/kexec.c
--- a/kernel/kexec.c~kexec-use-a-bitop-for-locking-rather-than-xchg
+++ a/kernel/kexec.c
@@ -9,6 +9,7 @@
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
+#include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/kexec.h>
@@ -924,19 +925,28 @@ static int kimage_load_segment(struct ki
  */
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
+
+static unsigned long kexec_bitlock;
+
 /*
- * A home grown binary mutex.
- * Nothing can wait so this mutex is safe to use
- * in interrupt context :)
+ * Return true if we acquired the lock
  */
-static int kexec_lock;
+static inline bool kexec_trylock(void)
+{
+	return !test_and_set_bit(0, &kexec_bitlock);
+}
+
+static void kexec_unlock(void)
+{
+	if (!test_and_clear_bit(0, &kexec_bitlock))
+		WARN_ON(1);
+}
 
 asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
 				struct kexec_segment __user *segments,
 				unsigned long flags)
 {
 	struct kimage **dest_image, *image;
-	int locked;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
@@ -972,8 +982,7 @@ asmlinkage long sys_kexec_load(unsigned 
 	 *
 	 * KISS: always take the mutex.
 	 */
-	locked = xchg(&kexec_lock, 1);
-	if (locked)
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	dest_image = &kexec_image;
@@ -1015,8 +1024,7 @@ asmlinkage long sys_kexec_load(unsigned 
 	image = xchg(dest_image, image);
 
 out:
-	locked = xchg(&kexec_lock, 0); /* Release the mutex */
-	BUG_ON(!locked);
+	kexec_unlock();
 	kimage_free(image);
 
 	return result;
@@ -1063,9 +1071,6 @@ asmlinkage long compat_sys_kexec_load(un
 
 void crash_kexec(struct pt_regs *regs)
 {
-	int locked;
-
-
 	/* Take the kexec_lock here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
 	 * we are using after a panic on a different cpu.
@@ -1074,8 +1079,7 @@ void crash_kexec(struct pt_regs *regs)
 	 * of memory the xchg(&kexec_crash_image) would be
 	 * sufficient.  But since I reuse the memory...
 	 */
-	locked = xchg(&kexec_lock, 1);
-	if (!locked) {
+	if (kexec_trylock()) {
 		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 			crash_setup_regs(&fixed_regs, regs);
@@ -1083,8 +1087,7 @@ void crash_kexec(struct pt_regs *regs)
 			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(kexec_crash_image);
 		}
-		locked = xchg(&kexec_lock, 0);
-		BUG_ON(!locked);
+		kexec_unlock();
 	}
 }
 
@@ -1434,7 +1437,7 @@ int kernel_kexec(void)
 {
 	int error = 0;
 
-	if (xchg(&kexec_lock, 1))
+	if (!kexec_trylock())
 		return -EBUSY;
 	if (!kexec_image) {
 		error = -EINVAL;
@@ -1498,8 +1501,6 @@ int kernel_kexec(void)
 #endif
 
  Unlock:
-	if (!xchg(&kexec_lock, 0))
-		BUG();
-
+	kexec_unlock();
 	return error;
 }
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
