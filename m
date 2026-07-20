Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA61C44529
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fw+3DqEg6mkspJxmUkbqf+mdDaZyrEi0PQGmGu5K/Sc=; b=jgkIj7/58a2H/HmHcxdU+YBzB1
	KG4zBCWvdQ0sdrTrF1G4z9XjbdCvTFVuBf12+We9xRI6ihxqlI4xH2V4k38c4JKXBs1ra0CJqG47p
	+oG7YxuFt/Uf409savI6ObeGLmT1bt4fhoxaRHCBXoZlKvkOZI9KiApKPfT373stwOLyKS22nqA+J
	eMK7eO7zvOe8o9RcYfQxo6sxsYb4SHQ7aRUA+1nY23wgqnYq0GnDXz/QMHD9Y51QyJNqeY4kvxQVP
	p5sx3Rpo3YsHzIb9PRsTRI7kRN2D+FQ/pWEUy+o5n5XsD30rSa7g2b9qYX2DtuHe4+JOQONTlYqeg
	PY8SaI8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlrJ2-00000007SKD-3HeG;
	Mon, 20 Jul 2026 16:57:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlrIw-00000007SJc-2lvh
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 16:57:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F7EC601D9;
	Mon, 20 Jul 2026 16:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDEC1F00A3A;
	Mon, 20 Jul 2026 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566641;
	bh=fw+3DqEg6mkspJxmUkbqf+mdDaZyrEi0PQGmGu5K/Sc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=igrPVqBDpEaPBI25WLKbX5c17QyJntJ8rlSrExAtX1F7Ud326aJP1Bq+NdcpBFoMh
	 8OZhdDyFvqi3oN6Caq5pr9rBYe4xyCs8cfzohHGr0QJRL8977tPS/MXhMfv2YQaMBT
	 vz1W+NA0byWf8ZPbClJ0wEhi0v6XmIQuAGI2MvMEOB3rxfEudj3QoCu3hTU1KUu6bT
	 CBBkzA0xx49NS0aU+Cbzipph/pYEKk97u+RRAOyLKzY7Hw3qGwWcx1rWfZin2Ehjxe
	 yFL34AQ9/fIMswoUcdAyvBMDdhENzc4kGZrcdwPP0fiaJQYO547NZ07KrG+442Vwdq
	 HDJh1wEZGE/eQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v2 1/2] kho: Introduce a helper to init unsplit
 pages
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260713204935.3069000-2-praan@google.com>
References: <20260713204935.3069000-1-praan@google.com>
 <20260713204935.3069000-2-praan@google.com>
Date: Mon, 20 Jul 2026 19:57:15 +0300
Message-Id: <178456663513.143128.13731300065093148388.b4-review@b4>
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

> The current KHO restoration logic assumes all multi-page blocks are
> split into independent 4KB pages. Break out a helper to prepare for
> supporting high-order non-compound pages.
> 
> Extract kho_init_unsplit_pages() to handle the refcount pattern
> where only the head page is refcounted. Use the helper for folio
> restoration that requires a similar refcount logic.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 4834a809985ab..07f6f453cd69d 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -357,6 +357,24 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  }
>  EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
>  
> +/* For physically contiguous pages. */
> +static void kho_init_unsplit_pages(struct page *page, unsigned int order)
> +{

Can't say I like "unsplit". How about kho_init_high_order_page?

And whatever name we pick here, it's surely must end with "page" rather
than "pages".

-- 
Sincerely yours,
Mike.


