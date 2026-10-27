Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90E606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dDlKQWVt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIt7QM+L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ynZeVp4GE9gMyAxS9d+MxTL5L2L0Jem+z5pMoQXOO9g=; b=dDlKQWVtm7lAxvhiF+9NwBFnBQ
	TkeSzqTli1D8P15y3RmpwVw84M3Qc/h2bmylqOPQzhfg5kwBXNr3ngk9Crp/evm5k4qk/65Ug9LZV
	oGuOvG4hVDk5A+sJgY44UMhUggpSbPpk+BS0Y6Wve7w+nD5BIQHc2PE5jeRVabSiayxzeHzjU6FYW
	YhZ6BOqFyOOrr/KpmvN5TFGqGNvhYByRqyIrMJXNhfY60J++qs+8qeMSV4DwzOxg/H+uG9oXcbyw8
	7i5jD7iflhbUHJ07AmRW1FSgD6ZlPNwXwFfQufYgl0yDmD6/ODWpCSjN7vejyrnK7ictwqBXWrk0h
	EFOKcJlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUpS-00000003WAG-493G;
	Tue, 27 Oct 2026 00:14:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUpR-00000003W8g-35xU
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:14:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 13A51600DA;
	Tue, 27 Oct 2026 00:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2211F01825;
	Tue, 27 Oct 2026 00:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060052;
	bh=ynZeVp4GE9gMyAxS9d+MxTL5L2L0Jem+z5pMoQXOO9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FIt7QM+LtoZk/9BMUyqAGkEqusx4YtcgVhjZHuLbQmkAPmFpiKHoj50I5rfGlpTUB
	 I/6yCj4jjbNg4pykPFfQk0rZ2IF2lljJtXWDOkmFls6j0GbQnSEEll/RcW7WW67y03
	 qMDPxlxH4NLZeeC4OI9nt5oRHqRef9ggF/dC554M9peo2dQY6WGEAcx73ubuNhcCTY
	 VTRYZ2o90gMMhYOcnjUVKRAMUVWW3l+CrIHX5zJ5ulJCmJkhbSOdPo6u+x/K6NEp6X
	 8bpNgG24anMGUNmhGCJdidIRmTUtTwqZ+yTh2bwdl2B4QWpXN3+ji30NhkIeVcyFbJ
	 eQVTNmGLEDqEg==
Message-ID: <sashiko-outbox-185922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 40/46] mm/ksm: check large swap-cache folios before
 mapping them
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
In-Reply-To: <20261027-fixes_core-v1-40-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-40-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:14:09 +0000
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

> From: Chris Mason <mason@kernel.org>
>=20
> KSM folios are always small, but their shared swap slots can be read
> back as part of a large folio in the swap cache. ksm_might_need_to_copy()
> skips large folios, so another process can map a page with an incompatible
> anon_vma or page index. Reverse mapping then cannot find the new
> mapping, preventing migration or reclaim.
>=20
> Apply the same compatibility checks to large folios as to small ones.
> Pass the page corresponding to the swap entry and copy only that page
> when necessary. In do_swap_page()'s copy path, decrement only that slot's
> swap count, because the source swap-cache folio can now be large.
>=20
> Fix generated by an LLM and sent by Chris Mason in private.
>=20
> Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_=
SYNCHRONOUS_IO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fixes_core=
-v1-0-6f74bec9a5bb@kernel.org?part=3D40


