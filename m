Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636D3C43334
	for <kexec@archiver.kernel.org>; Tue, 21 Jun 2022 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZfGlkUIcFjaLq8+6gs+uHnLo17dSI/jo72ZasJevArs=; b=CY6WIxFfeGe84t
	lqZ443c16bnnPlk9gSQnR1r+XZtcFohFZnsdVWdUs4wsPWM3zsHjhKXzPX1EVCnSVyxLzM683dKri
	+r+tbTF1AVHKaVC6VEMoFO4dRPsyzdMgUdISQF/Cq5R/2Nr10MTK3x4dvvUjkJXzlZQy+D8G5fRuf
	nVPZ5/b4aYea8boSoQUVVNSrpYWSfbEg6HZeKaOPOpQnbfMhIyl+eT0xtMszO9vMR1jIAf7WJt+Q5
	fRzU+iC1nWByIdfdNhTOwPRunhLgFPmLK5UytnPfKo2tS6ohJfWSicXkeClxNA8dTY3iJ47WMihkn
	U4F28teWHUBwKInNtn2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3aIs-004fLN-3p; Tue, 21 Jun 2022 09:36:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3aIo-004fIp-Mj
	for kexec@lists.infradead.org; Tue, 21 Jun 2022 09:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655804163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4GxMxN9cunj7j/s8YfY5rtdI8+FBR/4TfOiBLvKgbPo=;
	b=KyWQgsRXa/9uPjqDK8KekF+MkytrL9JIuApDy0G1uwuOMBfT7h7H2+O5YIkz7e6bevH+np
	0WXWiexQp/z6g91xAk47YBbLs7wMMckd1JgG1+YfVCwtc/Hm0j5jQZY6O46HiuN5PWToJm
	KmiVSDUmM3D6Fu24O0sBxuGOX3N1zKw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-0kqwBBi6O-aiHPJp5CQaRQ-1; Tue, 21 Jun 2022 05:36:00 -0400
X-MC-Unique: 0kqwBBi6O-aiHPJp5CQaRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 975E229AB3F0;
	Tue, 21 Jun 2022 09:35:59 +0000 (UTC)
Received: from localhost (ovpn-12-183.pek2.redhat.com [10.72.12.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 134E81121314;
	Tue, 21 Jun 2022 09:35:57 +0000 (UTC)
Date: Tue, 21 Jun 2022 17:35:54 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Message-ID: <YrGQ+l8bwAsMXaX1@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <4ad5f8c9-a411-da4e-f626-ead83d107bca@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ad5f8c9-a411-da4e-f626-ead83d107bca@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_023606_863884_39605116 
X-CRM114-Status: GOOD (  57.35  )
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

On 06/21/22 at 03:56pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/6/21 13:33, Baoquan He wrote:
> > Hi,
> > 
> > On 06/13/22 at 04:09pm, Zhen Lei wrote:
> >> If the crashkernel has both high memory above DMA zones and low memory
> >> in DMA zones, kexec always loads the content such as Image and dtb to the
> >> high memory instead of the low memory. This means that only high memory
> >> requires write protection based on page-level mapping. The allocation of
> >> high memory does not depend on the DMA boundary. So we can reserve the
> >> high memory first even if the crashkernel reservation is deferred.
> >>
> >> This means that the block mapping can still be performed on other kernel
> >> linear address spaces, the TLB miss rate can be reduced and the system
> >> performance will be improved.
> > 
> > Ugh, this looks a little ugly, honestly.
> > 
> > If that's for sure arm64 can't split large page mapping of linear
> > region, this patch is one way to optimize linear mapping. Given kdump
> > setting is necessary on arm64 server, the booting speed is truly
> > impacted heavily.
> 
> There is also a performance impact when running.

Yes, indeed, the TLB flush will happen more often.

> 
> > 
> > However, I would suggest letting it as is with below reasons:
> > 
> > 1) The code will complicate the crashkernel reservatoin code which
> > is already difficult to understand. 
> 
> Yeah, I feel it, too.
> 
> > 2) It can only optimize the two cases, first is CONFIG_ZONE_DMA|DMA32
> >   disabled, the other is crashkernel=,high is specified. While both
> >   two cases are corner case, most of systems have CONFIG_ZONE_DMA|DMA32
> >   enabled, and most of systems have crashkernel=xM which is enough.
> >   Having them optimized won't bring benefit to most of systems.
> 
> The case of CONFIG_ZONE_DMA|DMA32 disabled have been resolved by
> commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones").
> Currently the performance problem to be optimized is that DMA is enabled.

Yes, the disabled CONFIG_ZONE_DMA|DMA32 case has avoided the problem since
its boundary is decided already at that time. Crashkenrel=,high can slso
avoid this benefitting from the top done memblock allocating. However,
the crashkerne=xM which now gets the fallback support is the main syntax
we will use, that still has the problem.

> 
> 
> > 3) Besides, the crashkernel=,high can be handled earlier because 
> >   arm64 alwasys have memblock.bottom_up == false currently, thus we
> >   don't need worry arbout the lower limit of crashkernel,high
> >   reservation for now. If memblock.bottom_up is set true in the future,
> >   this patch doesn't work any more.
> > 
> > 
> > ...
> >         crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >                                                crash_base, crash_max);
> > 
> > So, in my opinion, we can leave the current NON_BLOCK|SECT mapping as
> > is caused by crashkernel reserving, since no regression is brought.
> > And meantime, turning to check if there's any way to make the contiguous
> > linear mapping and later splitting work. The patch 4, 5 in this patchset
> > doesn't make much sense to me, frankly speaking.
> 
> OK. As discussed earlier, I can rethink if there is a better way to patch 4-5,
> and this time focus on patch 1-2. In this way, all the functions are complete,
> and only optimization is left.

