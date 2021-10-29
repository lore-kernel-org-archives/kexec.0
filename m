Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgMGM-00A1ia-JP
 for kexec@lists.infradead.org; Fri, 29 Oct 2021 07:25:19 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] kexec_file: clean up arch_kexec_kernel_image_load
Date: Fri, 29 Oct 2021 15:24:24 +0800
Message-Id: <20211029072424.9109-4-bhe@redhat.com>
In-Reply-To: <20211029072424.9109-1-bhe@redhat.com>
References: <20211029072424.9109-1-bhe@redhat.com>
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
Cc: kexec@lists.infradead.org, dyoung@redhat.com, akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>

Function arch_kexec_kernel_image_load() has a common weak version which
is a wrapper of kexec_image_load_default() , and has only one arch
dependent version in x86_64. Now the x86_64 dependent function is not
needed any more. So clean it up.

And also rename kexec_image_load_default() to kexec_kernel_image_load() for
better reflecting its functionality.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 11 -----------
 include/linux/kexec.h              |  1 -
 kernel/kexec_file.c                |  9 ++-------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index dc8b17568784..6339ae7e6e79 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -371,17 +371,6 @@ void machine_kexec(struct kimage *image)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	if (!image->fops || !image->fops->load)
-		return ERR_PTR(-ENOEXEC);
-
-	return image->fops->load(image, image->kernel_buf,
-				 image->kernel_buf_len, image->initrd_buf,
-				 image->initrd_buf_len, image->cmdline_buf,
-				 image->cmdline_buf_len);
-}
-
 /*
  * Apply purgatory relocations.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..47b70402c0a4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -186,7 +186,6 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 /* Architectures may override the below functions */
 int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len);
-void *arch_kexec_kernel_image_load(struct kimage *image);
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..0f2eed939f1f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -60,7 +60,7 @@ int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 	return kexec_image_probe_default(image, buf, buf_len);
 }
 
-static void *kexec_image_load_default(struct kimage *image)
+static void *kexec_kernel_image_load(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
@@ -71,11 +71,6 @@ static void *kexec_image_load_default(struct kimage *image)
 				 image->cmdline_buf_len);
 }
 
-void * __weak arch_kexec_kernel_image_load(struct kimage *image)
-{
-	return kexec_image_load_default(image);
-}
-
 int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
@@ -279,7 +274,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	ima_add_kexec_buffer(image);
 
 	/* Call arch image load handlers */
-	ldata = arch_kexec_kernel_image_load(image);
+	ldata = kexec_kernel_image_load(image);
 
 	if (IS_ERR(ldata)) {
 		ret = PTR_ERR(ldata);
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
