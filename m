Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8289EC531F9
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 03:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XsGyYiFyMYFI9L2NS0y/ZZKusZC2V7j9ria54DgCTvg=; b=BKRAo9Qqp36LMXsAFcF2Iq1OXr
	xByBoSBdBDdJxBO8X8S9u76gB4l90+PGdJg2G1z5jWnH5WG4NDKssFX7fOS9pKjxZGcBopwadZrPk
	Sbo1CLyvWW91VapJ+wc7mySjuJ7alhCOUHiihi1ITHoIDGPRTPlY2LEQYb3Sib6eFFz42hdxFavtn
	G2vsqXHleb1QU4HBjvNtucOehy9i1W/bL8ifePjXBK0AT9ByG+HtMl+KcN1bOaL7yo6QP+C14RV1H
	BaWMwzlwI2jirmMwnQbJCsoXHQdH5cRdJ2nUipX2GuSTj4EF6DbNoukMuFjzJfwKcJbiinMHKE7ot
	8FrUjv6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBy3-00000001s9z-05wR;
	Mon, 27 Jul 2026 03:25:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBy0-00000001s9g-0jqh
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 03:25:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DC81600D8;
	Mon, 27 Jul 2026 03:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B351F000E9;
	Mon, 27 Jul 2026 03:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785122723;
	bh=XsGyYiFyMYFI9L2NS0y/ZZKusZC2V7j9ria54DgCTvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=2SMuE6+jtlUJGMjNlIL7V1BctnQiR7Uo9OTYyybI7QMnQbecBSJlenZWs/HudWknX
	 nGJuIjw6r2E3LHvdtZ0HVHUPAYLGiYj3dCcIJyav42g+1NKbHv5U5bFEeiZ569iI+1
	 LExXWNGYvAQViTisqtpUy8ZXghtC+sm1zRp6aiPU=
Date: Sun, 26 Jul 2026 20:25:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, David Hildenbrand
 <david@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander
 Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, Jason Miu <jasonmiu@google.com>, Jork Loeser
 <jloeser@linux.microsoft.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Muchun Song
 <songmuchun@bytedance.com>
Subject: Re: [PATCH v4 16/21] mm/mm_init: simplify deferred_free_pages()
 migratetype init
Message-Id: <20260726202522.e55861cc87fc3e0c6d030e1f@linux-foundation.org>
In-Reply-To: <amXelr2DcRRyZDY4@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
	<20260725172133.4018491-17-pratyush@kernel.org>
	<amXelr2DcRRyZDY4@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 26 Jul 2026 13:16:54 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> On Sat, Jul 25, 2026 at 07:21:16PM +0200, Pratyush Yadav wrote:
> > From: Muchun Song <songmuchun@bytedance.com>
> > 
> > deferred_free_pages() open-codes two loops to initialize the pageblock
> > migratetype for a range of pages.
> > 
> > Replace them with pageblock_migratetype_init_range() to remove the
> > duplication and make the code clearer (Note that deferred_free_pages() may
> > be called from atomic context).
> > 
> > Link: https://lore.kernel.org/20260612035903.2468601-6-songmuchun@bytedance.com
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: Oscar Salvador <osalvador@suse.de>
> > Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> > ---
> > 
> > Notes:
> >     This patch is taken from Muchun's series [0]. The patch as of today is
> >     in mm-unstable.
> 
> @Andrew,
> 
> It looks like it'll take some time for this patch to get into mm-stable so
> we can't base this work on a branch in the mm tree :(

I didn't know anyone was using mm-stable :(

Series is adequately reviewed and is near head-of-queue so I can move
it into mm-stable a few days hence if that helps?

> I'd like to expose the KHO scratch extension to linux-next ASAP so I'm
> inclined to take this patch as a part of this series and live for a while
> with a duplicated commit in linux-next. Once this patch would be in
> mm-stable we can rebase kho-scratch work on top of mm-stable and hopefully
> there will be enough time for it to live in linux-next so that Linus won't
> get angry at us :) 
> 
> How does that sound to you?

That's fine - let me know what you choose to do and I'll adapt to it.

An unknown (to me) is whether Muchun's series "mm: Refactor bootmem
gigantic hugepage allocation, v4" still works with this patch removed.  Everything
applies OK for what that's worth.

