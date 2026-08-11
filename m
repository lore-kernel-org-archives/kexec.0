Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97437C5CFCF
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=peLTNi99sZ2H7Vza/JehbVMvGp+dy+fil6mDbDYjoZg=; b=QNU5OLd+iu6CtBx8fWK1znI0fz
	7sGCAgRuhes5kn0xJpCqLVCmCLsZCdJT77MeblPqXbglllXLJti5a8zRNOeRtqxFGdtoGDTuYTku6
	SAsEA7aY1b9cGDZQ+I/tEf40HGMpm53fU+s1R9giOQT4CudYTRj7UTcUE5uOqp5aazhdNXVptqghY
	xZJO/+PbUgE3372nn3uoIrLTMPSMJ+Wk8c/tAt2iYWIdYgwITwbGvE3eD1hUtrr29l4syyKDaF5Pr
	DTbJZMQKr52VVkaGwibyorGyg64Xe+6eSb9g1QGxCcz8VaPfNBf+BV5bfOOZUV0L9snuz1YpFJkaM
	mHRrex+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtnMb-0000000ECoZ-3N8C;
	Tue, 11 Aug 2026 14:21:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtnMa-0000000ECnt-1o1i
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 14:21:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 88321600C3;
	Tue, 11 Aug 2026 14:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554BE1F00A3D;
	Tue, 11 Aug 2026 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458114;
	bh=peLTNi99sZ2H7Vza/JehbVMvGp+dy+fil6mDbDYjoZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YPCtKJ/zhCkCva4zFXUg9jO0YrPFvEl3WZ35EO9gz/4m+jyCREP52lFOEZrhmVmVk
	 q9OfJLHxHqUsjDq2iSwSN3HjUTEJRNhQoDlrVifRm/ann37gbHQdF/4wz9DsdKHjvP
	 ZJ6uHvmsXixubav2aJNC6A2MkcNMMtF3FevXqxqA1wqLoqxr3+IFZgwVn52lHIZkpL
	 zXwj6RvKGMr94+Afzh6G5wQSGR7JlfOP+n2BXpVuwphQpzxrDGftS46MCMjpSCZh3Q
	 SGbkmSwbLnjhckbn2ndILydF5mh0Av9eFOl//RFKqmT99VQekhyFRvTxciQYdjEhcr
	 08P8quJLKeRmQ==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.ams.internal (Postfix) with ESMTP id E701D1980047;
	Tue, 11 Aug 2026 10:21:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 11 Aug 2026 10:21:52 -0400
X-ME-Sender: <xms:_C97ap8d0FoZkFK0U8B_jPUlI25CNWm_y8ZbhejD4KGHL8C0CmxzGQ>
    <xme:_C97avy5oSXUCjPbMMT4DF6qHAv4BUid2Fl6ZWfUy-6WZ9qIyP8EE7Qjm0XcFPGii
    kgqheceZtwy7DwXG94BzEpeKG_I56iSjGVsJ5aclGpRszlBCnfnjk4>
X-ME-Received: <xmr:_C97alKeGcjrQDl3nk9jA7wZ2kgu-INHs-aeYF0DZSrfv8txGmnRMv0Pob8>
X-ME-Proxy-Cause: dmFkZTEF+xcj27Q+X7YiPbPh0zXmZ9K4g7JaWjhfenTktvgKuXBjdkYrtDhTVEfZp35l3O
    Ci1dFFfWSdoRvqSIMzAH3oul02hDp/yFssBrCleZyfCcMMJ7bABwPVnJTTsrQdiD3SYYrF
    ZgkYBReBlR0Jqo2nbAIUMgtdUcb66G1uaxfctkfRihIcNFyrtTNi4iyFMVLzXAdFir9AfH
    txxbhKcaVGmzkR70G/VWfO2i1xKH+IEVFz1/1J8SGfHsB0eej5ky4FcvMVrtKFljmAHtau
    sCfeEiDCS31F8DXg5RVacCP7VEf8zwTAdDxddoNko/n0H+j0G0wuhddNVvVFdlkKrDe9d2
    yaJTVcmZCsY5LWhbjEM73hg0/3Vkx3DxgaBNT7inqhday9p195l2w9Ja7xVzGEx3cMIjzG
    NQzSmzELkdrUvEkJ4khuqC9ClO3ImUbOpxMp+H3eFxcCA5rNQR3sqfzaWcFi/As17VnBr6
    6mMTThnUasH6RSgfFrbAkFES9iyL0e0l92/UqdkcmrqkX68Sas8tEDFSzVUNxlDApiGbSo
    a9zdkI+3dWc2qAXGpIBTG31pNxvJolZ8YcG8VVT+efMWtq4jUoGgpJYP9PNFA9w402v2EP
    61/b/g9nTcKTfKcTfQHltZnRUtUBBj3wg7KaroulzYdaukXjioIrB4oo1Y+A
X-ME-Proxy: <xmx:_C97aiaJk_Lkq5nrfzq9zS-lfKB70vRHyJW9p_mGL7KsOfN_RC08mw>
    <xmx:_C97aqzmI9RXOFCFxWcTFUiNLuWEOdpORxJa-WID88g9gawgJCXqkQ>
    <xmx:_C97apbBOzb2dGyqjYipUQKEd6LWEK4qFHIbBCvVViul9ZiOWd4VsQ>
    <xmx:_C97apzC5nXKXBhOHZnsSmEjTRZl3lLYzXYFzWBi7mRqTFp7d_TNvg>
    <xmx:_C97alGDC0UdErQKXjJCK9yiUoqAK5XdnOU2lDgSLDbo9wzdp2zwUXW2>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 10:21:47 -0400 (EDT)
Date: Tue, 11 Aug 2026 15:21:46 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v5] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <ansuaOyItxGTBlTl@thinkstation>
References: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
 <ann9Kcesyb4T9Z8b@kernel.org>
 <anr59P1ZCAuHxv6x@gmail.com>
 <anskyrEVUlnTVEgF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anskyrEVUlnTVEgF@kernel.org>
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

On Tue, Aug 11, 2026 at 04:34:02PM +0300, Mike Rapoport wrote:
> On Tue, Aug 11, 2026 at 04:17:41AM -0700, Breno Leitao wrote:
> > > > +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> > > > +
> > > > +		cond_resched();
> > > 
> > > cond_resched() for every pfn is too much, isn't it?
> > 
> > It is what the other pfn walkers do: the kpageflags read loop in
> > fs/proc/page.c and read_page_owner() in mm/page_owner.c both call it
> > once per pfn. 
> 
> I think it depends on the pfn walker, some of them cond_resched() once per
> "block"
>  
> > But I honestly don't have a strong opinion here, though, happy to batch
> > it if you prefer. Would this one look better?:
> > 
> > 	if (!(pfn % MAX_ORDER_NR_PAGES))
> > 		cond_resched();
> 
> Can't say I know the magic number here, but I think it's better to batch.

Hm. I thought cond_resched() deal with this internally, no?

We call it in pretty tight loops, like clear_contig_highpages() or
copy_folio_from_user().

I think adding external batching might be a bad move.

If calling cond_resched() often is a problem, something is wrong with
cond_resched().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

