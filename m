Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0760A2600
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=V28TY9VK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwqIIlxM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+dRu/ieWpcjsSh7FVYBbeFZj4sROfKx0KyOovHmm1RY=; b=V28TY9VKYAljio0CEqE9N8LTDs
	Wf0FfXucvCoJxD1k5MEe/p+r6AlIzyKinMKU7nuX1YRNLIUqYFdrFD2aJ9d6R4J7/1qvWJ+NKNOeD
	UXGyrGzxl3R/XG+0knfqREKzL9pJIpcFEOvhGbruhrKPAyRW1+JtfYyBwa13TWIrN10Q+pLd9rsyI
	me+8yrJOjNpNIwNjmXphHeZu3MJhk8/HCbVKtpT2ZcVpMx28/Fj2T9g7i0o/IqTRK95CWVTVpaNCM
	kh8auxybO0FeECtQdFw4PI0tEOt5uOQTLjWbJPXqud95lhDh8p/z+Sej3e01HauNHx2DwlNhD2D4I
	thNBA3TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dj-00000005jQH-3eNz;
	Wed, 11 Nov 2026 06:16:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dh-00000005jON-45oM
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B0A5842BBA;
	Wed, 11 Nov 2026 06:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C58B1F00A08;
	Wed, 11 Nov 2026 06:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377817;
	bh=+dRu/ieWpcjsSh7FVYBbeFZj4sROfKx0KyOovHmm1RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lwqIIlxMXrhYYv9u6rn6/R+m3BQWilpswuTnNNzR7yp3/ItMy1nrzysFsVVxY2uaR
	 pF/iZKJvXjVwtdWWHhd+HL4g9wRnXHBxIc7ngZZjy5tFvlE5lbnjYcuzgiEmr1vcjW
	 BC4iN5Grj6nuG9Cn/enM1yoxbz+v8vEnhZmf6XuWN63tgRG/4i5kvRev9cp3GIN4jp
	 lQuxV8OCqzaAw8jzGfcu+IaFEXDd6SpvZYqvdkv+DpmT8XOIpzJJ1ibGX3T+jYndGg
	 LoNeYtSZiPSwXfZti8k86fBtODSfaWUd4e51aH1CiWZFClJAelnbqxBZ3ScFu2N/Nj
	 wbYWMC0757c+w==
Message-ID: <sashiko-outbox-208420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/19] mm: memfd_luo: Add feature header to struct
 memfd_luo_ser
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-18-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-18-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:55 +0000
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

> Precede struct memfd_luo_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Later memfd features can be appended under new
> feature indices without breaking compatibility between adjacent kernels.
>=20
> Allocate both the memfd_luo_ser feature header and the kho_vmalloc
> feature header in the same preserved folio. On restore and retrieve,
> validate incoming required features before accessing payload fields.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D17


