Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03C606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Aq0CXTZt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILbT5fWD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=e6z6ENp9mw2d0XbLY45BrfnOczEiRPfheO2Dw1rG1q0=; b=Aq0CXTZtZYZSCQCoTnEQ7K/pX8
	bSk/DRJ97qhs5em1zBNNAjfqP1oSroMSBrCMNNIMLNXGHFKaa9gPDfexFRHaoxfCcxqdkZDlX5KOE
	1j/shV6L9U0r+DdgyZDjTTanQmY/DZDCsxaFlhtRPdSffeZyuHZKyOpvfE7Ws4vicT6/N2ORSTRJp
	SGKLGJ/iSZaVL8gksXWNvQOKgXkg6ghielIfX1IEdUMc05GW9n6x7AgaH6wIJEKoOfbk69PO67kBY
	xDJhNV5nImPbhIwDYKehLh+ShbRmZHZmhJVkIuqXqWI0sxHoAlm3Kue0FaX6ZDSXjowZ1XJ+LjSr7
	w3DKLbTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPX-000000042O9-3k8D;
	Wed, 04 Nov 2026 01:03:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPW-000000042Mu-2ohp
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6CC8A43CFE;
	Wed,  4 Nov 2026 01:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604AA1F000C1;
	Wed,  4 Nov 2026 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754210;
	bh=e6z6ENp9mw2d0XbLY45BrfnOczEiRPfheO2Dw1rG1q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ILbT5fWDFPO9tw7ha78DMgUGqs0aGpNmOfANCl0MaXhwSvFIgaHgLsAWrt8HU79d1
	 fjcbZMvQkTmskorIFBhWSbXP2aQZgU8TuiEcdD7HXCybZcdYUaUEKPA7f8iV1C1N3M
	 CmD5Uj1MjmmydBq6Jkk9c/DxkgXMSadUBSIAzPS/O6GCbjmNGntyKk2ndGbVyOSGQ1
	 6s59aZcp2hf2Xz3tZz5dY/x9SuDLPW0UH3/puVxae5LIOxBXxaYJwkh0TNa5RQCRfj
	 Omg2O2x77LkzKkfr+AqIVlrRzuVteif6R7uba3xOYRGl84luhGTz1N71K3C5PNdxWb
	 XtXCfgaMwFbxw==
Message-ID: <sashiko-outbox-196337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] mm/shmem_luo: Don't make early retrieve
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
In-Reply-To: <20261103010216.3447716-7-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:29 +0000
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
> folios as retryable, and return the error without freeing the serialized
> state. If no retrieve succeeds, finish() frees the preserved folios,
> like it does for a file that was never retrieved.
>=20
> Nothing has consumed the preserved state before the folios are
> restored, so the retrieve can be tried again.
>=20
> This also fixes leaking the preserved folios when one of these early
> steps fails, e.g. because the file has seals that this kernel doesn't
> support. The retrieve freed the serialized state but not the folios, and
> finish() then skipped the file because its retrieve had failed. There is
> no Fixes tag, since the fix relies on args->retryable, which was only
> added earlier in this series.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D6


