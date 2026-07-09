Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390C6C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 06:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DbmJ4H55ecd8aV4hAdjxFXgHksDpeIB+JXxAmclYzEc=; b=rP5+1os/cTKjNg
	zvlQ04Mnibdl/SYrzSOA4+kh5PKIdJNBelJGMBhp3vVjvJW1yrNH3wE4P1+yVgS3Qh/JcOSFHsqyC
	YTpHzaLu2VE4o58UIGL9SPmi+QenzEEusYoTWdiuCzxhS+4/l0IPg908T2ERL9ikPjYmyR3N6Bj4H
	zKs7GhpAp61mlUsWvGf/Z8xhYdIEHrJZN2TEuYyE/W8MatcWFJYwFL4Eg4HgJ0B9TwMQ+xt4lg41b
	zxzvIY9VtPsWa6bpHieqnmT9s1wvZ9PJYbAy0kigruker6ZXr8oqRgY3AttxQFlO4klJTyeB8rYL9
	iOL26AtsiDTREp0RRAuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiSR-00000001Ch1-1OjC;
	Thu, 09 Jul 2026 06:42:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiSL-00000001Cgv-2OhY
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 06:41:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 17A3F41B30;
	Thu,  9 Jul 2026 06:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD6A1F000E9;
	Thu,  9 Jul 2026 06:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579317;
	bh=DbmJ4H55ecd8aV4hAdjxFXgHksDpeIB+JXxAmclYzEc=;
	h=From:Subject:Date:To:Cc;
	b=LF1pQ0O5nJ2Z3Dm1Jm/fh4X8oEOM+VYR0N/Bk2fP0J7a2WkMAL1G6YnSpArGbDDsV
	 06hp/utqBr+CWqg3Ujy9AtP5wZbH9W3d87aCfzk5Gt/pXaVXCrrlTrQRd0jGTZVtPM
	 tgXAL+yxzpcaaPY25BLk7K8JHGzzuxRo3ckGJbWPMlfqB70iuGtS+DEzHDDueNEG4I
	 cdYz2VUjOg1CqmEiPuoBzP+AnCsbw3rThJu+U3Xvyok+GrGuok3fC2zru2/jWL1Zgd
	 ne0W2DbLlV/dj+uFacZ1znnXrCHWhH5qtXCTAA26kU9H+K+U6mm37COv2opKa2Kxmo
	 tM8Dj4NmEGa9w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/3] mm: split a couple of headers from internal.h
Date: Thu, 09 Jul 2026 09:41:46 +0300
Message-Id: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpCT2oC/yWMyw7CIBBFf6WZtRMpJtT4K8YF0EHGyNQAPpKm/
 y7o8tzcc1YolJkKnIYVMr248CINxt0APlq5EvLcGLTSRk1qQpZKWewdI2oKFIxRh+M4QxMemQJ
 /frHz5c/l6W7kay/0h7OF0GUrPvYppaWmfUoo9IZt+wLt6tKojQAAAA==
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
base-commit: 820d5dfede0cd55dcbc89ce96fcfbb11b7c457ba
change-id: 20260707-internal-h-2efef660381d

--
Sincerely yours,
Mike.


