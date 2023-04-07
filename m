Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A35CC76196
	for <kexec@archiver.kernel.org>; Fri,  7 Apr 2023 02:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FZu0Z1Y46/i0vWX1jwvMe+X6Xv7iyCHm2bIr91DxsCU=; b=44oKXYT+6kfvVY
	sGethTtlpK7bIoJpWcv1yt3JhlIhMIDgFH6RNQ6SkU6mkNuaVmFAgYShxfZAwywnJMmcizo7j4ydU
	2Tdi2yaTRIqr2+eAbmOnqRqUBt7TVU+ndxYp7bfTsInxxBQJfxAq+iLD7ejwwXkdOazxEwOGiG8RK
	SnLJ/0OmCnSv7QNWn5pFolb0uwQeI1Vs1n5oXiyqATiJoQoO00au1/7bt9gG6/xxF5cwS98j6wg7P
	/5cHDNtXK5p0slMtZ615b92qeT+TelfT0v2zCmlAhLc6akVzJqScemf6periazZUclyKeTll7ps4S
	JBi9HQn23+fyFS0owe7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkbuG-0091Xz-0A;
	Fri, 07 Apr 2023 02:32:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkbuC-0091XL-19
	for kexec@lists.infradead.org;
	Fri, 07 Apr 2023 02:32:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680834767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7h63opVENuJW8FQVoqo+R1OZ8MkJq/jjfXsWcHAMYyo=;
	b=Yg0cnIM8Tmodj7e/80FwszOBCD5w6Ay+ca95reosznP3Xi5m75SMrjHCGQq5rWwswcAIhc
	+mJj20fLpVIxS6X6gG6aAFlFCV4X5tO6cDf8TyS+Tmv5ypAXIw0bbZk40jjzRB3/W4DRek
	xbv96qf6Vw3ayyn7QLkMR6fkFCH6jPc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-LOeQWN3IPBC4g4DIOV7-TQ-1; Thu, 06 Apr 2023 22:32:43 -0400
X-MC-Unique: LOeQWN3IPBC4g4DIOV7-TQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 214C7855420;
	Fri,  7 Apr 2023 02:32:43 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EE6C140E94F;
	Fri,  7 Apr 2023 02:32:41 +0000 (UTC)
Date: Fri, 7 Apr 2023 10:32:38 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, horms@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, will@kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230407022419.19412-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_193248_517148_D5721ADF 
X-CRM114-Status: GOOD (  24.81  )
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

On 04/07/23 at 10:24am, Baoquan He wrote:
......
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 66e70ca47680..307263c01292 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -69,6 +69,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  
>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> +#define CRASH_HIGH_SEARCH_BASE		SZ_4G
>  
>  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
>  
> @@ -101,12 +102,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   */
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_low_size = 0;
> +	unsigned long long crash_base, crash_size, search_base;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long crash_low_size = 0;
>  	char *cmdline = boot_command_line;
> -	int ret;
>  	bool fixed_base = false;
> +	bool high = false;
> +	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -129,7 +131,9 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> +		search_base = CRASH_HIGH_SEARCH_BASE;

Here, I am hesitant if a conditional check is needed as below. On
special system where both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 
are disabled, there's only low memory, means its arm64_dma_phys_limit
equals to (PHYS_MASK + 1). In this case, whatever the crashkernel= is,
it can search the whole system memory for available crashkernel region.
Maybe it's fine since it's not big deal, the memory regoin can be found
anyway.

  		crash_max = CRASH_ADDR_HIGH_MAX;
		if (crash_max != CRASH_ADDR_LOW_MAX)
			search_base = CRASH_HIGH_SEARCH_BASE;

> +		high = true;
>  	} else if (ret || !crash_size) {
>  		/* The specified value is invalid */
>  		return;
> @@ -140,31 +144,51 @@ static void __init reserve_crashkernel(void)
>  	/* User specifies base address explicitly. */
>  	if (crash_base) {
>  		fixed_base = true;
> +		search_base = crash_base;
>  		crash_max = crash_base + crash_size;
>  	}
>  
>  retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       crash_base, crash_max);
> +					       search_base, crash_max);
>  	if (!crash_base) {
>  		/*
> -		 * If the first attempt was for low memory, fall back to
> -		 * high memory, the minimum required low memory will be
> -		 * reserved later.
> +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> +		 * message if can't reserve the specified region.
>  		 */
> -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +		if (fixed_base) {
> +			pr_warn("crashkernel reservation failed - memory is in use.\n");
> +			return;
> +		}
> +
> +		/*
> +		 * For crashkernel=size[KMG], if the first attempt was for
> +		 * low memory, fall back to high memory, the minimum required
> +		 * low memory will be reserved later.
> +		 */
> +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}
>  
> +		/*
> +		 * For crashkernel=size[KMG],high, if the first attempt was
> +		 * for high memory, fall back to low memory.
> +		 */
> +		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
> +			crash_max = CRASH_ADDR_LOW_MAX;
> +			search_base = 0;
> +			goto retry;
> +		}
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
>  	}
>  
> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
> +	     reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
>  	}
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
