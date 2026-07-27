Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C58C53209
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 22:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gBx1sqPOi/sYxMgcMoA4vUh2Ha5IO4euZ+QG5rwNAXI=; b=L27mjIY6i/tsige1OW2at0ns9g
	bVFQNeOnjLzTjZ25Eq5S7mZdGg2kbgCbvgb9nghJGFN1IyQJU1wob68+0aBMm5pCrQq+2ZhdF5Ivn
	jj7GqVSdLGzGrWyZYYu6NgQwjxShvVBllYikRtEaLLrnrHWq5ngrMnmeeIzCqCAFCISQ4XZ4RRs0I
	g9cG77ZDgUIaXgX0D9MLpXwkVbaLgIQ3HT+q9E4FTra4wvxNNpDd8g6EqgBATKQFcKYbJxwrHtbu7
	3a4F1r+xIHFHFslKkcbjALCH6rDwW8QIQ/fE6ovXwDhbs9PTiL/mFxYimgXHhjNfTZOAFBLcuXJ5B
	+So79trQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woUCu-000000042vo-3LL4;
	Mon, 27 Jul 2026 22:54:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woUCs-000000042vc-3oPp
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 22:53:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4304B6013A;
	Mon, 27 Jul 2026 22:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830781F000E9;
	Mon, 27 Jul 2026 22:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785192837;
	bh=gBx1sqPOi/sYxMgcMoA4vUh2Ha5IO4euZ+QG5rwNAXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=drUnlP/gTpTNJGf3kSPuQsBGCK6KUDTIbN8ppYNrzSy4mH9fLmZBTM2YFav9YRT7A
	 umgV2laiKooA58w9Td7kAuFj003uCbfsViLfF/Wp7D5bsBXTJj9XKBn+mZzOLmPnju
	 NPUMhrljboSYiUJ+cWnZ8RkXY9ebJit2KojBiuGY=
Date: Mon, 27 Jul 2026 15:53:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Pratyush Yadav
 <pratyush@kernel.org>, David Hildenbrand <david@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, Oscar
 Salvador <osalvador@suse.de>, Jason Miu <jasonmiu@google.com>, Jork Loeser
 <jloeser@linux.microsoft.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Muchun Song
 <songmuchun@bytedance.com>
Subject: Re: [PATCH v4 16/21] mm/mm_init: simplify deferred_free_pages()
 migratetype init
Message-Id: <20260727155356.2b2d39657d1154f9400e69ea@linux-foundation.org>
In-Reply-To: <amcuEiLzIunJwZVx@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
	<20260725172133.4018491-17-pratyush@kernel.org>
	<amXelr2DcRRyZDY4@kernel.org>
	<20260726202522.e55861cc87fc3e0c6d030e1f@linux-foundation.org>
	<92E24479-07A8-4998-9607-87420A8BE04E@linux.dev>
	<amcuEiLzIunJwZVx@kernel.org>
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

On Mon, 27 Jul 2026 13:08:18 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> On Mon, Jul 27, 2026 at 11:43:31AM +0800, Muchun Song wrote:
> > 
> > 
> > > On Jul 27, 2026, at 11:25, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > 
> > > On Sun, 26 Jul 2026 13:16:54 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> > > 
> > >> On Sat, Jul 25, 2026 at 07:21:16PM +0200, Pratyush Yadav wrote:
> > >>> From: Muchun Song <songmuchun@bytedance.com>
> > >>> 
> > >>> deferred_free_pages() open-codes two loops to initialize the pageblock
> > >>> migratetype for a range of pages.
> > >>> 
> > >>> Replace them with pageblock_migratetype_init_range() to remove the
> > >>> duplication and make the code clearer (Note that deferred_free_pages() may
> > >>> be called from atomic context).
> > >>> 
> > >>> Link: https://lore.kernel.org/20260612035903.2468601-6-songmuchun@bytedance.com
> > >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > >>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > >>> Acked-by: Oscar Salvador <osalvador@suse.de>
> > >>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> > >>> ---
> > >>> 
> > >>> Notes:
> > >>>    This patch is taken from Muchun's series [0]. The patch as of today is
> > >>>    in mm-unstable.
> > >> 
> > >> @Andrew,
> > >> 
> > >> It looks like it'll take some time for this patch to get into mm-stable so
> > >> we can't base this work on a branch in the mm tree :(
> > > 
> > > I didn't know anyone was using mm-stable :(
> 
> Maybe nobody uses it because it's not really stable? ;-)

Well it's supposed to be.  Rebases are rare.

The larger problem is that it doesn't contain anything until -rc5ish
because we haven't stabilized anything yet!

> > I'd like to confirm that this is a completely independent cleanup patch,
> > so it can be merged on its own.
> 
> That's great, thanks for confirming!
> 
> Then I think the easiest would be to take "mm/mm_init: simplify
> deferred_free_pages() migratetype init" via liveupdate tree.

No probs, I'll drop it when Mark reports the duplicate.

