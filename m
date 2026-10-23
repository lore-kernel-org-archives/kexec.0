Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE035606A31A
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o1Ifsefq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTxd5rEH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zn+DjN73xSS2+wN2UnH47utXuIv+PF96Ftx6Sa6ja9Q=; b=o1IfsefqoxIH/8wBKe6ciBu0eq
	d68nD1az+1pSoPPQTDyI0LRId8LuR1kTsvQVuNHKrWVOhNIYCQ7fb5MH9DV5mMGgUw7BcPcgCXM6Z
	zHl53KHeS26dhS8b7TYa+WFsze3gOr73ltj+c+e+Iwcgpm91zv0hNy2MtitwHtKvtG/b5xVicvR4O
	W+0OnbAx3F4KHAfnwtShznvy4pPzLrtBP2dIj1uuQztSqu9zTJWL5+LaMr0iL2cw5mKJUQ68vsWU6
	zVa2U89M5mIJzhUsSA1gDZPPfVvUHgBGkqC1Jq4s/5yn42IOqlS357nOQ5Y65miD88WD9nBO62F6F
	ocSDF/RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6l-0000000H4c0-3yLZ;
	Fri, 23 Oct 2026 22:51:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6k-0000000H4bk-2bUk
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 22:51:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0630C43E0C;
	Fri, 23 Oct 2026 22:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D571F01825;
	Fri, 23 Oct 2026 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795889;
	bh=Zn+DjN73xSS2+wN2UnH47utXuIv+PF96Ftx6Sa6ja9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dTxd5rEHPSRwQEguMAM6Z2akOpKurthTIpZGu+orAmVmy9HD24rD/bxVyQNADEkz+
	 LJFDeo/vs9Audn+QdnNfuBTEBYAWFbsJDm947elyDAzfg+cTYapjl8TcF7i6gOD4R0
	 WHi++nPpvPvCptLRcCjwx3McPuCLeTgUv/fn0oRx25yg6gx8SmBdEnGGyY9FnBTzDL
	 vLcEQE4+ULhPzoRyZaT3fSev1oGNTNxzYErxmKab/rFDi5kx3J2L3JXFzVetI9aRSO
	 UO65SKzmWJpblzrD5kej311nU7K/hP9vHfbUHdeRDma0/x2mEVmz55sKdD68vRpWRl
	 0UAUuoz9HcBbA==
Message-ID: <sashiko-outbox-183320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/10] liveupdate: Pass user argument to file
 preserve and retrieve
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
In-Reply-To: <20261022225035.377445-2-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:51:28 +0000
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

> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>=20
> Allow userspace to pass a file-handler-specific argument structure when
> preserving or retrieving an FD via LUO. File handlers may need
> additional context during preservation or retrieval, such as a target
> FD, device location, or handler-specific parameters, without introducing
> separate ioctls for each file type. Whether the argument is required,
> optional, or unused is defined by the file handler.
>=20
> Extend struct liveupdate_session_preserve_fd and
> struct liveupdate_session_retrieve_fd with a 64-bit arg field pointing
> to a handler-defined argument structure that begins with a 32-bit size
> field. Because IOCTL_OP validates a minimum size up to the token field,
> existing callers passing the 16-byte struct remain compatible and have
> arg zero-filled by copy_struct_from_user().
> [ ... ]
> so fail with -EBUSY if a non-zero argument is passed then, instead of
> silently ignoring it.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022225035.3774=
45-1-dmatlack@google.com?part=3D1


