Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A5C44501
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Qbt4ekz8xcd03uy7P/OzMvJEFCLZFGb2OtRS59Nxxvw=; b=ahZAnHtvO6/HeO
	amEjCi5AAjGgaOt4uIPOxfhY3cfIOeuQEpDsLmfin9ssaDwpwWrC9Usy5NFglFiAGIzI9U0xfJXG3
	z3UdxL4AP9nn0E5cHQxYPyqLe3ZtfW596RY5tA7r4VmxnxrkwOzuXWoLO64hMOTQYfQg5AjZl2/Mp
	flRfCpR6lxFHyrzr+Szl28vDMdWpl8KgypgcyH/Fmv+HFBHWfOchwnsTwP3j5yN5EAg8yIceXw9Rv
	AAlDT9FcuAYxAp+RpSroFDjC2LF5bhMnjLrfXHY0HU9yYfyA6NoY/HIsbEsYjXguJemqPnTGeTFVF
	AQrD/7FHMjfey1won+tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlYF-00000001qta-0Vzm;
	Thu, 09 Jul 2026 10:00:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlYD-00000001qtE-4BFo
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 10:00:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 12CE06001A;
	Thu,  9 Jul 2026 10:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC85F1F000E9;
	Thu,  9 Jul 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591212;
	bh=Qbt4ekz8xcd03uy7P/OzMvJEFCLZFGb2OtRS59Nxxvw=;
	h=From:Subject:Date:To:Cc;
	b=HQ91UncX+cUG+i2RI6m/YzVDE4IRkVEMUzrs+RCV2chjiekRRlFo8RZOiMP4k+T2P
	 +auhgOw3e8TOq1fBwklI3IxXVH6M3XT9UvDSAUyvcYzUnfQm6edwVOBcwccFaXVgfm
	 M8I6oBoAMC4q175jV7n67WUlz1rk+sDE15EOuXB0Hr3c1ngJ7y7nmS45hGyVDeMPb/
	 ZX5WPqGuvq2nXaf0StFaeza79djxGu/NogpMGG0nKjFYUfWMC4PrCB9eqoiY84xxfI
	 qgl/Pi5VP+gw978b9vvfSP1t5pL5tTYj0Xa+bwQsYCW+VoeQbnU4vcQ58Y6LXkfD3U
	 U72n6krj64VvQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/3] mm: split a couple of headers from internal.h
Date: Thu, 09 Jul 2026 13:00:02 +0300
Message-Id: <20260709-internal-h-v2-0-695631425968@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJxT2oC/02OQQ6CMBBFr0K6drTUUMCV9zAsCh2gSlvTVtQQ7
 m6LMXH55s+8Pwvx6BR6csoW4nBWXlkTge0y0o3CDAhKRiaMMk5LWoIyAZ0RE4zAsMeec3qsckn
 iwd1hr16b7NJ82T/aK3YhGdJGKzxC64TpxjTS2gZ90BoMPlM8Kh+se2/PzHnS/Hrr/945Bwp1w
 WVBa1ZWTJ5vMcJpb91AmnVdP0COcLbWAAAA
X-Change-ID: 20260707-internal-h-2efef660381d
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Alexander Potapenko <glider@google.com>, 
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>, 
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, kasan-dev@googlegroups.com, 
 kexec@lists.infradead.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

mm/internal.h becomes more and more bloated.

Split declarations related to mm_init, memblock, vmalloc and sparse into
new headers.

---
v2 changes:
* fix fallouts of rebase fixups of checkpatch warnings

v1: https://patch.msgid.link/20260709-internal-h-v1-0-956d5092782d@kernel.org

---
Mike Rapoport (Microsoft) (3):
      mm: split out mm_init and memblock declarations from internal.h
      mm: split out sparse declarations from internal.h
      mm: split out vmalloc declarations from internal.h

 MAINTAINERS                        |   3 +
 kernel/liveupdate/kexec_handover.c |   3 +-
 mm/cma.c                           |   1 +
 mm/execmem.c                       |   1 +
 mm/hugetlb.c                       |   1 +
 mm/internal.h                      | 183 -------------------------------------
 mm/kmsan/hooks.c                   |   1 +
 mm/kmsan/shadow.c                  |   1 +
 mm/memblock.c                      |   1 +
 mm/memory_hotplug.c                |   1 +
 mm/mm_init.c                       |   3 +
 mm/mm_init.h                       | 120 ++++++++++++++++++++++++
 mm/page_alloc.c                    |   1 +
 mm/percpu-vm.c                     |   1 +
 mm/sparse-vmemmap.c                |   2 +
 mm/sparse.c                        |   2 +
 mm/sparse.h                        |  63 +++++++++++++
 mm/vmalloc.c                       |   1 +
 mm/vmalloc.h                       |  46 ++++++++++
 19 files changed, 251 insertions(+), 184 deletions(-)
---
base-commit: 59e34180e138a293260301c139cf7ee800978533
change-id: 20260707-internal-h-2efef660381d

--
Sincerely yours,
Mike.


