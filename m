Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4D7C43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 04:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OLR+LMvCITa57IUs7ZIefU7BUBTVtU10EnBIPHoNkX0=; b=lgQwIK+OdZc4b9
	Jf0k+06unj9GIeEUwhfHaNm/jjzVLEocCyo+9D9OuUgmA83p82jlz8FnjyH4a3AUXIWcBVWtxW/3W
	aBVpezMWOV+SVoQHRPJrWDxzOPD+PWxs4oy9hGAc6VOUB4Mda9fAV7uE2dqqkd21m0Pf/JG5XL12d
	jftEoXQAJlu8Zjs7qMjkVoInxNyAKSh+j+EP8f76iq95Euhxa+bMT3OOzKwIK1NJa+Eq4UkYJtaPl
	Q1HMAPGTwcIYIXRUY5EAeFIwEJzGmOttRXJ+cR0kremIG961RwNykMrCF69QRPsL2hnJAWM4pD3u1
	3YfzUj8O7Y0HRbP/+P8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o23Pb-005PfO-4p; Fri, 17 Jun 2022 04:16:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o23PY-005Pe2-C0
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 04:16:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655439403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rv0vNXKXyCH9T82Y1Ot9urO7/UnO0DqQajZUCOmTg8E=;
	b=bjp4DPpxhd9zPgJ0k+q8uFwxd/QHVAbGalHmWgrWWcFE+gSL9iz2oEKYpfiugViKH8I3om
	Qd5H6+OKVHq2PN4g/UMmVwMbv8SefGTKc4GQLDu/O1nQVJaiMSTtXUdAg6ptNjxz4JGK9o
	YMblMbwQFWXH+e9UFvm08dmntdpaOD8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-NCX5GbcZNReCBVP6NcqkMg-1; Fri, 17 Jun 2022 00:16:39 -0400
X-MC-Unique: NCX5GbcZNReCBVP6NcqkMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6386F185A79C;
	Fri, 17 Jun 2022 04:16:38 +0000 (UTC)
Received: from localhost (ovpn-12-144.pek2.redhat.com [10.72.12.144])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 43DDE1121314;
	Fri, 17 Jun 2022 04:16:37 +0000 (UTC)
Date: Fri, 17 Jun 2022 12:16:33 +0800
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
Subject: Re: [PATCH 2/5] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
Message-ID: <20220617041633.GD234358@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613080932.663-3-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_211644_549548_B7EBD258 
X-CRM114-Status: GOOD (  24.53  )
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
> For crashkernel=X without '@offset', select a region within DMA zones
> first, and fall back to reserve region above DMA zones. This allows
> users to use the same configuration on multiple platforms.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/arm64/mm/init.c                            | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 61b179232b68001..fdac18beba5624e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -823,7 +823,7 @@
>  			memory region [offset, offset + size] for that kernel
>  			image. If '@offset' is omitted, then a suitable offset
>  			is selected automatically.
> -			[KNL, X86-64] Select a region under 4G first, and
> +			[KNL, X86-64, ARM64] Select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 5390f361208ccf7..8539598f9e58b4d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -138,6 +138,7 @@ static void __init reserve_crashkernel(void)
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	char *cmdline = boot_command_line;
>  	int ret;
> +	bool fixed_base;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -166,15 +167,28 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> +	fixed_base = !!crash_base;
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	/* User specifies base address explicitly. */
> -	if (crash_base)
> +	if (fixed_base)
>  		crash_max = crash_base + crash_size;
>  
> +retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);
>  	if (!crash_base) {
> +		/*
> +		 * Attempt to fully allocate low memory failed, fall back
> +		 * to high memory, the minimum required low memory will be
> +		 * reserved later.
> +		 */
> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +			crash_max = CRASH_ADDR_HIGH_MAX;
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +			goto retry;
> +		}
> +
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
