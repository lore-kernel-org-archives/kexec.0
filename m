Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE340606A322
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qOtZvdKn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8D5TG2q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V4AbOjSd8nLqrtcumv1Oed6an9beVtdQXmRt91Erfqw=; b=qOtZvdKngqg2F6F1jpFAnx58j3
	DzMh2ajkT3WsBpn+nwmv3oQgEhbqGedyric054cG/ERlBx4wAjnuko+sRtMBHQVftgW/Y3Z1zK/4N
	Q3YAp8J6VQJ+On4stHKJ7BYCpnoFkHHzXIOW4z2ESwTFLAJ/dL215+W3H14eVllTpxoIOZ0FLtIXO
	njsmXrdK4pv7hGXiMV6DP2o+cVu7VxWMvbH93srQ1av0wHPjg7SGdVeLjo6J3jH/FkUdh5EPHvsOl
	1ok1YDDNyTiUA7920/lK/WXyuSWwGTXfvVXmhK79dIrgX6W+vOzaeIaImKPWvkusLH7ZH3lQwJKlZ
	hhHnQE+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUpJ-00000003W1e-2TJH;
	Tue, 27 Oct 2026 00:14:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUpH-00000003W11-3sEm
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:14:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4BA44322E;
	Tue, 27 Oct 2026 00:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC951F01828;
	Tue, 27 Oct 2026 00:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060043;
	bh=V4AbOjSd8nLqrtcumv1Oed6an9beVtdQXmRt91Erfqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8D5TG2qYUAIB/BlTBUWx2qDQG4CnM5GhxgZiAzJlj6IHivJaSx5Lgpeb2H48flyJ
	 gyDT6Ax27niFQCd1BQGb2TvrnuX12snyi9r8mj2/9iw0OJQhIbL4PbzbxNzJMcGdqH
	 m0YHTjDArzysFONEjqiKHtF8ouQ3zwjgijdQcVKU34O63uMABKWxvzT2NiFhjDckFV
	 iwHTVcke7B48plSr3pgS01pUaQRm8jsGvGWfu6ujIzc5cEicBPRFLhuPw9JjfzmTp9
	 ODigG+4f9+YxGh+zqvwbbYW0eqXcE16s/1AI12+65ij3EwdOKXUiO6aSl0rOiJSahl
	 QMZ6+Y9Q3Up0w==
Message-ID: <sashiko-outbox-185919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 37/46] mm: fix deadlock of mremap() against UFFDIO_MOVE
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
In-Reply-To: <20261027-fixes_core-v1-37-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-37-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:14:00 +0000
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
> With per-VMA locks, UFFDIO_MOVE can run concurrently with mremap()
> on different VMAs in the same mm. Those VMAs can share page tables, so
> both operations can acquire the same pair of page-table locks.
>=20
> UFFDIO_MOVE orders the locks by address, while mremap() takes the source
> lock first. These conflicting orders can deadlock; mremap() holding
> mmap_lock for writing no longer helps.
>=20
> Move double_pt_lock() and double_pt_unlock() to mm/internal.h and use
> them for all page-table moves in mremap(). Preserve the source entry
> checks after acquiring both locks. Remove the comments claiming that
> exclusive mmap_lock makes lock ordering irrelevant.
>=20
> In move_ptes(), make sure to just recheck source and destination PMD
> after taking the locks and drop the overly-long comment.
>=20
> Fix generated by an LLM and sent by Chris Mason in private.
>=20
> Fixes: 867a43a34ff8 ("userfaultfd: use per-vma locks in userfaultfd opera=
tions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: use new helpers consistently; simplify description and comments;
>          move_ptes() fixup ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fixes_core=
-v1-0-6f74bec9a5bb@kernel.org?part=3D37


