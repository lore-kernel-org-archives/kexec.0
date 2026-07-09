Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11017C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/zW25RGaPGwBbxFd+aS9kBW8b47epnczIHFRFBCLAYo=; b=oOIrtn6asPQoGQ701R93NZf9ok
	dfv4hu4E721XzGdcjEwUiCzG6Hf8ZdDzhPCBGqCe3BAd/bIn66ARzjQeKt4buHRfh/J+dmoP6Nnge
	fgLZPRvyZoDAqF1cB0XHTSQu4BFEfDxvJwrF7xj3gFqHYyzvPq5wpuyS9FYk0ZmP2LhJwA82xYv7a
	3kRNqMvCdJZgBPlOyqCtE6wBnAZcnvE+nUPDj3zAhG/mK2Yb9o/KiSEptCuRN6VBpGdepn6azCJp/
	6h70dNMb9vRmsDx4Puo7rrE8JPgyvvZJmYZpVNKS9V/5h5hx+6NQSsLcLIpWMiRxEto0d5bZZysqG
	ZTxH8JFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whj5s-00000001Gc3-3Lba;
	Thu, 09 Jul 2026 07:22:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whj5s-00000001Gbt-1KP6
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 07:22:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B2146001A;
	Thu,  9 Jul 2026 07:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CE41F000E9;
	Thu,  9 Jul 2026 07:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783581767;
	bh=/zW25RGaPGwBbxFd+aS9kBW8b47epnczIHFRFBCLAYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vfkr0ESuoATXnPUkdBeq5+55sr7cVzSbt5ClCmVrSnQkJcQlnePuTOPN43DOTmXBB
	 YSlQfUnogVcP5QFkvu6bmLtwBljgujN7UWqTgrsBz/mE/apwSbu1SjJZF9FbAd9uHS
	 YN+nGemmSCwyGDh+062S5GniNn8bNOd+VlJTpc4Ev7w6aZ1qJeLKrrA3kf7DEhJXCs
	 NcIZY28KAhZuKKTdEjThKMco81MwWoZcwhDhzGMSYaZvrTkjXcV/6rn4gWFjtTemEr
	 iQZoNnClbYQXt0PJm8wXnjYh33q++mH230eCtmwWcF0M7UOxqN4QNmZ5IiHWpXSsJK
	 2uv9LvYoeHkhQ==
Date: Thu, 9 Jul 2026 10:22:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Alexander Potapenko <glider@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Marco Elver <elver@google.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>,
	kasan-dev@googlegroups.com, kexec@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm: split a couple of headers from internal.h
Message-ID: <ak9MO-FWjkgr22KL@kernel.org>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
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

On Thu, Jul 09, 2026 at 09:41:46AM +0300, Mike Rapoport (Microsoft) wrote:
> mm/internal.h becomes more and more bloated.
> 
> Split declarations related to mm_init, memblock, vmalloc and sparse into
> new headers.

Sashiko rightfully pointed to some issues, will send v2 later.
 
> ---
> Mike Rapoport (Microsoft) (3):
>       mm: split out mm_init and memblock declarations from internal.h
>       mm: split out sparse declarations from internal.h
>       mm: split out vmalloc declarations from internal.h
> 
>  MAINTAINERS                        |   3 +
>  kernel/liveupdate/kexec_handover.c |   3 +-
>  mm/cma.c                           |   1 +
>  mm/execmem.c                       |   1 +
>  mm/hugetlb.c                       |   1 +
>  mm/internal.h                      | 183 -------------------------------------
>  mm/kmsan/hooks.c                   |   1 +
>  mm/kmsan/shadow.c                  |   1 +
>  mm/memblock.c                      |   1 +
>  mm/memory_hotplug.c                |   1 +
>  mm/mm_init.c                       |   3 +
>  mm/mm_init.h                       | 120 ++++++++++++++++++++++++
>  mm/page_alloc.c                    |   1 +
>  mm/percpu-vm.c                     |   1 +
>  mm/sparse-vmemmap.c                |   2 +
>  mm/sparse.c                        |   2 +
>  mm/sparse.h                        |  63 +++++++++++++
>  mm/vmalloc.c                       |   1 +
>  mm/vmalloc.h                       |  46 ++++++++++
>  19 files changed, 251 insertions(+), 184 deletions(-)
> ---
> base-commit: 820d5dfede0cd55dcbc89ce96fcfbb11b7c457ba
> change-id: 20260707-internal-h-2efef660381d
> 
> --
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.

