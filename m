Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EA6C54EE9
	for <kexec@archiver.kernel.org>; Mon,  5 Sep 2022 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w7+Z5Ms41s/Sopod4hlz52gtoGJD6fNWOBo+TAR05QQ=; b=wlXylhINFYq9ag
	KMMD0fnwK2qReFljKpiLdRtj/ZOTS8yIOop0SSB+IbEELoULUPplqRokzbq194CdWbrjYWi1Tuqn8
	mudLlXivvfGawTmswu+Hlwve9v3CdzeQv9sSzT16jz6GfO7km2Llo8cwtxTHLUTGYNQ7fQb5xvK5U
	WOna5szlQV6pUCuUSsG55dAZWjsRdqUU2+prP2BYLFojdTSrSePEExjJ1Pe9cqjh+ne7Iqoty8ikS
	z347dBm5uAAz9PL3P/TMR4By1wBZUf1yWqxqDK6STQImv8cZ9qw6j6VybWj6pmtTMeiILYUp8Svn1
	fF4T27YfVGbM4JR48UcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVE0b-005vi1-PM; Mon, 05 Sep 2022 15:27:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVAu0-001q9j-AJ
	for kexec@lists.infradead.org; Mon, 05 Sep 2022 12:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662379707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nwyShCFZbZOZb3RqUUSZIoZqzOmpN20eUJtd5XLm+U=;
	b=IwxRvA+oogGeE0U8nWzS656xNbGRCClfT5uyCkKTC8tzTFycf32ypUp/rW/RtgR7HMTTyF
	SNTL3LtMEoU3IzIUnVHzM0mVYflcrw1iBS98WJCWd9SA6o35sRMEHx+yIjc4FciyN5d8Hj
	dBVuFs9ohrWhhvZ6b3PCIhuWca3uxww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-VPX3JYRiOW28KDwXPsBZ3g-1; Mon, 05 Sep 2022 08:08:22 -0400
X-MC-Unique: VPX3JYRiOW28KDwXPsBZ3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 869F880418F;
	Mon,  5 Sep 2022 12:08:21 +0000 (UTC)
Received: from localhost (ovpn-12-58.pek2.redhat.com [10.72.12.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C7B971121314;
	Mon,  5 Sep 2022 12:08:20 +0000 (UTC)
Date: Mon, 5 Sep 2022 20:08:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, ardb@kernel.org,
	guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
	will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
	wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxXPannyTqBZInAt@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_050833_426435_438566E2 
X-CRM114-Status: GOOD (  17.09  )
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

On 09/05/22 at 01:28pm, Mike Rapoport wrote:
> On Thu, Sep 01, 2022 at 08:25:54PM +0800, Baoquan He wrote:
> > On 09/01/22 at 10:24am, Mike Rapoport wrote:
> > 
> > max_zone_phys() only handles cases when CONFIG_ZONE_DMA/DMA32 enabled,
> > the disabledCONFIG_ZONE_DMA/DMA32 case is not included. I can change
> > it like:
> > 
> > static phys_addr_t __init crash_addr_low_max(void)
> > {
> >         phys_addr_t low_mem_mask = U32_MAX;
> >         phys_addr_t phys_start = memblock_start_of_DRAM();
> > 
> >         if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> >              (phys_start > U32_MAX))
> >                 low_mem_mask = PHYS_ADDR_MAX;
> > 
> >         return low_mem_mast + 1;
> > }
> > 
> > or add the disabled CONFIG_ZONE_DMA/DMA32 case into crash_addr_low_max()
> > as you suggested. Which one do you like better?
> > 
> > static phys_addr_t __init crash_addr_low_max(void)
> > {
> >         if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> > 		return PHYS_ADDR_MAX + 1;
> > 
> >         return max_zone_phys(32);
> > }
>  
> I like the second variant better.

Sure, will change to use the 2nd one . Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
