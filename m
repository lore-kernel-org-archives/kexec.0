Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A80606A31A
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AfmAUR5f;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNRMQknp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BTXKKvZZ1A5xGnBvN7q6VkvFyR3TifJU6DyvGMFA+KQ=; b=AfmAUR5fdIViE/cfNWZYnSlTn/
	SYj7UsFphmoBxNQDHmL/h/Bezw4J4QpJmehI0qDCUZ1URjZ3IaslLIRAH+7r+ypunYRqfQbh+tXXM
	+8Cz3g7P/XfbqVFHukfCMxcjbgS1vLfZpOejCEcDbHm3PBuJwHp+GdMmoX4yZwAllUnSMwo1H5abd
	aJe3uW0FEFYBInA1F0O75/dkVb1zwhyrpktjszqeBq6SqGsDtZaxyyudApfIuLk3oz7OWumCYdi9u
	OwYxkfO14ZyVhZxHmfyKnYRndmNoIib4xtesFeZcqMrVTppYDroXQkHCtJYbuAzBi5OPGwM+AmXEq
	CCS+my/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6y-0000000H4qP-02h9;
	Fri, 23 Oct 2026 22:51:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6x-0000000H4oc-03Pe
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 22:51:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7271A60A87;
	Fri, 23 Oct 2026 22:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D5C1F01825;
	Fri, 23 Oct 2026 22:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795902;
	bh=BTXKKvZZ1A5xGnBvN7q6VkvFyR3TifJU6DyvGMFA+KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNRMQknpjDSMImsmPQjC9bDo0LgO51+nudI8XKn3OwGLZ2jIPuRqkMyRbACYhVJWX
	 4A3I46gX59JvUCMJxnTQJq9lfivl5l/ERIAOuI33xPnfnniLhwfM1E3+634r4q/JVZ
	 DkChjF+qt6XV+AZ+D5ld1KNb87r6Ovegwcbb6JpeJDUeN3LwUp+WtQcUiKfEXeDoUY
	 THPHN5SDpzoBqOvKpk6oyh+oEFMMvIl3V7imI0Szkghoo9UM1c1jXKW+141B9KH7Uj
	 cjG0IDsFjU0kDygPiOpQOLCbg9NWm5XqAMZidN/opDWR443clmkCcOeE4avF0w7HjL
	 tjtPCS9EIUVrw==
Message-ID: <sashiko-outbox-183329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] selftests/liveupdate: Add a test for
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
In-Reply-To: <20261022225035.377445-11-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:51:41 +0000
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
> tmpfs quotas are not tested, since the test runs as root, which is not
> subject to quota limits.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022225035.3774=
45-1-dmatlack@google.com?part=3D10


