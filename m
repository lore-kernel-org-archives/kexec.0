Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F7606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Nl4f1ucc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnQLwV7r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2ZbYjkVO/Tyj9ADMpjxCj4P7o1XYmQvtTAdXyF+oamY=; b=Nl4f1ucc1OcgMVBTb99up+HCGF
	4FWQwqKxK0SY/nBTzJmEGOCfVEFAhtZ6ExwUAFp3i4/sRI3mp1lFlBRkf/WR2Cb3Ar7JI1OtVptTF
	w9L0rkoOo5Pzih5X/KhYXA3p6pJycirTnLIOlo50ei2jd9tiA/k44UZVIH73cthtrrLH0PGZCBdjl
	m7zJp4DVTFva6khckvHrVu/S8fE3DHYuJiPZASOZVdYVspnVrfglrM/AG84R+JdcIVo0vT5aNvQ/r
	VuA73owp0kvaEktBsnCawFtBxU+rhc3vMLlVxsBRH3P25rEvsXsWUNlncEA9YQ1Lqo30v47W39b41
	lQFCfJkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdUL-0000000AkGI-3kLF;
	Fri, 30 Oct 2026 03:41:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdUK-0000000AkFL-1mKg
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:41:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BF2CD600C8;
	Fri, 30 Oct 2026 03:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF62E1F000C1;
	Fri, 30 Oct 2026 03:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331667;
	bh=2ZbYjkVO/Tyj9ADMpjxCj4P7o1XYmQvtTAdXyF+oamY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dnQLwV7rNK0l+RMc8F8tqEU6c77p8Ys3neVXEGqK4t2bh5dl/newEegjwUMJBfw+s
	 OH9eBsy8cJo6nadnBZWtaPpj4pWQg4fEsq6L5SUXj0tc02JNzpCGKLKPcHIr0WKrHc
	 9iKNguX6399k5Y44xI90E7AW+RWdnt07mfuW/6/nGxbgKFOuk5I+74P+6HY3017AHe
	 xNMwxMtVxtIZBzUCwNcnJAFHHm9Sg+qspYbcOGiYbmXPCqAo9S61JgZLeMUMYm1AmS
	 k9XetslwWQtdJA5/xntGrxmWVFDuum/kY8SO3dnUuh54J/fPT1v2akxyqh75qG/mbZ
	 02aw/s1W4vosQ==
Message-ID: <sashiko-outbox-190245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/47] mm/khugepaged: preserve dirty bits when
 collapsing PTE-mapped THPs
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
Cc: kexec@lists.infradead.org, "Chris Mason" <mason@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-17-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-17-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:41:04 +0000
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
> try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
> bits to the folio. A shmem read fault can map a clean folio writable, so
> a later store only dirties the PTE. Losing that dirty bit allows reclaim
> to discard modified data.
>=20
> The assumption that regular files are read-only is also obsolete since
> commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collap=
se
> for writable files"). In any case, transferring PTE dirty bits to the fol=
io
> when removing mappings (and while the folio is still mapped) is the right
> thing to do.
>=20
> Use get_and_clear_ptes() to collect the dirty bits and mark the folio
> dirty before unmapping it. Update the comment.
>=20
> This was reproduced with shmem using MADV_COLLAPSE followed by
> MADV_PAGEOUT.
>=20
> Fix generated by an LLM and sent by Chris Mason in private.
>=20
> Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
> Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collap=
se for writable files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: adjust comment; simplify description; cover file-thp as well ]
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D17


