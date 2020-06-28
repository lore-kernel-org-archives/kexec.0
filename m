Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpN3a-00013J-Al
 for kexec@lists.infradead.org; Sun, 28 Jun 2020 02:28:35 +0000
Subject: Re: [PATCH 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
From: piliu <piliu@redhat.com>
Message-ID: <ed94a357-16aa-9f17-aa5f-5aab6617ed68@redhat.com>
Date: Sun, 28 Jun 2020 10:28:15 +0800
MIME-Version: 1.0
In-Reply-To: <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
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
To: Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Mimi Zohar <zohar@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>

Hi Hari,

If in [4/11],  get_exclude_memory_ranges() turns out to be unnecessary
,then this patch is abundant either. As my understanding, memblock has
already helped to achieved the purpose that get_exclude_memory_ranges()
wants.

Thanks,
Pingfan

On 06/27/2020 03:04 AM, Hari Bathini wrote:
> Some archs can have special memory regions, within the given memory
> range, which can't be used for the buffer in a kexec segment. As
> kexec_add_buffer() function is being called from generic code as well,
> add weak arch_kexec_add_buffer definition for archs to override & take
> care of special regions before trying to locate a memory hole.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  include/linux/kexec.h |    5 +++++
>  kernel/kexec_file.c   |   37 +++++++++++++++++++++++++++++++++----
>  2 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 1776eb2..1237682 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -195,6 +195,11 @@ int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
>  					const Elf_Shdr *relsec,
>  					const Elf_Shdr *symtab);
>  
> +extern int arch_kexec_add_buffer(struct kexec_buf *kbuf);
> +
> +/* arch_kexec_add_buffer calls this when it is ready */
> +extern int __kexec_add_buffer(struct kexec_buf *kbuf);
> +
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index bb05fd5..a0b4f7f 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -669,10 +669,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>   */
>  int kexec_add_buffer(struct kexec_buf *kbuf)
>  {
> -
> -	struct kexec_segment *ksegment;
> -	int ret;
> -
>  	/* Currently adding segment this way is allowed only in file mode */
>  	if (!kbuf->image->file_mode)
>  		return -EINVAL;
> @@ -696,6 +692,25 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
>  	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
>  
> +	return arch_kexec_add_buffer(kbuf);
> +}
> +
> +/**
> + * __kexec_add_buffer - arch_kexec_add_buffer would call this function after
> + *                      updating kbuf, to place a buffer in a kexec segment.
> + * @kbuf:               Buffer contents and memory parameters.
> + *
> + * This function assumes that kexec_mutex is held.
> + * On successful return, @kbuf->mem will have the physical address of
> + * the buffer in memory.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int __kexec_add_buffer(struct kexec_buf *kbuf)
> +{
> +	struct kexec_segment *ksegment;
> +	int ret;
> +
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
>  	ret = kexec_locate_mem_hole(kbuf);
>  	if (ret)
> @@ -711,6 +726,20 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	return 0;
>  }
>  
> +/**
> + * arch_kexec_add_buffer - Some archs have memory regions within the given
> + *                         range that can't be used to place a kexec segment.
> + *                         Such archs can override this function to take care
> + *                         of them before trying to locate the memory hole.
> + * @kbuf:                  Buffer contents and memory parameters.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int __weak arch_kexec_add_buffer(struct kexec_buf *kbuf)
> +{
> +	return __kexec_add_buffer(kbuf);
> +}
> +
>  /* Calculate and store the digest of segments */
>  static int kexec_calculate_store_digests(struct kimage *image)
>  {
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
