Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsN5x-0002Gh-QZ
 for kexec@lists.infradead.org; Mon, 06 Jul 2020 09:07:26 +0000
Date: Mon, 6 Jul 2020 17:07:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 01/12] kexec_file: allow archs to handle special
 regions while locating memory hole
Message-ID: <20200706090707.GA9048@dhcp-128-65.nay.redhat.com>
References: <159371956443.21555.18251597651350106920.stgit@hbathini.in.ibm.com>
 <159371964681.21555.573193508667543223.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <159371964681.21555.573193508667543223.stgit@hbathini.in.ibm.com>
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>, kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Mimi Zohar <zohar@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>

On 07/03/20 at 01:24am, Hari Bathini wrote:
> Some architectures may have special memory regions, within the given
> memory range, which can't be used for the buffer in a kexec segment.
> Implement weak arch_kexec_locate_mem_hole() definition which arch code
> may override, to take care of special regions, while trying to locate
> a memory hole.
> 
> Also, add the missing declarations for arch overridable functions and
> and drop the __weak descriptors in the declarations to avoid non-weak
> definitions from becoming weak.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> [lkp: In v1, arch_kimage_file_post_load_cleanup() declaration was missing]
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> Changes in v2:
> * Introduced arch_kexec_locate_mem_hole() for override and dropped
>   weak arch_kexec_add_buffer().
> * Dropped __weak identifier for arch overridable functions.
> * Fixed the missing declaration for arch_kimage_file_post_load_cleanup()
>   reported by lkp. lkp report for reference:
>     - https://lore.kernel.org/patchwork/patch/1264418/
> 
> 
>  include/linux/kexec.h |   29 ++++++++++++++++++-----------
>  kernel/kexec_file.c   |   16 ++++++++++++++--
>  2 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ea67910..9e93bef 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -183,17 +183,24 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  				   bool get_value);
>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
>  
> -int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> -					 unsigned long buf_len);
> -void * __weak arch_kexec_kernel_image_load(struct kimage *image);
> -int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> -					    Elf_Shdr *section,
> -					    const Elf_Shdr *relsec,
> -					    const Elf_Shdr *symtab);
> -int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
> -					Elf_Shdr *section,
> -					const Elf_Shdr *relsec,
> -					const Elf_Shdr *symtab);
> +/* Architectures may override the below functions */
> +int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> +				  unsigned long buf_len);
> +void *arch_kexec_kernel_image_load(struct kimage *image);
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +int arch_kexec_apply_relocations(struct purgatory_info *pi,
> +				 Elf_Shdr *section,
> +				 const Elf_Shdr *relsec,
> +				 const Elf_Shdr *symtab);
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#ifdef CONFIG_KEXEC_SIG
> +int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> +				 unsigned long buf_len);
> +#endif
> +int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 09cc78d..e89912d 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -636,6 +636,19 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  }
>  
>  /**
> + * arch_kexec_locate_mem_hole - Find free memory to place the segments.
> + * @kbuf:                       Parameters for the memory search.
> + *
> + * On success, kbuf->mem will have the start address of the memory region found.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> +{
> +	return kexec_locate_mem_hole(kbuf);
> +}
> +
> +/**
>   * kexec_add_buffer - place a buffer in a kexec segment
>   * @kbuf:	Buffer contents and memory parameters.
>   *
> @@ -647,7 +660,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>   */
>  int kexec_add_buffer(struct kexec_buf *kbuf)
>  {
> -
>  	struct kexec_segment *ksegment;
>  	int ret;
>  
> @@ -675,7 +687,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
>  
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> -	ret = kexec_locate_mem_hole(kbuf);
> +	ret = arch_kexec_locate_mem_hole(kbuf);
>  	if (ret)
>  		return ret;
>  
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
