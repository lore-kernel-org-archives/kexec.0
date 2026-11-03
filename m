Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C6608362D
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IuhweuFz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwzRzS5A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gV5NT+tmA2Gw/Z5qKaer//A28wnkD1hM4OuWasFx0vA=; b=IuhweuFzJLeMJ2GG5F2Bw3krxy
	7UXrNOjWRD96OgZz4dVOmPVoF2NnwYez88srno0oGx/UNRQKA1wZxsNlLgLpyl+5ZFIDNL6oYmkpD
	eLH2noqAb7XyM4PTIft0Q3h2+yRqfPJ5OoCrhoF/If6KkdDPkE9fz9XLHVCID9SA8NPajCtUVLccO
	XSL+/z/K6NFHmoOq+0vrUrsPXISHoHC1tgG6Oex7Y2cqRcapUYJeshSyiJlHvSyK5ecYG95VY/oNC
	2rPaJYKy4xprsU59zlNTDyYOHeZhvcDjGBsEu2hZl7OD2LvqhwKg4xjJxht7TyAiBsKALLArbyOmU
	Yl3FHTPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGeS-000000030Mx-3WnW;
	Tue, 03 Nov 2026 15:42:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGeR-000000030Mk-3SMR
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:42:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A7CD40310;
	Tue,  3 Nov 2026 15:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DD51F00A1B;
	Tue,  3 Nov 2026 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720539;
	bh=gV5NT+tmA2Gw/Z5qKaer//A28wnkD1hM4OuWasFx0vA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HwzRzS5ARH48CYlno2DpragId7JUW6ojVgtcDiSFJAIzu5juxtmR/3WVLzX14aHzt
	 CRFFYL60LNskKk+FmPOt9GAxfb87TWYiibB7JUITEGeqbhw4H22bVziUS9pl/uCxz/
	 4L08PByALJ3d/vMpQoayFp9L7Ziw05YCfi6dX4XRl9CARMSeC8SlX71r+DtsDhfxtQ
	 tZUqthwvJ/O6FJhQniXpDgooEIOmc5mjwAJym/a5Nm/ylXNPVfm0teAs1Cex/hHGA2
	 XuTH0KbUGyKVLKTm299K5t0tl5MHMuBZtroo//VxA9NBhb6627SCcbqkcLrYc76vje
	 5evpylYOlF06g==
Message-ID: <sashiko-outbox-195638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] liveupdate: check for duplicate session before growing
 block set
To: "Christian Aurich Zanettini Martins" <christian.aurichzm@gmail.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: kexec@lists.infradead.org
In-Reply-To: <20261103153928.716753-1-christian.aurichzm@gmail.com>
References: <20261103153928.716753-1-christian.aurichzm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:42:18 +0000
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

> luo_session_insert() grows the outgoing block set before checking for a
> duplicate session name. On -EEXIST the new block stays in the set.
>=20
> If the session count is an exact multiple of the per-block capacity (51
> with 4K pages), that block stays empty. It is serialized with count 0,
> which kho_block_set_restore() rejects in the next kernel:
>=20
>   luo: Block contains invalid entry count: 0
>   Kernel panic - not syncing: The incoming tree failed to initialize prop=
erly [-EINVAL], disabling live update
>=20
> Check for the duplicate before growing the block set, as
> luo_preserve_file() does with the token.
>=20
> Fixes: 2a441a14c2c0 ("liveupdate: Remove limit on the number of sessions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gma=
il.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103153928.7167=
53-1-christian.aurichzm@gmail.com?part=3D1


