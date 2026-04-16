Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB19AF8D760
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O/bqmT/sHPhtEYlBdl+Pe9z2g5g8mvJyEt3k/kSDG8s=; b=TgZYtxNU3m04GndUEVVMQPuTqy
	QbeZJ/XKak5qI67f1lyiUupwnZ+P/7EKLFi8TtH+Q0dS7/y6dwBqAKzudmsbj922hixwnjWokdnoJ
	L0ApNLl5WuQqAtM9D4TDPy5nhP0h0TT6PzxzY7R/r/HYtHUXMyYCFY8EKkYqCPXkKK9mY61iI4JXJ
	PD03VxY72p8f5fK4gNI5LCVsT4/viUq+nNQf+26rfSIPePNN/lHB5QKDhZ52BjEXZsuIuttNEAEZc
	xoZ949aqxbCWU9QGaXHJfFEyoYLTtsDAv9Zdc1iaAxi4FPyfq8pFaELet9NdiTfZjPlwgk1kxNF8n
	1wNxIOCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDPLF-00000002ed8-2YZ8;
	Thu, 16 Apr 2026 16:13:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDPLB-00000002ecm-2ZFU
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 16:13:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 392FC4045A;
	Thu, 16 Apr 2026 16:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC17C2BCAF;
	Thu, 16 Apr 2026 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776355994;
	bh=qIXWb9zk7cCWCWuHZHzx5UEDyqwqm3ROl3GtCRHkRO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFMlIkBMMOgwrHCtflz3RSb2FmJbQI3+0F0SMsRAc0uohnsekVsLJz5Z9EXVf4Xb0
	 CtGuojup3h+lZc0vq+tLGlF7XtmI2de9YP7mqpprDY74xiQG/jxLLMYMwLo7k3q/82
	 aUbDdG6fQnVsbHAwkZs8wYWu7BH+Er8zqlf1x2vL6/jy1xTnaNgbPiyQMW0pDl8Arh
	 AIGMIJenzzQrP6mpskMgHgfAzxrYBi1dTrPg+DlXpi46lkwFLxCm675Rg8N7G4gKe/
	 jbdlQfMq5MkkffV4oTRE4OJwJ27mpwluJ1cW944HIiiJsDAnOQ8/IlVOBESGAkdf2Y
	 /KE0/l9U0ErFQ==
Date: Thu, 16 Apr 2026 19:13:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v8 1/2] kho: fix deferred initialization of scratch areas
Message-ID: <aeEKksfLxQ0A7Jun@kernel.org>
References: <20260416110654.247398-1-mclapinski@google.com>
 <20260416110654.247398-2-mclapinski@google.com>
 <aeD2Fzr6yr4pu9-X@kernel.org>
 <CAAi7L5d-ujEa7R21Lmd37X9451KBmK8ZhagSKbJde15aQLi2MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5d-ujEa7R21Lmd37X9451KBmK8ZhagSKbJde15aQLi2MQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_091317_674320_A41EBB6F 
X-CRM114-Status: GOOD (  13.32  )
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

On Thu, Apr 16, 2026 at 05:06:10PM +0200, Michał Cłapiński wrote:
> On Thu, Apr 16, 2026 at 4:45 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Michal,
> >
> > On Thu, Apr 16, 2026 at 01:06:53PM +0200, Michal Clapinski wrote:
> > > @@ -2262,6 +2253,12 @@ static void __init memmap_init_reserved_range(phys_addr_t start,
> > >                * access it yet.
> > >                */
> > >               __SetPageReserved(page);
> > > +
> > > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> >
> > No need for #ifdef here, there's a stub returning false for
> > CONFIG_MEMBLOCK_KHO_SCRATCH=n case.
> 
> In all 3 places the #ifdef is there because MIGRATE_CMA might be
> undefined. I already broke mm-new branch in the past because of that.

Hmm, that hurts :/

The best I can think of is to add a static inline in memblock.h and ifdefs
around it.

> > > +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
> > > +                 pageblock_aligned(pfn))
> > > +                     init_pageblock_migratetype(page, MIGRATE_CMA, false);
> > > +#endif
> > >       }
> > >  }

-- 
Sincerely yours,
Mike.

