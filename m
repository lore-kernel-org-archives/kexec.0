Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B4606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BsryAWZa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/3bI66V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2FGlcQNvjb1qEph9MnhzIvWuZCAzG9Qp7ajKfHgUz/4=; b=BsryAWZaVVRN8uG6B00LX/r0L3
	QLRLxkhtlw7aHTPDyXiVQbUOeDKtlEHs0FxwA7N+mH3JTJkgVR0cpOE9ayHs6xn0TFl0P8WTFxxf9
	8gmzeMD8ouykc7M8H+apPWi0H3AjLKakeRYhe38vV2PZgIdRY0slQwLBE5E0Wy6/VWRa7Mb/WoweF
	IsOrvaMsHnCX76PU905ddXryrr/YDLj1UHZGR8JPfuQAslKK3vitQ6Ch8kRKflhD2iiPWv2J76gLi
	eFWpL7Eo0r0His+XcEBF83ZHBa698IOmVlQYksOuj16ETponRh49LnNfYE+imHoSQZjIbsoLQor+s
	/EtJhtpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPV-000000042LV-2z43;
	Wed, 04 Nov 2026 01:03:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPU-000000042Jx-0nsM
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 952AF40598;
	Wed,  4 Nov 2026 01:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8506F1F000C1;
	Wed,  4 Nov 2026 01:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754207;
	bh=2FGlcQNvjb1qEph9MnhzIvWuZCAzG9Qp7ajKfHgUz/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/3bI66V2D0MtIlnGzxSU5f9fDGXhHe5WgOkiEGBnKBXcxApWH91dijdUyZFVoEuw
	 jHjCsHw/LV2rhXYM5DP1F2/DnohylXlRIIu2mJ+YsZkbGD9RYZSQ/1PgTAHX44iy0E
	 BkeQ9qxSjXaKLyY0FbEzH3DzPiTP1+b9OzIqRjjRR1DzUooBGzRO94bL7/bFLw+s43
	 sMXbFP57yvI939CoJcgXYX+RYhuI8L0oncXaG9Pl7R6QuLLWE9o+u4f+3AagloKWuP
	 deoucIh4xjklUs15o27XFyoSIjIvvHrYKDLhwgB6WiaVmVC+dQpk5kRFLfuADzf46h
	 h8drTVDELoWlQ==
Message-ID: <sashiko-outbox-196335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] mm: Rename memfd_luo to shmem_luo
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Suren Baghdasaryan" <surenb@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>
In-Reply-To: <20261103010216.3447716-5-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:26 +0000
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

> Rename the memfd Live Update file handler from memfd_luo to shmem_luo,
> including the source file, its KHO ABI header, its documentation and its
> Kconfig option (CONFIG_LIVEUPDATE_MEMFD to CONFIG_LIVEUPDATE_SHMEM).
>=20
> The handler preserves shmem files. Today those are memfds, but following
> commits extend it to other files on tmpfs mounts, for which the memfd
> name is confusing. Preserving memfds created with MFD_HUGETLB, which are
> hugetlbfs files, will need a separate handler, so naming the handler
> after the filesystem that backs the files also avoids having to rename
> it again then.
>=20
> Don't change the compatible string of the handler, "memfd-v2". It is
> matched against the preserved state from the previous kernel, so
> changing it would break live updates from kernels that use the old
> name. The serialized format doesn't change either.
>=20
> Also clarify in the documentation that memfd means a memfd created
> without MFD_HUGETLB, and name the ABI documentation after the handler.
>=20
> No functional change intended.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D4


