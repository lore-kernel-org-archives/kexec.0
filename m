Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96457606A324
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=18vEls06;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1UeEywY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2KEBJhlQN+IifOVpIfen53jQyBv2hvgP9EsuIKqJX5k=; b=18vEls06GDtGKijutjVjxykx5c
	C5MTUHAK2dUfemS2ho7XCzeTU7Q94+7Q/U7haHODbeZmyap2YPN7JkluPE9rAZE5IH/vncRr8BjXj
	thge7ek/HH75OosfN+Q+gk2JoxD3EYR8LzHcMJFkt4LGgxbpXvJYE7Vr0BFa3ge0Ift/mLUhUpNLk
	7qvmTS8dIhn+1wNEpDAEw6i51POeNTDZn234D/za+IzWYF8bJXVM+jtp3iUoD3i1jn1c34QPKQMQB
	BqS+AazMmRrMOjtmGMLi4FNOiy64xzTIHJlg8t3BnD2pwvgcSW8yM1KBEdLU5dgEr+4PYKu+rsCDW
	kU9FOCkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIig-00000008F6j-12is;
	Thu, 12 Nov 2026 00:31:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIid-00000008F49-2euJ
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 64284411D7;
	Thu, 12 Nov 2026 00:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5315E1F00A05;
	Thu, 12 Nov 2026 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443471;
	bh=2KEBJhlQN+IifOVpIfen53jQyBv2hvgP9EsuIKqJX5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1UeEywYua3s1l/jbkxuyqWBRBsgU3z/rz/8xHhqJOxyip9jmWYPnEwAL59UfOF5C
	 A8frMeZMiHDeROprIZoPTBYdQ+E62TXsovdj1tqL5YM0br3qCppT+vNFeQ47Vz1SkG
	 rei6x53LX2zdrlmdxr4fmQJVXhMoEV8vkMJ7dwvxosvv2j/8P/QC0/psdXM+M8qPM4
	 xAMqM+cttxbxodq+yIkQjeRCvvvuz6R0OpO09nf81H4YL6B89Oh/ZBKXc7My/10LoA
	 0ugmKfg8JAXs2jncvT16J7scrLy/XHb+a8VDkPpU24N6eXdVzYwxEiEzNlIBZDJ+vv
	 9K/hX5xVXAdag==
Message-ID: <sashiko-outbox-209937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/19] mm: Rename memfd_luo to shmem_luo
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
In-Reply-To: <20261111002358.1842967-6-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:09 +0000
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
> name is confusing. Memfds created with MFD_HUGETLB are hugetlbfs files
> and would need a separate handler, so name this one after its backing
> filesystem instead.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D5


