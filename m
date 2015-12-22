Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aBKRC-0004Iy-0Y
 for kexec@lists.infradead.org; Tue, 22 Dec 2015 10:45:04 +0000
Date: Tue, 22 Dec 2015 18:47:04 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] kexec: Move some memembers and definitions within the
 scope of CONFIG_KEXEC_FILE
Message-ID: <20151222104704.GA28313@dhcp-128-25.nay.redhat.com>
References: <1450678154-12581-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1450678154-12581-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: dyoung@redhat.com, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On 12/21/15 at 02:09pm, Xunlei Pang wrote:
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 7b68d27..2cc643c 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -109,11 +109,7 @@ struct compat_kexec_segment {
>  };
>  #endif
>  
> -struct kexec_sha_region {
> -	unsigned long start;
> -	unsigned long len;
> -};
> -
> +#ifdef CONFIG_KEXEC_FILE
>  struct purgatory_info {
>  	/* Pointer to elf header of read only purgatory */
>  	Elf_Ehdr *ehdr;
> @@ -130,6 +126,28 @@ struct purgatory_info {
>  	unsigned long purgatory_load_addr;
>  };
>  
> +typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
> +typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
> +			     unsigned long kernel_len, char *initrd,
> +			     unsigned long initrd_len, char *cmdline,
> +			     unsigned long cmdline_len);
> +typedef int (kexec_cleanup_t)(void *loader_data);
> +
> +#ifdef CONFIG_KEXEC_VERIFY_SIG
> +typedef int (kexec_verify_sig_t)(const char *kernel_buf,
> +				 unsigned long kernel_len);
> +#endif
> +
> +struct kexec_file_ops {
> +	kexec_probe_t *probe;
> +	kexec_load_t *load;
> +	kexec_cleanup_t *cleanup;
> +#ifdef CONFIG_KEXEC_VERIFY_SIG
> +	kexec_verify_sig_t *verify_sig;
> +#endif
> +};
> +#endif
> +
>  struct kimage {
>  	kimage_entry_t head;
>  	kimage_entry_t *entry;
> @@ -161,6 +179,7 @@ struct kimage {
>  	struct kimage_arch arch;
>  #endif
>  
> +#ifdef CONFIG_KEXEC_FILE
>  	/* Additional fields for file based kexec syscall */
>  	void *kernel_buf;
>  	unsigned long kernel_buf_len;
> @@ -179,38 +198,7 @@ struct kimage {
>  
>  	/* Information for loading purgatory */
>  	struct purgatory_info purgatory_info;
> -};
> -
> -/*
> - * Keeps track of buffer parameters as provided by caller for requesting
> - * memory placement of buffer.
> - */
> -struct kexec_buf {
> -	struct kimage *image;
> -	char *buffer;
> -	unsigned long bufsz;
> -	unsigned long mem;
> -	unsigned long memsz;
> -	unsigned long buf_align;
> -	unsigned long buf_min;
> -	unsigned long buf_max;
> -	bool top_down;		/* allocate from top of memory hole */
> -};
> -
> -typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
> -typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
> -			     unsigned long kernel_len, char *initrd,
> -			     unsigned long initrd_len, char *cmdline,
> -			     unsigned long cmdline_len);
> -typedef int (kexec_cleanup_t)(void *loader_data);
> -typedef int (kexec_verify_sig_t)(const char *kernel_buf,
> -				 unsigned long kernel_len);
> -
> -struct kexec_file_ops {
> -	kexec_probe_t *probe;
> -	kexec_load_t *load;
> -	kexec_cleanup_t *cleanup;
> -	kexec_verify_sig_t *verify_sig;
> +#endif
>  };
>  
>  /* kexec interface functions */

Hi, Xunlei.

Following functions will be used only in kexec_file. Please wrap them in
CONFIG_KEXEC_FILE.

int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
					 unsigned long buf_len);
void * __weak arch_kexec_kernel_image_load(struct kimage *image);
int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
					unsigned long buf_len);
int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
					Elf_Shdr *sechdrs, unsigned int relsec);
int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
					unsigned int relsec);

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
