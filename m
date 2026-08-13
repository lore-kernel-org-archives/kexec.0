Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6823BC5CFDB
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bzwlkKgAjFA4jPn5mhlQ/drv3ccUTPbHoR0B3kcJtU0=; b=NOO2qU2RTC5ONIt1mZWiway/K9
	lzz7HBgL6axshxHyX+puj8pkE70VeaaZoFjHejtCqHwn0NNqrQQolP5DSA8UfaxrzFdGOaQ1kpRaH
	Ov2K/enJb+z0jC62D8I+fJW1xlcocm0rUZD7EDOEwySeyWuUPE8C6V7kI0K9gcjDRXeMMNv9KIVOh
	Hm6uXYQTAssF6BlxPyWdzUjDJfHTWMLbGbeU38p0pI69ysHQKW/AxXWnkI90g/hNZPyCnjt7OvFXX
	PQSWHAqmq6HdpkltIZb4ngHp/LFleVKe/xZsomkACTZOK5qKBJ1H9byquJpw3tpl/rnhlMwAgOxQ3
	MgR/1CnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTmt-00000000Zl8-0RvH;
	Thu, 13 Aug 2026 11:39:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTms-00000000Zl0-0pCd
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 11:39:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32B1D600BB;
	Thu, 13 Aug 2026 11:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8A31F000E9;
	Thu, 13 Aug 2026 11:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786621192;
	bh=bzwlkKgAjFA4jPn5mhlQ/drv3ccUTPbHoR0B3kcJtU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gp28GzYV34B/sJAzyVyl+eGvrNb5UuB4gSP85z0eoWa3UUx2NSg2JThEbyxeyPix1
	 l5G5xD3OpRrw0O7lS/pUWjvs1GloVvb+G00bRgBxHYeE5cIt9SR++oyp1mUnT6AWcR
	 Ie/K++d2vQYE3sWy/XekaKcV2Z+wSEn1Sn4jcFj1C+ze8lVlZLeOEY6vyhhddIqC/W
	 1V626T0m8H58D9b+4pm10o6UG8i2ojikIvc++n0r656j0p7haiFFlvTgwG4VFroSqZ
	 rR6UbGiTwEwiUX3MQ4aUWaCE2QdmQiOQuiHR96DoHeevN8HP+YeuOdKP+UThYp3KlH
	 PPlJOrwJ4I/ag==
Date: Thu, 13 Aug 2026 14:39:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] kho: support preserving high-order non-compound
 pages
Message-ID: <an2tArzOomSNpjV9@kernel.org>
References: <20260803113944.3694290-1-praan@google.com>
 <anr4-F-e5_vHEar8@kernel.org>
 <2vxzv79f39za.fsf@kernel.org>
 <anxrvA3z3NUkWvnE@google.com>
 <2vxzecg33103.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzecg33103.fsf@kernel.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Aug 12, 2026 at 03:46:20PM +0200, Pratyush Yadav wrote:
> On Wed, Aug 12 2026, Pranjal Shrivastava wrote:
> 
> > On Wed, Aug 12, 2026 at 12:32:25PM +0200, Pratyush Yadav wrote:
> >> On Tue, Aug 11 2026, Mike Rapoport wrote:
> >> 
> >> > Hi Pranjal,
> >> >
> >> > On Mon, Aug 03, 2026 at 11:39:41AM +0000, Pranjal Shrivastava wrote:
> >> >> Introduction
> >> >> ============
> >> >> This series is required for the ongoing effort to preserve DMA allocations
> >> >> across KHO [1]. It addresses a fundamental mismatch between the current KHO
> >> >> restoration logic and the physical reality of high-order buddy allocations.
> >> >
> >> > I skimmed through the patches, they look fine to me before the in-depth
> >> > review :)
> >> >
> >> > But we are really close to the merge window, so we'll anyway need to
> >> > reiterate after v7.3-rc1.
> >> >  
> >> >> The Problem
> >> >> ===========
> >> >> The current KHO restore implementation treats all multi-page blocks as
> >> >> split pages during restoration. Specifically, kho_restore_pages()
> >> >> initializes every 4KB sub-page with a refcount of 1.
> >> >> 
> >> >> However, many kernel subsystems, most notably the DMA allocator (via
> >> >> dma_alloc_coherent), frequently return high-order non-compound pages.
> >> >> In this state, only the head page carries a refcount of 1, while
> >> >> all tail pages have a refcount of 0.
> >> >
> >> > This hints that these patches could be a part of the DMA preservation
> >> > series, unless you expect other users of the new API.
> >> >
> >> > Generally, we don't merge new APIs without the users and if DMA
> >> > preservation is the only user, it's better to fold these two patches there.
> >> 
> >> Makes sense I think. We can review the patches here, but then they can
> >> go in with the DMA series.
> >> 
> >
> > So.. IIUC, I'll post a v5 here as a standalone series till we get
> > consensus, and finally the reviewed patches can be folded with the DMA
> > series?
> 
> That sounds good to me at least.

Yes, although when the patches will be a part of the DMA series we might
notices something else :)
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

