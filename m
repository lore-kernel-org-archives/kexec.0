Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766B4C00140
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 08:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vfm1b0J4G0dJNCA/TMeyAOcqIEyo+SUN48GtqMJPxzY=; b=c9rbQFXNcnPviw
	5EyQJQ/zohoQCOHXFJrHoW7swA/EaHMIBmy91LqLgzkylzy4rrK/YCLxA+PIK8JbpDkRyWcHJD9cy
	PBzXHk5XtCABtycF6BPWhQNYBGKlFUMzuN0ZEuicK5rvvTCs5O5like4dCqCkkW7UMFqU9QQK7cK0
	NtFydvH2PcP0fUI2vix13o+Ij0ZH8N5HnjoV8mg2cN2eUYZ4ocKFPpZ/63DW+nr+vlHVQkUeKsrXb
	c+5RlUudaHJUJxXQ2KlXRaxRfswt/WTLe2VSW9rbs6ftMV7r69M1JDxaGTAxuBz8yO75LC6xZPMJ/
	+6XppmN7fZW5ts+WfYDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oInOy-00BtyB-Ck; Tue, 02 Aug 2022 08:37:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oInOt-00BtuF-CX; Tue, 02 Aug 2022 08:37:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5481160AEB;
	Tue,  2 Aug 2022 08:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722ECC433D6;
	Tue,  2 Aug 2022 08:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659429431;
	bh=yVMVoT/6Mw0lk1hw42cWt6ofhqaPBU8Dsd54VMW97C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxAhykuX9sQh9v8UcR46j9w+XNKe2vsiSm9sJevrJ9SG1m7eWpi7old3zWBjXpK9Q
	 mj0HjrQcZ8jsCD6iuqulqWBsc3XxGE5mJaBliv/6diaCiFF91bUspCtTZI3IHcJil7
	 1SGlOBi7D7dxOwsL45QWamyd5NU7Y6bGIsY62nIMsxJGB91uTKHQopl6I0v+nh1DZB
	 g/PVaSJHAUf7CZRPGaESiyC1oG/6lTuE8YnWtPHQj1uu8Ag3lV4O4W4/KKGANQN4cD
	 qiPFXtM2pigOX43aHjwoPVNlnuEGbu7o1k2oGI0gP1n2qWxu8W5ErLfBN3Bj68OPn9
	 GNJMedzFw75kw==
Date: Tue, 2 Aug 2022 09:37:04 +0100
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>, ardb@kernel.org
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
Message-ID: <20220802083703.GA26962@willie-the-truck>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220711090319.1604-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_013715_513036_B0FC15CB 
X-CRM114-Status: GOOD (  28.95  )
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
> To be consistent with the implementation of x86 and improve cross-platform
> user experience. Try to allocate at least 256 MiB low memory automatically
> for the case that crashkernel=,high is explicitly specified, while
> crashkenrel=,low is omitted.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 +-------
>  arch/arm64/mm/init.c                            | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
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

Honestly, I read that comment and I'm none the wiser. What does "due to
mapping restrictions" mean? The remainder of the comment appears to be
specific to x86 and refers to jump ranges with 5-level page-tables.

> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)

So why does this value make sense for arm64? We have considerable platform
fragmentation^Wdiversity compared to x86 and picking a one-size-fits-all
default is more likely to cause weird problems when it doesn't work imo. I'd
actually prefer that the default is something that fails obviously (e.g. 0)
and we force an appropriate size to be specified.

On the other hand, if you can convince me that having a global constant is
the right way forward, then please move this out of the arch code.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
