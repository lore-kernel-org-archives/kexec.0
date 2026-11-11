Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB8606A33B
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j7YhiGK7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwJUZaGA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jKhtAJpIMZr5zkQ90WAPxbGozyWEzkhOTKXWRTKOuzQ=; b=j7YhiGK7FFMi4Q83iWP7Hgem4M
	FqaRGivCx/domXUBGynUJYuy174RU05HcqalNvmY8GyLg728LlxSL8MUTLY5auBT1uAzvG090PMjs
	kr0SFiq+LQVdWHwjPVVbIM3r99tR0otG5F6wgBjI1K6SlHcV7NLYPtApU83J+SGNk+z3iE5q1vT+i
	8uHPAs/QPJ62CsguiU0K51e0XdsihMHytD6gJ1wr2ie1PDE5Z2jCcudQU0Ot7gT8C1hcYO87Xu5eh
	8XtDxvfKFqUGm8CNWpyTT3UQ/kMWreY9kVTFiGqWyN4nblQcPUUNmoKlwC0uGtgfkYjRbmEbmq3ZV
	390O/f+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dM-00000005izA-22Oa;
	Wed, 11 Nov 2026 06:16:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dJ-00000005ix6-1LxC
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B38C344000;
	Wed, 11 Nov 2026 06:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D1D1F00A05;
	Wed, 11 Nov 2026 06:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377792;
	bh=jKhtAJpIMZr5zkQ90WAPxbGozyWEzkhOTKXWRTKOuzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwJUZaGAA10OJ8aiAKAfQiaMUgxpaWWXnuTeSXsf8IhhOa9PSFn0Rvo6UeCC7aFWQ
	 M5bUtR/NUyDFBnPlnu9WNKosXkTMlZEk2Z35BS+/rHzCTnZKmuGOWP81WE6Ntf6cNe
	 z39Y6Ox86l/URlLcEA8Qon1RSSEKWMkYNk70/DNyWR3wQvqU2i87DrX4/HnzPwVf1T
	 sAtuUMCB0r+QrZZYojiWp7j8rMT7x4k0pdmuFKBgemd+3oYMIrkOIsd++Tg9NXdMaN
	 ++gPQPTiOvJaK7abOWxvJ9pugS05EsrLCxSaBed8IiaQ3qLh3QPBM2pUbuZy8YJzjC
	 /Z3DAKhxlGJWg==
Message-ID: <sashiko-outbox-208406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-4-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:30 +0000
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

> Subsystems preserving vmalloc allocations currently embed struct
> kho_vmalloc directly by value in their serialized structures or device
> tree properties. For example, struct memfd_luo_ser embeds struct
> kho_vmalloc folios, and test_kho writes the structure directly into the
> folios_info FDT property.
>=20
> Embedding struct kho_vmalloc directly couples the containing layout's
> field offsets and size to struct kho_vmalloc. Any modification to struct
> kho_vmalloc shifts subsequent fields in the containing structure and
> breaks the handover ABI across kexec.
>=20
> Convert callers to hold a DECLARE_KHOSER_PTR pointer to struct
> kho_vmalloc instead of embedding it by value. In memfd_luo, allocate the
> main structure and struct kho_vmalloc in the same preserved folio, placing
> struct kho_vmalloc in the remaining 8-byte-aligned space, and bump the
> compatibility string to memfd-v3. In test_kho, place struct kho_vmalloc
> in the remaining space of the FDT folio, store the serialized pointer in
> the folios_info property, and bump the compatibility string to
> kho-test-v2.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D3


