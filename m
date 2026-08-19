Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1317C5DF6D
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JTF3U2EL5wIQEwuPiw65PvVWmB+O0rc/BDnD0e5FQ+Y=; b=W5HCQGaYxb9v/KUhpD4A7BXVDi
	qz/8ZQ3vmTa09uMZ0Cl5Q01NYJWSyos+cQZf51XTv6gHh7bEo+V1nFCFDKEVXUkaikcnTrPVUmW8f
	wrtfMHW3El3rfO38xAaevD8hmhSeoGeDpcbLsP6QxhEhkg5HKZTsWIxK4OHPWTFhBLnDl6vRW5MHU
	DMOA0gqHoJK6nW6gKEvPS+2g/3XeXhWluQ7zNqpJAgbIRruyoR8kY9tnoziG3y3PEi2E1T/DV1TGd
	T2/qJ7PB1vQU8HLtxAuYrFC0UDsHHyaDm/NH5Gd3tElrUYGWnPBxfwLNoaXKqadz4IlJipKtlrNsh
	ErtgKnqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcik-00000009QSX-1BXJ;
	Wed, 19 Aug 2026 09:36:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcii-00000009QSF-33iR
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 09:36:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CDF7060A63;
	Wed, 19 Aug 2026 09:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986B61F00A3A;
	Wed, 19 Aug 2026 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132187;
	bh=JTF3U2EL5wIQEwuPiw65PvVWmB+O0rc/BDnD0e5FQ+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hj0ElIKx6VJRJ8JYMcW7LtKc86NfHVIYzjKdrLUeZRiOHTg8nGQ4o2cY/ibgpYML/
	 oY/NM6K7sOKxMrpb3VNMwdiGX7zic2LJrZFIABndvfb/CjQdDqEdy/y6366j5cKMoo
	 pASkORkbrV3sVPZpjcO88OWwTuomkL97xuv0br9C2NgzYfQuWggsNnC2Fed8X32maS
	 xCdS8A/WycqjnVUdaPrvSkNNFdUu+qJ1tNH4hGrhowXTj6WQSN9lctDaAVYh7pjOi5
	 PrjjS9A+UJTIrbRfBxuxliHP7lu4ISMtCOm/xLFIIaEbbSAyXd3Hi6JfrGOaxR6P2s
	 DbUdsMWU7bmsw==
Date: Wed, 19 Aug 2026 12:36:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	rmikey@meta.com, riel@surriel.com, kernel-team@meta.com,
	Kiryl Shutsemau <kas@kernel.org>,
	Bradley Morgan <include@grrlz.net>
Subject: Re: [PATCH v6 0/2] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <aoV5EfBtlWcyf51E@kernel.org>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
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

On Wed, Aug 12, 2026 at 04:31:50AM -0700, Breno Leitao wrote:
> Memory failures are common enough on large fleets that kexec regularly
> lands the next kernel on a frame the memory failure subsystem has already
> marked bad. Patch 2 teaches the segment placement to avoid those frames.
> 
> Patch 1 is a prerequisite. locate_mem_hole_top_down() walks candidates
> downwards without ever checking that the subtraction stays above zero, so
> the walk can wrap and report success with a destination outside of RAM.
> Patch 2 adds one more downward step to that loop, so the bug is fixed
> first and both patches rely on the same bail-out.

I queued this for v7.4, the patches will appear in the liveupdate tree
after the merge window.
 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v6:
> - Split the pre-existing top-down underflow out into its own patch, and
>   drop the "if (poison < kbuf->memsz)" guard from the hwpoison hunk now
>   that the loop bail-out covers it. (Mike Rapoport, Sashiko)
> - Reword the changelog: the MCE comes from reading the poison back, not
>   from the relocation copy writing it, and the placement paragraphs read
>   better split up. (Mike Rapoport)
> - Move cond_resched() after the struct page dereference, so the scan does
>   not yield between pfn_to_online_page() and is_page_hwpoison().
>   (Pratyush Yadav, Sashiko)
> - Keep cond_resched() per pfn rather than batching it. (Kiryl Shutsemau,
>   Rik van Riel)
> - Link to v5: https://patch.msgid.link/20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org
> 
> Changes in v5:
> - Return -EHWPOISON instead of -EADDRNOTAVAIL
> - Leverage is_page_hwpoison() instead of per-page check
> - Link to v4: https://patch.msgid.link/20260807-kexec_posioned-v4-1-70d57f14625d@debian.org
> 
> Changes in v4:
> - Anchor the top-down hole finder on the first poisoned page in the
>   window and the bottom-up one on the last, so each jumps clear of the
>   poison in one step. New range_first_hwpoison(). (Kiryl Shutsemau)
> - Count a poisoned hugetlb folio in full: the flag lives on the folio,
>   not on the subpages, so the per-pfn scan missed poisoned tail pages.
>   (Kiryl Shutsemau)
> - Link to v3: https://patch.msgid.link/20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org
> 
> Changes in v3:
> - Return the address of the last poisoned page in the range, or
>   PHYS_ADDR_MAX when it is clean, instead of a bool plus an output
>   parameter. Renamed to range_last_hwpoison(). (Pratyush Yadav)
> - Add cond_resched() to the scan loop, as a segment can span half of
>   memory. (Sashiko)
> - Link to v2: https://patch.msgid.link/20260730-kexec_posioned-v2-1-f92d18551f64@debian.org
> 
> Changes in v2:
> - Change from pfn_to_page() to pfn_to_online_page(). (Miaohe Lin)
> - Return the poisoned address once we find a hit, to avoid the O(n^2)
>   rescan. (Sashiko)
> - Link to v1: https://patch.msgid.link/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org
> 
> To: Andrew Morton <akpm@linux-foundation.org>
> To: David Hildenbrand <david@kernel.org>
> To: Lorenzo Stoakes <ljs@kernel.org>
> To: "Liam R. Howlett" <liam@infradead.org>
> To: Vlastimil Babka <vbabka@kernel.org>
> To: Mike Rapoport <rppt@kernel.org>
> To: Suren Baghdasaryan <surenb@google.com>
> To: Michal Hocko <mhocko@suse.com>
> To: Baoquan He <baoquan.he@linux.dev>
> To: Pasha Tatashin <pasha.tatashin@soleen.com>
> To: Pratyush Yadav <pratyush@kernel.org>
> To: Miaohe Lin <linmiaohe@huawei.com>
> To: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Cc: rmikey@meta.com
> Cc: riel@surriel.com
> 
> ---
> Breno Leitao (2):
>       kexec_file: stop the top-down search before it underflows
>       kexec: keep the next kernel off hardware-poisoned pages
> 
>  include/linux/mm.h  | 14 ++++++++++++++
>  kernel/kexec_core.c | 10 ++++++++++
>  kernel/kexec_file.c | 20 +++++++++++++++++++-
>  mm/memory-failure.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 1 deletion(-)
> ---
> base-commit: c5e32e86ca02b003f86e095d379b38148999293d
> change-id: 20260727-kexec_posioned-72bb0a4143a0
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

-- 
Sincerely yours,
Mike.

