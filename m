Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4063DC77B6E
	for <kexec@archiver.kernel.org>; Wed, 12 Apr 2023 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JBzWyUbewofuBEvsvXE2hS/B7Ve5a49H9i3tsZA9mxs=; b=pwBl2pwplBYXPL
	U7S09q6w5qzaH5wmigATmi+z6nwbzqRUuAqADzTONQzeGUKg+bwuAHVxQ1Ls30arFlnlNmjQUPARU
	B/U3EzBg/Ss5WjWZ78QXVqD0TMtHSL4kKoiNy6chCBaGycfrOmMWzuVr5uAsrAnGdV4eiEvmIfUbE
	MXLN73YdaeIapZp71K0ZY0QW+8gMWdk3DysnaIGvsqemg4aiy4jnSIxbpxpNkKkj7PWeUF8VVQsfE
	aR2A5UrWuWoHjBipeqC74iCZW3hTVhXhgsBGe14AdqshGrvZyqiEKgcNFEZN1IuieedxBBX0ZTB/4
	8dSQ6p16dxIysnF9WKCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmZ0o-002wnx-2u;
	Wed, 12 Apr 2023 11:51:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmZ0m-002wmN-00;
	Wed, 12 Apr 2023 11:51:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7892A632BC;
	Wed, 12 Apr 2023 11:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83743C433D2;
	Wed, 12 Apr 2023 11:51:37 +0000 (UTC)
Date: Wed, 12 Apr 2023 12:51:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDabRr/yyakrrDDO@arm.com>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_045140_080903_CFE7A5D8 
X-CRM114-Status: GOOD (  22.64  )
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

On Fri, Apr 07, 2023 at 10:32:38AM +0800, Baoquan He wrote:
> On 04/07/23 at 10:24am, Baoquan He wrote:
> ......
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 66e70ca47680..307263c01292 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -69,6 +69,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
> >  
> >  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> >  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> > +#define CRASH_HIGH_SEARCH_BASE		SZ_4G
> >  
> >  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> >  
> > @@ -101,12 +102,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >   */
> >  static void __init reserve_crashkernel(void)
> >  {
> > -	unsigned long long crash_base, crash_size;
> > -	unsigned long long crash_low_size = 0;
> > +	unsigned long long crash_base, crash_size, search_base;
> >  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > +	unsigned long long crash_low_size = 0;
> >  	char *cmdline = boot_command_line;
> > -	int ret;
> >  	bool fixed_base = false;
> > +	bool high = false;
> > +	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> >  		return;
> > @@ -129,7 +131,9 @@ static void __init reserve_crashkernel(void)
> >  		else if (ret)
> >  			return;
> >  
> > +		search_base = CRASH_HIGH_SEARCH_BASE;
> 
> Here, I am hesitant if a conditional check is needed as below. On
> special system where both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 
> are disabled, there's only low memory, means its arm64_dma_phys_limit
> equals to (PHYS_MASK + 1). In this case, whatever the crashkernel= is,
> it can search the whole system memory for available crashkernel region.
> Maybe it's fine since it's not big deal, the memory regoin can be found
> anyway.
> 
>   		crash_max = CRASH_ADDR_HIGH_MAX;
> 		if (crash_max != CRASH_ADDR_LOW_MAX)
> 			search_base = CRASH_HIGH_SEARCH_BASE;

Does x86 do anything different here or they just can't disable
ZONE_DMA32? I'd be tempted to instead define CRASH_ADDR_LOW_MAX as
min(SZ_4G, arm64_dma_phys_limit) so that the crashkernel=,high semantics
are still preserved irrespective of how the kernel was built.

There's also the difference between what the current kernel vs the kdump
kernel. I don't think there's a strong requirement that they have the
same config options, in which case it may be safer to just honour the 4G
boundary.

Otherwise the patch looks fine. Whether you want to add the min limit
above:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
