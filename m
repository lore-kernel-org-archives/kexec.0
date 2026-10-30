Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C1606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n7WyZBdR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1NozHJG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EXDyCZ9d9v8062HqYr5Ri8CAFz+AKpRHIqe7Y2rz7Qo=; b=n7WyZBdRzm3n0fysd+EWWQKERc
	pOfZTgR8cUTOEk+Iemj8SX+ZF0r7Z89dDNwUjVU0bYb4/spCBAc7wTija3AGMwkQH1u1Z50u7wFA1
	qrph9Pr3DLU+fr/rVdnRWX3iodmiRDW5QUlwSdgQ7F0UbgvFiT7NDPoXgqtFOh+sA9g1QTTfWcfSF
	UcjHebAnYy16QcyRkHpwWgT7n8y1kW/eiECz91wB2glELeb4XsQblrZwY7ta0viOkGAuVW9jFgdR+
	+ovDc0+6bABLQFx9Bf7zXYRltfnxFPDEwBaNtijRUF2eUZtkQUVG89e8agSAltXyeJhi5DiYtJaua
	/cLwTXZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdUU-0000000AkMo-3Whr;
	Fri, 30 Oct 2026 03:41:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdUT-0000000AkLi-2Bm9
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:41:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 485F342DAB;
	Fri, 30 Oct 2026 03:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8331F0093A;
	Fri, 30 Oct 2026 03:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331677;
	bh=EXDyCZ9d9v8062HqYr5Ri8CAFz+AKpRHIqe7Y2rz7Qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z1NozHJGOQV1BOqD8eQkU71Oq6t+Es7kvSGM7+1qWcBHA9vlbolvvorMDZOLzfQwk
	 iutXzYQiuEjjDyrrh0ki3GeQjzw0LX6UKUd360C3pgIkIx8Kxov0KoTStj6eaK5mu4
	 br6G0AjmrAuw3KZfYQTexKXiAa2Dbn6KSh2rhtrrddeo3HKfHiKa0z25lsuoYtVQT0
	 FexFOwhvc+z+UTFUr3F/4vX8WXVxFJGEXt9hYhqW76qCf0ZRU4rB+oaGw7+zx5eVSg
	 Fv/utV4Esioiy96QfvAjL0xh6XsM7HyZneRVO3Pg2wLwpBBbdCPlby1E7CtSvqWe6f
	 Snt3GiC6Pgy6g==
Message-ID: <sashiko-outbox-190248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/47] mm/gup: fix clearing folios in
 memfd_pin_folios()
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Barry Song" <baohua@kernel.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei
 Xu" <weixugc@google.com>, "Baoquan He" <baoquan.he@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Hugh Dickins" <hughd@google.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Jan
 Kara" <jack@suse.cz>, "Zi Yan" <ziy@nvidia.com>, "Lance Yang" <lance.yang@linux.dev>, "Rik
 van Riel" <riel@surriel.com>, "Harry Yoo" <harry@kernel.org>, "Alistair
 Popple" <apopple@nvidia.com>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Will
 Deacon" <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Nick
 Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Minchan
 Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Xu Xin" <xu.xin@linux.dev>, "Chengming
 Zhou" <chengming.zhou@linux.dev>, "Chris Li" <chrisl@kernel.org>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Nhat Pham" <nphamcs@gmail.com>, "Youngjun
 Park" <youngjun.park@lge.com>, "Gregory Price" <gourry@gourry.net>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: kexec@lists.infradead.org, "Chris Mason" <mason@kernel.org>, "Samiullah
 Khawaja" <skhawaja@google.com>
In-Reply-To: <20261029-fixes_core-v2-20-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-20-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:41:14 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: Chris Mason <mason@kernel.org>
>=20
> memfd_pin_folios() pins folios obtained directly from the page cache
> without checking whether they are uptodate. However, shmem fallocate()
> can leave newly allocated folios uncleared and not uptodate. Callers
> such as udmabuf can then expose uninitialized memory to userspace.
>=20
> Clear non-uptodate folios and mark them uptodate under the folio lock
> before returning them to the caller.
>=20
> Fix generated by an LLM and sent by Chris Mason in private.
>=20
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning me=
mfd folios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description and comment ]
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Tested-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D20


