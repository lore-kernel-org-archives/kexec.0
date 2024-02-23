Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE273C48BC4
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 07:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVY8zfqdEUeSJIPpl5lPTDLmaMB7NGZpSwGn6MQVgas=; b=Zh26AfVRL5d+fC
	BQG8N1RNEwfd655b/xBv2FdvLRUdGrqGacpemy11KTcZKzQffRb8yZCSfIAuf7lzcRp2Mn8EBpyl/
	ZOL9z7HJahGQ0afeC1sJTrVmPu3YwkgsEMO3f/A/X2DnaqcLWEsoAesxvLK4Khsal0hMURopZdJFx
	DMp0moi9aKJE83Po55qIcpYr+J25GkNBZo5a0QSycPZLUCzpwkmqNeeCi4KaTFAXLe7K4Ap2Yp1lR
	V+iqiUAP1rjRY8q7Cv/lrQZAOGW+TVXicDGTm6HC2Z+o8H33gvwakO/G008cj+wRdZM5h7XfvUfv/
	eQ0VWyczg0k0oC3lxjKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQOg-00000008Nxr-2DEF;
	Fri, 23 Feb 2024 07:55:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQOT-00000008Nso-3Fen
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 07:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708674880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2JRZUjDaQnphQQqHfy5zrZKRZBn1/n86XXqy/60Ffo=;
	b=iN5nqu1vh5PFVxKRqUxJ//YxG2z0pIhjhtl7V2kOXR5KV58MK8LRdekScuB8SFV7dK7Y6Q
	27nNy/UtVwPkfyaldbuvU481mAlDazqdNvEmA9y18aXxRs8WEcv6/pl25caOGeiqmpou3F
	+E05/AFBSQq37xrK5QFUJvZwk3FCBtQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-UKpKwurhNzuw2bV8uQ1OMA-1; Fri, 23 Feb 2024 02:54:35 -0500
X-MC-Unique: UKpKwurhNzuw2bV8uQ1OMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBA2885A588;
	Fri, 23 Feb 2024 07:54:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 51711C03380;
	Fri, 23 Feb 2024 07:54:16 +0000 (UTC)
Date: Fri, 23 Feb 2024 15:54:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Aditya Gupta <adityag@linux.ibm.com>, k-hagio-ab@nec.com
Cc: kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] makedumpfile: ppc64: read cur_mmu_type from vmcoreinfo
Message-ID: <ZdhPJKGd7wqbesVp@MiWiFi-R3L-srv>
References: <20240223055306.34466-1-adityag@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240223055306.34466-1-adityag@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_235453_998578_E68E38B8 
X-CRM114-Status: GOOD (  28.43  )
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

Add maintainer Kazu to CC.

