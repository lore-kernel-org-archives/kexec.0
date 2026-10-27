Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFD606A331
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SgYkwXv2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/CP9SX4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2vnlERlJNAFOuSRlH/67bOAJMpNP9jaP45wQMRMKEqU=; b=SgYkwXv2R0OlaCbRS1Md/MFiNH
	ZZVV7dSZm3nv9v1mf1VC1p04sxG/ogeB0q8Xt+s3rJK04bX05IUGlnM1ai4VkhKPBYbjF4T9Dmzi3
	i23tU4Z1mAiYGr3kgJZihSoSffl+H8F9OI3uK4tDDi+dHVaUALfOpzuFHqGC7YkIiTTx38+Ho66g7
	2mKgRNJPduufy6UnO3z3+DizZThD6PihBUmaKz2PYML3OjkFepbQFs+q7VG1gVpCiRgvXD8ZyiN1m
	UeqI2t0KvUt+kRHm3Fm5SLVM197lourml9+S88MKJ02Kf8FCWdYrQd83Npv4dxLRbqQgn+sf6AH/y
	RchzQ9+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUp2-00000003VoM-0MUr;
	Tue, 27 Oct 2026 00:13:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUp1-00000003Vnt-2OzG
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:13:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5490243657;
	Tue, 27 Oct 2026 00:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2511F1F01825;
	Tue, 27 Oct 2026 00:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060027;
	bh=2vnlERlJNAFOuSRlH/67bOAJMpNP9jaP45wQMRMKEqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/CP9SX4jCxpllSGBUQKl0e1EF7cj4lnIeAHLK5SrPj6tgYh6piKwcnXqqAMBw6a8
	 1jeFWvBa4avHWrfNLknj+cFpO/1usdt6U2W6WnYiuuj/3WVPyilfRcbtXXRooTbJGd
	 FSRrJKdRhcLDtO0x9usWgfSFSOEY86qnxP9JBdHc1kLkTLSE3Al9MSY3AMqkLBzYet
	 vBym5dgDVXRL73L3AGqpwXkl/LQCHvdwYFcwGVveCAsYJXpxp/CHlOGA+KJj5bydcB
	 14fA0ZiuciLFGtO5I3BsYOUP4fFyfSoi71TKtWB/P55GjGESmtz8psMwca4tkg2b0O
	 gPmUv2RMNrxkw==
Message-ID: <sashiko-outbox-185914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
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
Cc: kexec@lists.infradead.org, "Josef Bacik" <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:13:43 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> If ZONE_DEVICE memory shares a memory section with ordinary memory, the
> section is online and the pfns of the device are valid.
> pfn_to_online_page() tells them apart by asking get_dev_pagemap() whether
> the pfn belongs to a dev_pagemap.
>=20
> get_dev_pagemap() only returns a dev_pagemap whose reference is alive.
> memunmap_pages() kills the reference first, waits until all pages are
> idle, and then removes the memmap. During all that time the function
> finds nothing, and pfn_to_online_page() hands out the struct pages of the
> device as if they were online memory. A pfn walker reads them while they
> are poisoned and freed.
>=20
> The entry in pgmap_array is only deleted after the pages have been
> removed. Look at that instead of trying to get a reference.
>=20
> This is probably not worth CCing stable.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE se=
ction collisions")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fixes_core=
-v1-0-6f74bec9a5bb@kernel.org?part=3D32


