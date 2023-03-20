Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6755C7618D
	for <kexec@archiver.kernel.org>; Mon, 20 Mar 2023 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ny1y6F2ew9qouFRP6iG1iDdBcP8xAG4JtN5ujODu/dg=; b=yaf10dR+rleu1M
	P13EZs665Vcpis6ra9h2deQek2ArPzoXvXGOeECPx05EmPSv61WIYx9/cp41RMoeZmHiiEL4WXLxG
	BGICpZYNhnZZYxnulE9aJXufe79YejVTBOiokxjL+YXrHoWz3hbd8kR0Y317XJ21JzdAhfay/Vfzc
	n+0q/CIEABtrroTjHv7UNnqlk+LSDby2gUuuAviAtkObTiBfRPM/NotfwBl0+ynNTdmakDFvufsfM
	i8TpHQJhRFWgaw4tIQKC/6xY+yWjpqdbc24Rx0vLk22iZJj+YEr25BnJpgKgk3xpiO6Rb0aDGgfey
	WdebSLqKvLsct83aOhFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peGdC-009LLv-22;
	Mon, 20 Mar 2023 14:37:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peGd9-009LLQ-1N;
	Mon, 20 Mar 2023 14:37:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4D2D361564;
	Mon, 20 Mar 2023 14:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BA8C433EF;
	Mon, 20 Mar 2023 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679323018;
	bh=RBCPLadb47MmmM5lyC16jA4sDrS0Ng9R8msS2b1JT2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIUx8Kpc72knwAt3Y2kVvxbqBuS8f6IsLzyPUO9KSs4xprK5vfQZQN8+Q5qocAxQ1
	 6ymOu9/uAXcxB0ehwdkHa3u9SJMGcsgnz6eLRLy1MRtYvQsQlj4uKRltIEqkVkvOPr
	 ic7Ci9vZgyxy/FyEzEEPMJInt9ptuiUxeccwwi/QvTZajJBZi6CGokC2/umBl+Uazb
	 AmKkCTLp9iTF8m4gVBOTEp+FgKJbn42Mwc4sLAQWap8Qw2EffV9sybw7/H8il1zXd9
	 ZL3Zrwq2GEC14wgsgKeJTBt1bvkCANgg0kvCCnpUIVhabc5XvGPvxPXewOYhbz7R7H
	 qqGFjH0t65WFw==
Date: Mon, 20 Mar 2023 15:36:52 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
	bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
	atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH -next 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZBhvhBTQhAnN5qdm@kernel.org>
References: <20230320204244.1637821-1-chenjiahao16@huawei.com>
 <20230320204244.1637821-2-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230320204244.1637821-2-chenjiahao16@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_073659_565145_BE20655C 
X-CRM114-Status: GOOD (  21.34  )
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

On Tue, Mar 21, 2023 at 04:42:43AM +0800, Chen Jiahao wrote:
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
> 
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Here introduce the parameter option crashkernel=X,[high,low].
> 
> We can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=X,high"; or reserve a memory range
> below 4G with "crashkernel=X,low".
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>

Some minor nits, but I don't think there is any need to respin for them.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 478d6763a01a..5def2174b243 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c

...

> @@ -1201,16 +1242,25 @@ static void __init reserve_crashkernel(void)
>  	 */
>  	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>  					       search_start,
> -					       min(search_end, (unsigned long) SZ_4G));
> +					       min(search_end, (unsigned long) dma32_phys_limit));

nit: While here, you could drop the space before 'ma32_phys_limit'.
     Or perhaps use min_t, which seems appropriate here.

>  	if (crash_base == 0) {
>  		/* Try again without restricting region to 32bit addressible memory */
>  		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> -						search_start, search_end);
> +						       search_start, search_end);
>  		if (crash_base == 0) {
>  			pr_warn("crashkernel: couldn't allocate %lldKB\n",
>  				crash_size >> 10);
>  			return;
>  		}
> +
> +		if (!crash_low_size)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +	}
> +
> +	if ((crash_base > dma32_phys_limit - crash_low_size) &&
> +	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {

nit: The line above should be aligned one character to the left
     (remove one space in the indent).

> +		memblock_phys_free(crash_base, crash_size);
> +		return;
>  	}
>  
>  	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
