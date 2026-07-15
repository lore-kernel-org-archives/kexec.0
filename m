Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562E9C44508
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 06:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XS3kbxCx44iZwLbc9BUE26Q+IAKNuquwzB8Yp7TaY1w=; b=yXNhmAXUo2Apd6Kz2mqcbhxwCw
	XrCq0H6QOJaODCRS9DgUB/QCZcesW6ckUQEtfZewcHV37QCnF5gaZAM+9b7/B9Cy3Xl8Ht2zqhxPB
	BzuGb0g1KtDRF7LyBdr9P1X+CQt4koFF66+vWnajosFcr1FTEbmuyH7cxS/BVUhWd8LdjgJpIHysO
	t4MlD1gO1++/ujaI7gmpHEFfdrUakO0Mx5cmI3FNhLOhFWxjz9A5Z1Id2Sn+IuIq+RUEgzGHiStyP
	0GcFri3nkuZ+GYudJ+6EFCVkrmdGWVVdfXBHPI2vH685GoaB7+47+8ccdmMvnI/TUKjYuaR8ytExc
	eInFoW2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtKk-0000000DvmU-3AgR;
	Wed, 15 Jul 2026 06:43:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtKi-0000000Dvm2-1pq7
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 06:43:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 009E643E9B;
	Wed, 15 Jul 2026 06:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64E91F000E9;
	Wed, 15 Jul 2026 06:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784097783;
	bh=XS3kbxCx44iZwLbc9BUE26Q+IAKNuquwzB8Yp7TaY1w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ARYV8KZdrzKV0yzTwW31iOu6eS7aj29k8+atE1dlCYs2UjOnt2wpUxT9B70J/JM/L
	 ju6ipGpUrfyockp5N5H+24pkdOYwl0mOcXzFaOTjnKanOSILqAjeqGbSZSCFbWOyIL
	 xNuN/II3wO5nVQ18lj7xDYA2FIVhFg5X9AR/JBNnptxCub2I53cEZDtaswDFoipzgW
	 Rz0RS1cD8fqQktazA2DiIgZlxB01obs65hagz/YFYM4af5fvfgiGWro2TjKiQBgWxz
	 maF/UARF5T2XXzG68d5bo3+mG+0b71fwBS1gQSDrnsMPtSLqgqwpO4AGjVUFBHiKw3
	 qNjoP1mcRA1IQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260714205111.2497151-1-mclapinski@google.com>
References: <20260714205111.2497151-1-mclapinski@google.com>
Date: Wed, 15 Jul 2026 09:42:57 +0300
Message-Id: <178409777790.255896.16691338963510282908.b4-review@b4>
X-Mailer: b4 0.16-dev
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

Hi Michal,

> I caught this crash:
> BUG: unable to handle page fault for address: ff19164fffff8328
> RIP: 0010:__free_one_page+0x1a1/0x6b0
> Call Trace:
>  <TASK>
>  [<ffffffff913208bf>] free_one_page+0xaf/0x240
>  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
>  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
>  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
>  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
>  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
>  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
>  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
>  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
>  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
>  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
>  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> deferred_init_memmap_chunk() works fine without KHO because free
> regions will never be neighbors. However, with KHO, free memory
> will be split into (free && scratch) and (free && !scratch).
> KHO scratch is aligned to CMA_MIN_ALIGNMENT_BYTES (which on my setup
> is equal to 1 << 9 pages) but buddy can look at the neighborhood of
> MAX_ORDER_NR_PAGES pages (which is equal to 1 << 10 pages).
> This sometimes crashes when one half of the neighborhood is being
> initialized but the other part is yet to be initialized.
> 
> To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.
> 
> Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferred struct page init")
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 4834a809985ab..50928aaa33710 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -38,6 +38,16 @@
>  #include "../kexec_internal.h"
>  #include "kexec_handover_internal.h"
>  
> +/*
> + * This is the minimal alignment required by deferred struct page init.
> + * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> + * If KHO scratch is not aligned to that value, buddy can access uninitialized
> + * struct pages, which can cause a crash.
> + */
> +#define SCRATCH_ALIGNMENT_BYTES (1 << (PAGE_SHIFT + MAX_PAGE_ORDER))
> +static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);

Maybe make it a variable and set it at runtime?
We won't need to worry about different confugurations that override
MAX_ORDER and potentail divergence of pageblock size from MAX_ORDER in
the future.

-- 
Sincerely yours,
Mike.


