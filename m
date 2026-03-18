Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD5FF6E9F
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d+xpX7UOEumMkTqUmEa6ChXvEP47aGRBEA4u/Yiw3Ao=; b=PTWyxTKpBIOMFJiSnnQmprFZ2s
	ICQdCoXuBWA057JEeDVLFClwSqxOJYHfPSiDkBs2bplnlaaEbbUa9dpdIvRqnUzmGNLNyPN9qR/e0
	SfEZkR8ba6e//h1GRQ/ASixJKZulOlUYq9Mugf33yFXtsMNaPAlqffdHyhVAOFS7sq17yhJTs9csb
	cBlnHLAOs/LLSuWZ/iJQ6P9kxo8SJQ5QH5VYKjOXqDWEflb4IfRQXHrwwF/IQ0P4NEh+o1ptw58Ij
	J0Vejs/6U0lD/Do9n5SfclQQ62qbal1uyuWecqxKKkiedp4jJpKcrrBGqiPySo+nH0URUB2CORB3E
	8D3/ikyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2eSf-00000007Tvu-264h;
	Wed, 18 Mar 2026 00:08:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2eSe-00000007Tvj-2Rj8
	for kexec@bombadil.infradead.org;
	Wed, 18 Mar 2026 00:08:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=d+xpX7UOEumMkTqUmEa6ChXvEP47aGRBEA4u/Yiw3Ao=; b=COQmdONRP1bJV1e6iezfu2CLn7
	RefVdBO8l363OD3ZWhEWwzcqrPJwhShrBjgFIlt8LKdPUKhAOa5wrDjB2pMPWdZrNafiQBfhepfH7
	2tjyCKhVBT3psVoG+6QSVCtaVvfy8t/JHYy8GENId4xXiF2LncPibUnfc4iDC5VFdnTThIV8Fjelp
	5l3dvjWmwmu5qN4ykl1s3IZ43PtzR1PdZ+K62sccWKfPk04Od0jnZ82DA7nzCnwIlPIa54rQuiRWZ
	k+Hh31hHEYoH6595j/1M8hVbASBQkVPDPV23GOqA9ELix1Y/JAnCDIwP3jAjP5jhbsaPLTnD6UDxM
	Nt0mXBfA==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2eSb-0000000ABVX-12Xa
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 00:08:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D65A4458E;
	Wed, 18 Mar 2026 00:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA32C2BCB9;
	Wed, 18 Mar 2026 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773792505;
	bh=djFFpPUmzZrEXSAwoP2fU6PeHYBExiHv5Hefbxl+VZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B14gM2NxXwWc8lTi/b7HajGaiaT/Kpvsy4hzPBngZCRuYZGmqrtNkE74SQ8/y0XaV
	 ZWn2u6THSdbxgZtuKKYVyN2PK+bt1wqzTM0pxkv76Gcd72zrA4uwjuYlKSWVKFbTeA
	 R9T3Ks8VnKUWxU94ImqCIHmoNzTdV3U1NjFD1t6tSpnB0VT1KzOnHkQdyqbw8bR8dM
	 Mg6/5P3f9rAfK9/Sl4dbzC/PhS5767pQOy5dDvUjLoMtfSbk/RexC6+L7AKTL/pX6+
	 gQj4CJE9KR+UH9Dsg/FeYVoZgblq7NyzcYXSLXXvgpRpAAyCGtJC/f7xC9HjxAnvVH
	 5N11YHhEIkfgA==
From: SeongJae Park <sj@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Michal Clapinski <mclapinski@google.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
Date: Tue, 17 Mar 2026 17:08:15 -0700
Message-ID: <20260318000817.130248-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <abniW3D8wbGQcB5T@fedora>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_000829_697222_FBACE800 
X-CRM114-Status: GOOD (  27.52  )
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

On Tue, 17 Mar 2026 16:23:07 -0700 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> On Tue, Mar 17, 2026 at 03:15:33PM +0100, Michal Clapinski wrote:
> > Currently, if DEFERRED is enabled, kho_release_scratch will initialize
> > the struct pages and set migratetype of kho scratch. Unless the whole
> > scratch fit below first_deferred_pfn, some of that will be overwritten
> > either by deferred_init_pages or memmap_init_reserved_pages.
> > 
> > To fix it, I modified kho_release_scratch to only set the migratetype
> > on already initialized pages. Then, modified init_pageblock_migratetype
> > to set the migratetype to CMA if the page is located inside scratch.
> > 
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index ee81f5c67c18..5ca078dde61d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/cacheinfo.h>
> >  #include <linux/pgalloc_tag.h>
> >  #include <linux/mmzone_lock.h>
> > +#include <linux/kexec_handover.h>
> >  #include <asm/div64.h>
> >  #include "internal.h"
> >  #include "shuffle.h"
> > @@ -549,6 +550,12 @@ void __meminit init_pageblock_migratetype(struct page *page,
> >  		     migratetype < MIGRATE_PCPTYPES))
> >  		migratetype = MIGRATE_UNMOVABLE;
> >  
> > +	/*
> > +	 * Mark KHO scratch as CMA so no unmovable allocations are made there.
> > +	 */
> > +	if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)))
> > +		migratetype = MIGRATE_CMA;
> > +
> >  	flags = migratetype;
> >  
> >  #ifdef CONFIG_MEMORY_ISOLATION
> 
> I've just tried to build the current mm-new tree. I'm getting this
> error:
> 
>  error: ‘MIGRATE_CMA’ undeclared (first use in this function); did you mean ‘MIGRATE_SYNC’?
>   557 |                 migratetype = MIGRATE_CMA;
>       |                               ^~~~~~~~~~~
>       |                               MIGRATE_SYNC
> 
> >From what I can tell, MIGRATE_CMA is only defined if CONFIG_CMA is
> enabled (for x86 defconfig its disabled).

I also got the same issue, and was about to report.  I added below workaround
patch to my test setup.  It is just a temporal quick fix for only my setup.
Michal or others may find a better fix.

=== >8 ===
From 9d89a12e1a17edd68750e97b0c8b1970e3adc648 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Tue, 17 Mar 2026 16:56:17 -0700
Subject: [PATCH] mm/page_alloc: enclose kho-specific code with
 CONFIG_KEXEC_HANDOVER

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5ca078dde61d6..ed4d585f46202 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -550,11 +550,13 @@ void __meminit init_pageblock_migratetype(struct page *page,
 		     migratetype < MIGRATE_PCPTYPES))
 		migratetype = MIGRATE_UNMOVABLE;
 
+#ifdef CONFIG_KEXEC_HANDOVER
 	/*
 	 * Mark KHO scratch as CMA so no unmovable allocations are made there.
 	 */
 	if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)))
 		migratetype = MIGRATE_CMA;
+#endif
 
 	flags = migratetype;
 
-- 
2.47.3


