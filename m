Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A70CCF9F8
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 01:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:To:From:
	Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L9ajnhOoxDRiGFYl3wuL64nz1f19StQBd281qP65M3o=; b=AgfLwPvrMHJk7w338va/GpGvlc
	YRoM5du4OmE3TA3iQETIQztHysCfFpoWmP5u4E/XXKVgOr5BxFLf9viPW0giDPoH1GEqtDk4ZHnSg
	HWBvAXVXX2Sz7Mawt3BFtLqPvW6N7M7m6fmX/5NHiGepNpP/cwcVVZc3X5owRlTUZcUutJbVqHiUg
	G25sLJJ31X7VEkZ+SuFjhTz6X6aconn5S5rzu7VGPSrXTRBhqPAwX4v5cZgEoY+8v2k5pWTwlX5B3
	qo9A+/TDmsonmYnGY59LTPPk8vvMiUIrLPJJ+gkpvNTsD+ybmrTtULvv0xZ+TVaYtxqrRMUxE28bg
	n792qzrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5lc-0000000AtNQ-0lo9;
	Tue, 04 Nov 2025 01:23:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5la-0000000AtMw-35yp
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 01:23:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F0AC641876;
	Tue,  4 Nov 2025 01:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926DEC4CEE7;
	Tue,  4 Nov 2025 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762219401;
	bh=O+EbnOruKhiIrqCFK8PK7/fd3bCIQqLDIo8Gmu5gXD8=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=EdgYUvAYaqJ4iE8rYLjZnK2QIlkPprTnCr88K3m1l6ewi6mUMHyNC3jl/5qjpCZmJ
	 rSlcoRH1V4Ijowsw6+XnYbz7c/pJXq2Yz/Xu0h3elPEQtBgNAfiYr7X3LN5LDSum1g
	 wpRnmKi1RJbzz7C859LT39PqK9okofTjRhUCsP3w=
Date: Mon, 3 Nov 2025 17:23:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>, Baoquan He <bhe@redhat.com>,
 Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kho: misc fixes
Message-Id: <20251103172321.689294e48c2fae795e114ce6@linux-foundation.org>
In-Reply-To: <20251103162020.ac696dbc695f9341e7a267f7@linux-foundation.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
	<20251103162020.ac696dbc695f9341e7a267f7@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_172322_813705_BC6207E0 
X-CRM114-Status: GOOD (  19.29  )
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

On Mon, 3 Nov 2025 16:20:20 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon,  3 Nov 2025 19:02:30 +0100 Pratyush Yadav <pratyush@kernel.org> wrote:
> 
> > This series has a couple of misc fixes for KHO I discovered during code
> > review and testing.
> > 
> > The series is based on top of [0] which has another fix for the function
> > touched by patch 1. I spotted these two after sending the patch. If that
> > one needs a reroll, I can combine the three into a series.
> >
> 
> Things appear to be misordered here.
> 
> [1/2] "kho: fix unpreservation of higher-order vmalloc preservations"
> 	fixes a667300bd53f2, so it's wanted in 6.18-rcX
> 
> [2/2] "kho: warn and exit when unpreserved page wasn't preserved"
> 	fixes fc33e4b44b271, so it's wanted in 6.16+
> 
> So can we please have [2/2] as a standalone fix against latest -linus,
> with a cc:stable?
> 
> And then [1/2] as a standalone fix against latest -linus without a
> cc:stable.
> 

OK, I think I figured it out.

In mm-hotfixes-unstable I have

kho-fix-out-of-bounds-access-of-vmalloc-chunk.patch
kho-fix-unpreservation-of-higher-order-vmalloc-preservations.patch
kho-warn-and-exit-when-unpreserved-page-wasnt-preserved.patch

The first two are applicable to 6.18-rcX and the third is applicable to
6.18-rcX, with a cc:stable for backporting.


