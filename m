Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77101C5B56A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4DlA54u08QSleIzxXC03qMaWaKXGBXVOD3RnOmcy+1U=; b=a2jD00uu1Dms69dQF5C4SVTHf2
	VCgloJP7cuaKBpynSmLBYTmZiH+a8rUYyhZawxAgpJNX/fanLciNTddg8Ge0rWKwb5wrgcymiRacf
	K6r03j/wMU8ERpVf3R7ayKHik5J3r41dH9m8J6hyvtclw6EyRTb214cMva5iUgHqYAbjmIS6TNJ3l
	C9uq5dlf1oO+keWDio9i3TTF43FRhgS483whYEsydnt3gDLeAnwHy6Vdmse75zhJ7fg4LpUbI/GNK
	eybvU34GBzP+OcBLfy/1cIigrqkvvJJ5gW5a+YQ0/aFMqJGlkXkwPx7v7smRYbQyf2y99/U1PgiBA
	vo18VigA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu8OM-0000000GDg9-060e;
	Wed, 12 Aug 2026 12:49:10 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu8OJ-0000000GDf6-21gl
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 12:49:08 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cab97c86bdso93945ad.1
        for <kexec@lists.infradead.org>; Wed, 12 Aug 2026 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786538947; x=1787143747; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4DlA54u08QSleIzxXC03qMaWaKXGBXVOD3RnOmcy+1U=;
        b=n9dZzsf+afMDptENtkjjEpjp3Ecapz474rk8NQQRvShhrmRNLgg59sPTUsg21YQTWM
         hU3Blhd5hLB+pn0Bw/FZGbFy+VHy8KpCpvDolZ1yYNVkVkfolCqIEnH0pnZTruhevbfr
         xOzkUOUiel/khrCQdviLvtrDW+nvQZGmK/mEEkEw6T0gCecljuBwh44nXTM+sfZJrtlj
         We0LFNex5pml1xaJsYcw/50dxCM/Tr9Q7c7ZdxlIDSxS2cLzJcUO7wLXVBzbgYpWAFjF
         WOkB579L/AyAlgLs1qCLSOvj72z8bjbSuCc8D7ovSBG09u+w616besyvv1lO0D+BrQ3p
         b6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786538947; x=1787143747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4DlA54u08QSleIzxXC03qMaWaKXGBXVOD3RnOmcy+1U=;
        b=W1BZAXUbu7cYhHDRS0n7s+1kDQGyruSxqWzXiVVnig48IYvSU7D2gRHt7YMWw/t5Ne
         hxkLEM8HtK0FvZaMq4AOyHQixzAsXrZZXlovWCrx48LXXQs/Aa6UoAxiV3QqgPUUn9x0
         XeJ+xJcI17t5LxZrJ80V3juFZH0qpTsPjqL42XmSM5bwK6OHY28sc9E1YLK0W8dMPRR6
         OUgca8TBANkWMhyhau7KqgKTEBxNwfbYT8XS9adtoujzoENEPgec/ES0vw7She30tCUH
         YUXh0Fb1j7/j8j/rl5/KF9nOdXSP5lZvdEr+lLJJ+U9DR0ZxByAllaRdDz5jyOBHpUFZ
         creg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3z8/tnmr+EcxhIJbIym6/InJWuPGG6dCgJ8a+pZhHE7h/kvwCiJe15z7F9hAVA8X2a4lwuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyitLFyWsND6G5jcbV9Yx5sbX4kO9Ro2fUnEzxp3jzHkh6yXR4f
	h6xt/qD+Cm8bCGlti+GaPBaO9Oi/7NvxYM29CeLu1jCfQjwHmhqR2gRRTGWgVjWw7g==
X-Gm-Gg: AR+sD135yvGRmII2VFYTVEx5n4aK3lR15HLOONHMNft1UyGOk89GDQ2cwQkhgShy88a
	UWgiEf4Rchuus6ddgV+XhzJ6+G4wrC98lCIDiSFlTwz0elUUxi1hzzsOQ/xT+X9hyEJftMcpOxW
	zamunmrYARl9WQ3A2mgXDle7QRD9PXNis6J+AHXjQSxsXk8ZlCWnQY2btEnzRx9v9HVsnC0woQc
	mlE0+tzr4HflU0xjqTbkttZJGrdZN3xocOTExmd9ekUbTHzIJwLBgFwKFQ10AV0q3rnaRaF+rHg
	3gHM3g59GaHUGdzCJUXK1f37R1d7F3r8trBbtWpDV1svPhHZwK9xTDXwqYMcykWT3CQ25jE8TX2
	1LTAASpDS+bbPw6YTl/z2xNfkAbxm9h4g5kfP4ylJuyhCPyum1mSkyejscJRaINQqu6kCY7mMMe
	X0aBTkn8n67Q7S5ISvq5eHyZlPyDfCZSAsNynTAb1yaGk+q6Z5DhyQmPgBa+b/rZS2ZwhPBjh5m
	zOtlh39//C7e7D6h3pR1eY=
X-Received: by 2002:a17:903:19e6:b0:2ca:e0db:3cc with SMTP id d9443c01a7336-2d34ab72f8amr1230025ad.11.1786538946152;
        Wed, 12 Aug 2026 05:49:06 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35115103asm5901835ad.28.2026.08.12.05.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:49:05 -0700 (PDT)
Date: Wed, 12 Aug 2026 12:49:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] kho: support preserving high-order non-compound
 pages
Message-ID: <anxrvA3z3NUkWvnE@google.com>
References: <20260803113944.3694290-1-praan@google.com>
 <anr4-F-e5_vHEar8@kernel.org>
 <2vxzv79f39za.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzv79f39za.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_054907_522561_23895FB5 
X-CRM114-Status: GOOD (  23.29  )
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

On Wed, Aug 12, 2026 at 12:32:25PM +0200, Pratyush Yadav wrote:
> On Tue, Aug 11 2026, Mike Rapoport wrote:
> 
> > Hi Pranjal,
> >
> > On Mon, Aug 03, 2026 at 11:39:41AM +0000, Pranjal Shrivastava wrote:
> >> Introduction
> >> ============
> >> This series is required for the ongoing effort to preserve DMA allocations
> >> across KHO [1]. It addresses a fundamental mismatch between the current KHO
> >> restoration logic and the physical reality of high-order buddy allocations.
> >
> > I skimmed through the patches, they look fine to me before the in-depth
> > review :)
> >
> > But we are really close to the merge window, so we'll anyway need to
> > reiterate after v7.3-rc1.
> >  
> >> The Problem
> >> ===========
> >> The current KHO restore implementation treats all multi-page blocks as
> >> split pages during restoration. Specifically, kho_restore_pages()
> >> initializes every 4KB sub-page with a refcount of 1.
> >> 
> >> However, many kernel subsystems, most notably the DMA allocator (via
> >> dma_alloc_coherent), frequently return high-order non-compound pages.
> >> In this state, only the head page carries a refcount of 1, while
> >> all tail pages have a refcount of 0.
> >
> > This hints that these patches could be a part of the DMA preservation
> > series, unless you expect other users of the new API.
> >
> > Generally, we don't merge new APIs without the users and if DMA
> > preservation is the only user, it's better to fold these two patches there.
> 
> Makes sense I think. We can review the patches here, but then they can
> go in with the DMA series.
> 

So.. IIUC, I'll post a v5 here as a standalone series till we get
consensus, and finally the reviewed patches can be folded with the DMA
series?

Thanks,
Praan

