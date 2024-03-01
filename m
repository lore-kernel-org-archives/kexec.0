Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE83C5475B
	for <kexec@archiver.kernel.org>; Fri,  1 Mar 2024 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FZ0nzKWMiUX6zZePE425GjhTxatbYKsUK3d6BHn1hcI=; b=gAe3O2/DaL1vgz
	cUWJNq/veO0CJ9WzSiWE74mRegtM8rMrrezqBUvD18/S/ZvKrqeaot19DsGzEMy4Bokmjuurn2qZ4
	7pxAHzixpuQclphC5V05+UyndtVJZmX8ym0rZ2i7E3Oo4jsbAtpIr2Aqs79DBobBV9WqP5vUymeQ3
	LQx1L/IO5Yiw7U1U9JK8QgsZRlcoq3bJ8PfK+VwpuolNyg9xDAKInExlZqgLZybCrlSbW4X80888u
	BrvuN5lpJ/ys/vZ6qMfN9yZIxL+OY6XkVpm+SNelapMr1zSXYb2yRvukX73VL28finPziSQYmKKJA
	VgFERvuXyOffwntHHC1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfwlJ-0000000GdEP-3bNQ;
	Fri, 01 Mar 2024 06:52:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfwlG-0000000GdCW-41Sd
	for kexec@lists.infradead.org;
	Fri, 01 Mar 2024 06:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709275968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hAv7LCsa3iLqGJhJsJviM4n+BZxClj9lSP/nAIPeEE=;
	b=ZmFeYeafCN5TPui876iOjrQyDomNHY06yTBI4gCX5MdMBIH7/ivIv108GNUYrVtYQLU0q3
	MEaUIdasntw0fJSXeJuJgV8id17A2aUHXs/HqcfFpu+FnnCrlp8X2ugVrxHyYG7GQV6nx/
	1dmOz4IxhwRbaMPnBnY0nojTe2WxRCI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-k9AfNMFUM463nT0FJ3bfzg-1; Fri, 01 Mar 2024 01:52:44 -0500
X-MC-Unique: k9AfNMFUM463nT0FJ3bfzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B95183FC6C;
	Fri,  1 Mar 2024 06:52:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D4C21BDB1;
	Fri,  1 Mar 2024 06:52:42 +0000 (UTC)
Date: Fri, 1 Mar 2024 14:52:34 +0800
From: Baoquan He <bhe@redhat.com>
To: "yang.zhang" <gaoshanliukou@163.com>, akpm@linux-foundation.org
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, "yang.zhang" <yang.zhang@hexintek.com>
Subject: Re: [PATCH V3] kexec: copy only happens before uchunk goes to zero
Message-ID: <ZeF7Muc8WyuQ1bPR@MiWiFi-R3L-srv>
References: <20240222092119.5602-1-gaoshanliukou@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240222092119.5602-1-gaoshanliukou@163.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_225251_111316_4B523D9B 
X-CRM114-Status: GOOD (  20.38  )
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

CC Andrew

On 02/22/24 at 05:21pm, yang.zhang wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
> 
> When loading segments, ubytes is <= mbytes. When ubytes is exhausted,
> there could be remaining mbytes. Then in the while loop, the buf pointer
> advancing with mchunk will causing meaningless reading even though it
> doesn't harm.
> 
> So let's change to make sure that all of the copying and the rest only
> happens before uchunk goes to zero.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> 
> ---
> V2 -> V3:
> - Add more detailed description in the commit message
> v1 -> v2:
> - Only copy before uchunk goes to zero
> 
> V1: https://lore.kernel.org/lkml/20240130101802.23850-1-gaoshanliukou@163.com/
> ---
>  kernel/kexec_core.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d08fc7b5db97..2fc3d0e3715a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
>  				PAGE_SIZE - (maddr & ~PAGE_MASK));
>  		uchunk = min(ubytes, mchunk);
>  
> -		/* For file based kexec, source pages are in kernel memory */
> -		if (image->file_mode)
> -			memcpy(ptr, kbuf, uchunk);
> -		else
> -			result = copy_from_user(ptr, buf, uchunk);
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
>  		kunmap_local(ptr);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
>  		}
> -		ubytes -= uchunk;
>  		maddr  += mchunk;
> -		if (image->file_mode)
> -			kbuf += mchunk;
> -		else
> -			buf += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> @@ -866,11 +868,18 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			memset(ptr + uchunk, 0, mchunk - uchunk);
>  		}
>  
> -		/* For file based kexec, source pages are in kernel memory */
> -		if (image->file_mode)
> -			memcpy(ptr, kbuf, uchunk);
> -		else
> -			result = copy_from_user(ptr, buf, uchunk);
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
>  		kexec_flush_icache_page(page);
>  		kunmap_local(ptr);
>  		arch_kexec_pre_free_pages(page_address(page), 1);
> @@ -878,12 +887,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result = -EFAULT;
>  			goto out;
>  		}
> -		ubytes -= uchunk;
>  		maddr  += mchunk;
> -		if (image->file_mode)
> -			kbuf += mchunk;
> -		else
> -			buf += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
