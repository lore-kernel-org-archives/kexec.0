Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDC8C3ABCB
	for <kexec@archiver.kernel.org>; Mon, 12 May 2025 23:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqqKqN6+7vi7vcWHctM/OInU5vKYzOI7NzCsmciNe6I=; b=E5KO9fgLyO5WX+ezX84APu8HxG
	jhn0lzljizv5t5jrH49gxmd0eZan1KoZ7qiB9xXPnnAyGnErybXu8F3JSGSl0jPh6ZQHTZCYkNILZ
	FOXNrWtwoy5FEyT1zZhXNkGNP8LJCjTiZeUj1ibFUGK2lmlxgqnCj6jJNamB9tJrmAv+8nLzjgecM
	vwgd7GO6VC2UhRVZdfn/H+OF2hy4T8Fy8GAIgL9c/8fZaBEOpNuirQLayu2XNV3XyLvcE+bfF31p6
	onikTLBvzZwo5GHXULOxieUbSpmBSc7mOZBerhb0zP3ny+UI5s1uuKW7mRRxKRp+SAuAjJCWXtYQK
	EYjuuRaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEd3Z-0000000AxIT-37OF;
	Mon, 12 May 2025 23:59:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEd3W-0000000AxI3-40q1
	for kexec@lists.infradead.org;
	Mon, 12 May 2025 23:59:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BAD3B5C5C85;
	Mon, 12 May 2025 23:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BA1C4CEE7;
	Mon, 12 May 2025 23:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747094373;
	bh=EFW4kplBfp5PvCKelCjas54b0BRGDoqSeS+17LKB2Lk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PSPrKBy3xmNCETWcIRwwkoB0DJMRCdkgYS6KLO8QCc2oJChgW5ML7IuRokpMXlpDB
	 U11BcEaeO9ee6VZpH2t7py4lgyxxFnQIV8TICmD4X/ol9xyHAeJAGFb7crRmhDMp/q
	 u42NLNgIIIctcauWWPVLVMYC1HHghvnbZ75mSDfk=
Date: Mon, 12 May 2025 16:59:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Graf <graf@amazon.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Baoquan He
 <bhe@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 <nh-open-source@amazon.com>
Subject: Re: [PATCH] kexec: Enable CMA based contiguous allocation
Message-Id: <20250512165933.ad1dc7ec5872284b4b59f544@linux-foundation.org>
In-Reply-To: <20250512225752.11687-1-graf@amazon.com>
References: <20250512225752.11687-1-graf@amazon.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_165935_112669_44CC4CF6 
X-CRM114-Status: GOOD (  41.48  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, 12 May 2025 22:57:52 +0000 Alexander Graf <graf@amazon.com> wrote:

> When booting a new kernel with kexec_file, the kernel picks a target
> location that the kernel should live at, then allocates random pages,
> checks whether any of those patches magically happens to coincide with
> a target address range and if so, uses them for that range.
> 
> For every page allocated this way, it then creates a page list that the
> relocation code - code that executes while all CPUs are off and we are
> just about to jump into the new kernel - copies to their final memory
> location. We can not put them there before, because chances are pretty
> good that at least some page in the target range is already in use by
> the currently running Linux environment.
> 
> All of this is inefficient.
> 
> Since kexec got introduced, Linux has gained the CMA framework which
> can perform physically contiguous memory mappings, while keeping that
> memory available for movable memory when it is not needed for contiguous
> allocations. The default CMA allocator is for DMA allocations.
> 
> This patch adds logic to the kexec file loader to attempt to place the
> target payload at a location allocated from CMA. If successful, it uses
> that memory range directly instead of creating copy instructions during
> the hot phase. To ensure that there is a safety net in case anything goes
> wrong with the CMA allocation, it also adds a flag for user space to force
> disable CMA allocations.
> 
> Using CMA allocations has two advantages:
> 
>   1) Faster. There is no more need to copy in the hot phase.

How much faster?  Kinda matters as "fast" is the whole point of the patch!

>   2) More robust. Even if by accident some page is still in use for DMA,
>      the new kernel image will be safe from that access because it resides
>      in a memory region that is considered allocated in the old kernel and
>      has a chance to reinitialize that component.

