Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04063C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NIRIMIqxIBRoAUi+TzoRrEIZ+kOeLqxW4VMnYG6vpJM=; b=emIUQlpY9kYlHPJltk6EB2biQU
	iEGrFDV2m1W2Q2HzQMkpLc/IA30OsK2/UUEMxAQm3ULvk4ELpYXX2O7Xhk0fVSasDtI8TU+piy1qM
	5Tze4P2GyqJE2wA/Rp0hZ7FD2mLGOSNAkP4SJmw1dmakAzaY1Dwb7S/8CabUIUdv44Q3ZU85KxuOk
	ZKTRHUYJl8A01t6UXYbmbC7oc/M1Dy2NmpqThe5myrcsy5iGAeBIF48EgPIhh4Q+zbkflyahnKzKS
	EJQ5zEJEI91KV6r8u4Rn75X6FK4eD20prXJt/qTyi66w5rOq+bfjMQMVlwXadje86WSo+I1Kh+oBJ
	zNRkZCQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmUO-000000024Ch-21K8;
	Thu, 09 Jul 2026 11:00:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmUN-000000024CF-2tid
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 11:00:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 240F143306;
	Thu,  9 Jul 2026 11:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC70A1F000E9;
	Thu,  9 Jul 2026 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783594819;
	bh=NIRIMIqxIBRoAUi+TzoRrEIZ+kOeLqxW4VMnYG6vpJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RBlISwJqs2YqVKjGBoJ3mmQ4DaRDwrSPoF5W++7Hzrwz4c13bMoEWcxdhWoeVT7Yn
	 wuvE3qGGNmmSzcahSfSZeYHBWnbbUphVhHmbvytp8lDwWCrSqk0xnGIcJGrkZJRA3I
	 JzJDfQHyR2LnfUZK5V9n8R6BBkMe7pvyS+K6CugynwiPHMGFbXJhiDKhZIRLZe+zLA
	 p2fnpOH/iA/NEFOMM2SmUCg0jcfiFfK7H72NUeQB3Au8Gxgk/g+xEwGeeR1wbSVzvs
	 XPY2Brh9V6mMDNLIk2/COjzXz6r6MN7t/L5EGQfmpH6+7qp7EIcHKnIBr56/qCK1Xb
	 EGb+J2DdZHURA==
Date: Thu, 9 Jul 2026 14:00:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak9_PDCQjNWHWCyT@kernel.org>
References: <20260703020832.1731864-1-praan@google.com>
 <2vxz7bn5mv0n.fsf@kernel.org>
 <ak57VeunO8qd4wEh@google.com>
 <ak6DUC7NsIZ20RZD@google.com>
 <2vxzy0fll71f.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzy0fll71f.fsf@kernel.org>
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

On Wed, Jul 08, 2026 at 07:34:20PM +0200, Pratyush Yadav wrote:
> On Wed, Jul 08 2026, Pranjal Shrivastava wrote:
> > On Wed, Jul 08, 2026 at 04:36:46PM +0000, Samiullah Khawaja wrote:
> >> 
> >> I think this makes sense. The mm already relies on the allocator to
> >> track the type of pages it has and expectes it to use free_pages or
> >> put_page() or free_page(), so it is natural for KHO to rely on the
> >> caller to call the right restore API.
> >> 
> >> Lets add kho_preserve/restore_page_contig|_order|_nonsplit and the dma
> >> preservation can use the appropriate one during restore.
> >
> > Ack. I like kho_restore_contig, I don't think we'll need a preserve for
> 
> Dunno, everything is contiguous, folio, 0-order pages, higher order
> pages. So not exactly the best name.
> 
> Since you'd get these pages via alloc_pages, perhaps
> kho_preserve_pages() works better for this kind of allocation, and for
> the _current_ kho_preserve_pages(), we can rename it to
> kho_preserve_split_pages()? It is a bit too wordy though, so that's a
> downside.
> 
> Mike, you are better than me at naming things, so do you perhaps have
> any better ideas? :-)

Thank you for the compliment, but I'm drawing blank on this one :)

The best I could come up with is to kho_preserve_page_range() for order-0
pages.
 
> > this though? Preserve doesn't seem to be preserving refcounts, I guess
> > we could rely on kho_preserve_pages and the caller can use
> > kho_restore_pages_contig() to set refcount correctly for unsplit pages?
> 
> No, kho_preserve_pages() can split the preservations in unexpected ways.
> While for a high order pages the current algorithm _shouldn't_ do it, it
> is simpler to just add a new preservation function.
> 
> Move things out into helpers if you want to avoid duplication, though at
> first glance I don't think there should be much.

Right, preserving compound pages is more similar to preserving folios
actually.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

