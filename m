Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA9606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zF0AB5i8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqb5GSF6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XLcmW6k9cUsAndVOmZ2UJBXIC6qWQDPqUdlwIwcky4A=; b=zF0AB5i8l2vz+KOFOMe8IBSbOD
	yNU2/txzCY8fz/qv2ihtD/gFevchwJvu7Dy9w4GXize8MTmsErZbAQOSpSuPwnWxwrVn9ymK5GK+F
	S5HNGQ5ij+533LnzM3e318WFDeDJTXz2nT5RLGC9SXZf9lg/Pf63PyTvxnVamtr8KRBTix5nejm55
	ejUeb++XUYBaEgO83eP2U5zj0G2zD4oCw0pqdBKFwwu5m6/LOijNn3CS4tOtgxZ0kjhj9bKLXswgl
	cpXU1JZ+/p716nUUgVwlefnNm7BMBG4EHvBHChiRmMIoX4Ibwf7z3Rj90D5KZjTr/FtUWpHohAIpy
	NWh1o+5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIip-00000008FKc-2GOc;
	Thu, 12 Nov 2026 00:31:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIil-00000008FEm-25ho
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DDE9F632AB;
	Thu, 12 Nov 2026 00:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D001F00A09;
	Thu, 12 Nov 2026 00:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443478;
	bh=XLcmW6k9cUsAndVOmZ2UJBXIC6qWQDPqUdlwIwcky4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yqb5GSF6mND2jfWgqMEHZqeEI82fVv+MCY1JHtzShd2YqoM9OIsVqyXKombyXBfWq
	 QccWTQ5suvFmCecAlcTXMajnOp8saAiFSFXyhss5hPd2RUmf6BrkGodyO9XhW0b/Ay
	 7cveO/Xnt2RyjiaU3/sDGZHwxlrKcd0NZ4qM4czJqwlqQiLVdGkAx0S5eEVmLbbvK/
	 5BpnhyF36OFqkieC9R3LUfnDOttaK1Zkn2ZiXnD1hjzVYtxLpIVpa0B0/bNntlPRu3
	 ndlC1Zwm+8XHTQhKwf3trSrOpp752+FqH8mcnPUTDui+lwRRLFl1GcKVzL8IFTouad
	 ipahfxtKONA1A==
Message-ID: <sashiko-outbox-209942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/19] mm/shmem_luo: Don't make early retrieve
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
In-Reply-To: <20261111002358.1842967-11-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:17 +0000
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

> Mark failures in shmem_luo_retrieve() before it starts restoring the
> folios as retryable. If no retrieve succeeds, finish() frees the
> preserved state, like it does for a file that was never retrieved.
>=20
> Until the folios are restored, nothing has consumed the preserved state.
> Leave it for another retrieve, which may succeed, e.g. if
> memfd_alloc_file() failed with -ENOMEM.
>=20
> The exception is a preserved file that this kernel can't restore, e.g.
> because it has seals that this kernel doesn't support. Retrying can't
> help, so keep that failure permanent, so that every later retrieve
> returns the same error.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D10


