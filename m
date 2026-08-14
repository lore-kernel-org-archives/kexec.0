Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1282C5CFCF
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mG1kOJ+Tut2DmZVpOA/Iv9r39LYIA7qLrHZhoVN2dxo=; b=fW0sAYcOH60TDTeS4iryScKwbR
	htdZnkN/f+uzLtIvbEfTKoTgNJ5G1ImpNmCyiVifgwlx8QzXFBljO7WEAi8dCDwNB+bHoAHpzzjkN
	SJAXp3zNnMFsWVPrIk0vL1Q2bHzolgkZpr3M3rdcrzzyuyj+n0XPLp1BuSsAG724m6X0A9KEjT5aD
	mytOv6lz9UT3R1XmO+1HrokMWt5OuALUEb9bOBIvIswFGnOXeFWjDay5f5SsPBHmZN2DmOM6g9Ln+
	2fYZghZUVR2Rgskb3LBRVPARwqeUN+b2R8W9ZxEP722ZJN/b/O7DFgSpy+0Jp1PHaGwOX5LdZwTWK
	GsOyhfUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuv53-00000002wa1-1XDn;
	Fri, 14 Aug 2026 16:48:29 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuv50-00000002wZX-0n29
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 16:48:27 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2d3b440b97aso115155ad.1
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786726105; x=1787330905; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mG1kOJ+Tut2DmZVpOA/Iv9r39LYIA7qLrHZhoVN2dxo=;
        b=T0kCETLeBBIKqamwy/QrLiLSJjjdBHrUg3ws/OTXrtBGemrdJu+HQb5M6qxBqymnLv
         7462sCilDcybbjxwsan3Y4YaH/KnwR5ydlfpxReJcjYY9Xv4Bs/M+1LehByqReDXeQG7
         d0Fyk5B14PIUdHKTB6XHWZwmjryCinYeXfTichilSWSsadhJwRsBDNc3CxUaNStnJe1Y
         VPxPfuvIXRx8M/dJUuVQuh/zTX+Dn29ewQyOA1PjHET7vgcTnJroSOlehA8HOuql5cVU
         UJD3b8SgBduAus6vnR+B1ALwp297QYFcYyyz1CzBRFVabY6MMVgVCboi5s4fWbN+Tnqj
         UTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726105; x=1787330905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mG1kOJ+Tut2DmZVpOA/Iv9r39LYIA7qLrHZhoVN2dxo=;
        b=J48cAYUqi6pgUXOmQzvnpcOpCV1SlSTAEStzfv8pyxFanUvfATl/w9hvULWtwfuCyD
         ZQd1AEgmKvzGmqGwaaRNBL+Vda8IaUNX0Zq7JW1NwsEQIOdeEx+tRyAPiH4brStEsh46
         auSOzTv37WMR4qBa7wlpr8wQV8xJverWvRLMNpJ0N1F8bdbFrr+Qm40cvApzTZwMORJJ
         YE19gcwWQzunlINE3RV1dA/mSSWQLgBQ+2RmTqpA86zy7SyDkseNQ7O1PmNCCZ9Sj0bq
         1hGrVfxIpB0g9gtaWhrUETBLJFwwm43BR1PK7I4cjo869Q/zi8Qt1JtFscoq7vohFVG7
         I0qQ==
X-Forwarded-Encrypted: i=1; AHgh+RojdXjNp+F/Z0i8C3CT2OBOFX+jPZRPgZCeFn1Zb34BFuZ77IqcBDP125f9IZwEaW5dldB6VQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwbjOOJgl+C3rUkZ4LImDlJier0K+wijLpQvvTS1TWIxw7fUuFj
	ea5bxo0sSxADUeKGzzyVdYzVqK/HSuZZi+ez7hWHrq+wcnGM/k/nPIN9hARaiTsI6A==
