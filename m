Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217C3CAC592
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 13:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ILCtKFmfYnFvId3j5b1uDA9fz5e4kRdNZzLTAH6mDZU=; b=gYJBy0DB/wCU9Bc6nfpDkULTfj
	3/sFr6sE3Yc33/xcwdq+kc5xyaXmTUbz2KP4jwbrcM1/KpSlxijvWCTe8hr4CabOWxuuWvTTS0/1G
	Pvpb/J5c5CFlsR4V61vBt+d8mwn7QEn1/xvzCdNFf9+msL8CuvJaJMhjACi/r4WQG5pgX3ykjxWeB
	toKzfBOuSRIftpBOoTkUL6JXuhHs1O6frA/cnghKr9Y1zBLn4TsVJmmjfeE1Xvl1SIbR26x9dtu1W
	e7bzDzilaaih7Pa20c3H56ieF5MA8AvXnbP89/m6TTo1hAc+sbidjDx2iaq6RuUY9seTK9uYTh+96
	rFy3nXBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9iY-00000004WsW-0KuA;
	Mon, 15 Sep 2025 13:58:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9iV-00000004Wr0-2bLt
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 13:58:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C0F3B401D1;
	Mon, 15 Sep 2025 13:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB065C4CEF1;
	Mon, 15 Sep 2025 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944682;
	bh=zfhyJFbpd+KywjV+fUeZ4MHJ3acyIVGXF5VDrBR3oqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAj6E/Ir4AcO15gg4WswXPYafaVEjYoICbCA8Ag7OHWX6rZwizZktjF1JXf7VU6xd
	 CEUGAByV8DTlJ+KHyVddNKEdEmTI4oj4QL/FLCdjtOUkliPSnyRG6jVALUuzJj1VP6
	 CSLvcbzXRP4PWdf0ExQYFaIC3Km4yAfiJiV7PblSZUJj5iwtiXA3UfdP8UJ3kRQEIC
	 sbhpRwwwW5KgSgMQqG40XiL37ebky3DEBtTGVte+j4bIbtbTh8GweS7XL5GB97BkTO
	 cLM1lqDdieaRdNRGieHhWZNXbMwPsXIeBxXGo1M70cjoPlE+RCLHHI5xoe0eoU/aHj
	 /kAJkO4XoPTUg==
Date: Mon, 15 Sep 2025 16:57:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <aMgbYrYwxKjiW6Pd@kernel.org>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
 <20250903125620.GG470103@nvidia.com>
 <aLhg2Jli0KUe-CXC@kernel.org>
 <20250903170631.GK470103@nvidia.com>
 <aLiWDl3sq3RTkdfJ@kernel.org>
 <20250904123032.GM470103@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904123032.GM470103@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_065803_675237_EEAB89C6 
X-CRM114-Status: GOOD (  20.08  )
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

On Thu, Sep 04, 2025 at 09:30:32AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 03, 2025 at 10:25:02PM +0300, Mike Rapoport wrote:
> 
> > It seems that our major disagreement is about using 'folio' vs 'page' in
> > the naming.
> 
> It is a folio because folio is the name for something that is a high
> order page and it signals that the pointer is the head page. Which is
> excatly what KHO preservation works on.

kmalloc_large() and vmalloc(VMAP_HUGE) are not folios and won't be.
 
> I don't know what the next step is when folio is split - presumably we
> will get a new type to represent an abstract memdesc head of a high
> order allocation that the lowest KHO primitives will change over to.
> 
> > I'd rather stick to the good old 'page' and when the time comes we can
> > 's/page/memdesc/g' supposing Matthew actually plans for it.
> 
> I think you should just convert from the vmap page to folio for now
> and most likely vmap will stop using page someday..

This is wrong. vmalloc is not a folio and according to memdesc plan [1] it
will be be page until it becomes memdesc.
  
> > There is a struct page for everything that's memblock_alloc()ed. And we can
> > do page list, but for large  physically contiguous allocation it does not
> > make sense. 
> 
> Arguably you could make them into high order pages and preserve those..

They are not aligned by order and they may be partially freed starting at
arbitrary page. Making them high order pages will be a mess.

[1] https://kernelnewbies.org/MatthewWilcox/Memdescs

-- 
Sincerely yours,
Mike.

