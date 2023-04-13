Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AD6C77B6C
	for <kexec@archiver.kernel.org>; Thu, 13 Apr 2023 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LDptHJb+XLs4uTr6iXcJLFkFetvpHuNQkq/0fepVGUA=; b=PR2mC8rimt68Dh
	rSlM+w+uUHDwzuuv1uQ40QlmGnsRhprjIgsTtxOWUM2KdByOIsV2ma/3Ftz8615TT5U0UdKOqWA1e
	kbYnveqDbReh9jm/N0wU1mlLqVegUCAgMk1u3KohX2HQOuMxcjftUh7pXrCVIt26EjX/lP9vmEdhA
	BDl+zN3P43gE/rFvZehCTwmcu81Q7vB93SvxnW6c7QO+M/5C+dJCm8FndC+E6Z5oilz//taB1dL9t
	uHA6pDGDHnG+I7WBp8hW3YPhLKzyXkg4+r+Pr2Qi+k9yF470BepFv4NzD7Zf21ZhRFjiGLuvWk780
	EvLpeFLUzAQngDBBwKAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmrej-005Jdh-0L;
	Thu, 13 Apr 2023 07:46:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmrec-005JcZ-2M
	for kexec@lists.infradead.org;
	Thu, 13 Apr 2023 07:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681371960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zVRSyY7qP0no9q+oe8X0C+6WBuNwa4/GmgSpnscCToA=;
	b=U4uuIg6SDUU/LNfPjyrUF1lL1dkBUrMZiLApuDi7h3LrjFMKiYjpqheAIddtzN9NyPeTzR
	GfosLRlwNvbcHidNlS3+1bLVwwASWYo5tEZAA1KP7HQ8C4HoC7w2G8VjDNHsbK5VH+QDqh
	VQ8pUbC+pTqE1h6bG6s9+gEZzK78m2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-G5gsqHDqMR27jin3hdk7Tg-1; Thu, 13 Apr 2023 03:45:55 -0400
X-MC-Unique: G5gsqHDqMR27jin3hdk7Tg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 408758996E0;
	Thu, 13 Apr 2023 07:45:55 +0000 (UTC)
Received: from localhost (ovpn-12-108.pek2.redhat.com [10.72.12.108])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA3FF492B00;
	Thu, 13 Apr 2023 07:45:53 +0000 (UTC)
Date: Thu, 13 Apr 2023 15:45:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
 <ZDabRr/yyakrrDDO@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZDabRr/yyakrrDDO@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_004602_851557_8EE356FE 
X-CRM114-Status: GOOD (  35.26  )
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

On 04/12/23 at 12:51pm, Catalin Marinas wrote:
> On Fri, Apr 07, 2023 at 10:32:38AM +0800, Baoquan He wrote:
> > On 04/07/23 at 10:24am, Baoquan He wrote:
> > ......
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index 66e70ca47680..307263c01292 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -69,6 +69,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
> > >  
> > >  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> > >  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> > > +#define CRASH_HIGH_SEARCH_BASE		SZ_4G
> > >  
> > >  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> > >  
> > > @@ -101,12 +102,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> > >   */
> > >  static void __init reserve_crashkernel(void)
> > >  {
> > > -	unsigned long long crash_base, crash_size;
> > > -	unsigned long long crash_low_size = 0;
> > > +	unsigned long long crash_base, crash_size, search_base;
> > >  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > > +	unsigned long long crash_low_size = 0;
> > >  	char *cmdline = boot_command_line;
> > > -	int ret;
> > >  	bool fixed_base = false;
> > > +	bool high = false;
> > > +	int ret;
> > >  
> > >  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> > >  		return;
> > > @@ -129,7 +131,9 @@ static void __init reserve_crashkernel(void)
> > >  		else if (ret)
> > >  			return;
> > >  
> > > +		search_base = CRASH_HIGH_SEARCH_BASE;
> > 
> > Here, I am hesitant if a conditional check is needed as below. On
> > special system where both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 
> > are disabled, there's only low memory, means its arm64_dma_phys_limit
> > equals to (PHYS_MASK + 1). In this case, whatever the crashkernel= is,
> > it can search the whole system memory for available crashkernel region.
> > Maybe it's fine since it's not big deal, the memory regoin can be found
> > anyway.
> > 
> >   		crash_max = CRASH_ADDR_HIGH_MAX;
> > 		if (crash_max != CRASH_ADDR_LOW_MAX)
> > 			search_base = CRASH_HIGH_SEARCH_BASE;
> 
> Does x86 do anything different here or they just can't disable
> ZONE_DMA32? I'd be tempted to instead define CRASH_ADDR_LOW_MAX as
> min(SZ_4G, arm64_dma_phys_limit) so that the crashkernel=,high semantics
> are still preserved irrespective of how the kernel was built.

x86 defaults to have both ZONE_DMA and ZONE_DMA32, and hardcode the zone
upper limit. I think it's not easy to disable ZONE_DMA32. Otherwise, the
device can only grab memory from DMA zone which is only 16MB big. The
rest memory will enter into normal zone. Please see below code snippet.

arch/x86/include/asm/dma.h:
/* 16MB ISA DMA zone */
#define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT) 

/* 4GB broken PCI/AGP hardware bus master zone */
#define MAX_DMA32_PFN (1UL << (32 - PAGE_SHIFT))

arch/x86/mm/init.c
zone_sizes_init()

About CRASH_ADDR_LOW_MAX definition, with min(SZ_4G,
arm64_dma_phys_limit), it's similar to defining it as
arm64_dma_phys_limit directly. 
it's the same as defining CRASH_ADDR_LOW_MAX as arm64_dma_phys_limit.

Because arm64_dma_phys_limit has three kinds of value:
1) 1G on RPi4
2) 4G on normal system
3) (PHYS_MASK + 1) on special system w/o zone DMA and DMA32

For the first two types, min(SZ_4G, arm64_dma_phys_limit) is
arm64_dma_phys_limit. While for the 3rd one, CRASH_ADDR_LOW_MAX is 4G, but
it will make type 3) system not be able to reserve memory across 4G.
However, on type 3) system, all its memory is low memory, the 4G should
not be a boundary. I tried code change with min(SZ_4G, 
arm64_dma_phys_limit), if we can accept this, the v4 patch looks more
appripriate except that RPi4 has inconsistent behaviour when
crashkernel=,high is specified.

> 
> There's also the difference between what the current kernel vs the kdump
> kernel. I don't think there's a strong requirement that they have the
> same config options, in which case it may be safer to just honour the 4G
> boundary.

Yes. In principle, kdump kerel doesn't have to be the same as the current
kernel. However, in reality, we usually take the same kernel for the
current kernel and kdump kernel. In our distros, we do that by default.
While user can choose different kernel as kdump kernel.

But, we may not suggest user to take kernel with different config
options as kdump kernel. E.g on RPi4, the current kernel has ZONE_DMA
and ZONE_DMA32 enabled, then it has DMA zone under 1G, DMA32 zone under
4G. If we take a kernel without ZONE_DMA and ZONE_DMA32 set as kdump
kernel, it's very likely not working because the pci device could get
memory above 1G, even above 4G.

> 
> Otherwise the patch looks fine. Whether you want to add the min limit
> above:

I am OK with this version, or the version with min(SZ_4G,
arm64_dma_phys_limit), or v4. Please help point out if I got your idea
correctly. Thanks a lot.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
