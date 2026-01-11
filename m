Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB6ED2502F
	for <kexec@archiver.kernel.org>; Sun, 11 Jan 2026 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29aQ501ejql1AKGWkAKWOMmDDfQPHcgIHX+O5IkPtmg=; b=uv0/xSX78OzczbEt5bKBSJeThi
	zmGFRzWyI4hcdkZtQD61N7yFlOH8MjF3ssZ8uKk0nly4EqUfpZt5P4EdW9/s8G6tz8nKT16ynfDMf
	rO/aNQHL9YDybkG1JmoYCoTrOZyXzrELzFnaMIpqiusNxsfHELXrHkBteNOdHK6KpzWoeJL6ogG8k
	gU4gqG0bup+0J6MHEAZN9zLmXs0rKPaJbMOjNVw0PLr1YqkdD4FmsaUxgGtjJZwI6WKTWxAIZG1JT
	sRUGGDoEumPMT495ScSysZ+x88B9yIBBBOsvgphG8loRuBrnKd8rpJ5+vKKp/iRrjLFQMZX1tgYAH
	Ad3SK+Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1verUG-000000043Kw-3vlX;
	Sun, 11 Jan 2026 09:11:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1verUF-000000043KP-1c3b
	for kexec@lists.infradead.org;
	Sun, 11 Jan 2026 09:11:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 71DED60010;
	Sun, 11 Jan 2026 09:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD5DC4CEF7;
	Sun, 11 Jan 2026 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768122709;
	bh=uZsS9eMgw1qIS04QngwB711PIkKR14sDba+wAXFooJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBx97/xKW55BHFhSVToAhSY74nwEwwCtS78dADYRniDyX4CCS+3en/HYGMkyrXmoV
	 /AuPJB3Y2UD40BzYuaBuU1jtdVgm9eTzkA5RElTPjcTOCpNVq5sSYYp6Dk99gditdt
	 3M6U8KdpHXpkSSryv8WSVPFLVJFtZPDmWbsJm+2MyeoVvwSUP5+yJHQyvE+DvBLKCR
	 hIUoLfNEZvCsRTUjPlIeBfo3bK/hQ0ujKZrqXZe+/+BLDgjSa23ix6CXF1Jw0Wl2gc
	 5alBnwzzdT2yyhiSc2/ET4a+K+T/6OUo2CHG7R++XQrj1+wOBneVJ8fdWC/d1VSHRz
	 62nNZ6eZ6EuzQ==
Date: Sun, 11 Jan 2026 11:11:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ranxiaokai627@163.com, graf@amazon.com, pasha.tatashin@soleen.com,
	pratyush@kernel.org, surenb@google.com, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn
Subject: Re: [PATCH] kho: init alloc tags when restoring pages from reserved
 memory
Message-ID: <aWNpTnZKfjb6yLHp@kernel.org>
References: <20260109104251.157767-1-ranxiaokai627@163.com>
 <20260110162843.ecd8e731bdc281f4cd8e4764@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110162843.ecd8e731bdc281f4cd8e4764@linux-foundation.org>
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

On Sat, Jan 10, 2026 at 04:28:43PM -0800, Andrew Morton wrote:
> On Fri,  9 Jan 2026 10:42:51 +0000 ranxiaokai627@163.com wrote:
> 
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > Memblock pages (including reserved memory) should have their allocation
> > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> > released to the page allocator. When kho restores pages through
> > kho_restore_page(), missing this call causes mismatched
> > allocation/deallocation tracking and warning message:
> > alloc_tag was not set.
> > 
> > Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> > fix this.
> 
> Great, thanks.
> 
> It would be helpful to quote that warning message in the patch
> changelog, please.
> 
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
> >  	else
> >  		kho_init_pages(page, nr_pages);
> >  
> > +	clear_page_tag_ref(page);
> >  	adjust_managed_page_count(page, nr_pages);
> >  	return page;
> >  }
> 
> Warning splats are pretty bad and it's desirable to fix this in
> previous kernel versions.
> 
> To do that it's best for us to identify which kernel version(s) should
> be patched, via a Fixes: tag in the changelog.
> 
> From a quick look, it appears that Pratyush's 12b9a2c05d1b ("kho:
> initialize tail pages for higher order folios properly") is a suitable
> anchor, what do people think?

I think it should be even earlier:
fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
 
> Meanwhile I'll queue this up for some testing while awaiting maintainer
> feedback.

-- 
Sincerely yours,
Mike.

