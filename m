Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B32C47079
	for <kexec@archiver.kernel.org>; Fri,  5 Jan 2024 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ehmjSS5MX/bkEL0JYfqcWMiwirdxe2+IRuUsbQ+u31Q=; b=wbc0PbSTCywu7V
	fbn4gUH7fCCHf6QahVww7uPYw1nBfaVoETlX2jgg54RYPBFDTsEXGpMFuBMXlufD5bDbL7k6AEtzi
	hVPLoJEcvZtrmoTIN1zF07F52oFlZCql1cNnZFs5zKpDZA4s2U4CfmKZlS2z3ybVNtut+GxLsm6jK
	Bw77addCfCdTnjjaNLjYF2xexMECdzago5J9KO7TU1nfsGeJlwZNM0SxQOAJHdR5bd/I1pLvIWQ5t
	UAdG7wGRiRbqJjew7nvcVOwr37tNCUdG44HuiL/QmCTom0iyiXAB+hs3Dd/ODQ4v1Ykzo6BJeLvxJ
	v/Ysyy6rUxlp95XwiIIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLnNm-00HMOn-0g;
	Fri, 05 Jan 2024 16:49:18 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLnNi-00HMMM-2w
	for kexec@lists.infradead.org;
	Fri, 05 Jan 2024 16:49:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3DDC1CE1EAA;
	Fri,  5 Jan 2024 16:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A39CC433C8;
	Fri,  5 Jan 2024 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704473352;
	bh=yBEZyO9cmNSe7eUGAlx8l25OeQ5IowyYQAaA786v7DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1xsG3UIbgoXH8eDWj0UWzj8HxHu9glJsfJhUA/h7oi4aOWcBX8ofZnDfKjidBT20
	 USkR2ADcNSIrzIq96ywDguXoKUKwlqsllKnlF1Jow00FtpsHPMMk4rv6e07aXhkMH6
	 mKSA0oyiUx6okJHDgZEPH0wiR/if98XH/hnqRMUY=
Date: Fri, 5 Jan 2024 08:49:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, Youling Tang <tangyouling@kylinos.cn>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Defer the insertion of crashkernel resources
Message-Id: <20240105084911.b64f43b12b0c7e25436cb093@linux-foundation.org>
In-Reply-To: <20231229080213.2622204-1-chenhuacai@loongson.cn>
References: <20231229080213.2622204-1-chenhuacai@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_084915_121875_5582CC30 
X-CRM114-Status: GOOD (  15.19  )
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

On Fri, 29 Dec 2023 16:02:13 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:

> In /proc/iomem, sub-regions should be inserted after their parent,
> otherwise the insertion of parent resource fails. But after generic
> crashkernel reservation applied, in both RISC-V and ARM64 (LoongArch
> will also use generic reservation later on), crashkernel resources are
> inserted before their parent, which causes the parent disappear in
> /proc/iomem. So we defer the insertion of crashkernel resources to an
> early_initcall().
> 
> ...
>
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -377,7 +377,6 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>  
>  	crashk_low_res.start = low_base;
>  	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
>  #endif
>  	return 0;
>  }
> @@ -459,8 +458,19 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
>  }
> +
> +static __init int insert_crashkernel_resources(void)
> +{
> +	if (crashk_res.start < crashk_res.end)
> +		insert_resource(&iomem_resource, &crashk_res);
> +
> +	if (crashk_low_res.start < crashk_low_res.end)
> +		insert_resource(&iomem_resource, &crashk_low_res);
> +
> +	return 0;
> +}
> +early_initcall(insert_crashkernel_resources);
>  #endif
>  
>  int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,

I'm thinking 

Fixes: 0ab97169aa0 ("crash_core: add generic function to do reservation").

Also, is this a regression?  Were earlier kernels OK?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
