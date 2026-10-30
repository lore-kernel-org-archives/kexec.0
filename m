Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42EA606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3fp2vWSX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bq6IbL5W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZhL8BNSrHZGSoY++1Be8XSKI/qF2Hy1grT9AAtL1Ig0=; b=3fp2vWSX1dBLQ7kP734ob9NZcB
	Quvg5zTCThwCqlW53F8YZS4FLOrnKSXrhKA7f65m2d8CFnIUh6EhmtFkvclyh88MstrF7QO5qErk7
	IBJVOPt8xU3eTwU8lwNYL7KWOcAW2HIQCDuFcdL1y9XXqY3Yh8dDp83sjh9curgADemhU8pNtCEY8
	KzRX24Nir3E0DGSAnogpT0T/uSNE7aYfhoqud5VqC0XAUrHEmE9vtlKuePdTW3Ausa7tieN9P0p4Z
	hAYbRezyC0eyVydJ8/DAt8oFkfgdpBoHW+3zGhWcOriRaOUXH9FARN+luYzFWgoJhvUUmOmVECCXD
	l8wr+NEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdV9-0000000Akmj-1xFg;
	Fri, 30 Oct 2026 03:41:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdV8-0000000Akm5-1wKd
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:41:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E2744341B;
	Fri, 30 Oct 2026 03:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95981F000C1;
	Fri, 30 Oct 2026 03:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331718;
	bh=ZhL8BNSrHZGSoY++1Be8XSKI/qF2Hy1grT9AAtL1Ig0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bq6IbL5WtmYkqiPCauhwpTHyHIgWH9M5GpoxJKV6boQr/+1ba0saS2qFvta08YJ2W
	 e62gn4AhBFKx1uP5i0ps28Lk3nzMi4WYXqsCFC4ogfW51/o/mx9I9bhHouKgnjeMYI
	 FQLp7TWGlwmLiHR2gmIIz3RwT4VCCCXLbkZmwL4XwCWXqpT3xceEi4yUuSTMd8/hdn
	 E+P8JL/4RveatLUqmB7OJC3rBEo12ZaK5CmSX2D8f185ADFnlqo//5VnNJIarU4zlK
	 HgfxS7U3CEbTfI70jpcxhcDpYtMbH4BRDBuLbx33B6SjUrOSYUjBXuAHxnOK0CK/Se
	 IrsYXk1UCH34w==
Message-ID: <sashiko-outbox-190260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/47] mm/mremap: fix moving PUD leaves
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
In-Reply-To: <20261029-fixes_core-v2-32-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-32-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:41:54 +0000
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
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D32


