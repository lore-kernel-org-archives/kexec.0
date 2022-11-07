Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE3C433FE
	for <kexec@archiver.kernel.org>; Mon,  7 Nov 2022 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6L9dRQpuVUw0/sFDVjGNyiArqJrs0/gQDbgXaSgzRNA=; b=RNDdVEgwQpitPr
	9VQx54NSLx8MhXdHg9UWMwZ74oijrqRJNyMVgPeRg6U2CKZuTwebb4jZ/ae8O8FEGryfTO6T/7rd5
	joLMmreGILLcg9sNfmx/U0afmIymmR5zKvmr3I1flfG9p+PlhY1DcqoNmAcEFJk3SKZm9gH9NZuPF
	62wdqMBuzssyO9BPpVEAQn20bTSNpoUmJYY/7UYbLdOYfmwoicOVbPbi4kwEmse+o2HnKffjbfE15
	jB+SopYoD6jTfagTpp6wLB7lvkFlbwxy8vR7rjBdoCa+nf0a7G1K9itnBgSzSi70Zlr18Agby34iq
	K1aZ4LwNRkSWCuzBYr1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5ls-00Gc8h-Ny; Mon, 07 Nov 2022 17:18:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5lp-00Gc0e-F7; Mon, 07 Nov 2022 17:18:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F3E7A61052;
	Mon,  7 Nov 2022 17:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B513C433C1;
	Mon,  7 Nov 2022 17:18:45 +0000 (UTC)
Date: Mon, 7 Nov 2022 17:18:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
Message-ID: <Y2k98lFhtUP2u1VM@arm.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220711090319.1604-2-thunder.leizhen@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_091849_605295_9862C566 
X-CRM114-Status: GOOD (  25.82  )
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

On Mon, Jul 11, 2022 at 05:03:18PM +0800, Zhen Lei wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2522b11e593f239..65a2c3a22a4b57d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -843,7 +843,7 @@
>  			available.
>  			It will be ignored if crashkernel=X is specified.
>  	crashkernel=size[KMG],low
> -			[KNL, X86-64] range under 4G. When crashkernel=X,high
> +			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
>  			is passed, kernel could allocate physical memory region
>  			above 4G, that cause second kernel crash on system
>  			that require some amount of low memory, e.g. swiotlb
> @@ -857,12 +857,6 @@
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  
> -			[KNL, ARM64] range in low memory.
> -			This one lets the user specify a low range in the
> -			DMA zone for the crash dump kernel.
> -			It will be ignored when crashkernel=X,high is not used
> -			or memory reserved is located in the DMA zones.
> -
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 339ee84e5a61a0b..5390f361208ccf7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>  
> +/*
> + * This is an empirical value in x86_64 and taken here directly. Please
> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
> + * details.
> + */
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> +
>  static int __init reserve_crashkernel_low(unsigned long long low_size)
>  {
>  	unsigned long long low_base;
> @@ -147,7 +155,9 @@ static void __init reserve_crashkernel(void)
>  		 * is not allowed.
>  		 */
>  		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> -		if (ret && (ret != -ENOENT))
> +		if (ret == -ENOENT)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		else if (ret)
>  			return;

BTW, since we want a default low allocation, I think we should change
the checking logic slightly. Currently we have:

	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
		...

If crash_base is just below CRASH_ADDR_LOW_MAX, we deem it sufficient
but a crashkernel trying to allocate 64MB of swiotlb may fail. So maybe
change this to crash_base >= CRASH_ADDR_LOW_MAX - crash_low_size.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
