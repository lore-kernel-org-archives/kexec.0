Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aAtfh-0005GM-T3
 for kexec@lists.infradead.org; Mon, 21 Dec 2015 06:10:14 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH] kexec: Move some memembers and definitions within the scope
 of CONFIG_KEXEC_FILE
Date: Mon, 21 Dec 2015 14:09:14 +0800
Message-Id: <1450678154-12581-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Xunlei Pang <xlpang@redhat.com>, akpm@linux-foundation.org, dyoung@redhat.com, ebiederm@xmission.com

Move the stuff currently only used by the kexec file code within
CONFIG_KEXEC_FILE (and CONFIG_KEXEC_VERIFY_SIG).

Also move internal "struct kexec_sha_region" and "struct kexec_buf"
into "kexec_internal.h".

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c |  2 ++
 include/linux/kexec.h              | 62 +++++++++++++++-----------------------
 kernel/kexec_file.c                |  2 ++
 kernel/kexec_internal.h            | 21 +++++++++++++
 4 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 819ab3f..ba7fbba 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -385,6 +385,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return image->fops->cleanup(image->image_loader_data);
 }
 
+#ifdef CONFIG_KEXEC_VERIFY_SIG
 int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
 				 unsigned long kernel_len)
 {
@@ -395,6 +396,7 @@ int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
 
 	return image->fops->verify_sig(kernel, kernel_len);
 }
+#endif
 
 /*
  * Apply purgatory relocations.
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 7b68d27..2cc643c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -109,11 +109,7 @@ struct compat_kexec_segment {
 };
 #endif
 
-struct kexec_sha_region {
-	unsigned long start;
-	unsigned long len;
-};
-
+#ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/* Pointer to elf header of read only purgatory */
 	Elf_Ehdr *ehdr;
@@ -130,6 +126,28 @@ struct purgatory_info {
 	unsigned long purgatory_load_addr;
 };
 
+typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
+typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
+			     unsigned long kernel_len, char *initrd,
+			     unsigned long initrd_len, char *cmdline,
+			     unsigned long cmdline_len);
+typedef int (kexec_cleanup_t)(void *loader_data);
+
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+typedef int (kexec_verify_sig_t)(const char *kernel_buf,
+				 unsigned long kernel_len);
+#endif
+
+struct kexec_file_ops {
+	kexec_probe_t *probe;
+	kexec_load_t *load;
+	kexec_cleanup_t *cleanup;
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+	kexec_verify_sig_t *verify_sig;
+#endif
+};
+#endif
+
 struct kimage {
 	kimage_entry_t head;
 	kimage_entry_t *entry;
@@ -161,6 +179,7 @@ struct kimage {
 	struct kimage_arch arch;
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
 	/* Additional fields for file based kexec syscall */
 	void *kernel_buf;
 	unsigned long kernel_buf_len;
@@ -179,38 +198,7 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
-};
-
-/*
- * Keeps track of buffer parameters as provided by caller for requesting
- * memory placement of buffer.
- */
-struct kexec_buf {
-	struct kimage *image;
-	char *buffer;
-	unsigned long bufsz;
-	unsigned long mem;
-	unsigned long memsz;
-	unsigned long buf_align;
-	unsigned long buf_min;
-	unsigned long buf_max;
-	bool top_down;		/* allocate from top of memory hole */
-};
-
-typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
-typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
-			     unsigned long kernel_len, char *initrd,
-			     unsigned long initrd_len, char *cmdline,
-			     unsigned long cmdline_len);
-typedef int (kexec_cleanup_t)(void *loader_data);
-typedef int (kexec_verify_sig_t)(const char *kernel_buf,
-				 unsigned long kernel_len);
-
-struct kexec_file_ops {
-	kexec_probe_t *probe;
-	kexec_load_t *load;
-	kexec_cleanup_t *cleanup;
-	kexec_verify_sig_t *verify_sig;
+#endif
 };
 
 /* kexec interface functions */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b70ada0..007b791 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -109,11 +109,13 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_KEXEC_VERIFY_SIG
 int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 					unsigned long buf_len)
 {
 	return -EKEYREJECTED;
 }
+#endif
 
 /* Apply relocations of type RELA */
 int __weak
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index e4392a6..0a52315 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -15,6 +15,27 @@ int kimage_is_destination_range(struct kimage *image,
 extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
+struct kexec_sha_region {
+	unsigned long start;
+	unsigned long len;
+};
+
+/*
+ * Keeps track of buffer parameters as provided by caller for requesting
+ * memory placement of buffer.
+ */
+struct kexec_buf {
+	struct kimage *image;
+	char *buffer;
+	unsigned long bufsz;
+	unsigned long mem;
+	unsigned long memsz;
+	unsigned long buf_align;
+	unsigned long buf_min;
+	unsigned long buf_max;
+	bool top_down;		/* allocate from top of memory hole */
+};
+
 void kimage_file_post_load_cleanup(struct kimage *image);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
