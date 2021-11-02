Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhktM-000UcH-EW
 for kexec@lists.infradead.org; Tue, 02 Nov 2021 03:55:21 +0000
Received: by mail-pg1-f200.google.com with SMTP id
 p20-20020a63fe14000000b002cc2a31eaf6so4044300pgh.6
 for <kexec@lists.infradead.org>; Mon, 01 Nov 2021 20:55:16 -0700 (PDT)
Date: Tue, 2 Nov 2021 11:52:27 +0800
From: Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <20211102035227.4c4kvqqunpwgcuup@Rk>
References: <20211018083137.338757-1-coxu@redhat.com>
 <20211018083137.338757-2-coxu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211018083137.338757-2-coxu@redhat.com>
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>, kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>

Hi Eric,

Does this patch and "[PATCH v3 2/3] kexec, KEYS: make the code in
bzImage64_verify_sig generic" look good you?

On Mon, Oct 18, 2021 at 04:31:35PM +0800, Coiby Xu wrote:
>commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
>powerpc: factor out kexec_file_ops functions" allows implementing
>the arch-specific implementation of kernel image verification
>in kexec_file_ops->verify_sig. Currently, there is no arch-specific
>implementation of arch_kexec_kernel_verify_sig. So clean it up.
>
>Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> include/linux/kexec.h |  4 ----
> kernel/kexec_file.c   | 34 +++++++++++++---------------------
> 2 files changed, 13 insertions(+), 25 deletions(-)
>
>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>index 0c994ae37729..755fed183224 100644
>--- a/include/linux/kexec.h
>+++ b/include/linux/kexec.h
>@@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
> 				 const Elf_Shdr *relsec,
> 				 const Elf_Shdr *symtab);
> int arch_kimage_file_post_load_cleanup(struct kimage *image);
>-#ifdef CONFIG_KEXEC_SIG
>-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>-				 unsigned long buf_len);
>-#endif
> int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>
> extern int kexec_add_buffer(struct kexec_buf *kbuf);
>diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>index 33400ff051a8..42b3ac34e4ee 100644
>--- a/kernel/kexec_file.c
>+++ b/kernel/kexec_file.c
>@@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
> 	return kexec_image_post_load_cleanup_default(image);
> }
>
>-#ifdef CONFIG_KEXEC_SIG
>-static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>-					  unsigned long buf_len)
>-{
>-	if (!image->fops || !image->fops->verify_sig) {
>-		pr_debug("kernel loader does not support signature verification.\n");
>-		return -EKEYREJECTED;
>-	}
>-
>-	return image->fops->verify_sig(buf, buf_len);
>-}
>-
>-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>-					unsigned long buf_len)
>-{
>-	return kexec_image_verify_sig_default(image, buf, buf_len);
>-}
>-#endif
>-
> /*
>  * arch_kexec_apply_relocations_add - apply relocations of type RELA
>  * @pi:		Purgatory to be relocated.
>@@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
> }
>
> #ifdef CONFIG_KEXEC_SIG
>+static int kexec_image_verify_sig(struct kimage *image, void *buf,
>+		unsigned long buf_len)
>+{
>+	if (!image->fops || !image->fops->verify_sig) {
>+		pr_debug("kernel loader does not support signature verification.\n");
>+		return -EKEYREJECTED;
>+	}
>+
>+	return image->fops->verify_sig(buf, buf_len);
>+}
>+
> static int
> kimage_validate_signature(struct kimage *image)
> {
> 	int ret;
>
>-	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>-					   image->kernel_buf_len);
>+	ret = kexec_image_verify_sig(image, image->kernel_buf,
>+			image->kernel_buf_len);
> 	if (ret) {
>
> 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
>-- 
>2.31.1
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
