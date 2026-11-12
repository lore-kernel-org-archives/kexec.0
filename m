Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D3606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e+Vk+Mg0;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TUsoBkOE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LUQ//7qrgsHJhp2cav+kGCJj/I5E804GKbiJn2Jl/fc=; b=e+Vk+Mg0e6lAvw
	v3r6P6sCO0RP/lKHDn+mgLAEr3nsrwM/KA3H3Pb8+qfBnL8X7jEv+b9jKusRihkuvkX6hn3FZ3bMA
	9wUdVv5VaeXpWMAxRuFZwQprJ7+jitEAZheeJnuqzT1g33mKKRKUuApQ3S4XDoFW3zQtCzPOwUVen
	gWtI+Xc9Ii22MnlYKUEyjUrWmlvPB+EYfcFUIk2XhJDXmbV8zLTRbpXqeNkyBEdTKF6kPugXUddAD
	QRccqRh40RwZIvhBMYSrkB2iGdSn4je+k7tiXJyj56Smyi6Op1/VB9ZBI2cQFapAaGVeZzbPqx7Qk
	mh0WCzDvCHnChBEjaPVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xROc2-00000008qcp-272O;
	Thu, 12 Nov 2026 06:48:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRObw-00000008qc2-4447
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 06:48:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794466119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUQ//7qrgsHJhp2cav+kGCJj/I5E804GKbiJn2Jl/fc=;
	b=TUsoBkOE+XBFJKFbCZ3Lj3rAZ83IYq2mT+0eF35yZAQt0Q50TGrlKRbq3he4WudNpMutHF
	6elBylqD75AW77QqxkfXt8aBhSGhwSnkvpMxWZI2M5hJDU9bkNS+4Bb6wgkA9D49LjjFl6
	KlaGBP7+MwhNZb21q340TrPDEezj80E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-kivRchc0PzWUr1ywfkOgOA-1; Thu, 12 Nov 2026 01:48:38 -0500
X-MC-Unique: kivRchc0PzWUr1ywfkOgOA-1
X-Mimecast-MFC-AGG-ID: kivRchc0PzWUr1ywfkOgOA_1794466117
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so2212378a91.3
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 22:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466117; x=1795070917;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUQ//7qrgsHJhp2cav+kGCJj/I5E804GKbiJn2Jl/fc=;
        b=Pnp5TZX2fl8cZ4YtSvKisWdEogZJQuQ9fcM6dSUbty8d6NjkOHYU2hBebT4MrBjYbZ
         HPZE39DSviaTfjo5KUrZIYFm10Oekp7qF9L5gJWdvV9xQr2m3p12yrS8jNzsKsUu/gvQ
         DRK5A4NqqcI4VEHChWZbH7PCQUimuqghdTFwQAuYAnucE7NrBnoZOg+i03nZPBTboSPO
         u2Km3FNObNxh0tPdPXXR9JPRHNk2Zqbj8hZPjxXJei0oVM3lLDw5fPQvZWVu2gmgtm+q
         KhDEPqD7Twf4a8YiJM8dfHQXCOVTPK51ZAqzWttDLW/goSNC6mvk5Nxe8XtQ4P8Sa3qP
         6QFQ==
X-Forwarded-Encrypted: i=1; AL+hErEkVPb0+e8QwizYKIjY79wyjtB/l724bJgSVtWetOzwf9RaT05seIbnrTsaQvli91Uv32I6oA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+OOOvLmUz+R9Udn+4AgalPHoiwSCNz9gnhGIoAGIVuHiXUdYXR
	Nen1Zb3e9tYENZ07NCDEZRmEHTiGvzbwl/6JLde/y4PGG9DESVBV7OF9QH78h+d6e0xizfci7GA
	0b5MEDV0Gj3g/jBqeI3uyhi5XDZO8HskrOYWjW/Fdfrtg7MXZeZED7JlBvv75vA==
X-Gm-Gg: AYBFou0xti9klfZR6vU978x8urpD/XK7nN2gVPIHIdiPEwASAklCrETAkNO2DBKt0by
	lQKUjTCAEaR6A1xEwrgi1GV7AykUwBwks1Qk589exgTWMQ200JO/7FlZjom292S3T4H0fJlWGKe
	8P16oOwehgKQiQYyLN4u5AVszRl2EbrTZ71S91QO42uJpZaI1YrMZ+qO+ormILYNq/IJe96LDAc
	a4KGr0p/JHaEJ/hnncARfW6CiCkp4IjLnYDkpeUkqME8+u5pjdAwiR1gpY2J7j9ISd2eEA3T+9M
	kGlpKvCORNM8Mod6gZOcWtX/0/+AcrCaNNntEecRKSHHNDj6+Ca4jrF/3sl9sNrDXr3K7BKx+19
	OFcfN+8p+1iiwyTm08AsOWDpBLnk53BWAsSsoJxAJ477nQF8duFP3dzGO3UV2SXyyBB8ZwTk=
X-Received: by 2002:a17:90b:1f86:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3b182e6eb74mr4989594a91.10.1794466117038;
        Wed, 11 Nov 2026 22:48:37 -0800 (PST)
X-Received: by 2002:a17:90b:1f86:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3b182e6eb74mr4989576a91.10.1794466116545;
        Wed, 11 Nov 2026 22:48:36 -0800 (PST)
