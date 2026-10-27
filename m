Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA32606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S7GDWLGg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzMJW9Xa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RUfo2XMc3KT6Vu8yQ39DSBh+/d0W96OJd5u+ONpJt6Q=; b=S7GDWLGgYXCYZXx+ywP8GcJ5NV
	7gPlbtFh4ggqykA/DwSMj7STSj0e/Zwdj9IQUZyEbyZuAyQCu6rCsA76hW1C1W3ynNn4Dwy4u/EbA
	768X8DUKFMubZ3oaUjynAxJ1g+vQv4TPGpHeuBK4Z8ckF/yYn3WG1D0a4afmsSyZ8h02bimNR5Mid
	LjKuVLy9FbVT5fij3YekKYWZMynMT/dQMrVRakUKQDN0r/n/pSpdbPMaO6FDoTJKuKWYjKQK2QXxW
	VnIgvoCdpUgZSivFXr5EjOqiN3iS4uGr/BFFy59p641n/WrRaqB2D7U32rIbR2Gzf0Spe2z2+KWw/
	LXBbDsVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUnz-00000003V0b-11NT;
	Tue, 27 Oct 2026 00:12:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUnx-00000003Uyl-1lkm
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:12:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 21E7243652;
	Tue, 27 Oct 2026 00:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936071F01829;
	Tue, 27 Oct 2026 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059961;
	bh=RUfo2XMc3KT6Vu8yQ39DSBh+/d0W96OJd5u+ONpJt6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PzMJW9XaHh9RBYXgywKmm2BurE+Df1pKrVr/6kxrArAz/bG00VQLBikM+fIBhD88K
	 fW1mD+6KDITN3OgImzCNG0ABW2qNKPR7eUz6WQNuDoCqfTlI9dfRalrS1Y0cejkED+
	 d9fPTm+Ep1W0La+aBwIKCQxB9TGX4uvIl3fcUEB46CCG0kT2lQ0+fKXRnjyxNAxyEV
	 yg250LsgVgi7vxV+xCxTdOZVgsVs863APZviVW6Z4J/DtzmDFtRAQqrvji5detEiFE
	 tiNkv+8Ly1aj0HhPiu3JuRVkPDQZwdvRiXp0GQwFOWGGJg9X3GeNN5u3tzh+hyvpq+
	 1hFwtDu0WzCxw==
Message-ID: <sashiko-outbox-185894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/46] mm/huge_memory: fix livelock on device private
 folio
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
In-Reply-To: <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:12:38 +0000
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
> If do_huge_pmd_device_private() cannot lock the folio, it simply returns
> to try again on the next fault.
>=20
> Just like we did in commit b570f37a2ce4 ("mm: Fix a hmm_range_fault()
> livelock / starvation problem"), let's wait for the softleaf entry,
> which will drop the PTL and wait until the folio was unlocked. This is
> precisely what we do in do_swap_page() with device-private folios. This
> avoids possibly livelocking.
>=20
> Update softleaf_entry_wait_on_locked() documentation to clarify that
> device-private entries wait until the folio is unlocked.
>=20
> There seems to be no compelling reason to backport this to stable
> kernels unless we actually see problems there.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: 4964099163d0 ("mm/memory/fault: add THP fault handling for zone de=
vice private pages")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: simplify patch description, fixup softleaf_entry_wait_on_locked =
description]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fixes_core=
-v1-0-6f74bec9a5bb@kernel.org?part=3D12


