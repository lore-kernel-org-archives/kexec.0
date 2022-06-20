Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1780BC43334
	for <kexec@archiver.kernel.org>; Mon, 20 Jun 2022 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L9Bw+ENPSj983ETRwmP/kp37rXll+MaiL+f4T9Tzn2o=; b=Zh8sH1DqXq8aQ4
	bFOjnNDtOhfN7Tiayn6+ODvcwrISM7gAYqu/xdaOstg+Imfzdc9f0YlYVRsMfvy6Nxt7J5b1BS+XT
	l+H8tIxTm+Kekxg0kcHRdqmGqmcsjqkJopoCjJ4avj3w3wUMTq0guxWKUCpFCS008kSLi8S65BNlF
	dn+K6NDNO3j1jAz9r5/pIYiRYS7QIfwSCJpy7eMzt4fir7TEhAFHcK6fLckPhT5gHS+VZrFIUK8KZ
	YQbvgHs1u0BU9+BzuWkcN/hjusa5k4GBhSLQNC5MVtEyC0XpkzcIaz1Mk1NrTQA286LKUf8MzoKEs
	8Sgh/vL3jtiAy+9x3frw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3C40-00Gj4L-VT; Mon, 20 Jun 2022 07:43:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3C3x-00Gj0n-TJ
	for kexec@lists.infradead.org; Mon, 20 Jun 2022 07:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655710986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUNmq+SKtB8IP20c0SQTXtLsVBfIbeKTb4f/dBL0tMs=;
	b=jR/b3rV8eurNz4QKqKu6mFWRO5M1l1c2hIqjdwaPxCgWG8xmI9D3eudN1qqaD8j6UDAFtP
	Ftcz5QZbU66N2YVC1t29OROLIVV7aGdgvIoaUaeT0R+OHkUdYoZqrhe05YVjK+ui5Dv6eP
	MNnFGCv4uxardCvuFc2VQEjn/I4uakg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-czD0OaIeNQauw7EnkZNbLw-1; Mon, 20 Jun 2022 03:43:04 -0400
X-MC-Unique: czD0OaIeNQauw7EnkZNbLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0D45811E81;
	Mon, 20 Jun 2022 07:43:02 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 76A10C44AE3;
	Mon, 20 Jun 2022 07:43:01 +0000 (UTC)
Date: Mon, 20 Jun 2022 15:42:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 3/5] arm64: kdump: Remove some redundant checks in
 map_mem()
Message-ID: <YrAlAsgBcudz77pu@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613080932.663-4-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_004310_054617_69F73AF2 
X-CRM114-Status: GOOD (  22.49  )
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

On 06/13/22 at 04:09pm, Zhen Lei wrote:
> arm64_memblock_init()
> 	if (!IS_ENABLED(CONFIG_ZONE_DMA/DMA32))
> 		reserve_crashkernel()
> 			//initialize crashk_res when
> 			//"crashkernel=" is correctly specified
> paging_init()
> 	map_mem()
> 
> As shown in the above pseudo code, the crashk_res.end can only be
> initialized to non-zero when both "!IS_ENABLED(CONFIG_ZONE_DMA/DMA32)"
> and crash_mem_map are true. So some checks in map_mem() can be adjusted
> or optimized.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/mm/mmu.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 626ec32873c6c36..6028a5757e4eae2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -529,12 +529,12 @@ static void __init map_mem(pgd_t *pgdp)
>  
>  #ifdef CONFIG_KEXEC_CORE
>  	if (crash_mem_map) {
> -		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
> -		    IS_ENABLED(CONFIG_ZONE_DMA32))
> -			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> -		else if (crashk_res.end)
> +		if (crashk_res.end)
>  			memblock_mark_nomap(crashk_res.start,
>  			    resource_size(&crashk_res));
> +		else if (IS_ENABLED(CONFIG_ZONE_DMA) ||
> +			 IS_ENABLED(CONFIG_ZONE_DMA32))
> +			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  	}
>  #endif
>  
> @@ -571,16 +571,13 @@ static void __init map_mem(pgd_t *pgdp)
>  	 * through /sys/kernel/kexec_crash_size interface.
>  	 */
>  #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map &&
> -	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
> -		if (crashk_res.end) {
> -			__map_memblock(pgdp, crashk_res.start,
> -				       crashk_res.end + 1,
> -				       PAGE_KERNEL,
> -				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -			memblock_clear_nomap(crashk_res.start,
> -					     resource_size(&crashk_res));
> -		}
> +	if (crashk_res.end) {
> +		__map_memblock(pgdp, crashk_res.start,
> +			       crashk_res.end + 1,
> +			       PAGE_KERNEL,
> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_res.start,
> +				     resource_size(&crashk_res));
>  	}
>  #endif
>  }
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