Received: from [192.168.1.102] ([117.207.221.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d32ea0sm2902565a91.15.2026.11.11.22.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 22:48:36 -0800 (PST)
Message-ID: <9b290d87-1413-4981-a296-9d37552e8913@redhat.com>
Date: Thu, 12 Nov 2026 12:18:28 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] kho: skip zero-sized lowmem and global bootmem
 areas
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 96d1J1fP_mDyDkhKwbxrkLwImBiH-cvizrPoxJ16J-4_1794466117
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_224841_095860_DC98450F 
X-CRM114-Status: GOOD (  26.46  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

On 04/11/26 10:20 pm, Mike Rapoport (Microsoft) wrote:
> The lowmem and the global bootmem areas can have zero size, for example
> when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
> either of those areas is explicitly set to zero with kho_bootmem=.
> 
> For a zero-sized allocation memblock returns an address without reserving
> anything, and that empty area is recorded in kho_bootmem. If there is no
> memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
> fails and KHO gets disabled.
> 
> Extract a helper that checks for zero size and allocates memory from
> memblock, and use it to skip empty areas the same way as empty per-node
> areas are skipped.
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Chen Pei <cp0613@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.alibaba.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 66 +++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 2ac5d94f33fd4..5b1797d1289c8 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -829,6 +829,26 @@ static int __init kho_bootmem_cmp(const void *_a, const void *_b)
>  	return cmp_int(a->addr, b->addr);
>  }
>  
> +static int __init kho_reserve_bootmem_area(phys_addr_t size, phys_addr_t end,
> +					   int nid)
> +{
> +	phys_addr_t addr;
> +
> +	if (!size)
> +		return 0;
> +
> +	addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES, 0, end,
> +					nid, true);
The low memory and global areas are reserved with NUMA_NO_NODE, but
kho_reserve_bootmem_area passes exact_nid = true for them as well.
memblock only uses the flag for a valid node So Pass
numa_valid_node(nid) instant of true.

Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>

> +	if (!addr)
> +		return -ENOMEM;
> +
> +	kho_bootmem[kho_bootmem_cnt].addr = addr;
> +	kho_bootmem[kho_bootmem_cnt].size = size;
> +	kho_bootmem_cnt++;
> +
> +	return 0;
> +}
> +
>  /**
>   * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
>   *
> @@ -840,8 +860,8 @@ static int __init kho_bootmem_cmp(const void *_a, const void *_b)
>   */
>  static void __init kho_reserve_bootmem(void)
>  {
> -	int nid, i = 0, max_nr_bootmem;
> -	phys_addr_t addr, size;
> +	int nid, max_nr_bootmem;
> +	phys_addr_t size;
>  
>  	if (!kho_enable)
>  		return;
> @@ -861,66 +881,40 @@ static void __init kho_reserve_bootmem(void)
>  	 * reserve bootmem area in low memory for lowmem allocations in the
>  	 * next kernel
>  	 */
> -	size = bootmem_size_lowmem;
> -	addr = memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
> -					 ARCH_LOW_ADDRESS_LIMIT);
> -	if (!addr) {
> +	if (kho_reserve_bootmem_area(bootmem_size_lowmem, ARCH_LOW_ADDRESS_LIMIT,
> +				     NUMA_NO_NODE)) {
>  		pr_err("Failed to reserve lowmem bootmem\n");
>  		goto err_free_bootmem_desc;
>  	}
>  
> -	kho_bootmem[i].addr = addr;
> -	kho_bootmem[i].size = size;
> -	i++;
> -
>  	/* reserve large contiguous area for allocations without nid */
> -	size = bootmem_size_global;
> -	addr = memblock_phys_alloc(size, BOOTMEM_ALIGNMENT_BYTES);
> -	if (!addr) {
> +	if (kho_reserve_bootmem_area(bootmem_size_global,
> +				     MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE)) {
>  		pr_err("Failed to reserve global bootmem\n");
>  		goto err_free_bootmem_areas;
>  	}
>  
> -	kho_bootmem[i].addr = addr;
> -	kho_bootmem[i].size = size;
> -	i++;
> -
>  	/*
>  	 * Loop over nodes that have both memory and are online. Skip
>  	 * memoryless nodes, as we can not allocate bootmem areas there.
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
> -		size = bootmem_size_node(nid);
> -		if (!size)
> -			continue;
> -
> -		addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES,
> -						0, MEMBLOCK_ALLOC_ACCESSIBLE,
> -						nid, true);
> -		if (!addr) {
> +		if (kho_reserve_bootmem_area(bootmem_size_node(nid),
> +					     MEMBLOCK_ALLOC_ACCESSIBLE, nid)) {
>  			pr_err("Failed to reserve nid %d bootmem\n", nid);
>  			goto err_free_bootmem_areas;
>  		}
> -
> -		kho_bootmem[i].addr = addr;
> -		kho_bootmem[i].size = size;
> -		i++;
>  	}
>  
> -	/*
> -	 * Nodes that needed no bootmem were skipped, so fewer areas than
> -	 * initially estimated may have been reserved.
> -	 */
> -	kho_bootmem_cnt = i;
> -
>  	sort(kho_bootmem, kho_bootmem_cnt, sizeof(*kho_bootmem),
>  	     kho_bootmem_cmp, NULL);
>  
>  	return;
>  
>  err_free_bootmem_areas:
> -	for (i--; i >= 0; i--)
> +	for (int i = kho_bootmem_cnt - 1; i >= 0; i--)
Check the First patch comment on this.

>  		memblock_phys_free(kho_bootmem[i].addr, kho_bootmem[i].size);
> +	kho_bootmem_cnt = 0;
>  err_free_bootmem_desc:
>  	memblock_free(kho_bootmem, max_nr_bootmem * sizeof(*kho_bootmem));
>  err_disable_kho:
> 

-- 
Regards,
Mukesh Pilaniya