Is this known to be a problem in current code?

Some minor observations:

> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
>
> ...
>
> @@ -331,6 +336,7 @@ struct kimage {
>  	 */
>  	unsigned int hotplug_support:1;
>  #endif
> +	unsigned int no_cma : 1;

"no_cma:1" is more conventional.

>  #ifdef ARCH_HAS_KIMAGE_ARCH
>  	struct kimage_arch arch;
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 5ae1741ea8ea..8958ebfcff94 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
>
> ...
>
> +static int kimage_load_cma_segment(struct kimage *image, struct kexec_segment *segment)
> +{
> +	unsigned long maddr;
> +	size_t ubytes, mbytes;
> +	int result = 0;
> +	unsigned char __user *buf = NULL;
> +	unsigned char *kbuf = NULL;
> +	char *ptr = page_address(segment->cma);
> +
> +	if (image->file_mode)
> +		kbuf = segment->kbuf;
> +	else
> +		buf = segment->buf;
> +	ubytes = segment->bufsz;
> +	mbytes = segment->memsz;
> +	maddr = segment->mem;
> +
> +	/* Initialize the buffer with zeros to allow for smaller input buffers */
> +	memset(ptr, 0, mbytes);

Would it be more efficient to zero the remainder after performing the copy?

> +	/* Then copy from source buffer to the CMA one */
> +	while (mbytes) {
> +		size_t uchunk, mchunk;
> +
> +		ptr += maddr & ~PAGE_MASK;
> +		mchunk = min_t(size_t, mbytes,
> +				PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		uchunk = min(ubytes, mchunk);
> +
> +		if (uchunk) {
> +			/* For file based kexec, source pages are in kernel memory */
> +			if (image->file_mode)
> +				memcpy(ptr, kbuf, uchunk);
> +			else
> +				result = copy_from_user(ptr, buf, uchunk);
> +			ubytes -= uchunk;
> +			if (image->file_mode)
> +				kbuf += uchunk;
> +			else
> +				buf += uchunk;
> +		}
> +
> +		if (result) {
> +			result = -EFAULT;
> +			goto out;
> +		}
> +
> +		ptr    += mchunk;
> +		maddr  += mchunk;
> +		mbytes -= mchunk;
> +
> +		cond_resched();
> +	}
> +out:
> +	return result;
> +}
> +
>
> ...
>
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
>
> ...
>
> @@ -632,6 +635,38 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
>  		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
>  }
>  
> +static int kexec_alloc_contig(struct kexec_buf *kbuf)
> +{
> +	u32 pages = (u32)(kbuf->memsz >> PAGE_SHIFT);

I don't think the cast is needed?

> +	unsigned long mem;
> +	struct page *p;
> +
> +	if (kbuf->image->no_cma)
> +		return -EPERM;
> +
> +	p = dma_alloc_from_contiguous(NULL, pages, get_order(kbuf->buf_align), true);

dma_alloc_from_contiguous()'s `count' arg is size_t.  Making `pages'
size_t seems best here.  (And nr_pages would be a better identifier!)


> +	if (!p)
> +		return -EADDRNOTAVAIL;

EADDRNOTAVAIL is a networking thing.  People will be surprised to see
kexec returning networking errors.  Perhaps choose something more
appropriate?

> +	pr_debug("allocated %d DMA pages at 0x%lx", pages, page_to_boot_pfn(p));
> +
> +	mem = page_to_boot_pfn(p) << PAGE_SHIFT;
> +
> +	if (kimage_is_destination_range(kbuf->image, mem, mem + kbuf->memsz)) {
> +		/* Our region is already in use by a statically defined one. Bail out. */
> +		pr_debug("CMA overlaps existing mem: 0x%lx+0x%lx\n", mem, kbuf->memsz);
> +		dma_release_from_contiguous(NULL, p, pages);
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	kbuf->mem = page_to_boot_pfn(p) << PAGE_SHIFT;
> +	kbuf->cma = p;
> +
> +	arch_kexec_post_alloc_pages(page_address(p), pages, 0);
> +
> +	return 0;
> +}
> +
>
> ...
>

