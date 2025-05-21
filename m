Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF13C2D0CD
	for <kexec@archiver.kernel.org>; Wed, 21 May 2025 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LmS9BG/WjvqdoUcCV5RL/LLQy64Bdl84uNtFTecAxbA=; b=3jvIJvL6OCGKlHkIaTLLb+LP1M
	VRGtdoh09mbLWp7i0LMgQhq6prm4xNw9JAJisLpnQPFmUwgaC+sZabwUiHKATzLFBnaz7xTB28+k9
	IByrFo1HqpAOMY1fCEKUzkSJg0os2H4xmrp74xbp5IkbUqFlo821CcLc88rDJGXSf+Zk4AwaO9fjt
	PV/ursA6gQQMNUR6MTN063RBer1I8SwvgqHce/EDe6DgArKZx39phL14jL0HxklZ/5Wfq0aCsPgtX
	oXJEoi9gSzX1i7QlfPRnKxx9P9H7eseqY/W3OhXoVzgmRlVSFoDYCEYQpSqQ0yoW7yZKkezU20UHW
	DaMqhBRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHlMf-0000000GHFG-3kif;
	Wed, 21 May 2025 15:28:17 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHlLe-0000000GH1D-2kMW
	for kexec@lists.infradead.org;
	Wed, 21 May 2025 15:27:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 91E72A4F0C8;
	Wed, 21 May 2025 15:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB653C4CEE4;
	Wed, 21 May 2025 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841233;
	bh=OREQHZGYo3NvKNR+PKTA7t1MGjIJnrFFdGtkjwEU9qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7XUweCKpFKWJICYq76TfDISsYXAaRG/WO7DIzj+Cd0xOXyA60iZLJ0nhdVjPAlly
	 DHAxo+naXWo5rjJKLYvRjYRNIuFlNWx6Np0Bjk/QmmBGn3fIBYGOGaN2nqb6J9rEFS
	 j1ig1OlpBj19WT6pGkVxfX/ulXl1n+DGlfkYUIyv29inAlFODqP4QixgOauwg2sgR2
	 2zDkroPW/xH/d0oH02ugkePbiLo3nZ2vd2AkDkHSA18F21NR00eHQhzq1DBhwbH+3W
	 m81rhzkUK57nHLPAUmDn53ZolxhVNtIxFC9E+Nl234NAw8PG3veRASeFl77u4YBOJK
	 tkUG3kF0BMtKg==
Date: Wed, 21 May 2025 18:27:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org,
	bhe@redhat.com, chrisl@kernel.org, graf@amazon.com,
	jasonmiu@google.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pasha.tatashin@soleen.com
Subject: Re: [PATCH 1/2] memblock: show a warning if allocation in KHO
 scratch fails
Message-ID: <aC3wx5erybg00SaQ@kernel.org>
References: <aCoFphqeZAMkhq51@kernel.org>
 <20250521070310.2478491-1-changyuanl@google.com>
 <aC2EE1pg9ktQdstI@kernel.org>
 <aC2TdzP1AwYrQdcW@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC2TdzP1AwYrQdcW@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_082714_791240_9CEBA749 
X-CRM114-Status: GOOD (  17.10  )
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

On Wed, May 21, 2025 at 10:48:55AM +0200, Oscar Salvador wrote:
> On Wed, May 21, 2025 at 10:43:15AM +0300, Mike Rapoport wrote:
> > I think we should just make sparse_init_nid() panic or at least change 
> > "sparse_init_nid: node[0] memory map backing failed. Some memory will not be available."
> > to something more visible and clear. 
> 
> Panicking the system seems a bit too harsh.
> Those sections will not be initialized, and sure you will lose some memory,
> but still.
> 
> I think that making sure that subsection_map_init() does not access
> non-initialized values is enough.

It's not only subsection_map_init(), next failing one is
memmap_init_range() and maybe there's more, but we can audit and fix them.
I believe all those accesses are at init time because after system is
booted we are careful to avoid accessing absent sections.

> Because wrt. error message, I am not sure it can get more clear that we
> failed we allocate memory to back the section and so that section will
> not be activated :-)

Add a dump_stack()? ;-)

> -- 
> Oscar Salvador
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

