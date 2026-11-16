Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389F606A31C
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sra+k3C1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HS+icqbZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lRSp/KC43fGl85hMws3gLKnBnmqSKLCoF94lqJrfAqE=; b=sra+k3C1jvSmxESGTN3emVaWJC
	KswkUm5ob5Y7tuKX/UrewTxLGFEepVxFTO600w8ZiC6tQq0Gc7dYdgRdUMbqf9QpOtQ4ZtTBu7gsj
	zBj0zHgMG7mwXSOYFjs4czIW8/zmcmNpbkPNFpzTjyTwbjrRuOdisXI0GXWJCm5cnPQfVqJW+m/W9
	VjQcJl+S4KW+PUBjqUriKloPx8NL2aATD6bJ/IaMc4GwTdm36Z2BUT4Ycp8wKay4iFBQzCoAFUmIo
	cIJ3kdshJ1YaGMQoh7I2SERdImJI5EKwR3aFEVj3bon/SNUjYWDYqISujargnZ+s4BWf6DXTfzYdX
	27idokMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5vU-000000048fG-0CnT;
	Mon, 16 Nov 2026 23:15:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5vS-000000048ea-2Sqw
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:15:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DBD643CC1;
	Mon, 16 Nov 2026 23:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7DC1F000C4;
	Mon, 16 Nov 2026 23:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794870950;
	bh=lRSp/KC43fGl85hMws3gLKnBnmqSKLCoF94lqJrfAqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HS+icqbZIwAvtzuceRLVtpGNxVXXidAEZwW1IgkoWdrqefKgKmafv6my/m1BetmXq
	 imfVa37wyQPRUWWdHlNgjGFkiGaZO00LWnsnsMMyyZl4umJirEyZcmJB3OQ1TCnGkl
	 U2aPOhqbzZK8LWqf0N6fFXFbiH29M/suvX63zbgyqOjLfn1vhqTrXkU+9L4O2p4hPY
	 tDmjpkjsYW1g1ZcbiUABR9oJn/rCBMAeRF/VWha3yz4if00nMEnPwlhoNEYRqPO0eq
	 te8C8N0VvI2dr24iC8W0rmVZ2gpGnoDNcO7WcnR75uUficH5kM+drNW2eiBq1cU0Tm
	 JEgvU+aTNfPpg==
Message-ID: <sashiko-outbox-217866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/7] mm: kasan: skip KASAN for GFP_HIGHUSER
To: "Jeff Xu" <jeffxu@chromium.org>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Zi
 Yan" <ziy@nvidia.com>, "Alexander Potapenko" <glider@google.com>, "Andrey
 Konovalov" <andreyknvl@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Marco Elver" <elver@google.com>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Catalin Marinas" <catalin.marinas@arm.com>, "Chia-I
 Wu" <olvaffe@gmail.com>, "Dev Jain" <dev.jain@arm.com>, "Evgenii Stepanov" <eugenis@google.com>, "Ian
 Rickards" <ian.rickards@arm.com>, "Jann Horn" <jannh@google.com>, "Jeff
 Vander Stoep" <jeffv@google.com>, "Jeff Xu" <jeffxu@google.com>, "Kees Cook" <kees@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Peter Collingbourne" <peter@pcc.me.uk>,
 =?utf-8?b?UGllcnJlLUNsw6ltZW50IFRvc2k=?= <ptosi@google.com>, "Ryan Roberts" <ryan.roberts@arm.com>, "Tomasz
 Figa" <tfiga@chromium.org>, "Will Deacon" <will@kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Miklos Szeredi" <miklos@szeredi.hu>, "Baoquan He" <baoquan.he@linux.dev>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Allison
 Henderson" <achender@kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, kasan-dev@googlegroups.com, kexec@lists.infradead.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
In-Reply-To: <20261116230627.3537051-6-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
 <20261116230627.3537051-6-jeffxu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:15:36 +0000
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

> Move __GFP_SKIP_KASAN from GFP_HIGHUSER_MOVABLE to GFP_HIGHUSER so that
> both GFP_HIGHUSER and GFP_HIGHUSER_MOVABLE allocations skip KASAN
> unpoisoning on allocation and poisoning on free in HW_TAGS mode.
>=20
> Previously, commit c275c5c6d50a ("kasan: disable freed user page
> poisoning with HW tags"), commit 70c248aca9e7 ("mm: kasan: Skip
> unpoisoning of user pages"), and commit 0a54864f8dfb ("kasan: remove
> PG_skip_kasan_poison flag") added __GFP_SKIP_KASAN to
> GFP_HIGHUSER_MOVABLE because user pages are not intended to be used as
> directly addressable kernel data structures, and the lower likelihood of
> catching a kernel linear-map bug on user payload pages does not justify
> tagging all 256 16-byte MTE granules per 4 KB page on every allocation
> and free.
>=20
> GFP_HIGHUSER shares the same kernel-accessibility contract in
> [ ... ]
>=20
> Link: https://lore.kernel.org/r/20260519-panthor-kasan-v2-1-b7384458f076@=
gmail.com/ [1]
> Link: https://lore.kernel.org/r/20260521105148.5497c281@fedora/ [2]
> Assisted-by: LLM
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116230627.3537=
051-1-jeffxu@chromium.org?part=3D5


