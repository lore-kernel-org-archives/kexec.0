Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vostochny.stro.at ([78.47.22.85])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SXW94-0002N5-KB
 for kexec@lists.infradead.org; Thu, 24 May 2012 11:23:56 +0000
From: maximilian attems <max@stro.at>
Subject: [PATCH] kexec: export kexec.h to user space
Date: Thu, 24 May 2012 13:23:43 +0200
Message-Id: <1337858623-12892-1-git-send-email-max@stro.at>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: maximilian attems <max@stro.at>, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Add userspace definitions, guard all relevant kernel structures.
While at it document stuff and remove now useless userspace hint.

It is easy to add the relevant system call to respective libc's,
but it seems pointless to have to duplicate the data structures.

This is based on the kexec-tools headers, with the exception of
just using int on return (succes or failure) and using size_t
instead of 'unsigned long int' for the number of segments argument
of kexec_load().

Cc: Simon Horman <horms@verge.net.au>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: maximilian attems <max@stro.at>
---
 include/linux/Kbuild  |    1 +
 include/linux/kexec.h |   75 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 3973783..d4ad37e 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -225,6 +225,7 @@ header-y += kd.h
 header-y += kdev_t.h
 header-y += kernel.h
 header-y += kernelcapi.h
+header-y += kexec.h
 header-y += keyboard.h
 header-y += keyctl.h
 header-y += l2tp.h
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0d7d6a1..37c5f726 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -1,8 +1,58 @@
 #ifndef LINUX_KEXEC_H
 #define LINUX_KEXEC_H
 
-#ifdef CONFIG_KEXEC
+/* kexec system call -  It loads the new kernel to boot into.
+ * kexec does not sync, or unmount filesystems so if you need
+ * that to happen you need to do that yourself.
+ */
+
 #include <linux/types.h>
+
+/* kexec flags for different usage scenarios */
+#define KEXEC_ON_CRASH		0x00000001
+#define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_ARCH_MASK		0xffff0000
+
+/* These values match the ELF architecture values.
+ * Unless there is a good reason that should continue to be the case.
+ */
+#define KEXEC_ARCH_DEFAULT ( 0 << 16)
+#define KEXEC_ARCH_386     ( 3 << 16)
+#define KEXEC_ARCH_X86_64  (62 << 16)
+#define KEXEC_ARCH_PPC     (20 << 16)
+#define KEXEC_ARCH_PPC64   (21 << 16)
+#define KEXEC_ARCH_IA_64   (50 << 16)
+#define KEXEC_ARCH_ARM     (40 << 16)
+#define KEXEC_ARCH_S390    (22 << 16)
+#define KEXEC_ARCH_SH      (42 << 16)
+#define KEXEC_ARCH_MIPS_LE (10 << 16)
+#define KEXEC_ARCH_MIPS    ( 8 << 16)
+
+/* The artificial cap on the number of segments passed to kexec_load. */
+#define KEXEC_SEGMENT_MAX 16
+
+#ifndef __KERNEL__
+/*
+ * This structure is used to hold the arguments that are used when
+ * loading  kernel binaries.
+ */
+struct kexec_segment {
+	const void *buf;
+	size_t bufsz;
+	const void *mem;
+	size_t memsz;
+};
+
+/* Load a new kernel image as described by the kexec_segment array
+ * consisting of passed number of segments at the entry-point address.
+ * The flags allow different useage types.
+ */
+extern int kexec_load(void *, size_t, struct kexec_segment *,
+		unsigned long int);
+#endif /* __KERNEL__ */
+
+#ifdef __KERNEL__
+#ifdef CONFIG_KEXEC
 #include <linux/list.h>
 #include <linux/linkage.h>
 #include <linux/compat.h>
@@ -67,11 +117,10 @@ typedef unsigned long kimage_entry_t;
 #define IND_DONE         0x4
 #define IND_SOURCE       0x8
 
-#define KEXEC_SEGMENT_MAX 16
 struct kexec_segment {
 	void __user *buf;
 	size_t bufsz;
-	unsigned long mem;	/* User space sees this as a (void *) ... */
+	unsigned long mem;
 	size_t memsz;
 };
 
@@ -175,25 +224,6 @@ extern struct kimage *kexec_crash_image;
 #define kexec_flush_icache_page(page)
 #endif
 
-#define KEXEC_ON_CRASH		0x00000001
-#define KEXEC_PRESERVE_CONTEXT	0x00000002
-#define KEXEC_ARCH_MASK		0xffff0000
-
-/* These values match the ELF architecture values.
- * Unless there is a good reason that should continue to be the case.
- */
-#define KEXEC_ARCH_DEFAULT ( 0 << 16)
-#define KEXEC_ARCH_386     ( 3 << 16)
-#define KEXEC_ARCH_X86_64  (62 << 16)
-#define KEXEC_ARCH_PPC     (20 << 16)
-#define KEXEC_ARCH_PPC64   (21 << 16)
-#define KEXEC_ARCH_IA_64   (50 << 16)
-#define KEXEC_ARCH_ARM     (40 << 16)
-#define KEXEC_ARCH_S390    (22 << 16)
-#define KEXEC_ARCH_SH      (42 << 16)
-#define KEXEC_ARCH_MIPS_LE (10 << 16)
-#define KEXEC_ARCH_MIPS    ( 8 << 16)
-
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
 #define KEXEC_FLAGS    KEXEC_ON_CRASH
@@ -228,4 +258,5 @@ struct task_struct;
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
+#endif /* __KERNEL__ */
 #endif /* LINUX_KEXEC_H */
-- 
1.7.10


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
