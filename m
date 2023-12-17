Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C73C41535
	for <kexec@archiver.kernel.org>; Sun, 17 Dec 2023 01:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zNtH8Zcyx2RrqDZwUwBTJTbRT7lglsZmEMDqdvSkkWA=; b=ZtbrfCB5797nK7
	YUFm3paNmtAnoV7wyc+V4o9S9JEkiQm/lTJjpAbhHOnysTb9QQYcnpSzjdX/dOVoOrKcidSZR2BeJ
	ZgW0B7uOIlpfTtGsWfUGPwN5lk4b7BdbUBQzLnSY6bz/4iyygwerUX3TtaWqOZOhmXApn1Xdt7+C9
	sss+NUaBowo+39rSAUwE+tTyLjVzurCRystyiyzYGBffPius07npewwmR+XpPvFYLWh/5abTWhJAZ
	9FRuTpbuSUEAn9EoGtka/g+Drlty/kaNqm6wG+GZMpzm0IC3JYglKaLY5rMwZBp3bsZ0E81P41eA6
	1ZopOdJkje9xHi8h6Kcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEfXs-006wbW-18;
	Sun, 17 Dec 2023 01:02:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEfXp-006wak-28
	for kexec@lists.infradead.org;
	Sun, 17 Dec 2023 01:02:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702774931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC1xNmI+AjifUDHS1bdZGAuBlgGcJitzspR6cqUbaTE=;
	b=h5zWwdyDgcA6tVG/stDM/6b25u9plA66iz+gTxRB/fXbQXH+xlpiaJ2YYxSIijJEA5pvHe
	Tx+l3kFurSmcR7tQIx0PSjfwKc1EnWuEIEjIXJoTkEa+VdorYhY/E/pFyxvZ2hOF2BLDr8
	hI649dmQK7SM0Nh5ndv1VOtX2k2eQiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-9GswxSIZPNmJiASBmH-pBQ-1; Sat, 16 Dec 2023 20:02:08 -0500
X-MC-Unique: 9GswxSIZPNmJiASBmH-pBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 659E9803916;
	Sun, 17 Dec 2023 01:02:07 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D31C492BC6;
	Sun, 17 Dec 2023 01:02:05 +0000 (UTC)
Date: Sun, 17 Dec 2023 09:02:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
	dave.hansen@linux.intel.com, ebiederm@xmission.com, hpa@zytor.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 1/3 v4] kexec: modify the meaning of the end parameter in
 kimage_is_destination_range()
Message-ID: <ZX5Ii7hcgWr1vzVu@MiWiFi-R3L-srv>
References: <ZX1t/4Reai6HdoJf@MiWiFi-R3L-srv>
 <20231216120551.289324-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231216120551.289324-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_170213_793680_E330EE88 
X-CRM114-Status: GOOD (  28.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 12/16/23 at 08:05pm, Yuntao Wang wrote:
> The end parameter received by kimage_is_destination_range() should be the
> last valid byte address of the target memory segment plus 1. However, in
> the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
> the corresponding value passed to kimage_is_destination_range() is the last
> valid byte address of the target memory segment, which is 1 less.
> 
> There are two ways to fix this bug. We can either correct the logic of the
> locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions, or we
> can fix kimage_is_destination_range() by making the end parameter represent
> the last valid byte address of the target memory segment. Here, we choose
> the second approach.
> 
> Due to the modification to kimage_is_destination_range(), we also need to
> adjust its callers, such as kimage_alloc_normal_control_pages() and
> kimage_alloc_page().
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
> v1->v2:
>   Fix this issue using the approach suggested by Eric and Baoquan.
> 
>   As this patch is independent of the other patches in this series, I sent
>   out the v2 patch separately. If it's inconvenient for anyone, I can
>   resend the entire series again.
> 
> v2->v3:
>   Modify the assignment of eaddr as suggested by Baoquan.
> 
> v3->v4:
>   `eaddr = epfn << PAGE_SHIFT - 1` causes a compilation warning, fix it.
> 
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

The whole series looks good to me with this v4 of patch 1, you may need
to reorganize them and repost.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..e3b1a699f087 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -276,8 +276,8 @@ int kimage_is_destination_range(struct kimage *image,
>  		unsigned long mstart, mend;
>  
>  		mstart = image->segment[i].mem;
> -		mend = mstart + image->segment[i].memsz;
> -		if ((end > mstart) && (start < mend))
> +		mend = mstart + image->segment[i].memsz - 1;
> +		if ((end >= mstart) && (start <= mend))
>  			return 1;
>  	}
>  
> @@ -370,7 +370,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
>  		pfn   = page_to_boot_pfn(pages);
>  		epfn  = pfn + count;
>  		addr  = pfn << PAGE_SHIFT;
> -		eaddr = epfn << PAGE_SHIFT;
> +		eaddr = (epfn << PAGE_SHIFT) - 1;
>  		if ((epfn >= (KEXEC_CONTROL_MEMORY_LIMIT >> PAGE_SHIFT)) ||
>  			      kimage_is_destination_range(image, addr, eaddr)) {
>  			list_add(&pages->lru, &extra_pages);
> @@ -716,7 +716,7 @@ static struct page *kimage_alloc_page(struct kimage *image,
>  
>  		/* If the page is not a destination page use it */
>  		if (!kimage_is_destination_range(image, addr,
> -						  addr + PAGE_SIZE))
> +						  addr + PAGE_SIZE - 1))
>  			break;
>  
>  		/*
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
