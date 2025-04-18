Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3095DC369AB
	for <kexec@archiver.kernel.org>; Fri, 18 Apr 2025 04:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4z2rRRUuOwywXorABV6PjT0ToaPZLx/d2Fez8DE9Oc=; b=N5XZzzcFuVZCgeyTH2YMMqeFD+
	zItd5S53E4zC2NNyXK75lqqT5pjxE3XAfr4CwcC03Fli0Pr/nId7W4XGjxqa9YSQ1uuaswqdfctA7
	IirnGsDd1bNSd2pVE89+KTY4o04pxXeBPk5w1oh6Tk/bxorHXPFLcuAaM+B1U5CFUmZ0CAQX5tpBe
	u9m2GVYsMxkk7qp5M/uQCb3riB0kKJhEBnjZ+03+WsxZHcSHz6FbtU7LoFt+3m/TScHAFBiFfDsES
	XFM9hJMG04MLZaxFRZzEK6tS8jb2QAijjtyvEVPbECQZbMEG/hFQBbe9vbGLjZaPK6toBj1aTa8y5
	s0wOOGNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5dTN-0000000F5XC-3NgS;
	Fri, 18 Apr 2025 04:37:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5dTL-0000000F5Wo-3gMk
	for kexec@lists.infradead.org;
	Fri, 18 Apr 2025 04:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744951022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4z2rRRUuOwywXorABV6PjT0ToaPZLx/d2Fez8DE9Oc=;
	b=H5BeNks9SNjq0yYveB3RxxSZU5l0VXFLXhRN1pZGw0mBhAvEyB8Xab34jcrfuukQgDLxDm
	51qXEzvLO3c2GTruqHGCkyNW+arJwnLCowL3Z/7+nAOBJVyvvKD1P3+khYS8SMosvI/JoM
	AYIZcdPyp8qVcb1TzKdMUhuEd5KBOxI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-BAv6iW8rOyy94eXYbPoNlw-1; Fri,
 18 Apr 2025 00:36:58 -0400
X-MC-Unique: BAv6iW8rOyy94eXYbPoNlw-1
X-Mimecast-MFC-AGG-ID: BAv6iW8rOyy94eXYbPoNlw_1744951016
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CDFA1956048;
	Fri, 18 Apr 2025 04:36:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.106])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D250119560A3;
	Fri, 18 Apr 2025 04:36:52 +0000 (UTC)
Date: Fri, 18 Apr 2025 12:36:48 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v12 3/9] kexec: define functions to map and unmap segments
Message-ID: <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-4-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021028.1403-4-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_213704_001620_91CF2AA9 
X-CRM114-Status: GOOD (  27.10  )
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

On 04/15/25 at 07:10pm, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
 ^^^^^^
> 
> Implement kimage_map_segment() to enable IMA to map the measurement log 
> list to the kimage structure during the kexec 'load' stage. This function
> gathers the source pages within the specified address range, and maps them
> to a contiguous virtual address range.
> 
> This is a preparation for later usage.
> 
> Implement kimage_unmap_segment() for unmapping segments using vunmap().
> 
> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
  ^^^^^^
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
  ^^^^^^^
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com> 
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
  ^^^^^

The signing on this patch is a little confusing. I can't see who is the
real author, who is the co-author, between you and Tushar. You may need
to refer to Documentation/process/5.Posting.rst to make that clear.

> Acked-by: Baoquan He <bhe@redhat.com>
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
> index c0bdc1686154..a5e378e1dc7f 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>  	return result;
>  }
>  
> +void *kimage_map_segment(struct kimage *image,
> +			 unsigned long addr, unsigned long size)
> +{
> +	unsigned long src_page_addr, dest_page_addr = 0;
> +	unsigned long eaddr = addr + size;
> +	kimage_entry_t *ptr, entry;
> +	struct page **src_pages;
> +	unsigned int npages;
> +	void *vaddr = NULL;
> +	int i;
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
> 2.43.0
> 


