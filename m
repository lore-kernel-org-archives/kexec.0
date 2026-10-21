Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FCA606A319
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IS+1zT5l;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgrCjupz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8haZU/uSO4YsE/DNanZJFIT6TODW0MaMkPaEOqOJvm0=; b=IS+1zT5l8z97eCCUbl5Tc7m1g2
	UKtppW459o1kv8hi15V60lrj6RF/1bjYQcNF+PKEjuzIgflfAcR/2dGoTmfAu1Z6IAQMORO2h/8LK
	rX0ew3GnJMusozKkSQUf83F/iDe0QwKbpGCKv6EG9349B1tM44hYgJFhioOxfrBY8rPk7qr4jlHKM
	QeL2zO3Oascg/urcrhZibbNdNqfkDPittfst0JBC7+LJtcPG8wrrPr55cTlZWIa6w8xtIwPoKE8wO
	n9CLiH2dwYLug2V3fRBF1HFvAqT09cFsOrPZH4uP77JDSKDGoJsvQuCnqpF1qAdzjGln2CuljpxBy
	QAsswGoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdjI-0000000Cv9T-0LVZ;
	Wed, 21 Oct 2026 21:20:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdjF-0000000Cv95-3o9F
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 21:20:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57D4642E4B;
	Wed, 21 Oct 2026 21:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8461F000C1;
	Wed, 21 Oct 2026 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792617609;
	bh=8haZU/uSO4YsE/DNanZJFIT6TODW0MaMkPaEOqOJvm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kgrCjupzTIWwOV/He7flUENaRO28y8wqHH597Guw0RAVpZumckOWT9wLJyi5uTkcq
	 ICZ/vQhnENfLsWm5ipJDb5wnbqvF8DOLv7/NLjYjtHsAY/ucsokXkKl2tvr0Ac8++I
	 yr8Olog3+SdsG/b1WNbJD2Qjxcc80Sxf+dZFd9tKz6GUREVsuzPeXobVbjDm21+tJA
	 rt5KTvFPmIjzbxS9bWI4m4zW0+JAO+f7X1I9w5qEPkpCYTfTWQe5y7gKu6DGb10siS
	 iDiZ6rGHT9MUZYPXRjltYXv1Re/UZMHjK7rnbnWMW+NtiNYoEH7VGlAsMguz4d7vU9
	 WbN6kzpFEMcJA==
Message-ID: <sashiko-outbox-180693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] memblock: factor out the KHO bootmem check from
 memblock_alloc_hugetlb()
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, "Mike Rapoport" <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Kees Cook" <kees@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, "Changyuan Lyu" <changyuanl@google.com>
Cc: "Tony Luck" <tony.luck@intel.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, "Pratyush
 Yadav" <pratyush@kernel.org>
In-Reply-To: <20261021211058.83483-2-azpijr@gmail.com>
References: <20261021211058.83483-1-azpijr@gmail.com>
 <20261021211058.83483-2-azpijr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:20:08 +0000
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

> reserve_mem regions are preserved with KHO too, and need the same search
> that keeps HugeTLB pages out of KHO bootmem. Move it into a helper.
>=20
> No functional change intended.
>=20
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021211058.8348=
3-1-azpijr@gmail.com?part=3D1


