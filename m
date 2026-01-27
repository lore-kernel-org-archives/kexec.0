Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B438FD25958
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8SgAV9h1Zn5PVX1BsKjC6XEOwdgXQQ1A2jF1T2bUkU=; b=UymJGuFepmxOscBFgU7DCOU6w6
	SE+2LVnxa+R5QWobEvsan37kpj6jBPgjA0LUsu/uaK34XheEOCO7VcO6lMdbo+aTmgi5NUNmN9NXC
	KBC6tF625Yb95Pio9dDQG+zwlW+3iG9ynvK7Z2x9cpa3Z2YMyZ378D7SzuF4jPgMUy/J543plmULH
	UcC7tY6bAAXoOYDKu5hez9PS6n4oBWQPEgn4t8UaHGuImb0L6l1dX1CEsU5ZXtsKpJnvpjKAyUde4
	mwMI14VaHt1AdrNLTWyv/sZafyxohpSji6Kjh0NOsvTyiijtGwlkFJLew9M39DBsL1an+xGUUPXsO
	pnRPwvdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdRp-0000000DmIM-0XMn;
	Tue, 27 Jan 2026 07:25:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdRm-0000000DmHw-1lMp
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 07:25:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BADC2400F1;
	Tue, 27 Jan 2026 07:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF86C116C6;
	Tue, 27 Jan 2026 07:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769498709;
	bh=NM/XyGcuu3oC40AjWHvNWgcayap1TyIPrLlqNMwrM1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwHlpVjAUt4dHIEIKRYYNtICbchdIO4PS4BHoBalmKmLFKuaBGTgx0x57HuhDNT03
	 QJZP41o3Q0bN1Wla3i3pM/m16YT6ZP3gPIubbAakGqvBDIrbRRYKpMcAcIifJeEH4t
	 ce9W9LgL69U2JPtrQHEPwjtZ+FY13GlL98uHYUW4vm5b+rTsBM+YWfGXNlCQLGOavc
	 ae2wD7gP2t2o+NnORLMcHB1+aeatGIjHuGRLba+fppZAAlBPPeTVgecBh7R9DUYFki
	 iacaQc++NTBBkdWDmFfN8Geel4YHv1vxCzF1d6E9eADcVmoJmaKJlC+zr3NY77bluZ
	 sehFo4vHlyz3Q==
Date: Tue, 27 Jan 2026 09:25:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com,
	riel@surriel.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v5 1/4] kho: add size parameter to kho_add_subtree()
Message-ID: <aXhoTWqxIGNglgdV@kernel.org>
References: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
 <20260126-kho-v5-1-7cd0f69ab204@debian.org>
 <aXhn8ieKtj3T3FCc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXhn8ieKtj3T3FCc@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_232510_520481_42112D89 
X-CRM114-Status: GOOD (  24.37  )
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

On Tue, Jan 27, 2026 at 09:23:38AM +0200, Mike Rapoport wrote:
> On Mon, Jan 26, 2026 at 08:07:23AM -0800, Breno Leitao wrote:
> > kho_add_subtree() assumes the fdt argument is always an FDT and calls
> > fdt_totalsize() on it in the debugfs code path. This assumption will
> > break if a caller passes arbitrary data instead of an FDT.
> > 
> > When CONFIG_KEXEC_HANDOVER_DEBUGFS is enabled, kho_debugfs_fdt_add()
> > calls __kho_debugfs_fdt_add(), which executes:
> > 
> >     f->wrapper.size = fdt_totalsize(fdt);
> > 
> > Fix this by adding an explicit size parameter to kho_add_subtree() so
> > callers specify the blob size. This allows subtrees to contain
> > arbitrary data formats, not just FDTs. Update all callers:
> > 
> >   - memblock.c: use fdt_totalsize(fdt)
> >   - luo_core.c: use fdt_totalsize(fdt_out)
> >   - test_kho.c: use fdt_totalsize()
> >   - kexec_handover.c (root fdt): use fdt_totalsize(kho_out.fdt)
> > 
> > Also update kho_in_debugfs_init() to compute sizes using fdt_totalsize()
> > for the root and sub-FDTs it processes, since these are known to be
> > actual FDT blobs.
> > 
> > Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> > ---
> >  include/linux/kexec_handover.h              |  4 ++--
> >  kernel/liveupdate/kexec_handover.c          |  8 +++++---
> >  kernel/liveupdate/kexec_handover_debugfs.c  | 15 +++++++++------
> >  kernel/liveupdate/kexec_handover_internal.h |  5 +++--
> >  kernel/liveupdate/luo_core.c                |  3 ++-
> >  lib/test_kho.c                              |  3 ++-
> >  mm/memblock.c                               |  2 +-
> >  7 files changed, 24 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> > index ac4129d1d7416..abb1d324f42d0 100644
> > --- a/include/linux/kexec_handover.h
> > +++ b/include/linux/kexec_handover.h
> > @@ -32,7 +32,7 @@ void kho_restore_free(void *mem);
> >  struct folio *kho_restore_folio(phys_addr_t phys);
> >  struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
> >  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> > -int kho_add_subtree(const char *name, void *fdt);
> > +int kho_add_subtree(const char *name, void *fdt, size_t size);
> 
> I'd rename 'void *fdt' to 'void *blob' to make it clearer that subtree isn't
> necessary an FDT.

Scratch that, I didn't look at the second patch :)

> And s/fdt/blob/ in debugfs function names.
> All this could be a separate cleanup.
> 
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Sincerely yours,
Mike.

