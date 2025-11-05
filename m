Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B554CCFA04
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 03:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RbBUg28oaxVkeEtep5SXlIW3XpdcocyXCTta6NwNqNc=; b=lvzSd05HPJcYNEApVxum0z4aUI
	acB066FOpYsqNysYTSPCch4Jt/wNyJsl8ehVAcvomH1Qk0L8I1LIfirZY+lH0F5rNs2F+7i/nYXZp
	p+Fqb9O7sSPsSkWBHKXetv60m+YXxmmgzUHjT2ha7L6kBO0OZ9p6wG9/l0JPrsUYQPmdZFdLQ7kDY
	xeuFWnnpFf6J46ataFr3qNWvDa9583b3mW520v5aG601Fj3K6g/L0H3lMZx9i8vGZJyugiGBpfyjt
	wMnG6T+NxWhSPnJt6WscQUm9zP8268c4tUK8saD4WvQ+1/FvgsM9pOtCfDEGhzR1I9xUpdy+UF9Vl
	x+KeV9Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGTtl-0000000CwOw-46D1;
	Wed, 05 Nov 2025 03:09:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGTtj-0000000CwOV-2l7I
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 03:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762312162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RbBUg28oaxVkeEtep5SXlIW3XpdcocyXCTta6NwNqNc=;
	b=AIPI03OvBk/SqpPxywCR1zONeUJzy71TTLVyXKcrWb3axOTIM53kCEyoGcb92XsWcLOdLr
	fs0a3R5FniUda2fMfq590Nk5fajmDvfVTk1Z9A6TjwPL9hg9nUmquUQReA3/FXaAj4HEnO
	Ti7C83l0Kr5vidaVooFIGv3hDYqJpig=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-MMOe2f8MPGq4FzC9nfdRbA-1; Tue,
 04 Nov 2025 22:09:20 -0500
X-MC-Unique: MMOe2f8MPGq4FzC9nfdRbA-1
X-Mimecast-MFC-AGG-ID: MMOe2f8MPGq4FzC9nfdRbA_1762312159
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF216180065F;
	Wed,  5 Nov 2025 03:09:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 890F41956056;
	Wed,  5 Nov 2025 03:09:17 +0000 (UTC)
Date: Wed, 5 Nov 2025 11:09:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] kexec: add kexec_core flag to control debug
 printing
Message-ID: <aQq/2WN8Sqz6m6xc@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-3-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103063440.1681657-3-maqianga@uniontech.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_190923_791795_BA805445 
X-CRM114-Status: GOOD (  27.58  )
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

On 11/03/25 at 02:34pm, Qiang Ma wrote:
> The commit a85ee18c7900 ("kexec_file: print out debugging message
> if required") has added general code printing in kexec_file_load(),
> but not in kexec_load().
> 
> Since kexec_load and kexec_file_load are not triggered
> simultaneously, we can unify the debug flag of kexec and kexec_file
> as kexec_core_dbg_print.

After reconsidering this, I regret calling it kexec_core_dbg_print.
That sounds a printing only happening in kexec_core. Maybe
kexec_dbg_print is better. Because here kexec refers to a generic
concept, but not limited to kexec_load interface only. Just my personal
thinking.

Other than the naming, the whole patch looks good to me. Thanks.

> 
> Next, we need to do four things:
> 
> 1. rename kexec_file_dbg_print to kexec_core_dbg_print
> 2. Add KEXEC_DEBUG
> 3. Initialize kexec_core_dbg_print for kexec
> 4. Set the reset of kexec_file_dbg_print to kimage_free
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  include/linux/kexec.h      | 9 +++++----
>  include/uapi/linux/kexec.h | 1 +
>  kernel/kexec.c             | 1 +
>  kernel/kexec_core.c        | 4 +++-
>  kernel/kexec_file.c        | 4 +---
>  5 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff7e231b0485..cad8b5c362af 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -455,10 +455,11 @@ bool kexec_load_permitted(int kexec_image_type);
>  
>  /* List of defined/legal kexec flags */
>  #ifndef CONFIG_KEXEC_JUMP
> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT | \
> +			KEXEC_DEBUG)
>  #else
>  #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
> -			KEXEC_CRASH_HOTPLUG_SUPPORT)
> +			KEXEC_CRASH_HOTPLUG_SUPPORT | KEXEC_DEBUG)
>  #endif
>  
>  /* List of defined/legal kexec file flags */
> @@ -525,10 +526,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>  static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>  #endif
>  
> -extern bool kexec_file_dbg_print;
> +extern bool kexec_core_dbg_print;
>  
>  #define kexec_dprintk(fmt, arg...) \
> -        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> +	do { if (kexec_core_dbg_print) pr_info(fmt, ##arg); } while (0)
>  
>  extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>  extern void kimage_unmap_segment(void *buffer);
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 55749cb0b81d..819c600af125 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -14,6 +14,7 @@
>  #define KEXEC_PRESERVE_CONTEXT	0x00000002
>  #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
>  #define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
> +#define KEXEC_DEBUG		0x00000010
>  #define KEXEC_ARCH_MASK		0xffff0000
>  
>  /*
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 9bb1f2b6b268..c7a869d32f87 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -42,6 +42,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>  	if (!image)
>  		return -ENOMEM;
>  
> +	kexec_core_dbg_print = !!(flags & KEXEC_DEBUG);
>  	image->start = entry;
>  	image->nr_segments = nr_segments;
>  	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index fa00b239c5d9..865f2b14f23b 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -53,7 +53,7 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
>  
> -bool kexec_file_dbg_print;
> +bool kexec_core_dbg_print;
>  
>  /*
>   * When kexec transitions to the new kernel there is a one-to-one
> @@ -576,6 +576,8 @@ void kimage_free(struct kimage *image)
>  	kimage_entry_t *ptr, entry;
>  	kimage_entry_t ind = 0;
>  
> +	kexec_core_dbg_print = false;
> +
>  	if (!image)
>  		return;
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eb62a9794242..4a24aadbad02 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -138,8 +138,6 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  	 */
>  	kfree(image->image_loader_data);
>  	image->image_loader_data = NULL;
> -
> -	kexec_file_dbg_print = false;
>  }
>  
>  #ifdef CONFIG_KEXEC_SIG
> @@ -314,7 +312,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
>  	if (!image)
>  		return -ENOMEM;
>  
> -	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
> +	kexec_core_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
>  	image->file_mode = 1;
>  
>  #ifdef CONFIG_CRASH_DUMP
> -- 
> 2.20.1
> 


