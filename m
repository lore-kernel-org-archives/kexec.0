Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE761FF885A
	for <kexec@archiver.kernel.org>; Sun,  3 May 2026 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GRNlERfy3yvo0mRY0vvGmux3ZMRHeOx1EjEt2XLRCIE=; b=hrQ2UnGf7ccgjP/AcOSLiFFyVK
	WJi9E2vQ4VRBtTyR4UYwO0iCC7ubl21Vf7KBt2OMJJUhbmJ9E0GOMxps62/iHn3VdlqgoMfVYqPl9
	ipZdxWu7KzYJGmS27inOFT1hJu0YeE8OgQNnGcgBvgf82IyVePUZw/wCLE10M1ipVAIhwnhw/GAYV
	Z6O3Au27Klz1FED8bAconscf486O6dxR/k24S4WedJ8Fr6f25QxYC3y7vBDBIc2hCKmAe0Tws9pW8
	UUBXndyqj2PKeoVaR+VVdaD3cV9aKuIU+GsLj/w6qyu+OnD9Dn2x2qfz27m90i0RZOf5J+hGYRuv9
	j69n2NOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJTeB-0000000AlVu-2RMp;
	Sun, 03 May 2026 10:01:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJTeA-0000000AlVK-2rmJ
	for kexec@lists.infradead.org;
	Sun, 03 May 2026 10:01:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5EFAD60120;
	Sun,  3 May 2026 10:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEEFC2BCB4;
	Sun,  3 May 2026 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777802517;
	bh=tXOPghsTimOL2unyTOOfFn61l3RakHOcJag+q6KYp3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TV9LFfwMzE8GaeswmLI/bMn/J/TPTXZMYjybF1QacD0K+oV7PFM4QBLqrhFotPJGB
	 37VhM2H1PTjhDbGSnqTwXQkWhhRKfy4u8zDzyOiKfz42fmKm8PSK+A4H5Fj5HwiaDy
	 EGIWx+wIy3JO1vOu1B8myfjiwL7Bs5IhRFX0nXJ15DSdxl0kWB3OicNff7gf2b5tr4
	 cUptNm2AuZIj4gL+x/P0lY2ormrovtCW7Q6Y9dIX/fQK4dzDGqOnhXlr4PDoVCGH6N
	 e4kgOurDovEeWqoXrZTkCEbV9gBePB7ULNOO9slZgMm8HvyAlnLIYmOuI4N8JPwJ0A
	 KiZY2TJAIDIIQ==
Date: Sun, 3 May 2026 12:01:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 0/3] kho: add support for deferred struct page init
Message-ID: <afcdDm4aAJvNaQqH@kernel.org>
References: <20260423122538.140993-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423122538.140993-1-mclapinski@google.com>
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

On Thu, Apr 23, 2026 at 02:25:35PM +0200, Michal Clapinski wrote:
> When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> initialization is deferred to parallel kthreads that run later in
> the boot process.

This patchset breaks memblock tests:
https://github.com/linux-mm/linux-mm/actions/runs/25259346624/job/74063911769

Can you please send a fix?
 
> Michal Clapinski (2):
>   kho: fix deferred initialization of scratch areas
>   selftests: kho: test with deferred struct page init
> 
>  include/linux/memblock.h              | 21 +++++++++-
>  kernel/liveupdate/Kconfig             |  2 -
>  kernel/liveupdate/kexec_handover.c    | 52 ++++++++++++-------------
>  mm/memblock.c                         | 56 +++++++++++----------------
>  mm/mm_init.c                          | 30 +++++++-------
>  tools/testing/selftests/kho/vmtest.sh |  4 ++
>  6 files changed, 88 insertions(+), 77 deletions(-)
> 
> -- 
> 2.54.0.rc2.533.g4f5dca5207-goog
> 

-- 
Sincerely yours,
Mike.

