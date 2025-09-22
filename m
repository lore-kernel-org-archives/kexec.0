Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC45CA100F
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 21:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0gCwGlZ8CY2A3FXzOeVy9OeKGn7L/VR3P2r+tlBERUc=; b=TIvYVOEbGMNbclvb5SHYNXmx0i
	KTjREzu/I5gvkC3r0ZsbkaKoKwNfqBzBAax96OjuBE5htLIfA5Dn5tO5L6iezD3HGbsQoTwvgBw01
	dDGniPaS6wuC7obMk3x5hQaCbcB05gin67NnAwbBVw9a7ubCyF6F4GVBRKjNiuF4Pyslh2NwuYLex
	jwPRF2MUGODoTnUYPBAYi/nKc2l5cH6kGrMCCllKk6ErENxp9uBtUhv4nTUCBnDEWIrX8pideC/A+
	w0TelYRgnsXnaCQ03IsHDGP3CU4gI6U6q+/kdt8c7Z7R4hzDSe0gGrOQK2UIyOCtlGuyhdX/go8xA
	wn+NpB0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0o08-0000000BYfl-0Wwp;
	Mon, 22 Sep 2025 21:23:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0o06-0000000BYec-1eMq
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 21:23:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8700D60257;
	Mon, 22 Sep 2025 21:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CE3C4CEF5;
	Mon, 22 Sep 2025 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758576189;
	bh=YIJZv7/h0GsyGJwWQh9Ro75daSezB/fib8mlDVLM5SY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ua5mBLSK2YXIEzSHlfOiL2ItM6FhaYpUTjODNC6xqEN+/kHfZMXMNfTrT4x9TXaZG
	 sJoR09urv+5Xy+T7xdnecDXvmczqPRKIYIJ77DgTz05TKWSSgIduHFMkfFu3wvgtcL
	 79YTB5bYcJ0ezc1l8FuqQe8Y9kGlPPShW0rwlPdU=
Date: Mon, 22 Sep 2025 14:23:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, Chris
 Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Pratyush Yadav
 <pratyush@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250922142308.144ac7bd7bbcb9f5a68ac3a1@linux-foundation.org>
In-Reply-To: <CA+CK2bDFScwAwyKA2NNkQhvhrj5OsmHm4eTshw2B9e2muqBcvg@mail.gmail.com>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<CA+CK2bDFScwAwyKA2NNkQhvhrj5OsmHm4eTshw2B9e2muqBcvg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 22 Sep 2025 10:17:56 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> > +struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
> > +{
> > +       const unsigned long start_pfn = PHYS_PFN(phys);
> > +       const unsigned long end_pfn = start_pfn + nr_pages;
> > +       unsigned long pfn = start_pfn;
> > +
> > +       while (pfn < end_pfn) {
> > +               const unsigned int order =
> > +                       min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> > +               struct page *page = kho_restore_page(PFN_PHYS(pfn));
> 
> This line breaks linux-next build because, kho_restore_page has a prototype:
> void kho_restore_page(struct page *page, unsigned int order).

Thanks.  I think that's all fixed up in mm.git's current mm-nonmm-unstable branch.

