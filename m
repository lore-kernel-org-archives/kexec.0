Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3185606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jNFsOzLH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8MpI2jg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bpj0dvVUVpi7RsWayoERG6Te1lUJztO07bOfw6gaN/o=; b=jNFsOzLH0FuibSX6upwrztx9pU
	JyoC1Q7QmHrnX6Cql3FNjGR+BthNeju1+oyY15P00CgUAC8rqYbnxgnTxhZTGf1NWQ7h7sduhbLOw
	0TEnx5MrZjw3uMocCZJ5dHVvaZHCeeAM9hRnyPvchsgzYy+IvNdC0N824QVPKDEBfN086DQRzTckF
	PMh6nEhavgN/6Y1JaoEqqPxOUeyRpxp3h5/myp4VTSJGw/9izsnHs1Ed6eNT9eUcTg94Y1T94pXlA
	3lL9BZjDoqHm8Hq0Y/keWw7AjHf2d3UDu2SZ9E8Qx96C8tjlDgVNTMye+PlUF4Oiqtj1dK7diVv97
	cSaiq9GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPe-000000042Wx-1UaI;
	Wed, 04 Nov 2026 01:03:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPc-000000042V9-3jTY
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A193A43995;
	Wed,  4 Nov 2026 01:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62401F000C1;
	Wed,  4 Nov 2026 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754216;
	bh=bpj0dvVUVpi7RsWayoERG6Te1lUJztO07bOfw6gaN/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T8MpI2jgP8tTroGfgdwNiv+2ANrVhEvvg1CoPn6Wgs63Q30GZAghhqgJ7FBP92E14
	 tD06MxD7NESv5VzEZTgqzx26oT64AHPE+0s6atQcEg83Rmwklb0nKySkMkbu/pPd1g
	 6tshSlSDmo55BYqLpXlVvTgRm0kCM08BkBftVC+v+KbXtrnBBN4Z6pE4jYB+8MfBP2
	 Ymbo/rCwbvdAAQItf20e5nlLFimYSeAsSabsd5hdL3UJuWT4BDDCpsAY4RlgHxgQzN
	 Xs5u1MevAY3da+yysTQKX2vy23KRsh9tR3DqPi2+PJN/5YL8NgKEMlqZf6VbCjD046
	 pIYN+73Gy0Iuw==
Message-ID: <sashiko-outbox-196341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] selftests/liveupdate: Add a test for
 preserving tmpfs files
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
In-Reply-To: <20261103010216.3447716-11-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:34 +0000
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

> Add luo_tmpfs, a kexec test for preserving tmpfs files and memfds, and
> for retrieving tmpfs files onto a tmpfs mount with struct
> liveupdate_shmem_retrieve_arg.
>=20
> Stage 1 preserves the source files of each test case. Stage 2 runs
> each test case in its own directory, with its own tmpfs mounts, so that
> block usage can be checked exactly with statfs() and st_blocks. The test
> cases cover:
>=20
>  - The restored file: contents, size, position, seals and holes, for
>    linked and unlinked source files.
>=20
>  - Creating the file: it is created like with open(O_TMPFILE), with the
>    requested mode minus the umask, owned by the caller, and not linked
>    until userspace links it, unless it asked for O_EXCL. Also O_RDONLY
> [ ... ]
>=20
> tmpfs quotas are not tested, since the test runs as root, which is not
> subject to quota limits.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D10


