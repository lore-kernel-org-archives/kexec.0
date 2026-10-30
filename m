Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85371606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s67tafyL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFEHCcUA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WWHlJvm4sYewhU38umcbZ0ROTrmcfZhQeV3HCRulFDQ=; b=s67tafyL93qASo92alpd1sMxAW
	kXKVJT8haocLJj+HrQbToR3UhvrWo459IDNkjjM0ZNMo/vKnlmDfvyyoEyOkeWCK8vNM4Nb4HX1V+
	lrJiB0CGgyzyaAP7/UJN74S13OZFf+NQk8SIyIjSjnj4op3ikCzTzT9estCnQUX8vTOMHn8X3gxAB
	OJ8vclzY0xISnTV6FMsaBCN0B5zCgff8OILOv/I5D8CO9Jq+ylYijP3VSQ2rVtszslnf4UIj5gHjK
	I6YUDeurCgjJ1ObpolwmsJIu9SO8IwKbWBmWjcCY3aNq6Ogy3uxMi5huos008WL8O2SOg5F/k9Soi
	R3N8hREw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdV6-0000000Akkg-0pfF;
	Fri, 30 Oct 2026 03:41:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdV4-0000000Akjm-38Mt
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:41:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A21F42A9C;
	Fri, 30 Oct 2026 03:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8421F000C1;
	Fri, 30 Oct 2026 03:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331714;
	bh=WWHlJvm4sYewhU38umcbZ0ROTrmcfZhQeV3HCRulFDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFEHCcUAJ73UlIzKp4w1Ztp5h4592qFsZ9sHNRG5dVP0q9DgDRk0IbHFKCSr/AOru
	 CeRaXBpbQz3CDJkQbfPOqzJEOAq0aCWC3jJsikNkX9hI2VvShru/1QVonMz5FzX4cV
	 hSHayMPVXKUORlb7Q1g2t+UcrGuPwZGikOzPaHI2og7p8saSR5CHrsHt5ZEQo1qB6t
	 WNNiCwnJu8OX6lqWBI8+S+fKvYxDe/vAIj/G2SE1FrDlxQJJB8CW0LtoZZkFuBr89d
	 LrjVvpyCykCLFkN5ROF3HGCXd4SXiGxOMSeAxZJsqxijpKtwJ3K+lNGbjcFPWwY1CI
	 /TZx+cc9qxMuA==
Message-ID: <sashiko-outbox-190259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 31/47] mm/mremap: recheck PUDs under the page table
 lock
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
Cc: kexec@lists.infradead.org
In-Reply-To: <20261029-fixes_core-v2-31-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-31-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:41:50 +0000
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

> Once get_old_pud() is fixed to accept PUD leaves, unmap_mapping_range() c=
an
> clear a leaf between the lookup and the move. Holding mmap_lock in write
> mode does not prevent this.
>=20
> If the zap happens before move_page_tables() tests the entry, an empty
> PUD can reach move_normal_pud(), where pud_populate() turns it into a
> present page table entry. If it happens after the test, move_huge_pud()
> can instead try to move an empty entry, triggering CONFIG_DEBUG_VM
> warnings on powerpc.
>=20
> Recheck the source under the page table lock in both helpers. Treat an
> empty source in move_normal_pud() as a completed move, and use
> __pud_trans_huge_lock() in move_huge_pud().
>=20
> In the future we should likely have the code lookup a PUD/PMD lockless
> once, instead of multiple times, because one of the problematic bits
> here is the:
>=20
> 	pud_trans_huge(*old_pud)
>=20
> Fixes: 0881ace292b6 ("mm/mremap: use pmd/pud_poplulate to update page tab=
le entries")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D31


