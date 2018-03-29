Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from isilmar-4.linta.de ([136.243.71.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1VhA-0004ti-WE
 for kexec@lists.infradead.org; Thu, 29 Mar 2018 11:26:19 +0000
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 004/109] kexec: call do_kexec_load() in compat syscall directly
Date: Thu, 29 Mar 2018 13:22:41 +0200
Message-Id: <20180329112426.23043-5-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
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
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, kexec@lists.infradead.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, Eric Biederman <ebiederm@xmission.com>

do_kexec_load() can be called directly by compat_sys_kexec() as long as
the same parameters checks are completed which are currently handled
(also) by sys_kexec(). Therefore, move those to kexec_load_check(),
call that newly introduced helper function from both sys_kexec() and
compat_sys_kexec(), and duplicate the remaining code from sys_kexec()
in compat_sys_kexec().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/kexec.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index e62ec4dc6620..aed8fb2564b3 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -192,11 +192,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
  * that to happen you need to do that yourself.
  */
 
-SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
-		struct kexec_segment __user *, segments, unsigned long, flags)
+static inline int kexec_load_check(unsigned long nr_segments,
+				   unsigned long flags)
 {
-	int result;
-
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
@@ -208,17 +206,29 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	if ((flags & KEXEC_FLAGS) != (flags & ~KEXEC_ARCH_MASK))
 		return -EINVAL;
 
-	/* Verify we are on the appropriate architecture */
-	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
-		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
-		return -EINVAL;
-
 	/* Put an artificial cap on the number
 	 * of segments passed to kexec_load.
 	 */
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
+	return 0;
+}
+
+SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
+		struct kexec_segment __user *, segments, unsigned long, flags)
+{
+	int result;
+
+	result = kexec_load_check(nr_segments, flags);
+	if (result)
+		return result;
+
+	/* Verify we are on the appropriate architecture */
+	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
+		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
+		return -EINVAL;
+
 	/* Because we write directly to the reserved memory
 	 * region when loading crash kernels we need a mutex here to
 	 * prevent multiple crash  kernels from attempting to load
@@ -247,15 +257,16 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 	struct kexec_segment out, __user *ksegments;
 	unsigned long i, result;
 
+	result = kexec_load_check(nr_segments, flags);
+	if (result)
+		return result;
+
 	/* Don't allow clients that don't understand the native
 	 * architecture to do anything.
 	 */
 	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
 		return -EINVAL;
 
-	if (nr_segments > KEXEC_SEGMENT_MAX)
-		return -EINVAL;
-
 	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
 	for (i = 0; i < nr_segments; i++) {
 		result = copy_from_user(&in, &segments[i], sizeof(in));
@@ -272,6 +283,21 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 			return -EFAULT;
 	}
 
-	return sys_kexec_load(entry, nr_segments, ksegments, flags);
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
+	result = do_kexec_load(entry, nr_segments, ksegments, flags);
+
+	mutex_unlock(&kexec_mutex);
+
+	return result;
 }
 #endif
-- 
2.16.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
