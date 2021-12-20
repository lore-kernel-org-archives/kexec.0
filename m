Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzDl0-0018Vz-Uq
 for kexec@lists.infradead.org; Mon, 20 Dec 2021 08:10:56 +0000
Date: Mon, 20 Dec 2021 16:10:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <20211220081045.GC31681@MiWiFi-R3L-srv>
References: <20211213143927.3069508-1-willy@infradead.org>
 <20211213143927.3069508-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213143927.3069508-2-willy@infradead.org>
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
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, kexec@lists.infradead.org, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org

On 12/13/21 at 02:39pm, Matthew Wilcox (Oracle) wrote:
> Instead of passing in a 'buf' and 'userbuf' argument, pass in an iov_iter.
> s390 needs more work to pass the iov_iter down further, or refactor,
> but I'd be more comfortable if someone who can test on s390 did that work.
> 
> It's more convenient to convert the whole of read_from_oldmem() to
> take an iov_iter at the same time, so rename it to read_from_oldmem_iter()
> and add a temporary read_from_oldmem() wrapper that creates an iov_iter.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>


Thanks for making this to do an awesome clean up. This one looks good to
me.

Acked-by: Baoquan He <bhe@redhat.com>

...... 
> -/**
> - * copy_oldmem_page() - copy one page from old kernel memory
> - * @pfn: page frame number to be copied
> - * @buf: buffer where the copied page is placed
> - * @csize: number of bytes to copy
> - * @offset: offset in bytes into the page
> - * @userbuf: if set, @buf is int he user address space
> - *
> - * This function copies one page from old kernel memory into buffer pointed by
> - * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
> - * copied or negative error in case of failure.
> - */
> -ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> -			 size_t csize, unsigned long offset,
> -			 int userbuf)
> +ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
> +			 size_t csize, unsigned long offset)
                                ^^^^^^
I am curious why this parameter is called 'csize', but not 'size' directly.
This is not related to this patch, it's an old naming.

>  {
>  	void *vaddr;
>  
> @@ -40,14 +28,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  	if (!vaddr)
>  		return -ENOMEM;
>  
> -	if (userbuf) {
> -		if (copy_to_user(buf, vaddr + offset, csize)) {
> -			iounmap(vaddr);
> -			return -EFAULT;
> -		}
> -	} else {
> -		memcpy(buf, vaddr + offset, csize);
> -	}
> +	csize = copy_to_iter(vaddr + offset, csize, iter);
>  
>  	iounmap(vaddr);
>  	return csize;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
