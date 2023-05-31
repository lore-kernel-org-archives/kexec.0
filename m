Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF53C77B7C
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 07:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rSC0ZRCBZdd6+0gkDl52UrH2RI2i0UcQi9jl0duobfY=; b=X7WP+ECcnsIn09
	x/6bF+8DFRJwHUzIh+gYUX2w6M3v8pwaJ7Wx/HiolZle23bfnT0yZQRa2A9xQEndOEv1IRG/2T4Qh
	IeNQUnJXMQLNLnVU9wyVJRqVdIOchBWZ21u6FJKYubOBXsrF8RgJSFeO5bNEXKLyLifgOA/xqlj2D
	BTfrVAv4QDLtxRIVVyRLpFg0K1vpwGKeY67mTHPcpLybIQcm6MmtMoJMS1/WyBONXM5mLuR/YKyWv
	274B/cuU7hCIT2vqH8DBD/z9RYD4x+rX1wu5FJ8m7wi7/rGv4nIbQZGpWnOUADk6aq5m7ZGqGPSyz
	+EsrRFs7LxRXvFQuZDYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4GZW-00GVWb-1p;
	Wed, 31 May 2023 07:48:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4GZU-00GVW1-0O
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 07:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685519319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lN0vUYVvRFjvHRoECulLsT+QfP7ftEVA/sIPfwf8rQA=;
	b=Z5iG+cl85+VEXCz4FJ1VwvqMoad6lgET/0Jz5Pk+klyHk/C465J/zN0RLM2+P6XvplXuHR
	wArS+1wAQphEUeVyi4ilI9F+7xdJmLLyIz5nXKugncTMeYya8ie4H6317D5qf4zZ/YSqFb
	vGcIbGhlTLqUzgjV/YHwgwdnHmtCPXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-Q2H1UejbNMiemtkarHc2zQ-1; Wed, 31 May 2023 03:48:35 -0400
X-MC-Unique: Q2H1UejbNMiemtkarHc2zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F9C3858F0F;
	Wed, 31 May 2023 07:48:35 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4601B2166B25;
	Wed, 31 May 2023 07:48:33 +0000 (UTC)
Date: Wed, 31 May 2023 15:48:30 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/6] kexec: improve the readability of
 crash_shrink_memory()
Message-ID: <ZHb7ubJYO2lyNkud@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-5-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_004840_230248_BDE4DDFB 
X-CRM114-Status: GOOD (  23.74  )
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

On 05/27/23 at 08:34pm, Zhen Lei wrote:
> The major adjustments are:
> 1. end = start + new_size.
>    The 'end' here is not an accurate representation, because it is not the
>    new end of crashk_res, but the start of ram_res, difference 1. So
>    eliminate it and replace it with ram_res->start.
> 2. Use 'ram_res->start' and 'ram_res->end' as arguments to
>    crash_free_reserved_phys_range() to indicate that the memory covered by
>    'ram_res' is released from the crashk. And keep it close to
>    insert_resource().
> 3. Replace 'if (start == end)' with 'if (!new_size)', clear indication that
>    all crashk memory will be shrunken.
> 
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/kexec_core.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index bcc86a250ab3bf9..69fe92141b0b62d 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1108,7 +1108,6 @@ ssize_t crash_get_memory_size(void)
>  int crash_shrink_memory(unsigned long new_size)
>  {
>  	int ret = 0;
> -	unsigned long start, end;
>  	unsigned long old_size;
>  	struct resource *ram_res;
>  
> @@ -1119,9 +1118,7 @@ int crash_shrink_memory(unsigned long new_size)
>  		ret = -ENOENT;
>  		goto unlock;
>  	}
> -	start = crashk_res.start;
> -	end = crashk_res.end;
> -	old_size = (end == 0) ? 0 : end - start + 1;
> +	old_size = !crashk_res.end ? 0 : resource_size(&crashk_res);
>  	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
>  	if (new_size >= old_size) {
>  		ret = (new_size == old_size) ? 0 : -EINVAL;
> @@ -1134,22 +1131,20 @@ int crash_shrink_memory(unsigned long new_size)
>  		goto unlock;
>  	}
>  
> -	end = start + new_size;
> -	crash_free_reserved_phys_range(end, crashk_res.end);
> -
> -	ram_res->start = end;
> +	ram_res->start = crashk_res.start + new_size;
>  	ram_res->end = crashk_res.end;
>  	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
>  	ram_res->name = "System RAM";
>  
> -	if (start == end) {
> +	if (!new_size) {
>  		release_resource(&crashk_res);
>  		crashk_res.start = 0;
>  		crashk_res.end = 0;
>  	} else {
> -		crashk_res.end = end - 1;
> +		crashk_res.end = ram_res->start - 1;
>  	}
>  
> +	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
>  	insert_resource(&iomem_resource, ram_res);
>  
>  unlock:
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
