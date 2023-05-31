Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED0EC77B7C
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AGm7cNYST6aR3I6JENvGx4bwReS+ExHCc9HIlF57LQ0=; b=oh8Uw1sW9f3Lhw
	g3+/CrglEJXh8td41F9F+kWlKohMjpnRQ4o895nadImK0xP3cg01cy1p5KmtfNVmgC/v+WY6LgyWN
	HmvL1JN8+MiWc3cNaVrQwxs9hDmv5Kd+9wLjVZQNsdOG2LkkxT5oAHW01er1e8rq6SK6rV7LIQFPf
	QIrqhBNBuvF3n1lsdjZXod1K0N1uU6nH7pu9yOZ6cyFBGHdcQXUJUinWemd6MQ3Acwtc/ONoBV0IC
	y8r9vy3mhv/2GdQUS+0zTMfyUlALULOhNjGbUB5eCIWnSszDCqlP9APnbLpj1FzKexipN4nX8zkAO
	/JXTN5r+l/EvACixpqpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4IWe-00GvX1-2Q;
	Wed, 31 May 2023 09:53:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4IWb-00GvWD-0G
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 09:53:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685526827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn2QBqttB+dOYYBuMERj9tPY3tQCj+h6bHqi72Etugo=;
	b=XXRoKb9KvXIo0jU1+B/3g0V20XePyxI/PixTJpgR3GbEPAQ5HK3JJ5e8Djd/sSL/IhV7Kx
	RPs5tBfYdObx9EVRDqBJ22Ru/IATatbXrDXzXbcaaZNz1mfEA3Oz+UkLAXIxH+KgZbbkeo
	dBYNFq2uwCIp/lqpqDTlLgO9n2mm/PM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-YoT3WvbRNtq9mfbC6sguhg-1; Wed, 31 May 2023 05:53:39 -0400
X-MC-Unique: YoT3WvbRNtq9mfbC6sguhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9C96101A53A;
	Wed, 31 May 2023 09:53:38 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D80EB140E962;
	Wed, 31 May 2023 09:53:37 +0000 (UTC)
Date: Wed, 31 May 2023 17:53:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/6] kexec: enable kexec_crash_size to support two crash
 kernel regions
Message-ID: <ZHcY/jsExa8t7hJW@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-7-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-7-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_025349_679586_B4CC9E63 
X-CRM114-Status: GOOD (  28.13  )
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
> The crashk_low_res should be considered by /sys/kernel/kexec_crash_size
> to support two crash kernel regions. Since crashk_res manages the memory
> with high address and crashk_low_res manages the memory with low address,
> crashk_low_res is shrunken only when all crashk_res is shrunken. And
> because when there is only one crash kernel region, crashk_res is always
> used. Therefore, if all crashk_res is shrunken and crashk_low_res still
> exists, swap them.

This looks good, otherwise someone else won't stop attempting to add
support of crashk_low_res shrinking. Not sure if this will bring corner
case issue in testing, let's see. For the patch log, I tried to
rephrase, feel free to refer to.

=====
The crashk_low_res should be considered by /sys/kernel/kexec_crash_size
to support two crash kernel regions shrinking if existing.

While doing it, crashk_low_res will only be shrunk when the entire
crashk_res is empty; and if the crashk_res is empty and crahk_low_res
is not, change crashk_low_res to be crashk_res.
=====

With the log updated, you can add:

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index e82bc6d6634136a..c1d50f6566300d9 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1091,6 +1091,11 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>  	}
>  }
>  
> +static inline resource_size_t crash_resource_size(const struct resource *res)
> +{
> +	return !res->end ? 0 : resource_size(res);
> +}
> +
>  ssize_t crash_get_memory_size(void)
>  {
>  	ssize_t size = 0;
> @@ -1098,8 +1103,8 @@ ssize_t crash_get_memory_size(void)
>  	if (!kexec_trylock())
>  		return -EBUSY;
>  
> -	if (crashk_res.end != crashk_res.start)
> -		size = resource_size(&crashk_res);
> +	size += crash_resource_size(&crashk_res);
> +	size += crash_resource_size(&crashk_low_res);
>  
>  	kexec_unlock();
>  	return size;
> @@ -1135,7 +1140,7 @@ int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
>  int crash_shrink_memory(unsigned long new_size)
>  {
>  	int ret = 0;
> -	unsigned long old_size;
> +	unsigned long old_size, low_size;
>  
>  	if (!kexec_trylock())
>  		return -EBUSY;
> @@ -1144,14 +1149,42 @@ int crash_shrink_memory(unsigned long new_size)
>  		ret = -ENOENT;
>  		goto unlock;
>  	}
> -	old_size = !crashk_res.end ? 0 : resource_size(&crashk_res);
> +
> +	low_size = crash_resource_size(&crashk_low_res);
> +	old_size = crash_resource_size(&crashk_res) + low_size;
>  	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
>  	if (new_size >= old_size) {
>  		ret = (new_size == old_size) ? 0 : -EINVAL;
>  		goto unlock;
>  	}
>  
> -	ret = __crash_shrink_memory(&crashk_res, new_size);
> +	/*
> +	 * (low_size > new_size) implies that low_size is greater than zero.
> +	 * This also means that if low_size is zero, the else branch is taken.
> +	 *
> +	 * If low_size is greater than 0, (low_size > new_size) indicates that
> +	 * crashk_low_res also needs to be shrunken. Otherwise, only crashk_res
> +	 * needs to be shrunken.
> +	 */
> +	if (low_size > new_size) {
> +		ret = __crash_shrink_memory(&crashk_res, 0);
> +		if (ret)
> +			goto unlock;
> +
> +		ret = __crash_shrink_memory(&crashk_low_res, new_size);
> +	} else {
> +		ret = __crash_shrink_memory(&crashk_res, new_size - low_size);
> +	}
> +
> +	/* Swap crashk_res and crashk_low_res if needed */
> +	if (!crashk_res.end && crashk_low_res.end) {
> +		crashk_res.start = crashk_low_res.start;
> +		crashk_res.end   = crashk_low_res.end;
> +		release_resource(&crashk_low_res);
> +		crashk_low_res.start = 0;
> +		crashk_low_res.end   = 0;
> +		insert_resource(&iomem_resource, &crashk_res);
> +	}
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