X-Gm-Gg: AR+sD13DzRFVI0Ne6C+Gha3pPzi2z1fwdPd3vye1wERY4sEf+aVjMw+EzRyel27FUUd
	czruVYwE6kuQ6O0F8T5HcpFSAgaeCkyT/AWEqLIyD3wgm4rZ+M2MLEjBixXQcuiJpXfqqH5rIzV
	A7zhiI9QcU4SSF6ES3ZuUQq3xmHMsR8R7mfmmyTU79kfdPVLi3dAtyXlnqpoYIKZLgKksrE17P3
	xbxAfRzRfyQ5fPib/xxn5WNDssxESjDQthhZ4GuGybdRavBHJ3BsVx7MleBSWZTCXRwJ84QJ7Yj
	qS0lhNPX56O61SLIAn766D23w07yx4B6CkvLHD8mZHoApBEFBhF+aCD8aQtteLhsJ/URdRuEVoZ
	xxi9hMhCYlX3KJIq46ko0ZKtyXanXwdvu4VIiKp+D3CUeKMEyk7mQVxP2xdisnM7iXuAqbfFsnq
	oR2XfGHbSrd2dliKxFWum85Ow0nOSrXzJIli7u1LoLvPAACA8jT+wmf5qHToZZxd0WLYPLzimRu
	jTWad29nUOHJw6X5UEw34Y=
X-Received: by 2002:a17:902:f78d:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2d3b48aa5f2mr7298295ad.3.1786726103643;
        Fri, 14 Aug 2026 09:48:23 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a490c1sm935638a12.29.2026.08.14.09.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:48:23 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] kho: support preserving high-order non-compound
 pages
Message-ID: <an9G0Y3ZNIA2NfjP@google.com>
References: <20260803113944.3694290-1-praan@google.com>
 <anr4-F-e5_vHEar8@kernel.org>
 <2vxzv79f39za.fsf@kernel.org>
 <anxrvA3z3NUkWvnE@google.com>
 <2vxzecg33103.fsf@kernel.org>
 <an2tArzOomSNpjV9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2tArzOomSNpjV9@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_094826_252754_98194573 
X-CRM114-Status: GOOD (  26.53  )
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

On Thu, Aug 13, 2026 at 02:39:46PM +0300, Mike Rapoport wrote:
> On Wed, Aug 12, 2026 at 03:46:20PM +0200, Pratyush Yadav wrote:
> > On Wed, Aug 12 2026, Pranjal Shrivastava wrote:
> > 
> > > On Wed, Aug 12, 2026 at 12:32:25PM +0200, Pratyush Yadav wrote:
> > >> On Tue, Aug 11 2026, Mike Rapoport wrote:
> > >> 
> > >> > Hi Pranjal,
> > >> >
> > >> > On Mon, Aug 03, 2026 at 11:39:41AM +0000, Pranjal Shrivastava wrote:
> > >> >> Introduction
> > >> >> ============
> > >> >> This series is required for the ongoing effort to preserve DMA allocations
> > >> >> across KHO [1]. It addresses a fundamental mismatch between the current KHO
> > >> >> restoration logic and the physical reality of high-order buddy allocations.
> > >> >
> > >> > I skimmed through the patches, they look fine to me before the in-depth
> > >> > review :)
> > >> >
> > >> > But we are really close to the merge window, so we'll anyway need to
> > >> > reiterate after v7.3-rc1.
> > >> >  
> > >> >> The Problem
> > >> >> ===========
> > >> >> The current KHO restore implementation treats all multi-page blocks as
> > >> >> split pages during restoration. Specifically, kho_restore_pages()
> > >> >> initializes every 4KB sub-page with a refcount of 1.
> > >> >> 
> > >> >> However, many kernel subsystems, most notably the DMA allocator (via
> > >> >> dma_alloc_coherent), frequently return high-order non-compound pages.
> > >> >> In this state, only the head page carries a refcount of 1, while
> > >> >> all tail pages have a refcount of 0.
> > >> >
> > >> > This hints that these patches could be a part of the DMA preservation
> > >> > series, unless you expect other users of the new API.
> > >> >
> > >> > Generally, we don't merge new APIs without the users and if DMA
> > >> > preservation is the only user, it's better to fold these two patches there.
> > >> 
> > >> Makes sense I think. We can review the patches here, but then they can
> > >> go in with the DMA series.
> > >> 
> > >
> > > So.. IIUC, I'll post a v5 here as a standalone series till we get
> > > consensus, and finally the reviewed patches can be folded with the DMA
> > > series?
> > 
> > That sounds good to me at least.
> 
> Yes, although when the patches will be a part of the DMA series we might
> notices something else :)
>  

Ohh yes, definitely! Just asking to know what to follow for the next version :)

> > -- 
> > Regards,
> > Pratyush Yadav
> 
> -- 
> Sincerely yours,
> Mike.

Thanks,
Praan

