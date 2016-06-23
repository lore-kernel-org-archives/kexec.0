Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFuQH-0007h9-Te
 for kexec@lists.infradead.org; Thu, 23 Jun 2016 02:31:18 +0000
Date: Thu, 23 Jun 2016 10:30:52 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160623023052.GB12575@dhcp-128-11.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1466538521-31216-4-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622101801.GB7752@dhcp-128-65.nay.redhat.com>
 <5025034.R6Ttz76WZM@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5025034.R6Ttz76WZM@hactar>
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
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On 06/22/16 at 08:34pm, Thiago Jung Bauermann wrote:
> Am Mittwoch, 22 Juni 2016, 18:18:01 schrieb Dave Young:
> > On 06/21/16 at 04:48pm, Thiago Jung Bauermann wrote:
> > > +/**
> > > + * kexec_locate_mem_hole - find free memory to load segment or use in
> > > purgatory + * @image:	kexec image being updated.
> > > + * @size:	Memory size.
> > > + * @align:	Minimum alignment needed.
> > > + * @min_addr:	Minimum starting address.
> > > + * @max_addr:	Maximum end address.
> > > + * @top_down	Find the highest free memory region?
> > > + * @addr	On success, will have start address of the memory region
> > > found.
> > > + *
> > > + * Return: 0 on success, negative errno on error.
> > > + */
> > > +int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
> > > +			  unsigned long align, unsigned long min_addr,
> > > +			  unsigned long max_addr, bool top_down,
> > > +			  unsigned long *addr)
> > > +{
> > > +	int ret;
> > > +	struct kexec_buf buf;
> > > +
> > > +	memset(&buf, 0, sizeof(struct kexec_buf));
> > > +	buf.image = image;
> > > +
> > > +	buf.memsz = size;
> > > +	buf.buf_align = align;
> > > +	buf.buf_min = min_addr;
> > > +	buf.buf_max = max_addr;
> > > +	buf.top_down = top_down;
> > 
> > Since patch 2/9 moved kexec_buf from internal header file to kexec.h it
> > will be natural to passing a kexec_buf pointer intead of passing all
> > these arguments in kexec_locate_mem_hole.
> > 
> > kbuf.mem can be used for addr.
> 
> Ok. What about this version?
> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
> 
> Subject: [PATCH 3/9] kexec_file: Factor out kexec_locate_mem_hole from
>  kexec_add_buffer.
> 
> kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> implementation to find free memory for the purgatory stack.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/kexec.h | 12 +++++++++---
>  kernel/kexec_file.c   | 25 ++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 3d91bcfc180d..e8b099da47f5 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -147,9 +147,14 @@ struct kexec_file_ops {
>  #endif
>  };
>  
> -/*
> - * Keeps track of buffer parameters as provided by caller for requesting
> - * memory placement of buffer.
> +/**
> + * struct kexec_buf - parameters for finding a place for a buffer in memory
> + * @image:	kexec image in which memory to search.
> + * @size:	Memory size for the buffer.
> + * @align:	Minimum alignment needed.
> + * @min_addr:	Minimum starting address.
> + * @max_addr:	Maximum end address.
> + * @top_down:	Find the highest free memory region?

Above parameter comments should go to previous patch.
Other than that it looks good.

Thanks
Dave
>   */
>  struct kexec_buf {
>  	struct kimage *image;
> @@ -163,6 +168,7 @@ struct kexec_buf {
>  
>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(u64, u64, void *));
> +int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  struct kimage {
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b1f1f6402518..445d66add8ca 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -449,6 +449,23 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
>  }
>  
> +/**
> + * kexec_locate_mem_hole - find free memory to load segment or use in purgatory
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
>  /*
>   * Helper function for placing a buffer in a kexec segment. This assumes
>   * that kexec_mutex is held.
> @@ -493,11 +510,9 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  	kbuf->top_down = top_down;
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
>  	ksegment = &image->segment[image->nr_segments];
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
