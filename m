Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AD606A330
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yza+spgC;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhRo/JGb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3NtpiM0xYnT/1v59V3p8St+lXy7hIe2MXzgKrUP93ng=; b=yza+spgCi6qd2ZUHY/bwu3N1ao
	BpFpiuAk5PzW1v3cPSiZq/wm5TEZG8givLpGW9/76Q3nxu0V5MDQbWlRFC6fIhU0YOWkLzJqbjvqv
	LAJUe08GhGIJQqlV8R2E7s/wbiSfC6DSuugcIAsIqLSpY8yMQXifiDrdIjbCO5xyV2IZa8NBJgdgt
	nqTID+DDjGpfQcaPcJXRYQ3ZZ1Ld6JYWE3GCHqCmOWTxbGBDr+AgrLKSHelQxA4PxhxF0QGw6cyQQ
	sNc6XzEF+FGM5u/aowCo3BQz+dYtZraCpS9J/anr2/xdLHSAe+Cztg38aHJ84e9H2Qd8P6KpuEIZm
	UGs68I0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIii-00000008FAC-2NRd;
	Thu, 12 Nov 2026 00:31:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIih-00000008F8Q-3ltD
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4C7343900;
	Thu, 12 Nov 2026 00:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903371F00A05;
	Thu, 12 Nov 2026 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443475;
	bh=3NtpiM0xYnT/1v59V3p8St+lXy7hIe2MXzgKrUP93ng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhRo/JGbCX/91PDkQ3elAjk/DDplilMsthZBwrxVape8KKOzvviG8t++ORH2VYfRg
	 9EqojSvUsTM9UwC13WuE4glg8WhvW0FEiI248Obsao+t2kflrQ6s/y8y7Vbl9Soiil
	 +pGMJiCKCGg6tEhL6B/VYrJvtwgkJQXLPxOIw4QHxcyWDAyRcsYd4jlmrSHL8ZakoD
	 N6IMV1kAWLer4pVHnIL7m7EVWGVUh8mjPZZIqc5xznTrhsB0Oo39W7f8qqqe1W904B
	 zri6vGG4ONBFY7FWmEfuPjJN35OKvl6mjzMYJcK+3E+caXKsiV6Htvn1OEOoPEeUc0
	 gCsUGQo/xaofw==
Message-ID: <sashiko-outbox-209940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/19] liveupdate: Let file handlers retrieve into an
 existing file
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
In-Reply-To: <20261111002358.1842967-9-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:14 +0000
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

> Add liveupdate_claim_file() and liveupdate_unclaim_file(), which a file
> handler's .retrieve() callback can use to make LUO manage a file before
> restoring the preserved state into it. Also let the callback return the
> file descriptor of that file, so that LIVEUPDATE_SESSION_RETRIEVE_FD
> returns it instead of a new file descriptor.
>=20
> LUO starts managing a retrieved file after .retrieve() returns it, and
> fails the retrieve if it already manages the file. That works for new
> files. The shmem file handler will restore tmpfs files into an existing
> file, though, and such a handler has to know that LUO accepts the file
> before it modifies it, not after the preserved state is consumed.
> Otherwise, it could restore into a file that is preserved in an
> outgoing session, or into a file that was already retrieved. Preserve
> also makes LUO manage the file before the file handler touches it, so
> claiming the file also keeps a preserve from racing with the retrieve.
>=20
> If .retrieve() claimed the file it returns, LUO doesn't track it again.
> A callback that fails after claiming a file must unclaim it.
>=20
> A file that is restored into an existing file is already open in the
> caller, so installing a new file descriptor for it would just leave
> userspace with two file descriptors for the same open file. Retrieving
> the token again later still returns a new file descriptor, like for any
> other file that was already retrieved.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D8


