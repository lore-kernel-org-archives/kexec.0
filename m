Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFBBC77B7A
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ULDBrxIll6hzWewW5ZXfsYgjQVy4xGf12aWMF8WCQJg=; b=Kdb6V4sCqfoSJl
	PmhkuAvcUEpcEkYTS0Z2DzOAOzVjewo3hdM1y3c0KDlNSp0HqvDUF+Ihe1dDW2KiIkEhjIzAuACEh
	x6TJMJav+fEyOJqY2IrUAViLlxX8ekCzr+zQqZ8Eu9WquGU6ysnwhMI39U22GicYkTZvO4VmBgC8Y
	+Um27nsHescuVydT6dNiyJxpkQJ0P0YRuDh2mAW5NwEd2Dh0lWFjh2JDjp9JMCuY7S3lmOTxfKljv
	WvTMWi0XbqdOGzLdh3q/j9vQCJkpfka6fVJKEi5wVL5dWdG8VmCDCjqFrGzYtll39rduTz+mzolSS
	4VfAsfijiLaKxJkVBO3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4GbN-00GVog-3B;
	Wed, 31 May 2023 07:50:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4GbL-00GVnX-07
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 07:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685519434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1aeBJzatpJpgjRuxMCn5JWW+YK9YBd8odlhv1lWmlc=;
	b=QP4BzvG0RAniGXjdagVYoc1B9FQZpPs8ZX86gKCM2zxF6LaBgTO4z8jAcJLit0HvxMhX/d
	4jHnD8wqHBOCPA1gQ9NKBATdovYImB4KWXSHCBrcYLcGcbh8T6NqG5KFAOEOtM2MBju/Tz
	ygMuAVjBpFPgQKzGrSpPySvMmhSD36U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-Z99OpKI9Oi-dl-AZH0wRRw-1; Wed, 31 May 2023 03:50:30 -0400
X-MC-Unique: Z99OpKI9Oi-dl-AZH0wRRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF2628032EF;
	Wed, 31 May 2023 07:50:29 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D5B81C154D7;
	Wed, 31 May 2023 07:50:28 +0000 (UTC)
Date: Wed, 31 May 2023 15:50:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
Message-ID: <ZHb8Ms1T32K+Iyo2@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-6-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_005035_149087_473DB54F 
X-CRM114-Status: GOOD (  21.45  )
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
> No functional change, in preparation for the next patch so that it is
> easier to review.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 50 +++++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 69fe92141b0b62d..e82bc6d6634136a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1105,11 +1105,37 @@ ssize_t crash_get_memory_size(void)
>  	return size;
>  }
>  
> +int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)

Other than the missing static, looks good,

Acked-by: Baoquan He <bhe@redhat.com>

> +{
> +	struct resource *ram_res;
> +
> +	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
> +	if (!ram_res)
> +		return -ENOMEM;
> +
> +	ram_res->start = old_res->start + new_size;
> +	ram_res->end   = old_res->end;
> +	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
> +	ram_res->name  = "System RAM";
> +
> +	if (!new_size) {
> +		release_resource(old_res);
> +		old_res->start = 0;
> +		old_res->end   = 0;
> +	} else {
> +		crashk_res.end = ram_res->start - 1;
> +	}
> +
> +	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
> +	insert_resource(&iomem_resource, ram_res);
> +
> +	return 0;
> +}
> +
>  int crash_shrink_memory(unsigned long new_size)
>  {
>  	int ret = 0;
>  	unsigned long old_size;
> -	struct resource *ram_res;
>  
>  	if (!kexec_trylock())
>  		return -EBUSY;
> @@ -1125,27 +1151,7 @@ int crash_shrink_memory(unsigned long new_size)
>  		goto unlock;
>  	}
>  
> -	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
> -	if (!ram_res) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> -
> -	ram_res->start = crashk_res.start + new_size;
> -	ram_res->end = crashk_res.end;
> -	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
> -	ram_res->name = "System RAM";
> -
> -	if (!new_size) {
> -		release_resource(&crashk_res);
> -		crashk_res.start = 0;
> -		crashk_res.end = 0;
> -	} else {
> -		crashk_res.end = ram_res->start - 1;
> -	}
> -
> -	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
> -	insert_resource(&iomem_resource, ram_res);
> +	ret = __crash_shrink_memory(&crashk_res, new_size);
>  
>  unlock:
>  	kexec_unlock();
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
