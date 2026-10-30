Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8703606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HipNfAnx;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G17BoS7g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XkRzF+WlqeaBLSpPzXLW1Jl6kgCZWyaasAg+pMaJLIQ=; b=HipNfAnxFFEZDOtsRZQtRYhQh8
	L+8WV1xRdBLVA0XVr9txN5jN/2OhJKHwLazLe4/x8CVneVjkV2/xtvTMppJDEescpcuCxY5sJ3N4M
	z63/wkSuaUJt89rviB1VgZ35IiFZE5/MkUASgJHdvjvu1ixy8oFs4GfflaFAYYHxdeyuYHamG+EOG
	SqcxuaKSHE9nnFIa4gzP+qRtPSKrALSOKrtqbXvj7dUmSNLKRk6ITGUGDTbyc0Hl3JlGg//ikjD4a
	VR5J1ANVfUR2/xXxVB5poBNHpK6SbLcOLhrdUeNQ+DwOMRFJ2DmSqpreqttvu5IKIPEHzSKbs4RCj
	Q8svKNzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdTl-0000000AjpO-2Kav;
	Fri, 30 Oct 2026 03:40:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdTj-0000000AjnP-2iGP
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:40:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9583B600C8;
	Fri, 30 Oct 2026 03:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD51E1F0093A;
	Fri, 30 Oct 2026 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331630;
	bh=XkRzF+WlqeaBLSpPzXLW1Jl6kgCZWyaasAg+pMaJLIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G17BoS7gfahcAXjf9xyqQiMpRmvqkzPXasXH1TYdhV8HqkcDy5VxevigH21GsjHnb
	 Es3Vxp+F1zJdzrnhb+PoVuaoXFXHzDPYj5MldRXbxfcwDVb/b7Gvcy1EVN1TRPd0gy
	 nU5yMbUxhILbx9Cz6Yhlb5n52jJHlwczxgZSLx02E9bAOkqHnK8cYJL2Ok6Qwx6sjp
	 7bI+vhbd6AgzGGdCARObLuci2dTPekqiX40VB8jMgKjIsJan7NLgg+eUV1MOUAsJYC
	 6Cl+OoLybaBzHkxftVptzD4LkyIvKjVtjKwFL2FC44cBw/FmTQuzMu3jM4n/pdPceo
	 MVpM0K1man8ig==
Message-ID: <sashiko-outbox-190234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/47] mm/filemap: read mapping->a_ops->free_folio
 under i_lock
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
In-Reply-To: <20261029-fixes_core-v2-6-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-6-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:40:27 +0000
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
> memory_failure() -> ... -> filemap_remove_folio() can read mapping->a_ops
> after the inode has been freed. Once the folio is deleted from the
> pagecache it no longer pins the mapping, so after i_lock is dropped
> e.g., a concurrent final iput() can evict and free the inode before
> filemap_free_folio() looks up mapping->a_ops->free_folio.
>=20
> Most callers hold a reference on the inode, but not all.
>=20
> Documentation/filesystems/vfs.rst explicitly states that ->free_folio()
> must not assume the original address_space mapping still exists.
>=20
> Fix it by loading ->free_folio while i_lock is still held, similar to
> what folio_unmap_invalidate() does.
>=20
> Inline filemap_free_folio() into its remaining caller such that
> delete_from_page_cache_batch() also just loads the callback before
> dropping the i_lock.
>=20
> The bug was found by code inspection and has not been reproduced.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: 59c66c5f8c4f ("mm: factor out page cache page freeing into a separ=
ate function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: get rid of filemap_free_folio() entirely; improve patch descript=
ion ]
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D6


