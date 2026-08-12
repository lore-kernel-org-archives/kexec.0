Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E0AC5CFDB
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 11:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lnwlG71sjI06zsq7yj3kdlhgqiN/yez8QEYIr9vq9zU=; b=c+fwvvYKmTmuRQ07XCEo7ijwvc
	DofplkvDLMuH2qsMXctwPHnRrritHsxZSIV0d6W2Dab6qmUfUVGc+6cdDmZYWFGut3/OqjzvSSGpG
	CagGvp15gVZQzaWgtRPcER3eedVoWKMSwWBTxI4gEIlF8ejBcr+ZqoKCXvS8lCI/F3t/apserGemW
	mf26SxL24kxxwxz5yeETZGMGXVJIS8KWEcH18JHmT//K7kAsV423oygQBxgK3dHwSFmmO1T9Zd/Ef
	7E5iVXR4s+P6qbvCT9R4l6cUGUasbd6H1F44wGrC2wriQ4hWVf4EFNkC4utfHqfl5jqs/7J+eEl/J
	UHzkcPwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6qu-0000000G0oC-3xzz;
	Wed, 12 Aug 2026 11:10:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6qq-0000000G0nX-0nDZ
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 11:10:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 389C542A9D;
	Wed, 12 Aug 2026 11:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8941F000E9;
	Wed, 12 Aug 2026 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786533027;
	bh=lnwlG71sjI06zsq7yj3kdlhgqiN/yez8QEYIr9vq9zU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WYd2zt8tfz9f3l7W2MEvjC9PgjvttrZRZQVu40gKcm//Lc2oh3g67LBMStlLwpfhS
	 xMQicXNXtVelpILEAADkxgCYL9BvY84p7BepdW1igypoiA/RTrx9ZoHqQzeH9LzhNX
	 fFGCwLPk5SyGU+QOnoKQ5AJxqETgroS26+gZ9FeDb2c9/tgO0+uDSA3AuIbv0SG8Lr
	 lJESY+GMBNpPY8804d2TiZWZe3JjdQSimESxZtndotoBUjylLoQO3lxy2eco2WxcLF
	 n+yRKhPGPH/SONjna1QhUFRHOduSa5v7P3vbI4WsU1U9gscXN1ALeSmiWs6bN71fcL
	 ssDCkH9AWO2ew==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  David Matlack <dmatlack@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] kho: Introduce preserve/restore APIs for
 high-order pages
In-Reply-To: <20260803113944.3694290-3-praan@google.com> (Pranjal
	Shrivastava's message of "Mon, 3 Aug 2026 11:39:43 +0000")
References: <20260803113944.3694290-1-praan@google.com>
	<20260803113944.3694290-3-praan@google.com>
Date: Wed, 12 Aug 2026 13:10:23 +0200
Message-ID: <2vxzmrur3880.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Aug 03 2026, Pranjal Shrivastava wrote:

> The current KHO page preservation APIs (e.g. kho_preserve_pages) assume
> that multi-page blocks are split into independent 4KB pages during
> restoration. This is incompatible with high-order non-compound pages,
> such as DMA buffers, which must be restored with tail pages having a
> zero reference count.
>
> Introduce explicit preserve and restore APIs for high-order pages,
> which preserve and restore a high-order page block as a single unit,
> applying a refcount of 1 to the head page while leaving tail pages at 0.
> Rename the existing internal helper to __kho_restore_page() and
> consolidate the common restoration code into it.
>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

The code here looks very convoluted TBH. I think it will be simpler to
make kho_restore_page() only return non-compound pages. That is, it
returns 0 or higher order non-compound page.

Then kho_restore_pages() can call kho_restore_page() and then do
split_page() on the page it got to turn it into 0-order pages.
kho_restore_folio() can call kho_restore_page() and then do
prep_compound_page() on the page it got.

And then you expose kho_restore_page() to be used by DMA APIs to get
non-compound high order pages directly.

How does that sound?

[...]

-- 
Regards,
Pratyush Yadav

