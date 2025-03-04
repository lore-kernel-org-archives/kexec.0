Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFB2C282DC
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wycB/u9XAOt4/lUuaE33ICpBJvDVt/GsVEGio+606mM=; b=rD/ycdUBssUyGixbCGMvBEJOjp
	B90ZtP0QneVtpegF8gXKaNV3hCP5Q654T35t/6yEHs55dnHcwW+Yz6us0s5NK4ydIomxU+mFgGrEW
	zML8lzFKd9WuISXYYdO+6HwtCYS1Xnz4Fg7h4FNOz8jCf4rT/IN58ES0DTv1aPZ+DYcLld2E022+O
	xEi+Ll0wZ3LYyhPYMeEdbQ5gZbtndX5l2Bmwk8EIGXj+2IWhacQ/N+e0Am9UETDhiA923ysgV2k+B
	bnrqINL2DjZmfiqFkgYC1HwcaKf/a2BB0OjDtDD1MkpuhFWdWN2umBeU/2NE8Y9KXhnzKf5iX1SYN
	OFPkE49g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpapV-00000006QcP-1NGS;
	Tue, 04 Mar 2025 22:33:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpafQ-00000006Ofv-26e1
	for kexec@bombadil.infradead.org;
	Tue, 04 Mar 2025 22:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wycB/u9XAOt4/lUuaE33ICpBJvDVt/GsVEGio+606mM=; b=Fv1zCjSUVMBsu6TQnsNbve6lkj
	l0ua3LLYeiZj52g/tSGQ37imUABqUAhPPnD/fzg1+Ih9/kYLOcNKvSoi6SIB3qI94A3DtEaNB6j6S
	SirY9eszDmaMneh3VIcvJvA2X/kie3zSMcW9OrkNm1HNjUqH1X/EhfkEfvPQgsJsbsHHru+Bjoqzm
	dTMsXnL5TrguMVHg0PJ7z7gnaJJ5jUgxIkdKfRds/glawvdQ7gfPGvHvJhcmSk2MBKeqy0HOU2Eea
	2L8QDk3wGC0bndE7ZDX2RQSVTeHXPeuMFmNarlYO9qAUdY/Imz7EnXLi2IQzPd1CwQDmhrY1xYnBl
	Kqae9FmA==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpafN-00000004ChS-1j8P
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 22:23:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CB036A4600C;
	Tue,  4 Mar 2025 22:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86B7C4CEE5;
	Tue,  4 Mar 2025 22:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741126987;
	bh=EDaTlL8s7EFTKV867gVON4AEWAHqBXSc9SoE/eEN/qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXlroVFNmbNpIfl+8c8IoweltYy9n1VHi8GYmTF3jMAjnINtqhc/TBQwWJCOHwj5q
	 TZb5JTA4lXEYIUO9bVrLimmEN7vbT0T5nfXxb9hQb9tEi0mAwBlgIUYs2yLXWvcmf7
	 C65ZP+HV3CQCW/CZAyeopoFnAbk84kqgJKU+PU4IJFTYc06oOocfGSr1AounpZ6tlW
	 eHROW6ZlbxDOhsPL7tV/PwSKu5Y13b+QNuDMBNzARuSXo6HrOCM8F0ZJ7VkIAkhk09
	 2tj1exuNOTBxF6p6GDNwxPA2ShDRQfndbGom1nCDpSpPnYNjjvJWir37zXTXem/bG0
	 SmGzVBGlTbQrw==
Date: Wed, 5 Mar 2025 00:23:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z8d9RvRWPOADOgsx@kernel.org>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-3-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-3-chenste@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_222309_783872_575BA962 
X-CRM114-Status: GOOD (  29.59  )
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

On Tue, Mar 04, 2025 at 11:03:46AM -0800, steven chen wrote:
> The content of memory segments carried over to the new kernel during the 
> kexec systemcall can be changed at kexec 'execute' stage, but the size of
> the memory segments cannot be changed at kexec 'execute' stage.
> 
> To copy IMA measurement logs during the kexec operation, IMA needs to 
> allocate memory at the kexec 'load' stage and map the segments to the 
> kimage structure. The mapped address will then be used to copy IMA 
> measurements during the kexec 'execute' stage.
> 
> Currently, the mechanism to map and unmap segments to the kimage 
> structure is not available to subsystems outside of kexec.

How does IMA work with kexec without having this? Just interested
(and confused). 

> 
> Implement kimage_map_segment() to enable IMA to map measurement log list to 
> the kimage structure during kexec 'load' stage.  This function takes a kimage 
> pointer, a memory address, and a size, then gathers the
> source pages within the specified address range, creates an array of page
> pointers, and maps these to a contiguous virtual address range.  The
> function returns the start virtual address of this range if successful, or NULL on
> failure.
> 
> Implement kimage_unmap_segment() for unmapping segments
> using vunmap().
> 
> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com> 
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  include/linux/kexec.h |  6 +++++
>  kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..7d6b12f8b8d0 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
>  #define kexec_dprintk(fmt, arg...) \
>          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>  
> +extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> +extern void kimage_unmap_segment(void *buffer);
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
>  struct task_struct;
> +struct kimage;
>  static inline void __crash_kexec(struct pt_regs *regs) { }
>  static inline void crash_kexec(struct pt_regs *regs) { }
>  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>  static inline int kexec_crash_loaded(void) { return 0; }
> +static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> +{ return NULL; }
> +static inline void kimage_unmap_segment(void *buffer) { }
>  #define kexec_in_progress false
>  #endif /* CONFIG_KEXEC_CORE */
>  
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c0bdc1686154..63e4d16b6023 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>  	return result;
>  }
>  
> +void *kimage_map_segment(struct kimage *image,
> +			 unsigned long addr, unsigned long size)
> +{
> +	unsigned long eaddr = addr + size;
> +	unsigned long src_page_addr, dest_page_addr;
> +	unsigned int npages;
> +	struct page **src_pages;
> +	int i;
> +	kimage_entry_t *ptr, entry;
> +	void *vaddr = NULL;
> +
> +	/*
> +	 * Collect the source pages and map them in a contiguous VA range.
> +	 */
> +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
> +	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
> +	if (!src_pages) {
> +		pr_err("Could not allocate ima pages array.\n");
> +		return NULL;
> +	}
> +
> +	i = 0;
> +	for_each_kimage_entry(image, ptr, entry) {
> +		if (entry & IND_DESTINATION) {
> +			dest_page_addr = entry & PAGE_MASK;
> +		} else if (entry & IND_SOURCE) {
> +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
> +				src_page_addr = entry & PAGE_MASK;
> +				src_pages[i++] =
> +					virt_to_page(__va(src_page_addr));
> +				if (i == npages)
> +					break;
> +				dest_page_addr += PAGE_SIZE;
> +			}
> +		}
> +	}
> +
> +	/* Sanity check. */
> +	WARN_ON(i < npages);
> +
> +	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
> +	kfree(src_pages);
> +
> +	if (!vaddr)
> +		pr_err("Could not map ima buffer.\n");
> +
> +	return vaddr;
> +}
> +
> +void kimage_unmap_segment(void *segment_buffer)
> +{
> +	vunmap(segment_buffer);
> +}
> +
>  struct kexec_load_limit {
>  	/* Mutex protects the limit count. */
>  	struct mutex mutex;
> -- 
> 2.25.1
> 
> 

BR, Jarkko

