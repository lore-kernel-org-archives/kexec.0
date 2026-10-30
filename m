Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84591606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TZKSSnQF;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsXni+A7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PIehntMDhOQuefhKM728BoNUkZD/a41nwxdeionK+gw=; b=TZKSSnQFlI1QZoxj+qZVgRBB2I
	C2CviNmb9qF7llaQ8WpRmprD4ee1h+fMtB7aT59IwPf39RzBx2rjTpSNxcs/AXe3gzktn0gVnI6aN
	IwUL5q7ET22Z0BuiO0P+GeYoIUUDrysWkcpWh+WT118rDot+f9TFkM6iWaL0s3RQbQ3rIADKp7NSm
	fbJV0uNM/og0JnvzCvEbxHzGwpI/SftKgsGiJBy5nduEzVYV6P0ffgxmrUGH91lVHzq81kR+zGoUd
	wmK0a34QX/XpecdbVP/Bnvq1R3Mz+CCaWmsg4TvatbyeYDUcHKbdDC2loEFB8oDPWcEhyJMjQSg5A
	eVf2xdUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdUs-0000000AkbC-0hXe;
	Fri, 30 Oct 2026 03:41:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdUq-0000000AkaO-3NcS
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:41:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8ABE64378A;
	Fri, 30 Oct 2026 03:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A321F0093A;
	Fri, 30 Oct 2026 03:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331700;
	bh=PIehntMDhOQuefhKM728BoNUkZD/a41nwxdeionK+gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hsXni+A7Zw4xaOuAYcpA9ICMF0qbJcSiBvBhF9LEqgKwPxjZmVvkco6Vhr2Avr65m
	 x7+mhVyosSaGOJjOD/CVuwwl2wwgcRdD/++vAX8NUVC4ysYTKPMCyvic2T8bCuqPvN
	 3F0YfxzhV6y+sj+U19Tm3KpVnfS1lNqzbm/cDmMxQjIrT1VRs7AgFipL4W6EsqMIcl
	 o7kmyT8QJDTfL2i+mIYxLYLeMli5UuaYl4Jtoj1ztCdRxyL9ZK1YjF+M5iRODQ6trY
	 ZxYWpgstP7QG6KngG7OudsbndsYb5PO7yUiaZf1CcJNrdjX96S8NvIdLI5XR61bWP4
	 iPPua7DKaJcnw==
Message-ID: <sashiko-outbox-190255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/47] mm/mmu_gather: fix flushing ranges with 4 GiB
 or larger
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
In-Reply-To: <20261029-fixes_core-v2-27-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-27-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:41:37 +0000
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

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> __tlb_adjust_range() takes the size of the range which has to be flushed
> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
> and pass an unsigned long. Consequently, a range that is 4 GiB or larger
> gets truncated, possibly to 0.
>=20
> On arm64 with hugetlb, a 64k kernel can have 16 GiB hugetlb folios
> mapped contiguously at the PMD level and flush them when unmapping, and a
> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> at least these two scenarios are affected.
>=20
> Fix it by flushing the proper range instead of the truncated one by
> properly using "unsigned long" for range_size.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handli=
ng hugetlb pages")
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsha=
ring PMD tables using mmu_gather")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: use two-tab indent, simplify description ]
> Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D27


