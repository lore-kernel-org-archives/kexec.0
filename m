Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMRni-0003IB-53
 for kexec@lists.infradead.org; Mon, 11 Jul 2016 03:22:30 +0000
Date: Mon, 11 Jul 2016 11:22:03 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160711032203.GD2850@dhcp-128-65.nay.redhat.com>
References: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On 07/07/16 at 01:23pm, Thiago Jung Bauermann wrote:
> kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> implementation to find free memory for the purgatory stack.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> ---
>  include/linux/kexec.h |  1 +
>  kernel/kexec_file.c   | 25 ++++++++++++++++++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff5fa7707bd7..803f563df81d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -174,6 +174,7 @@ struct kexec_buf {
>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(u64, u64, void *));
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> +int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  struct kimage {
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 82ccfc4ee97e..3125d1689712 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -450,6 +450,23 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  }
>  
>  /**
> + * kexec_locate_mem_hole - find free memory for the purgatory or the next kernel
> + * @kbuf:	Parameters for the memory search.
> + *
> + * On success, kbuf->mem will have the start address of the memory region found.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> +{
> +	int ret;
> +
> +	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> +
> +	return ret == 1 ? 0 : -EADDRNOTAVAIL;
> +}
> +
> +/**
>   * kexec_add_buffer - place a buffer in a kexec segment
>   * @kbuf:	Buffer contents and memory parameters.
>   *
> @@ -489,11 +506,9 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
>  
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> -	if (ret != 1) {
> -		/* A suitable memory range could not be found for buffer */
> -		return -EADDRNOTAVAIL;
> -	}
> +	ret = kexec_locate_mem_hole(kbuf);
> +	if (ret)
> +		return ret;
>  
>  	/* Found a suitable memory range */
>  	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
> -- 
> 1.9.1
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
