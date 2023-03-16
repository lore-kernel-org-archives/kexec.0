Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2425C7618B
	for <kexec@archiver.kernel.org>; Thu, 16 Mar 2023 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=45Tf61nZn6Tykm51woIImUZ09Ob/v2vm2vCMLGMLSF4=; b=qC9R7ja0Fecj45
	c1J6BLpiHn9KyyXgBog43OJFeHnCet0nXDcu18FGJ6P2DQyk+BSnLsI42ri3IpjUgaGWp5824WoF+
	qGLXu5oy+oPIY6IRBBnntd0TIawsdirqf0NuCisTyXi2+YRCNJVRA3qKgI1PtlM6660brR/f2s3Vx
	XVgsI4JW79R60VQbJC/exTWGhJFEz30sYcoVI4xEYm4rk8jEQuHU3Ge8q1ok4NQHogvfDF+BAxXtE
	YAtN6HZg7hZWPW0Wcs6jYizBCX88WYxNZujle6RulQfPHwvyVoqGnQojV2kgLStIy2MLoOy7ac67U
	w2E+o7Bj7Ljwy5loHBjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcrVO-00H95a-2c;
	Thu, 16 Mar 2023 17:35:10 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcrVM-00H952-0D;
	Thu, 16 Mar 2023 17:35:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 220EBB822B2;
	Thu, 16 Mar 2023 17:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BFAC433D2;
	Thu, 16 Mar 2023 17:35:03 +0000 (UTC)
Date: Thu, 16 Mar 2023 17:35:00 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZBNTRBqqb74T3RMx@arm.com>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_103508_280331_100D2147 
X-CRM114-Status: GOOD (  24.55  )
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

On Thu, Mar 16, 2023 at 05:47:52PM +0800, Baoquan He wrote:
> On 03/15/23 at 02:52pm, Catalin Marinas wrote:
> > On Mon, Mar 06, 2023 at 04:41:24PM +0800, Baoquan He wrote:
> > > +		/*
> > > +		 * For crashkernel=size[KMG], if the first attempt was for
> > > +		 * low memory, fall back to high memory, the minimum required
> > > +		 * low memory will be reserved later.
> > > +		 */
> > > +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> > >  			crash_max = CRASH_ADDR_HIGH_MAX;
> > > +			search_base = CRASH_ADDR_LOW_MAX;
> > >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > >  			goto retry;
> > >  		}
> > 
> > So I'm more tempted to set the search_base to 4G here rather than
> > CRASH_ADDR_LOW_MAX. The crashkernel=x,high option on a RPi4 with all
> > memory below 4G will fall back to low allocation. But RPi4 is the odd
> > one out, so I think we can live with this.
> 
> I totally agree with you that we should take 4G as the fixed boundary of
> low and high memory because kdump is aimed at workstation and server
> platform. We can leave RPi4 to use crashkernel=size[KMG][@offset[KMG]]
> to specify a region if people have to use.
> 
> [PATCH 0/2] arm64, kdump: enforce to take 4G as the crashkernel low memory end
> https://lore.kernel.org/all/20220828005545.94389-1-bhe@redhat.com/T/#u
> 
> Now I am wondering if we should change CRASH_ADDR_LOW_MAX to 4G directly
> since we decide to take 4G as the low memory limit when doing 'high'
> reserving or falling back. This is just like what we have been doing in
> x86_64. Not sure if I follow you correctly.

On RPi4, we do need the 'low' allocation to be below 1GB, otherwise
ZONE_DMA will be empty. But we can leave the 'high' reservation above
4GB (if available). The downside is that we won't get anything between
1GB and 4GB unless explicitly specified with @offset.

I'm not entirely sure what you want to achieve: avoiding the 'high'
reservation going across an arbitrary boundary (1GB or 4GB) that the
user may not be aware of or just avoiding the 'high' reservation going
across a 4G boundary? On RPi4, if the 'high' reservation above 4GB
fails, should it fall back to below 1GB reservation or to somewhere
between 1GB and 4GB, making sure it doesn't cross any of these two
boundaries? For someone unfamiliar with the ZONE_DMA on RPi4, the latter
would look like two 'low' allocations below 4GB.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
