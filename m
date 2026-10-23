Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F93606A31A
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OrUUoq7J;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nm7R5MbV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m1z8CzNpb8HI7jl3nc04CgOMsKXrH2QXql27TCYyfA8=; b=OrUUoq7J4May/mpBr//cfVr69E
	zIjqMKwgBCN8E4imhWMsz3kFxu1iY3xB5gEOQSFZJc+wX0C4uRrq+P3RhKvOA1PIdKy4+DUzjZv0L
	41cBbLL8R8nQo6bsmKiOO+/aQnZsK09Y0Ns6lZwiSTDCoxxguqX7NuZiYV70lO1mmyAmuhrDOnOHz
	PklrAK9cCpWp1M5VAgqoLlFw1ueCkgKpdSfH6HAWj9PpIlYPXhQUJna1AiDnnCqr5S4e4o32mOFWR
	8kwvWOwMW7bUPLW4Of4pWUYHFzqaM2Ruw0OisgoBqMh2H6pIf82y+6pM+G+TRpT3KA92UJcjSefed
	5TYFzkTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6r-0000000H4gD-12Tr;
	Fri, 23 Oct 2026 22:51:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6o-0000000H4dF-15LY
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 22:51:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0917A42E63;
	Fri, 23 Oct 2026 22:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1454F1F01825;
	Fri, 23 Oct 2026 22:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795893;
	bh=m1z8CzNpb8HI7jl3nc04CgOMsKXrH2QXql27TCYyfA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nm7R5MbVhUC8m3Q7IG9yQ+atOIUu2ubi5Huiu2lZz6uR8roCBLY8mlDy0S8Bds0E0
	 6SRvD+yN3o3li1WfFMpeBLsi0ZAJ3aBBoXOrpLIA5c9mLqrCXFTBqO8uOATi2U3/75
	 I7Fd9GhyVbEMmdaxmqd2MDCWn8viZfF1ZiQdKV465fCS3jLBx/dV9Gmd3qw0mdt+Z/
	 fiJuvbOplCkv6jpU1/MGwW8DxHHYhKQdRP2HHnWwxVWvymRtwPf6pLUT/kuhNdT4k+
	 PA2yVS6DQZmGFRY56y0nSaMHG8Vd8tw/bMY1M7fK812HicDMp4ZBycC40eOTuyjWSJ
	 qO7nhZiCKheig==
Message-ID: <sashiko-outbox-183323@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] mm: Rename memfd_luo to shmem_luo
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
In-Reply-To: <20261022225035.377445-5-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:51:32 +0000
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
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022225035.3774=
45-1-dmatlack@google.com?part=3D4


