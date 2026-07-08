Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEE1C43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UlaCm1eMaE8ditGiuMnDuLYETT0AIKL8e3b4PiOGnmA=; b=vDziECi9dvXmRl8+6OOKRQOp/8
	LQb40snupneRPX0Tym0rlM3MVbhdPsXD+yHNoDHom3FsYlk5/O7X6HDqKqfyDJKnfoIKh+8GgzqCC
	lDEbkAz69Aknoh+p5dKa9x9tSgyIE/cRQDsCJ2shBbxPJcJ10uKJnTyEIJzn2X41Ls2SidSpXYUbo
	LM8HIX/INVdA0PepTIwU6ygwToMPu8QtBnPS2OoR8OR4RKpSCbhqjB2SrPLZuqOnuYlOgbKjFkqhM
	zjUk0L9js0cmMhR1gqOOI71yO7CD0xyc8rnTTW+vk11HrrvGe6/GGhTqVtvpCzRbnHw6Owgo5ke2Q
	J5Z6/LtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWAD-000000007Hu-1tQ3;
	Wed, 08 Jul 2026 17:34:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWAC-000000007Hm-1tje
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:34:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D65494139D;
	Wed,  8 Jul 2026 17:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A03E1F000E9;
	Wed,  8 Jul 2026 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532063;
	bh=UlaCm1eMaE8ditGiuMnDuLYETT0AIKL8e3b4PiOGnmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XicQy6A7R4AMUDvx3D2a/v3RwwR7yjOvvcXyM6rKqs71MtYBs6x72BnrlqujUNx/H
	 S1MBI0BZicZJTtSVN2U+M8NBii4KyomXpSHq9t2xJDlcF29mK0ZdhIqVPv2lDt/2Rp
	 ArUlW4cWaTpxhIgVUyf0xdA7mj1iBlUW3d/gItTVuJj5K0AAQTHjRQUbfF02Z07LNn
	 0gyab97QUfKitk/p0weyh+oNdEfBAJEWrg9swB0CMUYhRZ50JKTXMkxDgEN2gvx17R
	 /0kfVjA4VRKlYw+iH6dKRBSFmYqB/ZOHPO/5HNubcTfbF5p0vcQKOLLZBSJTroi5VC
	 xQj2/QaBexyrQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  David
 Matlack <dmatlack@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
In-Reply-To: <ak6DUC7NsIZ20RZD@google.com> (Pranjal Shrivastava's message of
	"Wed, 8 Jul 2026 17:05:20 +0000")
References: <20260703020832.1731864-1-praan@google.com>
	<2vxz7bn5mv0n.fsf@kernel.org> <ak57VeunO8qd4wEh@google.com>
	<ak6DUC7NsIZ20RZD@google.com>
Date: Wed, 08 Jul 2026 19:34:20 +0200
Message-ID: <2vxzy0fll71f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jul 08 2026, Pranjal Shrivastava wrote:

> On Wed, Jul 08, 2026 at 04:36:46PM +0000, Samiullah Khawaja wrote:
>> On Wed, Jul 08, 2026 at 04:11:04PM +0200, Pratyush Yadav wrote:
>> > On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
>> > 
>> 
>> [snip]
>> > > 
>> > > 3. kho_restore_page() applies the correct refcount pattern based on the
>> > >    preserved metadata.
>> > 
>> > Why do you need to save the type of pages in KHO metadata? For example,
>> > for pages or folios, we don't store any type information and leave it to
>> > the caller choose the right API. So reserve-mem and kho vmalloc need
>> > pages, they can call kho_{preserve,restore}_pages(), and memfd needs
>> > folios so it can call kho_{preserve,restore}_folio(). The radix tree
>> > itself does not hold the information. The caller knows what its memory
>> > is supposed to be so it calls the right restore API.
>> > 
>> > So why can't we add a kho_{preserve,restore}_page_multi() (pick a better
>> > name; we can argue about the naming later)? Then your driver knows it is
>> > restoring DMA buffers so it can call kho_restore_page_multi(), and KHO
>> > takes care of initializing the pages with the right refcounts.
>> > 
>> > You won't have to muck about with the ABI in that case.
>> 
>> +1
>> 
>> I think this makes sense. The mm already relies on the allocator to
>> track the type of pages it has and expectes it to use free_pages or
>> put_page() or free_page(), so it is natural for KHO to rely on the
>> caller to call the right restore API.
>> 
>> Lets add kho_preserve/restore_page_contig|_order|_nonsplit and the dma
>> preservation can use the appropriate one during restore.
>
> Ack. I like kho_restore_contig, I don't think we'll need a preserve for

Dunno, everything is contiguous, folio, 0-order pages, higher order
pages. So not exactly the best name.

Since you'd get these pages via alloc_pages, perhaps
kho_preserve_pages() works better for this kind of allocation, and for
the _current_ kho_preserve_pages(), we can rename it to
kho_preserve_split_pages()? It is a bit too wordy though, so that's a
downside.

Mike, you are better than me at naming things, so do you perhaps have
any better ideas? :-)

> this though? Preserve doesn't seem to be preserving refcounts, I guess
> we could rely on kho_preserve_pages and the caller can use
> kho_restore_pages_contig() to set refcount correctly for unsplit pages?

No, kho_preserve_pages() can split the preservations in unexpected ways.
While for a high order pages the current algorithm _shouldn't_ do it, it
is simpler to just add a new preservation function.

Move things out into helpers if you want to avoid duplication, though at
first glance I don't think there should be much.

-- 
Regards,
Pratyush Yadav

