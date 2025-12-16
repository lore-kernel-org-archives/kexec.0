Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277A7D609A7
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JHJ7no1hZB1d020eOjoHel8dcWh1hLCizfZ5kLv5nWA=; b=fG/pZ/eRJTv0C6O/vvzqdMTC+m
	LRnbBq2DR2ScQVcYIa29F/qTkOYQ3ZJdcs+1BzNg7x2IQS6a6YYW8pcFN+ILfknqb50wPu99AF5ly
	t2mZgUaSWCsOaMUfozwnDQjrLb8VcUVOq8oyUo5Qio94DLb5X9CYE+uKyEE5IqXlFiE+64r0+41tH
	kExTWTTROgNTUv7iBE00Ihtnq3xUw7iFRSLDKpM6lo/ZDY19VoIfREiYUqRB1wDHihjtyAEIW0xNU
	18H7iZTlAnTKIQ1mo9STYwBWB8LoNZbrqr1lBx5oqwQZAyJggvdf1PAhhv7r9kdOM4AbFXg0de4VF
	cI63fk4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVWps-00000005QtK-34J6;
	Tue, 16 Dec 2025 15:19:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVWpr-00000005Qsv-1u6m
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 15:19:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8301C60187;
	Tue, 16 Dec 2025 15:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4CFC4CEF1;
	Tue, 16 Dec 2025 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765898374;
	bh=1C3O1RJhSl5a7OnhBSz/2GvP934zpCWD3sNtHJ+8dxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBLlXIJzdfgq1Dnn+DyMW+MquYwEJofXKI4D2doa79u6kD0MRYJb6l1wAT6BKDb4s
	 XkpwiiFiqbKfGMVfvT8HoBcPne3ZtUfGcQMHgNMjZOdEox5BZGDjUu6NLw/q73HkDN
	 KIcn8FPQaV0jrEW+3EZd6+NHCZ/C7oJrgbMiniwrgh/D+B2YyTkzf9rkuWnnrw5zNV
	 oExQ+29v47kcWhJnY1/nU0WUAgIKX8vBNRqiM1O/2Zuj8ibSW0Yxgw1vrdCldKRTfW
	 8MoQF0Q/RYYNs23aF991zxpDZQRIciTAlIu5nMZBXmqE3+uw9puCKIyTokUzycVfJk
	 GwSD2QuKfRARA==
Date: Tue, 16 Dec 2025 17:19:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aUF4fsWwD9BswkFh@kernel.org>
References: <20251216084913.86342-1-epetron@amazon.de>
 <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
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

On Tue, Dec 16, 2025 at 10:05:27AM -0500, Pasha Tatashin wrote:
> > > +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> > > +                                               unsigned int order)
> > > +{
> > > +     unsigned long pfn = PHYS_PFN(phys);
> > > +     int nid = early_pfn_to_nid(pfn);
> > > +
> > > +     for (int i = 0; i < (1 << order); i++)
> > > +             init_deferred_page(pfn + i, nid);
> >
> > This will skip pages below node->first_deferred_pfn, we need to use
> > __init_page_from_nid() here.
> 
> Mike, but those struct pages should be initialized early anyway. If
> they are not yet initialized we have a problem, as they are going to
> be re-initialized later.

Can say I understand your point. Which pages should be initialized earlt?
And which pages will be reinitialized? 

> > > +
> > > +     return pfn_to_page(pfn);
> > > +}
> > > +
> > >  static void __init deserialize_bitmap(unsigned int order,
> > >                                     struct khoser_mem_bitmap_ptr *elm)
> > >  {
> > > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned int order,
> > >               int sz = 1 << (order + PAGE_SHIFT);
> > >               phys_addr_t phys =
> > >                       elm->phys_start + (bit << (order + PAGE_SHIFT));
> > > -             struct page *page = phys_to_page(phys);
> > > +             struct page *page = kho_get_preserved_page(phys, order);
> >
> > I think it's better to initialize deferred struct pages later in
> > kho_restore_page. deserialize_bitmap() runs before SMP and it already does
> 
> The KHO memory should still be accessible early in boot, right?

The memory is accessible. And we anyway should not use struct page for
preserved memory before kho_restore_{folio,pages}.
 
> > heavy lifting of memblock_reserve()s. Delaying struct page initialization
> > until restore makes it at least run in parallel with other initialization
> > tasks.
> >
> > I started to work on this just before plumbers and I have something
> > untested here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/deferred-page/v0.1
> >
> > >               union kho_page_info info;
> > >
> > >               memblock_reserve(phys, sz);
> > > --

-- 
Sincerely yours,
Mike.

