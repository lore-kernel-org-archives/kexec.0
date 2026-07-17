Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB53C44514
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kymz6dm33N7NX4Bxmj5nZNVNhxFYwOfgyqjCnNon1ew=; b=0EQaCOitcSGCcBf558vpRqAPlu
	bZ5x5x0m2AEs3QoSw7YDJXjX3ASXBotocQEffAGG8aqsDIVjcr179qh4DW7TKXIrvcAKr75VLy4au
	zKfw5t4FGHzVUh+1YuMQQ+iIMmF4y67KVC8EEUgUPBU9rz1RCw/QmVgtJJa2WjtcyzmRn+7sdty85
	GhMPIsCr43yDj46yGbb8FzAd2ivRn445eDZGggYmtH2do4Sz1BpbHldDO0/EoOE0CFDHkqdSveER0
	LQH6yDv/Ky3ixxrMy3Ympb04kT0LCo/2TOg2VmnX3yV1N/jqkuRc+HcUhNNccTc4jx0yDV+U/rm98
	0Is8mpkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkdeN-00000001a8x-3LBU;
	Fri, 17 Jul 2026 08:10:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkdeM-00000001a8l-0lZ7
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 08:10:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EB5EC43D1D;
	Fri, 17 Jul 2026 08:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97A51F00A3A;
	Fri, 17 Jul 2026 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275825;
	bh=kymz6dm33N7NX4Bxmj5nZNVNhxFYwOfgyqjCnNon1ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fjfITHEs0lQTAFOgRg4k6giweIJ5GZ/4/Db0+YwNmE2ov6L8tavH709tYC6DuRhYO
	 EnE/S9sY5HrpxPnb63L65SWwuFejJNGbotB3Zu4TOxUAK+DD9r7RoTkJSBsVMMp6iS
	 640mAVPdQ33w0snFTiqiWvAJZ4o3xlssHdvGvZk8gx7NY2ILSG7vqUgqRfDApAgdd0
	 srDAO3xVWHbR4CvygqO19PqvcxgyMZKm3HT+wre1WJFOYoJlJiHN18XOyvgs5bS9Kz
	 +UiCYdpzHU2n9PL9sD1QqfgunFabROz01rAP4Wq4r3mduO45MTUk4MCtvd6iIOHgoZ
	 qz/bHpBg2vrYg==
Date: Fri, 17 Jul 2026 11:10:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
Message-ID: <alnja9PTG1OPJOKi@kernel.org>
References: <20260714205111.2497151-1-mclapinski@google.com>
 <178409777790.255896.16691338963510282908.b4-review@b4>
 <CAAi7L5e13dwTOJYhYu2q0XNxRHjaZz=EatOpK9_8+jacyBzNzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5e13dwTOJYhYu2q0XNxRHjaZz=EatOpK9_8+jacyBzNzQ@mail.gmail.com>
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

On Wed, Jul 15, 2026 at 06:34:51PM +0200, Michał Cłapiński wrote:
> On Wed, Jul 15, 2026 at 8:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Michal,
> >
> > > I caught this crash:
> > > BUG: unable to handle page fault for address: ff19164fffff8328
> > > RIP: 0010:__free_one_page+0x1a1/0x6b0
> > > Call Trace:
> > >  <TASK>
> > >  [<ffffffff913208bf>] free_one_page+0xaf/0x240
> > >  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
> > >  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
> > >  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
> > >  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
> > >  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
> > >  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
> > >  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
> > >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> > >  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
> > >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> > >  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
> > >  </TASK>
> > >
> > > deferred_init_memmap_chunk() works fine without KHO because free
> > > regions will never be neighbors. However, with KHO, free memory
> > > will be split into (free && scratch) and (free && !scratch).
> > > KHO scratch is aligned to CMA_MIN_ALIGNMENT_BYTES (which on my setup
> > > is equal to 1 << 9 pages) but buddy can look at the neighborhood of
> > > MAX_ORDER_NR_PAGES pages (which is equal to 1 << 10 pages).
> > > This sometimes crashes when one half of the neighborhood is being
> > > initialized but the other part is yet to be initialized.
> > >
> > > To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.
> > >
> > > Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferred struct page init")
> > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > >
> > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > > index 4834a809985ab..50928aaa33710 100644
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -38,6 +38,16 @@
> > >  #include "../kexec_internal.h"
> > >  #include "kexec_handover_internal.h"
> > >
> > > +/*
> > > + * This is the minimal alignment required by deferred struct page init.
> > > + * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> > > + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> > > + * If KHO scratch is not aligned to that value, buddy can access uninitialized
> > > + * struct pages, which can cause a crash.
> > > + */
> > > +#define SCRATCH_ALIGNMENT_BYTES (1 << (PAGE_SHIFT + MAX_PAGE_ORDER))
> > > +static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
> >
> > Maybe make it a variable and set it at runtime?
> > We won't need to worry about different confugurations that override
> > MAX_ORDER and potentail divergence of pageblock size from MAX_ORDER in
> > the future.
> 
> Sorry, I don't track. What would I set it to at runtime?
> MAX_PAGE_ORDER must be >= PAGE_BLOCK_MAX_ORDER and I don't understand
> what's the problem if some configurations override MAX_PAGE_ORDER.
> They can't override it to be smaller than PAGE_BLOCK_MAX_ORDER.
> 
> Are you saying that in the future PAGE_BLOCK_MAX_ORDER could be bigger
> than MAX_PAGE_ORDER?

That's very unlikely, indeed.

-- 
Sincerely yours,
Mike.