Sounds nice, thx.

> > 
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  arch/arm64/mm/init.c | 71 ++++++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 65 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index fb24efbc46f5ef4..ae0bae2cafe6ab0 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -141,15 +141,44 @@ static void __init reserve_crashkernel(int dma_state)
> >>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> >>  	char *cmdline = boot_command_line;
> >>  	int dma_enabled = IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
> >> -	int ret;
> >> +	int ret, skip_res = 0, skip_low_res = 0;
> >>  	bool fixed_base;
> >>  
> >>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> >>  		return;
> >>  
> >> -	if ((!dma_enabled && (dma_state != DMA_PHYS_LIMIT_UNKNOWN)) ||
> >> -	     (dma_enabled && (dma_state != DMA_PHYS_LIMIT_KNOWN)))
> >> -		return;
> >> +	/*
> >> +	 * In the following table:
> >> +	 * X,high  means crashkernel=X,high
> >> +	 * unknown means dma_state = DMA_PHYS_LIMIT_UNKNOWN
> >> +	 * known   means dma_state = DMA_PHYS_LIMIT_KNOWN
> >> +	 *
> >> +	 * The first two columns indicate the status, and the last two
> >> +	 * columns indicate the phase in which crash high or low memory
> >> +	 * needs to be reserved.
> >> +	 *  ---------------------------------------------------
> >> +	 * | DMA enabled | X,high used |  unknown  |   known   |
> >> +	 *  ---------------------------------------------------
> >> +	 * |      N            N       |    low    |    NOP    |
> >> +	 * |      Y            N       |    NOP    |    low    |
> >> +	 * |      N            Y       |  high/low |    NOP    |
> >> +	 * |      Y            Y       |    high   |    low    |
> >> +	 *  ---------------------------------------------------
> >> +	 *
> >> +	 * But in this function, the crash high memory allocation of
> >> +	 * crashkernel=Y,high and the crash low memory allocation of
> >> +	 * crashkernel=X[@offset] for crashk_res are mixed at one place.
> >> +	 * So the table above need to be adjusted as below:
> >> +	 *  ---------------------------------------------------
> >> +	 * | DMA enabled | X,high used |  unknown  |   known   |
> >> +	 *  ---------------------------------------------------
> >> +	 * |      N            N       |    res    |    NOP    |
> >> +	 * |      Y            N       |    NOP    |    res    |
> >> +	 * |      N            Y       |res/low_res|    NOP    |
> >> +	 * |      Y            Y       |    res    |  low_res  |
> >> +	 *  ---------------------------------------------------
> >> +	 *
> >> +	 */
> >>  
> >>  	/* crashkernel=X[@offset] */
> >>  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> >> @@ -169,10 +198,33 @@ static void __init reserve_crashkernel(int dma_state)
> >>  		else if (ret)
> >>  			return;
> >>  
> >> +		/* See the third row of the second table above, NOP */
> >> +		if (!dma_enabled && (dma_state == DMA_PHYS_LIMIT_KNOWN))
> >> +			return;
> >> +
> >> +		/* See the fourth row of the second table above */
> >> +		if (dma_enabled) {
> >> +			if (dma_state == DMA_PHYS_LIMIT_UNKNOWN)
> >> +				skip_low_res = 1;
> >> +			else
> >> +				skip_res = 1;
> >> +		}
> >> +
> >>  		crash_max = CRASH_ADDR_HIGH_MAX;
> >>  	} else if (ret || !crash_size) {
> >>  		/* The specified value is invalid */
> >>  		return;
> >> +	} else {
> >> +		/* See the 1-2 rows of the second table above, NOP */
> >> +		if ((!dma_enabled && (dma_state == DMA_PHYS_LIMIT_KNOWN)) ||
> >> +		     (dma_enabled && (dma_state == DMA_PHYS_LIMIT_UNKNOWN)))
> >> +			return;
> >> +	}
> >> +
> >> +	if (skip_res) {
> >> +		crash_base = crashk_res.start;
> >> +		crash_size = crashk_res.end - crashk_res.start + 1;
> >> +		goto check_low;
> >>  	}
> >>  
> >>  	fixed_base = !!crash_base;
> >> @@ -202,9 +254,18 @@ static void __init reserve_crashkernel(int dma_state)
> >>  		return;
> >>  	}
> >>  
> >> +	crashk_res.start = crash_base;
> >> +	crashk_res.end = crash_base + crash_size - 1;
> >> +
> >> +check_low:
> >> +	if (skip_low_res)
> >> +		return;
> >> +
> >>  	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
> >>  	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> >>  		memblock_phys_free(crash_base, crash_size);
> >> +		crashk_res.start = 0;
> >> +		crashk_res.end = 0;
> >>  		return;
> >>  	}
> >>  
> >> @@ -219,8 +280,6 @@ static void __init reserve_crashkernel(int dma_state)
> >>  	if (crashk_low_res.end)
> >>  		kmemleak_ignore_phys(crashk_low_res.start);
> >>  
> >> -	crashk_res.start = crash_base;
> >> -	crashk_res.end = crash_base + crash_size - 1;
> >>  	insert_resource(&iomem_resource, &crashk_res);
> >>  }
> >>  
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
