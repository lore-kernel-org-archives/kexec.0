Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB8C74A5B
	for <kexec@archiver.kernel.org>; Sun, 26 Mar 2023 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=exG53ZwZyk3+e8GlbZjpxY/EqtjpL1jLaALUAzmzKk4=; b=R8SC4vHJIh5Hha
	FZXBGLC/a+L3LxMU35h2glmHCCfQs7dBakKCuFYDHs7MkvMSkXQfP6BWTev96d1bwxd3rpLS1hfk5
	HJHMkKzArD+0zcqbeBrY/OwErF4dmm4uZMQVhLjJ803bvvEGefSQdrn4ktCCIEvvcufysYJqy6wGw
	ARTTWVxCUntdxDwgqyrYcVwz2s41HPXlxMQpayP4IqNyG2bd3MJ3cfx5TghdjMB10gxR40SUf9GKe
	eX5TvvGKFB752XwQTJFkp3lPdwOFNavyRQtgs3Z6V49fteM6MBM2ar2pKG7ewnHpN7h7MM9N4KIab
	BJXWCSZj94kfT61hd7qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgQ97-008S6S-1U;
	Sun, 26 Mar 2023 13:10:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgQ95-008S5z-0u
	for kexec@lists.infradead.org;
	Sun, 26 Mar 2023 13:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679836250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPuzCb6emXFKjbfHKUqPR1esheXB74vBtkS6IskDoFs=;
	b=hH38jTzOd/aNx9aTrwMwAd/HjqY7tvyk2b3bvlNN2DZMJCBtKtuvyZeskNX4R09FZhslJs
	3tE1ipwRRlPs//dSyua4EYUgPbmHuw2DX0XdVAVE4vmF3NuFQVb0wufnNdhSD4ES4jMDet
	Q0rhs7xFeJX9JOK7vZsyNLyGhIkzjLA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-I9D9QCf1ObSRY4kuQG3jaA-1; Sun, 26 Mar 2023 09:10:47 -0400
X-MC-Unique: I9D9QCf1ObSRY4kuQG3jaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E125C38041C7;
	Sun, 26 Mar 2023 13:10:46 +0000 (UTC)
Received: from localhost (ovpn-12-88.pek2.redhat.com [10.72.12.88])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3C640C6E67;
	Sun, 26 Mar 2023 13:10:44 +0000 (UTC)
Date: Sun, 26 Mar 2023 21:10:27 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com, horms@kernel.org,
	John.p.donnelly@oracle.com, will@kernel.org,
	kexec@lists.infradead.org, ardb@kernel.org, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: kdump: defer the crashkernel reservation for
 platforms with no DMA memory zones
Message-ID: <ZCBEQ12AYSrujUBn@MiWiFi-R3L-srv>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-4-bhe@redhat.com>
 <3653555d-3302-fc40-c917-963b029fc839@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3653555d-3302-fc40-c917-963b029fc839@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_061051_415542_8ECEE42E 
X-CRM114-Status: GOOD (  22.72  )
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

On 03/25/23 at 10:04am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/3/24 21:18, Baoquan He wrote:
> > In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> > platforms with no DMA memory zones"), reserve_crashkernel() is called
> > much earlier in arm64_memblock_init() to avoid causing base apge
> > mapping on platforms with no DMA meomry zones.
> > 
> > With taking off protection on crashkernel memory region, no need to call
> > reserve_crashkernel() specially in advance. The deferred invocation of
> > reserve_crashkernel() in bootmem_init() can cover all cases.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/arm64/include/asm/memory.h | 5 -----
> >  arch/arm64/mm/init.c            | 6 +-----
> >  2 files changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index 78e5163836a0..efcd68154a3a 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -374,11 +374,6 @@ static inline void *phys_to_virt(phys_addr_t x)
> >  })
> >  
> >  void dump_mem_limit(void);
> > -
> > -static inline bool defer_reserve_crashkernel(void)
> > -{
> > -	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
> > -}
> >  #endif /* !ASSEMBLY */
> >  
> >  /*
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 58a0bb2c17f1..b888de59e0b7 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -408,9 +408,6 @@ void __init arm64_memblock_init(void)
> >  
> >  	early_init_fdt_scan_reserved_mem();
> >  
> > -	if (!defer_reserve_crashkernel())
> > -		reserve_crashkernel();
> > -
> >  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> >  }
> >  
> > @@ -457,8 +454,7 @@ void __init bootmem_init(void)
> >  	 * request_standard_resources() depends on crashkernel's memory being
> >  	 * reserved, so do it here.
> >  	 */
> > -	if (defer_reserve_crashkernel())
> > -		reserve_crashkernel();
> > +	reserve_crashkernel();
> >  
> >  	memblock_dump_all();
> >  }
> 
> Some comments also need to be deleted, above the definition of arm64_dma_phys_limit
> in arch/arm64/mm/init.c

Thanks, have posted v2 of patch 3 to remove the code comment, and move
back the arm64_dma_phys_limit assignmet as 'PHYS_MASK + 1;' into
zone_sizes_init(). These should be part of the reverting commit
031495635b46, I missed that.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
