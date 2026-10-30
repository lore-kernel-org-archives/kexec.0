Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5B606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yYrQBNGa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldUgwhDa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ylGAM8KQRZ9ZLmaDOtxL+ExPvvFScgEppaE4+gvRGSE=; b=yYrQBNGalig4iXGY973aKaMuOw
	3hUjIlfF68jdGcAF7Uz0/H54nC9SJ9MRB1w+Ax2eFwUNfF6YQtkdvYM07jqCcRo/m3FnU8IWrmwi8
	mZ2CcF+Z9knndCbfjHZJtwYqPH/SJ+hvHK8GUKFLvjIPkSgrkLt3awVs6CZmJw3g3ve9w0HlYUg0w
	jjlTc61oxgMGbSrHAby6DTctB5sVuAwjoU3vTlCDosvkGDPjIp/JsCrL/cqrVp9QQNEGU4qQPwgxi
	m3Aa/ZYruewIaTfm1Bh6cDp6W1U14iueNv+9yffEOu5a9ZzULyL9ciS638miTVcYaK7nPfSZQouXS
	UlW8TOXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdTz-0000000Ak0t-14kA;
	Fri, 30 Oct 2026 03:40:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdTy-0000000Ajzk-0mAU
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:40:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84FF7600E4;
	Fri, 30 Oct 2026 03:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F371F0093A;
	Fri, 30 Oct 2026 03:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331645;
	bh=ylGAM8KQRZ9ZLmaDOtxL+ExPvvFScgEppaE4+gvRGSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ldUgwhDaBnmnAkJVyc3e+gU8hak4j54zcsnSMOpGXPWewvQSrwBi0uX3/8A8DXpXd
	 yLuD9ey1ds4DaeiQuyV5fY33YWmImUg9rXwPhRVQWjTxHVZ6cBycC4HH8LlkmGLkkS
	 HbGSpg4ifa8ksdFku4Lh460iYK37O2O5FheBPcVrP7E+4SqPKNeYoosOuVEhLO089y
	 MzpWQ+2D4FyMAyYDxEFRGgUc8QRRlJg9tTYAq15U2rte2nDdlhjn1id8QUs380ENFa
	 yW3D4mBXPMNvAGgfTXla/Evlj28i3iJorxJ1Czs3j2UGQEI9WGDPcANRjmc60ouyGS
	 6gLZMFD4ajABg==
Message-ID: <sashiko-outbox-190239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/47] mm/huge_memory: properly handle refcounted PUD
 mappings on fork
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
In-Reply-To: <20261029-fixes_core-v2-11-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-11-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:40:42 +0000
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

> copy_huge_pud() copies device-DAX entries without taking a folio reference
> or updating mapcounts and the child's RSS.
>=20
> For example, MADV_GUARD_INSTALL sets VM_MAYBE_GUARD on a device-DAX VMA,
> forcing copy_page_range() to traverse the whole VMA on fork. Any remaining
> huge PUDs are then copied without accounting for the new mappings.
> Unmapping them in the child decrements accounting that was never added.
>=20
> Use vm_normal_page_pud() to identify refcounted mappings. Take a folio
> reference and add the child's PUD rmap and RSS accounting before installi=
ng
> the copied entry. Pass src and dst VMAs consistently instead of src and
> dst MM. Move the TODO.
>=20
> Fixes: aed877c2b4257 ("device/dax: properly refcount device dax pages whe=
n mapping")
> Cc: stable@vger.kernel.org
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D11


