Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD1DCFD360
	for <kexec@archiver.kernel.org>; Mon, 24 Nov 2025 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Ppi1BuPoqx1X2zZWvNparSryNPkUQN2+rPFLpw1M9E=; b=JqaI5bQgLCT7GHDiiLulYy7n5T
	2eH3jbDHMInq1m6wd/2YPdH8VbO4ruiKyQzVhctrgdp5Hk1o9Q5VWJKyJ4w2GPGqB25xcSwPwatN+
	QixOaxXxVZfrR7GLCj+gJ27gS5kdphIb+e+7dWua5gidnpvV9/bhyf4Rv0GTwRdsaV5H0JNmfuaPp
	LscH3GKfJg6aYafUXLDp3/K5hXY6OT+33lI3go8Z57afklg0/ATbmgxMcicYSm6DR9VVFJG7T1Gcb
	RTrLdTNBbtt5R6HgRadt4S3ulM4BfKRHN+hu9L8HXUZP56oqXQRGJzEaiWaRW2Oo8rEQrsed3ajat
	7BPTF2xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNerB-0000000COL8-0t6p;
	Mon, 24 Nov 2025 22:16:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNer8-0000000COKk-3fNh
	for kexec@lists.infradead.org;
	Mon, 24 Nov 2025 22:16:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CE109406A4;
	Mon, 24 Nov 2025 22:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D140C4CEF1;
	Mon, 24 Nov 2025 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764022581;
	bh=GOp5yKMHo3eVqVHkrd/G0zl12EV/VQsYrfuHXNZh7kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U3kJ8b5NBNgEEd9LwD3J5j7xvNlg6icnkz9UTERPiTHQbfDUqBzNaYwZRCBzYEzQ6
	 tEnjHRl3aTn3d5PHcT+RXVM0jF11hvwHNtPa9C4lmwkYHS/LzYbKg8n7PsvmDjvk6m
	 fuixOeQ4QvOLSYTI8rmM4wkrCvlj4b9gly9K+UGU=
Date: Mon, 24 Nov 2025 14:16:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, Baoquan He
 <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, Steven Chen
 <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-Id: <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
In-Reply-To: <20251106065904.10772-1-piliu@redhat.com>
References: <20251106065904.10772-1-piliu@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_141622_990705_9909CE8A 
X-CRM114-Status: GOOD (  22.80  )
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

On Thu,  6 Nov 2025 14:59:03 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> The kexec segment index will be required to extract the corresponding
> information for that segment in kimage_map_segment(). Additionally,
> kexec_segment already holds the kexec relocation destination address and
> size. Therefore, the prototype of kimage_map_segment() can be changed.

Could we please have some reviewer input on thee two patches?

Thanks.

(Pingfan, please cc linux-kernel on patches - it's where people go to
find emails on lists which they aren't suscribed to)

(akpm goes off and subscribes to kexec@)

> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: <stable@vger.kernel.org>
> To: kexec@lists.infradead.org
> To: linux-integrity@vger.kernel.org
> ---
>  include/linux/kexec.h              | 4 ++--
>  kernel/kexec_core.c                | 9 ++++++---
>  security/integrity/ima/ima_kexec.c | 4 +---
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff7e231b0485..8a22bc9b8c6c 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
>  #define kexec_dprintk(fmt, arg...) \
>          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>  
> -extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> +extern void *kimage_map_segment(struct kimage *image, int idx);
>  extern void kimage_unmap_segment(void *buffer);
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
> @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
>  static inline void crash_kexec(struct pt_regs *regs) { }
>  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>  static inline int kexec_crash_loaded(void) { return 0; }
> -static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> +static inline void *kimage_map_segment(struct kimage *image, int idx)
>  { return NULL; }
>  static inline void kimage_unmap_segment(void *buffer) { }
>  #define kexec_in_progress false
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index fa00b239c5d9..9a1966207041 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int idx)
>  	return result;
>  }
>  
> -void *kimage_map_segment(struct kimage *image,
> -			 unsigned long addr, unsigned long size)
> +void *kimage_map_segment(struct kimage *image, int idx)
>  {
> +	unsigned long addr, size, eaddr;
>  	unsigned long src_page_addr, dest_page_addr = 0;
> -	unsigned long eaddr = addr + size;
>  	kimage_entry_t *ptr, entry;
>  	struct page **src_pages;
>  	unsigned int npages;
>  	void *vaddr = NULL;
>  	int i;
>  
> +	addr = image->segment[idx].mem;
> +	size = image->segment[idx].memsz;
> +	eaddr = addr + size;
> +
>  	/*
>  	 * Collect the source pages and map them in a contiguous VA range.
>  	 */
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 7362f68f2d8b..5beb69edd12f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
>  	if (!image->ima_buffer_addr)
>  		return;
>  
> -	ima_kexec_buffer = kimage_map_segment(image,
> -					      image->ima_buffer_addr,
> -					      image->ima_buffer_size);
> +	ima_kexec_buffer = kimage_map_segment(image, image->ima_segment_index);
>  	if (!ima_kexec_buffer) {
>  		pr_err("Could not map measurements buffer.\n");
>  		return;
> -- 
> 2.49.0

