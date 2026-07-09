Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBDDC44506
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4mg2V0R7ROggXXchkyKDCKlOYU1ruVph4CL/uITEWhg=; b=x77KKx+e5GvQKzxWUi59VNGvvH
	SPCJatvNnf9bsAN/Kgkx0kCSDDIoPimMCkM1pipu84vVSVXQauXPraVmZAOB/M3CCentWu3vTFSPp
	v6Bkhlvja/Njk9fCH03NqtenXX26Zy8dTHjSBtCGNpGPjSaj6zRlddEC9xumFIH5mB5X9t1T7DD02
	KE5GTEE29xqHVP3ovZCChGSohSsEGWwmfWHmdppbqpz6QUR184zEVEgfEO8+m9Ecd/zl/fRu2YYd8
	9FqGRyQOjId3pMZACPmbS+/CpbudGvAgzakTLI4Z1jn7cj+S5f2mkbZVMz6/5MxgbyuyYNIbfxZCE
	B4xatWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whqnZ-00000002wmm-1wMP;
	Thu, 09 Jul 2026 15:36:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whqnX-00000002wmf-2DML
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 15:36:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D652341823;
	Thu,  9 Jul 2026 15:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BA21F00A3A;
	Thu,  9 Jul 2026 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611382;
	bh=4mg2V0R7ROggXXchkyKDCKlOYU1ruVph4CL/uITEWhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c58V4tRtaxqpKPeZvomkSUxRufHz00GTZSdV7gdbR7tLG41wuZYPKtLskkkHtg/Wb
	 8jNv8LPawi649eM8ho1JXfSx1BMDPxHrymwneL/GvGyWdhek3KsH7zFC5e1JjQWnou
	 iOv4zpApjw7SbfT7AEw2JV7BD/tfMbe0uXK3kEa812I62T6vpYt5jUz7FpFtTe10CD
	 4ECqE0tZFBdePa8c3CMUA9bDBbgK2axaR9q94iDgV5sxxlRY58ZdX0Hk+O48jzlZeo
	 qTiDDqfpGfqIZ8KxE9OxS7usK9HxPv2ff2iR6va1vt9/CrJjbTxqFimlbYjuS1kNkk
	 JQbXGDOnK1ftQ==
Date: Thu, 9 Jul 2026 16:36:08 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>, Alexander Potapenko <glider@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>, 
	Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Zi Yan <ziy@nvidia.com>, kasan-dev@googlegroups.com, kexec@lists.infradead.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] mm: split a couple of headers from internal.h
Message-ID: <ak-5GEPVMrwT77uQ@lucifer>
References: <20260709-internal-h-v2-0-695631425968@kernel.org>
 <0970fec0-5c18-41e1-b63d-029c7a8354ee@kernel.org>
 <67bbfc47-a8f1-4557-9a24-298bad4f3591@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67bbfc47-a8f1-4557-9a24-298bad4f3591@kernel.org>
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

On Thu, Jul 09, 2026 at 12:21:12PM +0200, David Hildenbrand (Arm) wrote:
> On 7/9/26 12:09, Vlastimil Babka (SUSE) wrote:
> > On 7/9/26 12:00, Mike Rapoport (Microsoft) wrote:
> >> mm/internal.h becomes more and more bloated.
> >>
> >> Split declarations related to mm_init, memblock, vmalloc and sparse into
> >> new headers.
> >>
> >> ---
> >> v2 changes:
> >> * fix fallouts of rebase fixups of checkpatch warnings
> >>
> >> v1: https://patch.msgid.link/20260709-internal-h-v1-0-956d5092782d@kernel.org
> >>
> >> ---
> >> Mike Rapoport (Microsoft) (3):
> >>       mm: split out mm_init and memblock declarations from internal.h
> >>       mm: split out sparse declarations from internal.h
> >>       mm: split out vmalloc declarations from internal.h
> >>
> >>  MAINTAINERS                        |   3 +
> >>  kernel/liveupdate/kexec_handover.c |   3 +-
> >>  mm/cma.c                           |   1 +
> >>  mm/execmem.c                       |   1 +
> >>  mm/hugetlb.c                       |   1 +
> >>  mm/internal.h                      | 183 -------------------------------------
> >>  mm/kmsan/hooks.c                   |   1 +
> >>  mm/kmsan/shadow.c                  |   1 +
> >>  mm/memblock.c                      |   1 +
> >>  mm/memory_hotplug.c                |   1 +
> >>  mm/mm_init.c                       |   3 +
> >>  mm/mm_init.h                       | 120 ++++++++++++++++++++++++
> >>  mm/page_alloc.c                    |   1 +
> >>  mm/percpu-vm.c                     |   1 +
> >>  mm/sparse-vmemmap.c                |   2 +
> >>  mm/sparse.c                        |   2 +
> >>  mm/sparse.h                        |  63 +++++++++++++
> >>  mm/vmalloc.c                       |   1 +
> >>  mm/vmalloc.h                       |  46 ++++++++++

One thing to be wary of, and I mean I'm going to get a bunch of conflicts with
my mega series, but anythign that uses vma's should use internal.h rather than
vma.h directly (the mega series touches this).

But nothing you changed does use VMAs afaict so should be good.


> >>  19 files changed, 251 insertions(+), 184 deletions(-)
> >
> > Sounds good
> >
> > Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>
> Agreed
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Oh hey me too! <3

Acked-by: Lorenzo Stoakes <ljs@kernel.org>

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