On 02/23/24 at 11:23am, Aditya Gupta wrote:
> Currently makedumpfile depends on reading the 'cur_cpu_spec' kernel
> symbol to get the current MMU type on PowerPC64.
> 
> The disadvantage with this approach was that it depends on bit '0x40'
> ('MMU_FTR_TYPE_RADIX') being set in 'cur_cpu_spec->mmu_features',
> which implies kernel developers have to be careful of modifying
> MMU_FTR_* defines
> 
> Instead a more stable approach was suggested by contributors in
> https://lore.kernel.org/linuxppc-dev/87v8c3m70t.fsf@mail.lhotse/, to
> pass information about the MMU type in vmcoreinfo itself, instead of
> depending on the MMU_FTR_* defines
> 
> This was implemented in linux kernel in:
>     commit 36e826b568e4 ("powerpc/vmcore: Add MMU information to vmcoreinfo")
> 
> With this commit, if RADIX_MMU is there in the vmcoreinfo, we prefer it
> to get current mmu type, instead of 'cur_cpu_spec'.
> On older kernels, where RADIX_MMU number is not there, makedumpfile will
> simply fall back to using 'cur_cpu_spec'.
> 
> The earlier defines for 'RADIX_MMU' have been renamed to 'MMU_TYPE_RADIX'
> which avoids conflict with the vmcoreinfo string 'RADIX_MMU', as well as
> being more clear about the value 0x40 with a comment about MMU_FTR_TYPE_RADIX
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  arch/ppc64.c   | 15 ++++++++++-----
>  makedumpfile.c |  1 +
>  makedumpfile.h |  9 ++++++---
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/ppc64.c b/arch/ppc64.c
> index 96c357cb0335..3b4f91981f71 100644
> --- a/arch/ppc64.c
> +++ b/arch/ppc64.c
> @@ -250,7 +250,7 @@ ppc64_vmalloc_init(void)
>  		/*
>  		 * 64K pagesize
>  		 */
> -		if (info->cur_mmu_type & RADIX_MMU) {
> +		if (info->cur_mmu_type & MMU_TYPE_RADIX) {
>  			info->l1_index_size = PTE_INDEX_SIZE_RADIX_64K;
>  			info->l2_index_size = PMD_INDEX_SIZE_RADIX_64K;
>  			info->l3_index_size = PUD_INDEX_SIZE_RADIX_64K;
> @@ -300,7 +300,7 @@ ppc64_vmalloc_init(void)
>  		/*
>  		 * 4K pagesize
>  		 */
> -		if (info->cur_mmu_type & RADIX_MMU) {
> +		if (info->cur_mmu_type & MMU_TYPE_RADIX) {
>  			info->l1_index_size = PTE_INDEX_SIZE_RADIX_4K;
>  			info->l2_index_size = PMD_INDEX_SIZE_RADIX_4K;
>  			info->l3_index_size = PUD_INDEX_SIZE_RADIX_4K;
> @@ -635,14 +635,19 @@ get_versiondep_info_ppc64()
>  	 * On PowerISA 3.0 based server processors, a kernel can run with
>  	 * radix MMU or standard MMU. Get the current MMU type.
>  	 */
> -	info->cur_mmu_type = STD_MMU;
> -	if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
> +	info->cur_mmu_type = MMU_TYPE_STD;
> +
> +	if (NUMBER(RADIX_MMU) != NOT_FOUND_SYMBOL) {
> +		if (NUMBER(RADIX_MMU) == 1) {
> +			info->cur_mmu_type = MMU_TYPE_RADIX;
> +		}
> +	} else if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
>  	    && (OFFSET(cpu_spec.mmu_features) != NOT_FOUND_STRUCTURE)) {
>  		if (readmem(VADDR, SYMBOL(cur_cpu_spec), &cur_cpu_spec,
>  		    sizeof(cur_cpu_spec))) {
>  			if (readmem(VADDR, cur_cpu_spec + OFFSET(cpu_spec.mmu_features),
>  			    &mmu_features, sizeof(mmu_features)))
> -				info->cur_mmu_type = mmu_features & RADIX_MMU;
> +				info->cur_mmu_type = mmu_features & MMU_TYPE_RADIX;
>  		}
>  	}
>  
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 3705bdd93deb..1bd7305f49ca 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2987,6 +2987,7 @@ read_vmcoreinfo(void)
>  #endif
>  
>  	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
> +	READ_NUMBER("RADIX_MMU", RADIX_MMU);
>  
>  	return TRUE;
>  }
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 3ed3ba551d96..a7b344974636 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -747,12 +747,13 @@ unsigned long get_kvbase_arm64(void);
>  /*
>   * Supported MMU types
>   */
> -#define STD_MMU         0x0
> +#define MMU_TYPE_STD         0x0
>  /*
>   * The flag bit for radix MMU in cpu_spec.mmu_features
> - * in the kernel. Use the same flag here.
> + * in the kernel (MMU_FTR_TYPE_RADIX).
> + * Use the same flag here.
>   */
> -#define RADIX_MMU       0x40
> +#define MMU_TYPE_RADIX       0x40
>  
>  
>  #define PGD_MASK_L4		\
> @@ -2258,6 +2259,8 @@ struct number_table {
>  	unsigned long kernel_link_addr;
>  	unsigned long va_kernel_pa_offset;
>  #endif
> +
> +	unsigned long RADIX_MMU;
>  };
>  
>  struct srcfile_table {
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
