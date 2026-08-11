Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E75C5AC67
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kXXh8PYIfsaZmMaidvXBBrRKRtqDnrYuD5GOCyydIk=; b=vPr59B4AGOVqVAFGVWW3Z6TroT
	EO8hEXMzkV9zXtXBi9C6DjIof7mWZaiZFikJCslNo0Y4A6XuxGzXAsdQm5ujPKML/4QNkfxrK4CzJ
	zoEUt2RQpfRxN+hW6ViLyoc/3DiHBXZztW+0Efa6hpw8Gjn/9S/afdKNdKpWjLu7fCMvbCYgz4NHK
	V6bShT+TpENJbjd02tSzyYGsj6Y1q7QQ0vLFWSNDmasFTG+mgV2wBDM6HM8Ikz94eY+QVQqu8UD9s
	Wb4ZPQeV19ldw3//WFyG1l6H54hHtsPJ0xVDbubLWnBebmpbWg4ZsIQga2xBsmItSlvqbkho/QjRj
	I4f6gT0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjhQ-0000000Dqq8-2mlL;
	Tue, 11 Aug 2026 10:27:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjhQ-0000000Dqpm-00gk
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 10:27:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 76DEF40BEB;
	Tue, 11 Aug 2026 10:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69E1F000E9;
	Tue, 11 Aug 2026 10:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786444031;
	bh=1kXXh8PYIfsaZmMaidvXBBrRKRtqDnrYuD5GOCyydIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oaG9JOuX/0vcBfIckuFTx0W15YPUcXCkJnkcQjMIbr0AOcvnRtL0pLoDIAript9S5
	 fvsQp8kNlISsYrcm5UCUZ4SUOLxshJUgfj26E8vKd2lAx74cQDzRVPevMviHGIMdVv
	 EgJjlP6Wz0Ayg7/ts/UeqsCKHQESAC+awlHAHhcpRnWTStKseu8NMxYTkE8R/VTz4v
	 GakfJG9VtthV8QjjqYYAeOBe2uBY3IDnsjz/PmL1jmZkHj3Kr9VTBdMU6Qay7ioC2Q
	 G9+2+aCFeO8ej69JItG0DCUlPp/k2q9njH+oEzPqW42l3pEdl6LV6pkscYGwajURgk
	 JocxcWXRiS5GQ==
Date: Tue, 11 Aug 2026 13:27:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] kho: support preserving high-order non-compound
 pages
Message-ID: <anr4-F-e5_vHEar8@kernel.org>
References: <20260803113944.3694290-1-praan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803113944.3694290-1-praan@google.com>
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

Hi Pranjal,

On Mon, Aug 03, 2026 at 11:39:41AM +0000, Pranjal Shrivastava wrote:
> Introduction
> ============
> This series is required for the ongoing effort to preserve DMA allocations
> across KHO [1]. It addresses a fundamental mismatch between the current KHO
> restoration logic and the physical reality of high-order buddy allocations.

I skimmed through the patches, they look fine to me before the in-depth
review :)

But we are really close to the merge window, so we'll anyway need to
reiterate after v7.3-rc1.
 
> The Problem
> ===========
> The current KHO restore implementation treats all multi-page blocks as
> split pages during restoration. Specifically, kho_restore_pages()
> initializes every 4KB sub-page with a refcount of 1.
> 
> However, many kernel subsystems, most notably the DMA allocator (via
> dma_alloc_coherent), frequently return high-order non-compound pages.
> In this state, only the head page carries a refcount of 1, while
> all tail pages have a refcount of 0.

This hints that these patches could be a part of the DMA preservation
series, unless you expect other users of the new API.

Generally, we don't merge new APIs without the users and if DMA
preservation is the only user, it's better to fold these two patches there.

-- 
Sincerely yours,
Mike.

