Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8CFCFD370
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 04:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YdR8Z6T8OIfli5E5J41K476Jn08Ov4NSocZy3BTIhqU=; b=x+GXrQfVEocHIf2D6yaQ61vfEs
	rhN8qH9/19qnozO9+lgmg7r11UQOdfQa9WlaXn67A33qXe95KkUno9kCYokEI9f9vnd3BiGWwWxCp
	1IbJU0LzXxrDHTQjjdcie6BvClk/NKFz3CZBqNlKq1qzJJSEVt1yJqTjLEZMGobcSAjh6TgV1KViA
	kUjq7255epK9Jlt5qn5hISCsiZnQ7SQ5e+qicfVGi88/RPRxuV/tE7fo8NGkPqAy2/4qXz6oQ0LK+
	I9Bk6LwarY0GGJItL+Bgf7QR98vE8bY+kQitk5y347pJooz74KH/P9T+RcqxSQODlDkj1FHX3gc52
	37+M2TiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNl4u-0000000Ckzd-0tOi;
	Tue, 25 Nov 2025 04:55:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNl4q-0000000CkzF-48Xk
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 04:54:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764046494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YdR8Z6T8OIfli5E5J41K476Jn08Ov4NSocZy3BTIhqU=;
	b=UgFdoz08VvySZxlWyTTA17yzTZmjl5TivEP4FhY9hEmVHioDuE6OciFHU0ki2A3jnAxxmJ
	E3JKrpsCwZ6HXnbms0QEQpuGKKe3rnE2FkquYA5ER+xYW4m00KlRmDSOUNNQXz6mtx///9
	pRST0ZK7uXYG5fmdEqaz8MSrYNrN8Kg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-Bv9E9R1pOPyZ8Pcd9Gyg4Q-1; Mon,
 24 Nov 2025 23:54:49 -0500
X-MC-Unique: Bv9E9R1pOPyZ8Pcd9Gyg4Q-1
X-Mimecast-MFC-AGG-ID: Bv9E9R1pOPyZ8Pcd9Gyg4Q_1764046487
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E94E318001D1;
	Tue, 25 Nov 2025 04:54:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D683A18004D8;
	Tue, 25 Nov 2025 04:54:43 +0000 (UTC)
Date: Tue, 25 Nov 2025 12:54:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-ID: <aSU2jy/ujJILHH9n@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_205457_100602_51F3A4B4 
X-CRM114-Status: GOOD (  29.21  )
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

On 11/24/25 at 02:16pm, Andrew Morton wrote:
> On Thu,  6 Nov 2025 14:59:03 +0800 Pingfan Liu <piliu@redhat.com> wrote:
> 
> > The kexec segment index will be required to extract the corresponding
> > information for that segment in kimage_map_segment(). Additionally,
> > kexec_segment already holds the kexec relocation destination address and
> > size. Therefore, the prototype of kimage_map_segment() can be changed.
> 
> Could we please have some reviewer input on thee two patches?

I have some concerns about the one place of tiny code change, and the
root cause missing in log. And Mimi sent mail to me asking why this bug
can'e be seen on her laptop, I told her this bug can only be triggered
on system where CMA area exists. I think these need be addressed in v3.

> 
> (Pingfan, please cc linux-kernel on patches - it's where people go to
> find emails on lists which they aren't suscribed to)
> 
> (akpm goes off and subscribes to kexec@)
> 
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > To: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/kexec.h              | 4 ++--
> >  kernel/kexec_core.c                | 9 ++++++---
> >  security/integrity/ima/ima_kexec.c | 4 +---
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..8a22bc9b8c6c 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
> >  #define kexec_dprintk(fmt, arg...) \
> >          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> >  
> > -extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> > +extern void *kimage_map_segment(struct kimage *image, int idx);
> >  extern void kimage_unmap_segment(void *buffer);
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> >  static inline int kexec_crash_loaded(void) { return 0; }
> > -static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> > +static inline void *kimage_map_segment(struct kimage *image, int idx)
> >  { return NULL; }
> >  static inline void kimage_unmap_segment(void *buffer) { }
> >  #define kexec_in_progress false
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index fa00b239c5d9..9a1966207041 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int idx)
> >  	return result;
> >  }
> >  
> > -void *kimage_map_segment(struct kimage *image,
> > -			 unsigned long addr, unsigned long size)
> > +void *kimage_map_segment(struct kimage *image, int idx)
> >  {
> > +	unsigned long addr, size, eaddr;
> >  	unsigned long src_page_addr, dest_page_addr = 0;
> > -	unsigned long eaddr = addr + size;
> >  	kimage_entry_t *ptr, entry;
> >  	struct page **src_pages;
> >  	unsigned int npages;
> >  	void *vaddr = NULL;
> >  	int i;
> >  
> > +	addr = image->segment[idx].mem;
> > +	size = image->segment[idx].memsz;
> > +	eaddr = addr + size;
> > +
> >  	/*
> >  	 * Collect the source pages and map them in a contiguous VA range.
> >  	 */
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 7362f68f2d8b..5beb69edd12f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
> >  	if (!image->ima_buffer_addr)
> >  		return;
> >  
> > -	ima_kexec_buffer = kimage_map_segment(image,
> > -					      image->ima_buffer_addr,
> > -					      image->ima_buffer_size);
> > +	ima_kexec_buffer = kimage_map_segment(image, image->ima_segment_index);
> >  	if (!ima_kexec_buffer) {
> >  		pr_err("Could not map measurements buffer.\n");
> >  		return;
> > -- 
> > 2.49.0
> 


