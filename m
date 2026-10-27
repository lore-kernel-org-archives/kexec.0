Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883A606A327
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZlxDbZXd;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jw/grf2m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QHo9JMDis/nNK6J8U8zRMdKCromwj/kyHvEHOdJ+mKk=; b=ZlxDbZXd52px735743DM9zdH5g
	IIvkZ7NFz7PjtAgnQwsDE+VVzWa9ddUh6Emg+ZWKzQqvKojlMQg+IbhEWr/K0nPKuVyUDQiNbl8vF
	1dkiaQGdJkP4gszanYpVZI7mC9Kw80z1fkSZZet9HZszD5FZk5scNwtJ//wuoR/TBC3CYqclD1h1G
	qik7yNIUQb4p0meGxRgvfQMXnOGlJOePiLeGcyiBVv6DswERXXAl3IuWtVVhmDp/CXh3dP7Dl/KO8
	oBV+0w1CpFduk0YqxuWDEVcHTLta0ODM/I30zBgwsacKOZZiYDkK+1jlZBIqbr3/OHFSI5RslNSQn
	v5LKSa5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUoy-00000003Vm0-4Apa;
	Tue, 27 Oct 2026 00:13:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUoy-00000003VlV-09uK
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:13:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C496A40E59;
	Tue, 27 Oct 2026 00:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2137C1F01825;
	Tue, 27 Oct 2026 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060023;
	bh=QHo9JMDis/nNK6J8U8zRMdKCromwj/kyHvEHOdJ+mKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jw/grf2maZc1TDDZ7AlMdDeSI0WYjK8ofD3p9WzL0KO0Asexwu1PDk8uOfAmQMqbN
	 /Mzzanmki5dPReaDjAFjKEPzvhl1kuPqxQCXIKa3ub/49OGK64ajBQzOpE0biwrDC8
	 DPxeCgm1IQvbj4b0zLb8xKrHqVln0+39ubnwRbmCiW6yXE5ne5qPlsb4M6ADzgaFs0
	 9GHKzuVXob2Jza5n+QGSPJqsvl2LTsDsYKrGmnDbXaIPVDfpKRvvYKulMpVlUkqzU6
	 mq7IcjTfQtEbbwAQudqafuLf7mJyp1Rl72iFjnVhnt9nQsRA7S+XKquL8a9CjP/RdR
	 xpAnyKF930HVQ==
Message-ID: <sashiko-outbox-185913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/46] mm/mremap: fix moving PUD leaves
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
In-Reply-To: <20261027-fixes_core-v1-31-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-31-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:13:40 +0000
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

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> pud_none_or_clear_bad() only really works on page tables. PUD leaves
> confuse the check and make us clear the page table entry and print a
> warning.
>=20
> Since commit aed877c2b4257 ("device/dax: properly refcount device dax pag=
es
> when mapping"), this also leaks device-DAX folio references, mapcounts
> and RSS accounting, resulting in "Bad rss-counter state" warnings on exit.
>=20
> Allow PUD leaves in get_old_pud(). If a PUD leaf cannot be moved as a
> whole or the move fails, split it. This unmaps it with proper accounting
> instead of treating the leaf entry as a PMD table.
>=20
> Keep using pud_trans_huge() for now, in the future this code should be
> cleaned up to just check for PUD leaves.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent huge=
pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: fallthrough after splitting ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fixes_core=
-v1-0-6f74bec9a5bb@kernel.org?part=3D31


