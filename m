Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341DBC6FD1D
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 01:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AHhFqwTCrT0Tckp6opxN3TXaJX6cfnGEz92ZGH4B9hE=; b=0luHsvRXE9aMggxpaDVfG+eO03
	gseIX62bvSxqSaDxxlyVuFniWs9hxm+Hi8qnA0D8QGvcAQZ4kBy6DALfkdlAYS5F+gTUleooY3O77
	Aa7+psB5wl+SEVQEyC+4CJ+1ZX0rwd5dtFmCLcs9vJ7Am79557RIc4hqT7QRj6JVGRJYQK0K8BLZe
	Ts9ltp8zHKnL6szwGAX7zYsCGEG3XejOnrtDOXutP/Eo5rKG+kpeFoDs0wmRZLiuCL85rj/wBMWKs
	noOxjkhHrp9nPbyfIKBFT0ZLlOw03M3pyaYvhhnZPZry6+TxVE4FwxCHrSoCD350Ml1om9SLqIP16
	fKfAfv9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peR4Y-00Axje-20;
	Tue, 21 Mar 2023 01:45:58 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peR4W-00Axj4-0i;
	Tue, 21 Mar 2023 01:45:57 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PgZD45bryzrV2n;
	Tue, 21 Mar 2023 09:44:52 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 09:45:51 +0800
Subject: Re: [PATCH -next 2/2] docs: kdump: Update the crashkernel description
 for riscv
To: Chen Jiahao <chenjiahao16@huawei.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <conor.dooley@microchip.com>, <guoren@kernel.org>,
	<heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
	<akpm@linux-foundation.org>, <atishp@rivosinc.com>, <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <20230320204244.1637821-1-chenjiahao16@huawei.com>
 <20230320204244.1637821-3-chenjiahao16@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c3d6caae-39ed-a785-13b5-f36fb96d9a5e@huawei.com>
Date: Tue, 21 Mar 2023 09:45:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230320204244.1637821-3-chenjiahao16@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_184556_601336_47AD50AC 
X-CRM114-Status: GOOD (  20.26  )
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



On 2023/3/21 4:42, Chen Jiahao wrote:
> Now "crashkernel=" parameter on riscv has been updated to support
> crashkernel=X,[high,low]. Through which we can reserve memory region
> above/within 32bit addressible DMA zone.
> 
> Here update the parameter description accordingly.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6221a1d057dd..89e26a4864f8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -843,7 +843,7 @@
>  			memory region [offset, offset + size] for that kernel
>  			image. If '@offset' is omitted, then a suitable offset
>  			is selected automatically.
> -			[KNL, X86-64, ARM64] Select a region under 4G first, and
> +			[KNL, X86-64, ARM64, RISCV] Select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
> @@ -856,14 +856,14 @@
>  			Documentation/admin-guide/kdump/kdump.rst for an example.
>  
>  	crashkernel=size[KMG],high
> -			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
> -			to allocate physical memory region from top, so could
> -			be above 4G if system have more than 4G ram installed.
> -			Otherwise memory region will be allocated below 4G, if
> -			available.
> +			[KNL, X86-64, ARM64, RISCV] range could be above 4G.
> +			Allow kernel to allocate physical memory region from top,
> +			so could be above 4G if system have more than 4G ram
> +			installed. Otherwise memory region will be allocated
> +			below 4G, if available.
>  			It will be ignored if crashkernel=X is specified.
>  	crashkernel=size[KMG],low
> -			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
> +			[KNL, X86-64, ARM64, RISCV] range under 4G. When crashkernel=X,high
>  			is passed, kernel could allocate physical memory region
>  			above 4G, that cause second kernel crash on system
>  			that require some amount of low memory, e.g. swiotlb
> @@ -874,6 +874,7 @@
>  			size is	platform dependent.
>  			  --> x86: max(swiotlb_size_or_default() + 8MiB, 256MiB)
>  			  --> arm64: 128MiB
> +			  --> riscv: 128MiB
>  			This one lets the user specify own low range under 4G
>  			for second kernel instead.
>  			0: to disable low allocation.
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
