Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BD606A31C
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L4GfANsv;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROaesS/3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ktrth7z6bqVEoDbxEbdj3gt+iDStXOa/hCnDg/6qtJQ=; b=L4GfANsv0WbNTY/nNKC4FTw/ak
	GGVHgHGk2I9wwTQ2MIl8gGFSQSpx9XNLkk/AwbyXuxASKdv4VN5KvjxzXxm3h7QNvkcM0zPUhQF+c
	aVyHRZi9mTUxr5a2QdUWCQ1EJUCDI+YP9UKDcGgE0zFgDAEjtEWOyfMfV6xOAJTqRpoTukMzl+wkn
	FzGMkP2X+d0ch99+wXwXNTx5isF2ZD1JPx1ITf2E/Ri7MConuvKV5meR48+sJrOSmxr1He6OmekWN
	pWzDvOmzJYmjT/syotqr6HkIkcgcW+/191tdCJm8eGlxnpJkVEVm7f0KtBLMNuQLS+57X5xUl6Cxj
	4ycu49hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7Uf-00000007fJZ-3Vct;
	Wed, 28 Oct 2026 17:31:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7Ue-00000007fIF-19BH
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 17:31:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E32F43F24;
	Wed, 28 Oct 2026 17:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C098C1F01825;
	Wed, 28 Oct 2026 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793208679;
	bh=Ktrth7z6bqVEoDbxEbdj3gt+iDStXOa/hCnDg/6qtJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ROaesS/3UY+bMtqEYrgD16vTXgF++4D5YrKOrOsjWLhYhbszmRmx5WRaqj1dGubTv
	 Bqoy3lDU3B75ZY0BSZIYjx6M/Hdu4qg7vRABfWNEOesJqJQTx74WNU9Sucgf0iPS13
	 CTgincU0ol9K6SAq6rdrTlB6ye3jQ6OuwQw/t2pX7I+BHLvOj+1Px8TvYwsTvMkzig
	 4r78nB6BXAoe2ErRxdDeH67MjVshTWqC7OM8FHsLVn9QicK2AZ0ix3U1Y8bt/FYmIk
	 7bUmAatQpMgaJGekvrXImQxUvsTwIShupg9KQEahUzVzkg4Wcz0vNAmUE9V8etoOaJ
	 WIzUFwCoR9QVQ==
Message-ID: <sashiko-outbox-188235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm/memfd_luo: don't use memfd_pin_folios()
To: "Pratyush Yadav" <pratyush@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, =?utf-8?b?TWF0?=
 =?utf-8?b?dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Hugh
 Dickins" <hughd@google.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>, "Zi
 Yan" <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Byungchul Park" <byungchul@sk.com>, "Gregory
 Price" <gourry@gourry.net>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Kairui Song" <kasong@tencent.com>, "Qi Zheng" <qi.zheng@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Baoquan He" <baoquan.he@linux.dev>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>
Cc: kexec@lists.infradead.org
In-Reply-To: <20261027173031.763213-2-pratyush@kernel.org>
References: <20261027173031.763213-1-pratyush@kernel.org>
 <20261027173031.763213-2-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 17:31:17 +0000
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

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>=20
> memfd_luo takes a snapshot of the folios in the file's mapping. To make
> sure the snapshot does not go out of sync, it pins the folios in the
> file via memfd_pin_folios(). The pinning also migrates the folios out of
> MIGRATE_MOVABLE to make sure doesn't land in KHO boot memory or in a CMA
> region.
>=20
> memfd_pin_folios() does not lock the folios. So it can race with
> shmem_writeout(). A folio returned by memfd_pin_folios() might already
> be in swap cache. This happens to work but is fragile. memfd_luo looks
> at folio flags and index on a folio that isn't in the memfd's page
> cache.
>=20
> In addition, memfd_pin_folios() needs the caller to allocate an array of
> [ ... ]
> | THP, 32 GiB      | 4.83 ms  | 5.21 ms    |   +8% |
> | sparse, 32 GiB   | 8695 ms  | 7269 ms    |  -16% |
> |------------------+----------+------------+-------|
>=20
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027173031.7632=
13-1-pratyush@kernel.org?part=3D1


