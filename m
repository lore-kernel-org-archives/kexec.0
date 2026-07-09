Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB51C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bz0ZIC6honVFONNe2kkGW+tQ+zqDAmMEe2v+OkKeqyU=; b=ltAGUZMM59kkIPQaQ7emCywiJK
	hF5Cv4oVJ9IO7ptqmsDPR0lBY0MfuAlmJyim8+YSETv2udakIvgD1gXXbxVEiC1EHC4iLJ4YF81Lw
	z03jW/dlOBStxDDCeKsRXtHNgEpgptK8EDC5uf6PgjvGcgK4xKIQVx204jvE4JLNCS5PmPg2BBCBQ
	UZy9ZdmP9lrHWuMItT0HFO1EyDt5TPnaztJ7F/CKeFhsTMH/OQj3vFp7pBWuJXQU7xlKhhZAvqP99
	R8EnJHx/zUwdZln7o8Du6tn55f0DbSsjgmTkENjs1OZcCtmPOfImLLIMob0QxsdeKIpiepHR2DWQB
	k3f4yEEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whjVd-00000001MHP-0hDI;
	Thu, 09 Jul 2026 07:49:25 +0000
Received: from out-180.mta0.migadu.com ([91.218.175.180])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whjVa-00000001MGZ-0O6y
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 07:49:24 +0000
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783583347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz0ZIC6honVFONNe2kkGW+tQ+zqDAmMEe2v+OkKeqyU=;
	b=QxdDwnTRWm20VGliIkKhSn+dBliUnrpDgqk1fVsnpLGkywZOxT18NohgKhFG+VAe81Oqpb
	vZaKdUdBDjHYwNPbzP5z3Pr0BIIxbex1rg7tb6d3ea96i0kT0gM7H/us5Hnt3JI8etR/pk
	s6kFktWl8bcGGK9Saz4/zUix/SFzyk0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 0/3] mm: split a couple of headers from internal.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ak9MO-FWjkgr22KL@kernel.org>
Date: Thu, 9 Jul 2026 15:48:19 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Alexander Graf <graf@amazon.com>,
 Alexander Potapenko <glider@google.com>,
 Brendan Jackman <jackmanb@google.com>,
 Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Marco Elver <elver@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Oscar Salvador <osalvador@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Zi Yan <ziy@nvidia.com>,
 kasan-dev@googlegroups.com,
 kexec@lists.infradead.org,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B53B1031-B655-4526-B1AC-952BE39D96D3@linux.dev>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
 <ak9MO-FWjkgr22KL@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_004922_296804_E0C435A0 
X-CRM114-Status: GOOD (  12.80  )
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



> On Jul 9, 2026, at 15:22, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Thu, Jul 09, 2026 at 09:41:46AM +0300, Mike Rapoport (Microsoft) =
wrote:
>> mm/internal.h becomes more and more bloated.
>>=20
>> Split declarations related to mm_init, memblock, vmalloc and sparse =
into
>> new headers.
>=20
> Sashiko rightfully pointed to some issues, will send v2 later.

Hi Mike,

I recall that this work was mentioned during the last review in my =
series.
However, I didn't have time to address it then because I was still =
working
on the HVO refactoring. I really appreciate you taking this on. Thanks =
for
your work.

I've reviewed Sashiko's comments as well, and it doesn't look like there =
are
any major issues. Therefore, feel free to add my ack for this whole =
series
in your v2 version with the proper fix.

Acked-by: Muchun Song <muchun.song@linux.dev>

Muchun,
Thanks

>=20
>> ---
>> Mike Rapoport (Microsoft) (3):
>>      mm: split out mm_init and memblock declarations from internal.h
>>      mm: split out sparse declarations from internal.h
>>      mm: split out vmalloc declarations from internal.h
>>=20
>> MAINTAINERS                        |   3 +
>> kernel/liveupdate/kexec_handover.c |   3 +-
>> mm/cma.c                           |   1 +
>> mm/execmem.c                       |   1 +
>> mm/hugetlb.c                       |   1 +
>> mm/internal.h                      | 183 =
-------------------------------------
>> mm/kmsan/hooks.c                   |   1 +
>> mm/kmsan/shadow.c                  |   1 +
>> mm/memblock.c                      |   1 +
>> mm/memory_hotplug.c                |   1 +
>> mm/mm_init.c                       |   3 +
>> mm/mm_init.h                       | 120 ++++++++++++++++++++++++
>> mm/page_alloc.c                    |   1 +
>> mm/percpu-vm.c                     |   1 +
>> mm/sparse-vmemmap.c                |   2 +
>> mm/sparse.c                        |   2 +
>> mm/sparse.h                        |  63 +++++++++++++
>> mm/vmalloc.c                       |   1 +
>> mm/vmalloc.h                       |  46 ++++++++++
>> 19 files changed, 251 insertions(+), 184 deletions(-)
>> ---
>> base-commit: 820d5dfede0cd55dcbc89ce96fcfbb11b7c457ba
>> change-id: 20260707-internal-h-2efef660381d
>>=20
>> --
>> Sincerely yours,
>> Mike.
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.



