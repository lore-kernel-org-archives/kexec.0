Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4469606A31A
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PXyEYkPh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7vpk+Y1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0GRUBHSKmS6giePmd2cuzT/pZXJ6KpR8ZL1ZvA+aOD8=; b=PXyEYkPhaoKLr9gIBRLkDzRzbb
	cu09ykRfsr3H8D7Op8x+tCc1Dn7L1T/BQpM/i+1QZLFQLAe1WebXt+mm26ZknNNjlFHHwQ2qNrJmI
	b5g56XJhRn6VPIo6yVMbC1gy+rx5dN55jThw/LmrHDo/ww5NR4DHH3V+T6WrhpYBVHbyTgK3mqbFU
	H1nPKOLzt1JzTpvE+Jy9A/cebtwFnpCuKksiB/EBmjV9WyvY3Uvr+0+wyB2PVGMiCdW/D1z49F6Dz
	sTjMBmPnCHA41BdeTeWWlfK0BI7In5vpQWUtxg0J7Uif4fxbEB3TDfo5+hOd+snZX/zhJrdhsDfbV
	cSy2Z8vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6s-0000000H4hz-2Ejb;
	Fri, 23 Oct 2026 22:51:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6r-0000000H4gA-37AU
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 22:51:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EF8FE60A80;
	Fri, 23 Oct 2026 22:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1C61F01825;
	Fri, 23 Oct 2026 22:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795896;
	bh=0GRUBHSKmS6giePmd2cuzT/pZXJ6KpR8ZL1ZvA+aOD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J7vpk+Y1gH67GSYkSJSKwPzXi6cxCayd2O10ukHPxFARW+lp2TV0drb9fBrseiNFh
	 X4dpgrFc7PqmiOn29Khu9yyz1fCJCMpmTFkhIywOAjexDMhgn77EafUMimgnSy1nFx
	 UU8PCRcygEkD7ZBBIDtebkOgCZCbEq34uyDxHxZOKMJFs+Za0V6K8KT8aEGvancoJE
	 ScthW7ZRVtLAHzJS8My0FlHF3EuGlO+P0Xz+AG77jt3aSLjK7QlRwM0VFnkb18hgly
	 q5nIhTBvIZYZBeTRoPQIgJ+j3e280TcqD6B6Gx6yjizuR7br3tGqM+zfgIX1jTXv4C
	 MHZVy4dvrJ8SQ==
Message-ID: <sashiko-outbox-183325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] mm/shmem_luo: Don't make early retrieve
 failures permanent
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
In-Reply-To: <20261022225035.377445-7-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:51:35 +0000
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

> If shmem_luo_retrieve() fails before it starts restoring the folios,
> mark the failure as retryable and return the error without freeing the
> serialized state. Nothing has consumed the preserved state at that
> point, so the retrieve can be tried again. If no retrieve succeeds,
> finish() frees the preserved folios, like it does for a file that was
> never retrieved.
>=20
> This fixes leaking the preserved folios when one of these early steps
> fails, e.g. because the file has seals that this kernel doesn't support.
> The retrieve freed the serialized state but not the folios, and finish()
> then skipped the file because its retrieve had failed.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022225035.3774=
45-1-dmatlack@google.com?part=3D6


