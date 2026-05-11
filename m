Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3587DCD37AC
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vGdf13XXX13xG1g+PUbb7MpjUGk5XWxAWkONoYznhFQ=; b=PMlFUmRcdZ/wtGx3EbA7pGDgZj
	wXHni0jRjxNSnIV1YeEWEpRj1wi0LvcSD/yccEHrRDwv0PWZ83Ik0KEG/vP2gLgCXzuv7mrSV1qBf
	rKBwAbuhSq3LP5t+WZqAuxJrO3GBSRnYNhaU4rRLxfVk7sbE3aaMNvPr0VkGa2Bch8NyiaFqClaLW
	8htFiE1MgUM40cS/Of7NJDAEkiANonYEQNyKiSNkd3IB6BhLf57btF3ELi28sCLjErqEcFgtqfLCr
	v47BKhlFzgKIft7TujY62/cXVcO3qVMnYMYjCBxsSLmFTHtgsM+FY2y7T19O2WpTZzugvb0pl/pi2
	S9RE+iJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFt-0000000DQdn-15mz;
	Mon, 11 May 2026 11:57:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFs-0000000DQcz-14QI
	for kexec@bombadil.infradead.org;
	Mon, 11 May 2026 11:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vGdf13XXX13xG1g+PUbb7MpjUGk5XWxAWkONoYznhFQ=; b=GbVTdnBhhRFK3ds278Q/yIRE5s
	0eLXuqOrRtIt0SRmEJsf6keq+zvvIUNt8KA6v2DQXRPyXNTDVG+mBCEf73SSrO04yOklAqGepz/OA
	zsSfzt5smz4n937qxXTE2YEyvyjxphiEoUsE8sxBQHKgGff5N2jqRiLng5iA2zsEP4CTRYqjvpc2I
	geBil4GI2bAvO3TWQ1vp0A92UHIj50o8qO3FigSB1vya6Waxbl/f6pj78v7Cs6yip4z/vbNdR6Iit
	Kk3Z7HV5AkEXZUKs0oCo9wcdExEgmw6Qq1YarnwOgSIhhdnXn3qqJfx6db6fbI/g46OpL+jH1UGi6
	Tljpzr3g==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFg-0000000BXo0-1s4w
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:56:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 73DD341794;
	Mon, 11 May 2026 11:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDF2C2BCB0;
	Mon, 11 May 2026 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500607;
	bh=RPofv0sJIx1BCo2Ks5FWiQnTOmzxK00LHgl2H+nVruE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtRQQZSflLpDPcYSSW2Eym9IkYemtgSZn79u/D4IwuPzXF/iUKo1YguDzKs8+jnZN
	 wILT2t0cv01gTvm9pHZ8SeMvXchNRjY9mP7pZfYrbBxkAqm+PbjBI8j6q5feGc07BB
	 efAR4iajWMdaArynmYG1xj5MjZkS4VAJ4ZSh3Fgyn9ktxfQdmnBeAkl+Ru7LwZ1nva
	 ooJYZqsTTcqnqIndjWfgepNBwndgLARlwUmGo1ucOMtHKiae5H1rXIqHyp0pz7gMsT
	 dhONrAoW/LGU7Jul3d2XzvVQRz89joXDRfwvOmyWslxOZYBWHo1nFZLC9xlbogETvQ
	 uYek6voYXOUvQ==
Date: Mon, 11 May 2026 14:56:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] kho: allow early-boot usage of the KHO radix tree
Message-ID: <agHD-E4iDhvUEZDS@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-7-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-7-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_125655_675874_3832A9CE 
X-CRM114-Status: GOOD (  14.70  )
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

On Wed, Apr 29, 2026 at 03:39:08PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The KHO radix tree allocates memory for table pages from the buddy
> allocator using get_zeroed_page(). This is not available in early boot
> when memblock is still active.
> 
> Using the radix tree in early boot is useful for KHO to track metadata
> about its memory. One such example is for tracking free blocks for
> memory allocation when scratch runs out of space. This feature will be
> added in the following commits.
> 
> Add kho_radix_{alloc,free}_node() which allocate and free the table
> pages. They use slab_is_available() to decide which allocator to use.
> While slab_is_available() indicates availability of the slab allocator,
> it gets initialized right before buddy so it serves the same practical

                           ^ after?

> purpose.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.

