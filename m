Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D8606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H3BESp4x;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CD7Wjnz+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=btAFHWraiLZXnwN3m19IqyuO1ZQBC+GObDhlu50KPEc=; b=H3BESp4xmzA1Y9Cb13MUPNxVOt
	IoC8gdCn+EeZzif7X74xU0UkvYqciVfH/VgXA33/nJxlqisbHDqqfYB9DaIlktLkE2ljNqd/LB8Xy
	CIWHt5c1UdL3YDbxoLRTC7xSgslTwNjl+pG44Y+3PVO+6EuD7yb0eZkYRxH0HdLhZLx5DR4Afhjsg
	myLXxmTGWVownFGvq6hb4/auzVKdfYnyjuzgUj7gErkEshUXEDaY5/upsxJDnLeXKKnc9hFt56z3O
	CaVbd1Rq2tLQgVKEWqAlw4EkXlfKMFAiEY/ODO0+N7u5HcfotpXHBHXOvqs0Bh3ADwu0tTcqgaHmN
	DMjeeAJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdrv-00000005z2G-3yWc;
	Wed, 04 Nov 2026 16:29:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdru-00000005z1O-1gq4
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:29:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D0CB64131C;
	Wed,  4 Nov 2026 16:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A8C1F000C1;
	Wed,  4 Nov 2026 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809785;
	bh=btAFHWraiLZXnwN3m19IqyuO1ZQBC+GObDhlu50KPEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CD7Wjnz+JtwGrAA9NRB47TrFMJtyZNjUqSt4adUg7EE4nySAea609sO1i8h42sIju
	 LSCXEtQZhMYtalYJowJIGZ+GOYEpAfTnCBKLTgBknjsSQQYtzXZ3yZf7D8Pk6MEmEy
	 c3DMulzAL6GGC9W2VeqI5jwSG+yIukhIL7CiL1mbG9ISjitJNrZj5S52uVGhE2dr97
	 c3qdE5VinRhKdEoom4lw6Jpr4LLK5VfVTGQh36IkIMNAkPQ9evebHSOXwDpRD+feSi
	 3oeDoh5exOopwyDonQwMRyAuYzMMnk35iu71/msnVr7qadHU+jjvzRt/eEfk9qZYQf
	 Be4Q8HQSxMTLw==
Message-ID: <sashiko-outbox-197612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] kexec: do not place the next kernel in a
 fixed-address CMA area
To: "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>, robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, m.szyprowski@samsung.com, robin.murphy@arm.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20261103162429.2053989-2-radhey.shyam.pandey@amd.com>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
 <20261103162429.2053989-2-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:29:44 +0000
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

> kexec_alloc_contig() takes the next kernel's destination from the default
> CMA area and the next kernel runs from there in place, which is safe only
> if that area does not exist at the same address in the kernel being loade=
d.
> For a device-tree area it does: the loaded kernel declares the range it is
> executing from as a shared-dma-pool and cma_activate_area() frees its own
> image to the page allocator. Record in CMA_DYNAMIC_BASE which areas CMA
> placed itself and accept only those, letting kexec_locate_mem_hole() fall
> back to the memblock search. "cma=3Dnn" works, "cma=3Dnn@ss" no longer do=
es.
>=20
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103162429.2053=
989-1-radhey.shyam.pandey@amd.com?part=3D1


