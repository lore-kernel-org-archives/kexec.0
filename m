Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9A606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=D4jKWDOZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FA6w+Jxk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9rSJmHFmmzo2Pt9Nf2eI8B1Lzcp6eCmcHxMODGuW8xo=; b=D4jKWDOZDHOvgPa/5Rj8HVPv71
	iPAc8VbdnHkOUbpaYw06FTg8vN8E6hhJKQr4H/bYSyGTGmUxPDt1hA26eLTgrHVuGwmAZSaJIMyR0
	G30Kz8BM8tQdvHqBP2Qv8H0RSbn0N/EMWCEHZyC7uzK7Eyv20B+EG+N+veYXc4HAQke3EvN9gCGHz
	sTa7lqlyr3YdvlZEWskuS8sA+Amgq26yBTyDjfSiZ7CPhgLfyGw/f63uYindQG2GZ2AZT5QvqaSWS
	XbWcZzm4yyYWd9ByqLVbWNLyfNJ+AO63F5kC67d4BrRmnKWH1wkcj+zI4V64a4TitFWpoVh7zdNk5
	/V428jcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPV-000000042LJ-2ZiF;
	Wed, 04 Nov 2026 01:03:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPS-000000042JE-3iCK
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5544560A8D;
	Wed,  4 Nov 2026 01:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173301F000C1;
	Wed,  4 Nov 2026 01:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754206;
	bh=9rSJmHFmmzo2Pt9Nf2eI8B1Lzcp6eCmcHxMODGuW8xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FA6w+JxkAWiVm0quTONOBTYsIujY9G1qOT1ZqMwVi+PSuD7XfeyPyjORGqPBMc7iu
	 9/Eo3oicEqGcqGE0LnKgoZTaBDHYKse8l2ZskoAmaU+LF9OCrun1lUTpX+lF4tbyyM
	 4ZpXHLmzYC17IHdUK1dSRx6xaFBhwf34H/vmjjZpo/vhG0g6BPf6lqurJm++8veXHT
	 0BRZW+2w/C41Hhrmi8BTwU7BQzw/6JQJxBYkDVoo0ge52lJHYOZi9SR2X6wHibHsTW
	 HR3BB7BPOcnEdcmHTgb+cm6AC/KS2lcSHApDS2Tj6Zgn3HDGPd+xIbgwYV+qK8E5XI
	 SpxO7OAAbI1Hg==
Message-ID: <sashiko-outbox-196334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] liveupdate: Allow file handlers to mark
 retrieve failures as retryable
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
In-Reply-To: <20261103010216.3447716-4-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:24 +0000
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

> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>=20
> When luo_retrieve_file() invokes a handler's .retrieve() callback and it
> returns an error, LUO currently records the error in
> luo_file->retrieve_status and blocks any subsequent retrieve attempts.
> This is necessary when the handler has already partially consumed or
> freed the preserved KHO state.
>=20
> However, with user arguments passed to .retrieve(), a handler may fail
> early while validating caller-supplied parameters (such as a missing
> argument, an invalid or read-only target file descriptor, or a non-empty
> target file) before touching any preserved KHO state. In such cases,
> userspace should be able to fix the argument and retry
> LIVEUPDATE_SESSION_RETRIEVE_FD, and if the file is never retrieved,
> .finish() must still run to release the preserved KHO state.
>=20
> Add a retryable output flag to struct liveupdate_file_op_args. When a
> handler sets args->retryable =3D true on error, luo_retrieve_file() leaves
> luo_file->retrieve_status at 0 so the retrieve operation can be retried
> and .finish() will still clean up the unconsumed preserved state if the
> session is finished without retrieving the file.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D3


