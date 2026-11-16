Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A753606A323
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CrN77mEB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmpQqCUj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=grGi9MDFa2ndr+WLT5GQOibMFXvsdaKosOQN2//MZ0Y=; b=CrN77mEBg1OfKvW38xrxjIOoNc
	twkvCf86JsrH5FLMLIy5pWrauX/aIBcdFwzQV9AYgKlZexgByW9rWBeVuLR9BaEKNDkr3sWzQSQV8
	UtqMKl8o0lsR/gL3xD9oddK9X+e6rR77vbm+69yAs2Dl7kTKwT8lsSt1sPWxTZRgg+c/CSFb3N3I1
	JSbxREIDrvBpytbWTRccCCmzsqlDqpgVsX84Y0f1lp4zhoA/rLuFOp4p8rkGm6bKHC4UyXEIhDAG3
	tOHcYVkCeCrO1nhWnfmtcHyMJykzZ0rZdX2IBWvvRZPtEyeyxNFOvYI2Nl0dQm94LbxsiEAngke+P
	NxEdFjoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5vZ-000000048ik-0vFi;
	Mon, 16 Nov 2026 23:15:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5vY-000000048hx-23Fa
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:15:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 34B8642A17;
	Mon, 16 Nov 2026 23:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A8B1F000C7;
	Mon, 16 Nov 2026 23:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794870956;
	bh=grGi9MDFa2ndr+WLT5GQOibMFXvsdaKosOQN2//MZ0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LmpQqCUjKYiEcsETYyv8u0vwyxYn4lK7pM6j+tZ8AuGUJy4Rr1G2dEQe2bv90pnFu
	 zSRaaGo+t1IjgZ3ickHcqApDRFYWhFblsJNsMaWB48X1XF7zBmQprhUdwE67ADkRfj
	 N/ajjnLovPa7OEFAIFNmbhpuMwOZEPe1nf7bOfy1y444naRENQFgv/dG97XfvEkvRm
	 JBUS8ANGrDmfV+zaJmKaoMg8swbphPo1nbveD6+NoBTLCLtqwcjQwzPcWd/8zROTxb
	 wfJ7zAdvc6nUKSC0UZ6aMrnwFRP+6LVmAkMZA18+urDD9npW3bwwvLsJ+WFJH3khKW
	 yIDDXvdUsLOTQ==
Message-ID: <sashiko-outbox-217868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/7] mm/kasan/kunit: add page_alloc_highuser_kasan
 test
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
In-Reply-To: <20261116230627.3537051-8-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
 <20261116230627.3537051-8-jeffxu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:15:53 +0000
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

> Add a KUnit test (page_alloc_highuser_kasan) to verify that, unlike
> GFP_HIGHUSER, page allocations using GFP_HIGHUSER_KASAN under
> CONFIG_KASAN_HW_TAGS:
> 1. Get a KASAN tag in page_kasan_tag() across all sub-pages of a
>    high-order allocation, and the same tag in the pointer returned by
>    page_address(), and
> 2. Are poisoned on free, so that a use-after-free through the stale
>    pointer is reported.
>=20
> The test fails if __GFP_SKIP_KASAN is added to GFP_HIGHUSER_KASAN.
>=20
> Tested on arm64 with CONFIG_KASAN_HW_TAGS under QEMU (virt,mte=3Don) with
> kasan.mode=3Dsync, async and asymm.
>=20
> Assisted-by: LLM
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116230627.3537=
051-1-jeffxu@chromium.org?part=3D7


