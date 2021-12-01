Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msFOZ-007JoC-Jw
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 02:30:57 +0000
Received: by mail-pg1-f199.google.com with SMTP id
 s18-20020a63ff52000000b00320f169c0aaso11307863pgk.18
 for <kexec@lists.infradead.org>; Tue, 30 Nov 2021 18:30:52 -0800 (PST)
Date: Wed, 1 Dec 2021 10:26:37 +0800
From: Coiby Xu <coxu@redhat.com>
Subject: Re: Compile error ppc64le: Cannot find symbol for section 11:
 .text.unlikely.
Message-ID: <20211201022637.izwnmy57nc4xxljv@Rk>
References: <CA+tGwnkDsuwOyDoZUNvi9ExhSsiF1MiGvegwjpQem8c3BPJ=6g@mail.gmail.com>
 <20211124134743.GB11728@MiWiFi-R3L-srv>
 <20211201021926.3xfabf5zbzidvrwa@Rk>
MIME-Version: 1.0
In-Reply-To: <20211201021926.3xfabf5zbzidvrwa@Rk>
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
To: Baoquan He <bhe@redhat.com>
Cc: Veronika Kabatova <vkabatov@redhat.com>, kexec@lists.infradead.org, ebiederm@xmission.com

On Wed, Dec 01, 2021 at 10:19:26AM +0800, Coiby Xu wrote:
>On Wed, Nov 24, 2021 at 09:47:43PM +0800, Baoquan He wrote:
>>On 11/24/21 at 01:47pm, Veronika Kabatova wrote:
>>>Hi,
>>>
>>>for a while we've been seen the following error when compiling
>>>the mainline kernel with gcc 11.2 and binutils 2.37:
>>>
>>>00:02:32 Cannot find symbol for section 11: .text.unlikely.
>>>00:02:32 kernel/kexec_file.o: failed
>>>00:02:32 make[3]: *** [scripts/Makefile.build:287: kernel/kexec_file.o] Error 1
>>>00:02:32 make[3]: *** Deleting file 'kernel/kexec_file.o'
>>>00:02:32 make[2]: *** [Makefile:1846: kernel] Error 2
>>>00:02:32 make[2]: *** Waiting for unfinished jobs....
>>>
>>>The error only happens with ppc64le. I've tested this with cross
>>>compilation, but the only reference to the error I found suggests
>>>the same happens with the native compiles as well:
>>>
>>>https://github.com/groeck/linux-build-test/commit/142cbefbc0d37962c9a6c7f28ee415ecd5fd1e98
>>>
>>>In case it matters, the config used is the Fedora config with
>>>kselftest options enabled, which you can grab from
>>>
>>>https://gitlab.com/redhat/red-hat-ci-tools/kernel/cki-internal-pipelines/cki-trusted-contributors/-/jobs/1760752896/artifacts/raw/artifacts/kernel-mainline.kernel.org-ppc64le-e4e737bb5c170df6135a127739a9e6148ee3da82.config
>>>
>>>
>>>I've reached out to the Fedora compiler folks and Nick Clifton
>>>suggested this is a problem with the kernel:
>>>
>>>    This message comes from the recordmcount tool, which is part of the kernel
>>>    sources:
>>>
>>>    linux/scripts/recordmcount.[ch]
>>>
>>>    It appears to be triggered when a compiler update causes code to be
>>>    rearranged. The problem has been reported before in various forums,
>>>    but in particular I found this reference:
>>>
>>>    https://lore.kernel.org/lkml/20201204165742.3815221-2-arnd@kernel.org/
>>>
>>>    The point of which to me at least is that this is a kernel issue rather than
>>>    a compiler issue.  Ie there must be some weak symbols in kexec_file.o file
>>>    which need to be moved elsewhere.
>>
>>It could be arch_kexec_kernel_verify_sig() in kernel/kexec_file.c which
>>is __weak, but not implemented in any ARCH. If true, this has been
>>pointed out by Eric in one patch thread from Coiby.
>>
>>[PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
>>http://lkml.kernel.org/r/20211018083137.338757-2-coxu@redhat.com
>>
>>Maybe Coiby can fetch above config file and run the test to check.
>
>"[PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig" alone
>would fix the error. If I turn arch_kexec_apply_relocations{_add,} into
  ^^^^^
  wouldn't 

Sorry I made a typo.

>static function, the error would be gone. As attached is the patch would
>make this error disappear.
>
>However, s390 and x86 have its own implementation of
>arch_kexec_apply_relocations_add. This makes it looks like to be gcc's
>issue.
>
>
>>
>>Thanks
>>Baoquan
>>
>
>-- 
>Best regards,
>Coiby

From 49e0333f5a0743cdcc99777218524d6a6cd5ec34 Mon Sep 17 00:00:00 2001
>From: Coiby Xu <coxu@redhat.com>
>Date: Mon, 18 Oct 2021 15:52:46 +0800
>Subject: [PATCH] fix error "ppc64le: Cannot find symbol for section 11:
> .text.unlikely."
>
>---
> include/linux/kexec.h | 13 -------------
> kernel/kexec_file.c   | 40 ++++++++++++++++------------------------
> 2 files changed, 16 insertions(+), 37 deletions(-)
>
>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>index 0c994ae37..1476470a1 100644
>--- a/include/linux/kexec.h
>+++ b/include/linux/kexec.h
>@@ -186,20 +186,7 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
> /* Architectures may override the below functions */
> int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> 				  unsigned long buf_len);
>-void *arch_kexec_kernel_image_load(struct kimage *image);
>-int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>-				     Elf_Shdr *section,
>-				     const Elf_Shdr *relsec,
>-				     const Elf_Shdr *symtab);
>-int arch_kexec_apply_relocations(struct purgatory_info *pi,
>-				 Elf_Shdr *section,
>-				 const Elf_Shdr *relsec,
>-				 const Elf_Shdr *symtab);
> int arch_kimage_file_post_load_cleanup(struct kimage *image);
>-#ifdef CONFIG_KEXEC_SIG
>-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>-				 unsigned long buf_len);
>-#endif
> int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>
> extern int kexec_add_buffer(struct kexec_buf *kbuf);
>diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>index 8347fc158..e0afe36d3 100644
>--- a/kernel/kexec_file.c
>+++ b/kernel/kexec_file.c
>@@ -71,7 +71,7 @@ static void *kexec_image_load_default(struct kimage *image)
> 				 image->cmdline_buf_len);
> }
>
>-void * __weak arch_kexec_kernel_image_load(struct kimage *image)
>+static void * arch_kexec_kernel_image_load(struct kimage *image)
> {
> 	return kexec_image_load_default(image);
> }
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
>@@ -117,7 +98,7 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  *
>  * Return: 0 on success, negative errno on error.
>  */
>-int __weak
>+static int
> arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
> 				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
> {
>@@ -134,7 +115,7 @@ arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
>  *
>  * Return: 0 on success, negative errno on error.
>  */
>-int __weak
>+static int
> arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
> 			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
> {
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
>2.33.1
>


-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
