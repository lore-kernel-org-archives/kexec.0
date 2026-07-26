Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2D3C531CC
	for <kexec@archiver.kernel.org>; Sun, 26 Jul 2026 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fDOZqeNkjdo8vMXioiDYc0luD1S039f5+FXxpDb5Kvw=; b=z82DKi38xRnIOKWJM9OQJLz7Vt
	LNS+1Cyoy+NbXbT6H0zqzpt5nrlb9f9mITVOWaFpoAnntBC2sIYwuO/iqE60YkTq19Av7hgTV0yTD
	yRVRjlFQA6kqd5+0UoG71irBnZ2WYP3yovcBaVt7UOjlEj3I1rF5Nw3r5uNu3zDJ4HNUXYzKfzxFd
	0G99vES40ghhvPARJFGAlhrrf0/SMQHGr5Pv8zeDZGvl+qHhRiR3Zf0/CYl7aAMUH6BSlyZ1GXeNS
	Xp2ODXVJnLpC0ziuR+KXwXIBIaUj4mXLwz+cZkR4LHTNAKix/Gdscz8HLCdZArvSLbbG+GKam3VPE
	3pAbMyhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnvut-0000000146C-1lL2;
	Sun, 26 Jul 2026 10:17:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnvur-00000001460-3qga
	for kexec@lists.infradead.org;
	Sun, 26 Jul 2026 10:17:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1807D60008;
	Sun, 26 Jul 2026 10:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2021F000E9;
	Sun, 26 Jul 2026 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785061022;
	bh=fDOZqeNkjdo8vMXioiDYc0luD1S039f5+FXxpDb5Kvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dD/Bqvr0rOFvGdTmwOnN0Ba4hfE/9xY+Vx68zJZG+goUce76b2AtfJplLuD4ANVTB
	 l53gHeJbKkexYtCpJ7KXg+EU/Y6Ugu3N2wqeofwkp/JWJbQXMo1/dwOvYjQXMo79yZ
	 CuvRYHaZ2DW24R7jpNNn0dicF3QlBpRkc9jgQoLQRXI/+M4Js2ZPVDRdtEygN1+LDo
	 eNBh5lU21E+LC5PCdYTicTNkDL5K+ARoo9DkLeWPVahC8ldzw0bzvkmuq2Y71XoB4C
	 vDKKcp572kgzzODVlqYz7gYPoXpvwkGPA8grfevTZ+reVV8DQYI4T8wOkuPzFC3uRT
	 glCZUmU4Kr8rw==
Date: Sun, 26 Jul 2026 13:16:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4 16/21] mm/mm_init: simplify deferred_free_pages()
 migratetype init
Message-ID: <amXelr2DcRRyZDY4@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
 <20260725172133.4018491-17-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725172133.4018491-17-pratyush@kernel.org>
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

On Sat, Jul 25, 2026 at 07:21:16PM +0200, Pratyush Yadav wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> deferred_free_pages() open-codes two loops to initialize the pageblock
> migratetype for a range of pages.
> 
> Replace them with pageblock_migratetype_init_range() to remove the
> duplication and make the code clearer (Note that deferred_free_pages() may
> be called from atomic context).
> 
> Link: https://lore.kernel.org/20260612035903.2468601-6-songmuchun@bytedance.com
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> 
> Notes:
>     This patch is taken from Muchun's series [0]. The patch as of today is
>     in mm-unstable.

@Andrew,

It looks like it'll take some time for this patch to get into mm-stable so
we can't base this work on a branch in the mm tree :(

I'd like to expose the KHO scratch extension to linux-next ASAP so I'm
inclined to take this patch as a part of this series and live for a while
with a duplicated commit in linux-next. Once this patch would be in
mm-stable we can rebase kho-scratch work on top of mm-stable and hopefully
there will be enough time for it to live in linux-next so that Linus won't
get angry at us :) 

How does that sound to you?
     
>     [0] https://lore.kernel.org/linux-mm/20260612035903.2468601-6-songmuchun@bytedance.com/
> 
>  mm/mm_init.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

-- 
Sincerely yours,
Mike.

