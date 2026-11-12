Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF54606A326
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OPNGIYQA;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1SwE/Rd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j3xvoEb3g3glJg28RtEPef6QMPui8LetZrRu5/jxIUo=; b=OPNGIYQA2KJytbX6akFHEwJMzN
	rKIN2S3X0bHIxzTFRnIFl4MlYwMAsswqGTIYpTx6smVjqUWQ3qfp9wGHSvPzCpz5v+SV5OxTPOZSY
	U2sH46fso+SdYjcV/blQ3AaU8TiYCPbSZe5VLzb1u39dlNure8zXh+SBtPy+IOhL3ndCnJedN8E0T
	2AIT2QvbU+wXy/XrVXceIzMZog/lVymH6gXpABTALKMDFVGG2UHb43JANF4RoQx3KMUz9LGZJNrt0
	Z9gUJI+7yY0wOyu3TVOAS5ZKuDlP0ftJtRYJSlqVlypE9s2x/0Wc/LYWfPBvb+f992hOSpxMqagi7
	WDJWzpVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIir-00000008FNE-2l15;
	Thu, 12 Nov 2026 00:31:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIim-00000008FGj-35pG
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CCE040415;
	Thu, 12 Nov 2026 00:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2541F00A05;
	Thu, 12 Nov 2026 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443480;
	bh=j3xvoEb3g3glJg28RtEPef6QMPui8LetZrRu5/jxIUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1SwE/RdYpFB3wo9AJ/veY2fBXojCQERhtI5UGfuckzG3gQ/qBRjoubKPnDOGrTcG
	 +PfDv0QVayQt6VJGJnPq8PMBThW+F6D+sRM47VYiLIJ4zGilXxCuuMGxMBdSbdbqi+
	 GgutByUWj1zom7ms/VUEaG/MUuMfRfYAbU29hIn56EYAflKCYOeIcD6MbcHSzMGjZM
	 DX0RwKUSTGZbMWt2P1wZUv7MLRjw+xQJnqa60unCUcRD3EppW07oFECm2QAZuMPpvz
	 22JVEtbYFJi/fZ2+yJMAudV5nIGUbVb22CTDOGy9UHoO/tMyGKDlWJpvnXigQmRR4y
	 AG2chZxSBN24Q==
Message-ID: <sashiko-outbox-209943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/19] mm/shmem_luo: Require permission to preserve a
 file
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
In-Reply-To: <20261111002358.1842967-12-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:18 +0000
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

> Require the file to be opened for reading and the caller to have
> permission to write to it in order to preserve it. Also let the owner
> preserve a file that is immutable or on a read-only superblock, and
> reject append-only files.
>=20
> While a file is preserved, its size is frozen for all of its users:
> truncating it, fallocate() and writes past its end fail with -EPERM.
> Today any process with an fd for a memfd can do that, even one that was
> only given a read-only fd. Requiring write permission limits this to
> callers that could truncate the file themselves. A file descriptor
> opened for writing isn't required, since that would rule out preserving
> a running binary, which can't be opened for writing. Only the permission
> of the inode is checked, so the mount doesn't need to be writable
> either. The size of an immutable file or of a file on a read-only
> superblock can't change anyway, so its owner may also preserve it.
> Append-only files are rejected, since their writers can only append to
> them, and freezing the size would stop all writes.
>=20
> The retrieved file can be read, so also require the file to be opened
> for reading. Otherwise a caller with a write-only fd could preserve the
> file to read its contents.
>=20
> Document the frozen size and the permission requirements.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D11


