Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058ABC53219
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 10:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I03Tf7oe1oyPKkCeh2/uxA3siPkO86atNMUY0KznFQI=; b=B9Kbr/tjDA7OLdDb/yfqDBCKWl
	s/YGAp9JJDQMtCp5TOd04T9FLptl1Pu+GHS3hGubyub/LfXjC1KBQwDBZ1KmiDXFMgkGFCkB/5qyO
	2JmnFLGQwp7/onPG2FLZYP/j8UNm2bE/1QWH6hQGaOI2xc8k/Jq51oTr4UzbbTwDny+MYPjBPappq
	wu8s+/hiZ70u8v+uByGwMAKsmbZAMxIGR4j9LiyMZJwC6yyd2XlWPUGoRLak4m2eImwkThQyaotj+
	XL4K30onXJD8E3832ibg850hZQ1QRycLo5ExOKgOiPfSFA+kvoWwgmwtsoaTO7F6mWb8/CzxNKmv6
	mZ50v4og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woIG4-00000002Qwd-0Atj;
	Mon, 27 Jul 2026 10:08:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woIG2-00000002QwG-3yAw
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 10:08:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 59AA642DD9;
	Mon, 27 Jul 2026 10:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7771F000E9;
	Mon, 27 Jul 2026 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146906;
	bh=I03Tf7oe1oyPKkCeh2/uxA3siPkO86atNMUY0KznFQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cn4G1dYW14+InpRXOVRcBBEQ07NLqLs6jK/EZ35lNz8Esh0P26puvKGNauqqfEeh7
	 9osfo7sqwksjbyu4yX1mwS/iEbCZkW61Yfj+un3HoLHZemTan+2w77PFgAbeebUiiy
	 I5BYfz3xEnC9ZSbjnpdMAN4ogt1BFORpYP8aJvfMSz/J5AHvUjYG/pZ/KLNsoFbx7y
	 kq8ZUrlqSbfPCC5/NBrXNv0uBsFaTLR0D6yw/5i58V91kGNLmboB1/Aj8eJ085Ax8L
	 jsU/MRpgj8oTWBsEvYTUfIynnzcYvidOgP83QTQpp1mwbsALCPZWrGozEblgb/obUH
	 VCelFTLPuBqRA==
Date: Mon, 27 Jul 2026 13:08:18 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Oscar Salvador <osalvador@suse.de>, Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4 16/21] mm/mm_init: simplify deferred_free_pages()
 migratetype init
Message-ID: <amcuEiLzIunJwZVx@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
 <20260725172133.4018491-17-pratyush@kernel.org>
 <amXelr2DcRRyZDY4@kernel.org>
 <20260726202522.e55861cc87fc3e0c6d030e1f@linux-foundation.org>
 <92E24479-07A8-4998-9607-87420A8BE04E@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92E24479-07A8-4998-9607-87420A8BE04E@linux.dev>
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

On Mon, Jul 27, 2026 at 11:43:31AM +0800, Muchun Song wrote:
> 
> 
> > On Jul 27, 2026, at 11:25, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > On Sun, 26 Jul 2026 13:16:54 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> > 
> >> On Sat, Jul 25, 2026 at 07:21:16PM +0200, Pratyush Yadav wrote:
> >>> From: Muchun Song <songmuchun@bytedance.com>
> >>> 
> >>> deferred_free_pages() open-codes two loops to initialize the pageblock
> >>> migratetype for a range of pages.
> >>> 
> >>> Replace them with pageblock_migratetype_init_range() to remove the
> >>> duplication and make the code clearer (Note that deferred_free_pages() may
> >>> be called from atomic context).
> >>> 
> >>> Link: https://lore.kernel.org/20260612035903.2468601-6-songmuchun@bytedance.com
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >>> Acked-by: Oscar Salvador <osalvador@suse.de>
> >>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >>> ---
> >>> 
> >>> Notes:
> >>>    This patch is taken from Muchun's series [0]. The patch as of today is
> >>>    in mm-unstable.
> >> 
> >> @Andrew,
> >> 
> >> It looks like it'll take some time for this patch to get into mm-stable so
> >> we can't base this work on a branch in the mm tree :(
> > 
> > I didn't know anyone was using mm-stable :(

Maybe nobody uses it because it's not really stable? ;-)
 
> > Series is adequately reviewed and is near head-of-queue so I can move
> > it into mm-stable a few days hence if that helps?
> > 
> >> I'd like to expose the KHO scratch extension to linux-next ASAP so I'm
> >> inclined to take this patch as a part of this series and live for a while
> >> with a duplicated commit in linux-next. Once this patch would be in
> >> mm-stable we can rebase kho-scratch work on top of mm-stable and hopefully
> >> there will be enough time for it to live in linux-next so that Linus won't
> >> get angry at us :) 
> >> 
> >> How does that sound to you?
> > 
> > That's fine - let me know what you choose to do and I'll adapt to it.
> > 
> > An unknown (to me) is whether Muchun's series "mm: Refactor bootmem
> > gigantic hugepage allocation, v4" still works with this patch removed.  Everything
> > applies OK for what that's worth.
> 
> Hi Andrew,
> 
> I'd like to confirm that this is a completely independent cleanup patch,
> so it can be merged on its own.

That's great, thanks for confirming!

Then I think the easiest would be to take "mm/mm_init: simplify
deferred_free_pages() migratetype init" via liveupdate tree.
 
-- 
Sincerely yours,
Mike.

