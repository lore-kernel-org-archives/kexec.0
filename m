Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3F606A324
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1XTQInYV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LKlAaPvM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=N7UVRAXcie/pnloHtsQ5yFhI5Liq7hC0XKhTPdnLG8o=; b=1XTQInYVQUKF9GAcW1CzDTbpnt
	kC2sAcDKvp+pTj9YouYrp5EmdxA1NzlWwZMVqnEI/CGL6pLruHD195qUxaQi44hBlHHuo1qrP7fby
	DgeKOa2rlF41BKnOblS3G5JD48aUJoeUTMjHp0zeI3qMSR7/gPCSXQTGS2bxorJ+qCsDdW8I3XzPA
	XgqBj8+6C89q0MO1E2+OeiremdmSu2L/QHO2FRJ1W2E1egHkXJOwcjCcIA+k01Z50uSPtbMW3RLgv
	iRmVuwhNxW9jGqBgy5HNNOsFJv6CAHcSrRarGnAV7yzg+cVmUqu1alfnGqdExawlWL1ssXzRwB4rO
	BjCpoPfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIjD-00000008FhB-1Jj7;
	Thu, 12 Nov 2026 00:31:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIj1-00000008FYA-26Vc
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 352E640A5C;
	Thu, 12 Nov 2026 00:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319001F00A05;
	Thu, 12 Nov 2026 00:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443495;
	bh=N7UVRAXcie/pnloHtsQ5yFhI5Liq7hC0XKhTPdnLG8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LKlAaPvMFtOTIxzbSd/8bFGWiNYsbAFCVz3X3asYRjYxd3HAc5b1FZzJbYon5qids
	 sKSCQrWPNRC4w94jtouSyemwMPQlFeciEvnVzQyn0PdVzV5VeDHBunmI91rOaVbH0Z
	 m4cCp0DM+jFM3scHZ57zI5Mxj9RuAg7TlpcqiZ2zuzgcGZLFKUN09QguCMdUgCPOP7
	 fttiUK2MEfzFCEAKAxHMK3qmHATc7dlBGFF71UHPi471Id/CihsvjT73LExD0UY2uR
	 bubkdOVgG42mjEa8EvRLqlLcwdnq0dNQK5g2DjfPpFKDwwHhfj32+D+cdM3ESXYcmE
	 JvgIm/ERNrYKA==
Message-ID: <sashiko-outbox-209951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/19] selftests/liveupdate: Test block accounting of
 retrieved tmpfs files
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
In-Reply-To: <20261111002358.1842967-20-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-20-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:33 +0000
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

> Add test cases to luo_tmpfs for how the blocks of a retrieved file are
> charged: The file fits a mount of exactly its size, and a large folio
> that extends past the end of the file is charged in full. Running out of
> space on the mount, or hitting the memcg limit, fails permanently,
> leaves the target empty and nothing charged to the mount or the memcg,
> and the session can still be finished.
>=20
> Enable CONFIG_TRANSPARENT_HUGEPAGE for the large folio test cases, and
> CONFIG_CGROUPS and CONFIG_MEMCG for the memcg test case. They are
> skipped without them.
>=20
> tmpfs quotas are not tested.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D19


