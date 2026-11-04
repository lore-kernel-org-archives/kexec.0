Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD5606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=chlQpFwi;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SieJqreB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4axXO3nL7G5bgijsfeANN8KYpkb6wMVtpEHlvk23Fcc=; b=chlQpFwi7l6EjOj0vbSNb5HQu3
	1QynFt6t2rTAjy/tf8XAZvWlZyv03RNKimnvrIJ4HNEfkvNsgmAb42xI14BD79xNKcM8oDVDvW6II
	t7O6Mcp7AJOMOx4/CaqeoMh2A4koTXEpeU2AiNQKTn7qr6D684Wm9qgz85zNrLvAEwxTb3Y/QuLcs
	eMEmshS8L1zVKV188EVdfhtVEJ5KRy2YoBf0duhWxOORFg/q3JlZjRLnRuAEEvAKhXeJXlGu8WhnA
	+IPWANGaeVC3687gBvgxW3Kf51hnR2TeAvHILnhVY06r/4HeL2HViZO2ih8Nyod1dlgife17pC48R
	X2zJHG5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPc-000000042Tv-0Sgt;
	Wed, 04 Nov 2026 01:03:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPa-000000042Ql-1die
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6588D60D85;
	Wed,  4 Nov 2026 01:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED401F000C1;
	Wed,  4 Nov 2026 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754213;
	bh=4axXO3nL7G5bgijsfeANN8KYpkb6wMVtpEHlvk23Fcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SieJqreB9CvP6QrZes4bq2SUXxisTj7TQfJdTpET9m/wQP5Q25KVKN8oefzmB3R3O
	 FLIMzLz5+g67iDAeuHqX5zUD0byPqcJXNGfrsyaHUq9yVpcERADEo/gqKbCaU/V369
	 OwsBiYvs/sABqTNFQNJaG7TiyGKDCy1/qFGDnWrCcnC39t1zv2ZpiSxmPYS2D42cp8
	 IY3DpTmYal25XhQUgmVLfOZBnm0QfBNrkBAiRBMguBLBPVHIfk5338HalAZqFEuLCB
	 u5bRa/JpQraZXpB9huOKdw2ZML2yip2jFjwcPEYFXXcnA9WPSAJVWCwx9RkgF1vIBN
	 HNmFKrnLqLiog==
Message-ID: <sashiko-outbox-196339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] mm/shmem_luo: Allow preserving tmpfs files
 that are still linked
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
In-Reply-To: <20261103010216.3447716-9-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:31 +0000
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

> Allow preserving tmpfs files that are still linked. To preserve any
> file, require permission to write to it and the file to be opened for
> reading, and reject append-only files.
>=20
> shmem_luo already accepts any shmem file without links, which includes
> unlinked tmpfs files and files created with O_TMPFILE. Accepting linked
> files means that userspace doesn't have to unlink files to preserve them
> and can keep using them by path until the live update.
>=20
> The path of the file isn't preserved. Like other files from tmpfs
> mounts, a linked file is retrieved onto a tmpfs mount chosen by
> userspace, which can then link it at the path it wants.
>=20
> While a file is preserved, its size is frozen, so truncating it,
> fallocate() and writes past its end fail with -EPERM. For a linked file,
> [ ... ]
> and for immutable files.
>=20
> Document the frozen size and the permission requirements.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D8


