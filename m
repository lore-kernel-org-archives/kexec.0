Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A860AC6FD1D
	for <kexec@archiver.kernel.org>; Fri, 17 Mar 2023 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=52/PqXQ27Ba3a6BV0BRn01OC4izIl4NPY41tDDi0x8w=; b=FaIf5GmeoiT0oR
	aBvPed/Etwe8Si1YeF1PunKCzdW5tvbItD8bmBa0DXmKZMviIOYew6g7IiybuUJiz9JzofMco8uWC
	n2S4dJYWhoUnp52cxQp6CLHwWDRj7eEgnqF/h12kB4WzzkU2Mtj3kNB3+w8ymdBWp316QsN9FnfGg
	2wo5h907/0Kqcxao4vNCPQYs9PcFetx/qTtbsE6N4v18hximlfEp0LYx4xo9Di7bugHIfkjYwe9ft
	ANjRD4meRrMQlmX24r9yNxHZu+wBAYf6vyvLozTvXTeiZCjNs+wGxWFeRpdBHyK3XMaMTirL53wNu
	ZD11tvYUrOrWezOVdHCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pdESo-002yxE-06;
	Fri, 17 Mar 2023 18:06:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pdESi-002ywn-2R;
	Fri, 17 Mar 2023 18:05:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7A063610FB;
	Fri, 17 Mar 2023 18:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB0EC433D2;
	Fri, 17 Mar 2023 18:05:53 +0000 (UTC)
Date: Fri, 17 Mar 2023 18:05:50 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZBSr/kIIuxmC/INY@arm.com>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com>
 <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_110556_895369_295CEB5E 
X-CRM114-Status: GOOD (  43.34  )
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

On Fri, Mar 17, 2023 at 11:09:13PM +0800, Baoquan He wrote:
> On 03/16/23 at 05:35pm, Catalin Marinas wrote:
> > On Thu, Mar 16, 2023 at 05:47:52PM +0800, Baoquan He wrote:
> > > Now I am wondering if we should change CRASH_ADDR_LOW_MAX to 4G directly
> > > since we decide to take 4G as the low memory limit when doing 'high'
> > > reserving or falling back. This is just like what we have been doing in
> > > x86_64. Not sure if I follow you correctly.
> > 
> > On RPi4, we do need the 'low' allocation to be below 1GB, otherwise
> > ZONE_DMA will be empty. But we can leave the 'high' reservation above
> > 4GB (if available). The downside is that we won't get anything between
> > 1GB and 4GB unless explicitly specified with @offset.
> 
> Ah, I see. You want to have high reservation like below when RPi4.
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 307763f97549..9e558fadf483 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -95,6 +95,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  
>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> +#define CRASH_HIGH_SEARCH_BASE		SZ_4G
>  
>  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
>  
> @@ -156,7 +157,7 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> -		search_base = CRASH_ADDR_LOW_MAX;
> +		search_base = CRASH_HIGH_SEARCH_BASE;
>  		crash_max = CRASH_ADDR_HIGH_MAX;
>  		high = true;
>  	} else if (ret || !crash_size) {
> @@ -193,7 +194,7 @@ static void __init reserve_crashkernel(void)
>  		 */
>  		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> -			search_base = CRASH_ADDR_LOW_MAX;
> +			search_base = CRASH_HIGH_SEARCH_BASE;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}

This would probably do _if_ these are the semantics that we want (well,
more discussion below).

> > I'm not entirely sure what you want to achieve: avoiding the 'high'
> > reservation going across an arbitrary boundary (1GB or 4GB) that the
> > user may not be aware of or just avoiding the 'high' reservation going
> > across a 4G boundary? On RPi4, if the 'high' reservation above 4GB
> > fails, should it fall back to below 1GB reservation or to somewhere
> > between 1GB and 4GB, making sure it doesn't cross any of these two
> > boundaries? For someone unfamiliar with the ZONE_DMA on RPi4, the latter
> > would look like two 'low' allocations below 4GB.
> 
> Currently, with the existing code, the high and low memory is like below
> on arm64:
> RPi4:
> 0~1G: low memory | 1G~top: high memory
> 
> Other normal system:
> 0~4G: low memory | 4G~top: high memory

Yes, that's the current behaviour.

> Now you want RPi4 to have low and high crahskernel reservation like
> this: 
> 0~1G: low memory | 4G~top: high memory

I don't necessarily want this, I just want to clarify what we actually
need to fix. Your initial reasoning for this patch was that the user
gets confused by the high allocation going across the 4G boundary. But
without knowing of the 1GB vs 4GB boundary on RPi4, one can still get
confused by the high allocation across the 4GB boundary on RPi4.

> It's also fine. However, as far as I know, RPi4 usually only has 8G
> memory.

That's the maximum. Lots of them just come with 4GB or less.

> And arm64 only has top down memblock allocation. Its high memory
> above 4G will be fragmentary, the crahskernel high reservation will fail
> if the value is big.
> 
> In fact, what I want to achieve is we set CRASH_ADDR_LOW_MAX to 4G
> fixedly on arm64, just like what we do on x86_64. As for RPi4 platform,
> we leave it to crashkernel=size@offset syntax. Two reasons for this:
> 1) crashkernel is needed on enterprise platform, such as workstation or
> server. While RPi4 is obviously not the target. I contacted several RPi4
> players in Redhat and my friends, none of them ever played kdump
> testing. If they really have to, crashkernel=size@offset is enough for
> them to set.

I'd like crashkernel=size (without @offset) on RPi4 to still do the
right thing: a low allocation at least as we had until recently (or
high+low where high here is maybe above 1GB). IOW, no regression for
this crashkernel=size case. We can then change the explicit
crashkernel=x,high to mean only above 4GB irrespective of the platform
and crashkernel=x,low to be below arm64_dma_phys_limit.

> 2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
> problem of base page mapping for the whole linear mapping if crsahkernel=
> is set in kernel parameter shown in [1] at bottom. 

That's a different problem ;). I should re-read that thread, forgot most
of the details but I recall one of the counter arguments was that there
isn't a strong case to unmap the crashkernel reservation. Now, if we
place crashdump kernel image goes in the 'high' reservation, can we not
leave the 'low' reservation mapped? We don't really care about it as it
wouldn't have any meaningful code/data to be preserved. If the 'high'
one goes above 4G always, we don't depend on the arm64_dma_phys_limit.

> Arm64 enterprise OS deployment is now very important in our
> Fedora/Centos stream/RHEL. I am wondering how wide and important kdump
> feature is needed and deployed on RPi4 platform and what is the user case.

I doubt it's important beyond testing but I'd very much like not to
cause a regression and require the @offset argument for RPi4.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
