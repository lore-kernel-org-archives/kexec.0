Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B7606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nw2yLTJz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXS7sKKL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+tXReI7wCMf+vtxRNrBn0q0GYi0LF14nu7zCvb1wKcY=; b=nw2yLTJzZMIEPGrXjS3J+h6RRF
	YD793GBZdb4uKhqTXpyg+pj6pv/LdgnBC+QHQ6L/xzbGYzmQJLlYQRiAOGPj4A77e+braO/m+snuk
	2DMJQ2fceMGGV/5JApPxjRaGc43qxlc4j3qbPWk7eAgced4HAx18b/rdiJZJUyuX8gAMh73CmBU2Z
	fOVh9QeE0DX43LnBynMnyQVPwrQ2qgRUemwbn2xtNcYAFlGrRQZ910HSVWzGgc4qh8iPu33F2+GLc
	yGxo5RxC9iySlSntcK47jdMmrN+dpBLm0GQZYQ8RWvE1xiAWqgsY1w4rDllljQdvRUJjFMvdKaQAs
	0V6yxRUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUoL-00000003VHy-0T24;
	Tue, 27 Oct 2026 00:13:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUoK-00000003VHY-0k8P
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:13:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DD92B408F7;
	Tue, 27 Oct 2026 00:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496CF1F01829;
	Tue, 27 Oct 2026 00:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059983;
	bh=+tXReI7wCMf+vtxRNrBn0q0GYi0LF14nu7zCvb1wKcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dXS7sKKLcbrgZvgc5QpzQbB8G8tKiTFcCOuI+yRZMaVES6PAZvZH7QfBC5spRLKs+
	 2PiuRMkHBNhBYUQOQoJcrMRABb5+0m3ooqQVlmPhBTQ88mmbNr1I6+quvUNBxxEDVg
	 IP8A8wPfPBYXU5YsM2/HQeT6AwmB3NEoSUP3nLPb5GXwjj7FXE4JtXW+CP8a6clZsE
	 bSySMzoUHch+ZkA+QGbxgzFEs6PPkJTjTADcZ6DFvmTe2/XaHrpTCX/FwNpbF0KJCf
	 8nkANNORGQ5QDc/kvPP7W3sm8qMMOcju9QLtCCc/8ZUkwXusROTYnEy0y09Pq4eTO9
	 DNALYxThzWboA==
Message-ID: <sashiko-outbox-185901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/46] mm/gup: recheck the PUD under PTL in
 follow_pud_mask()
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
In-Reply-To: <20261027-fixes_core-v1-19-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-19-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:13:00 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> follow_pud_mask() reads the PUD without a lock. If it is a leaf, it takes
> the lock and calls follow_huge_pud(), which reads the entry again, but
> only tests whether it is present.
>=20
> A leaf can be zapped concurrently and a page fault can fill the empty
> entry with a page table.
>=20
> This currently only applies when device-dax makes use of PUD entries,
> and the fault after e.g., MADV_DONTNEED would find THPs to be disabled.
>=20
> That requires a sequence like
>=20
> 1) Fault in the PUD
> 2) Disable THP
> 3) Have GUP race against concurrent MADV_DONTNEED + refault
> [ ... ]
>=20
> Fixes: 1b1676180246 ("mm/gup: handle huge pud for follow_pud_mask()")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fixes_core=
-v1-0-6f74bec9a5bb@kernel.org?part=3D19


