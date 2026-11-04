Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7AB606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e3TItm7X;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGmiCuxI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ds/UOfmOvJuR4wrZT7xOsfABBaxA7lDS0xMWduVSe/g=; b=e3TItm7XrfvVNJs1Q9DbSF6w2L
	StkTqoUCtRustINnMaW8UXF5I3aowB7b+MnDk6TKncC9yetNqqDnQXkooCQ2+Eu2/1jc2n7NfwjyR
	R4cViRFHpqZXeI2upCeZUh8Qe+pevl6WdihRfP9fG04mstaP9Bc1vDqfugxjiATqwx0yjJJPA5fft
	wFkXhWAKRe1XXJAXDeOCKKgjViDoDJPVUr/bNr77QhlW+LbxeISDOVdYO1afW71cevssZ6Ch/OkEj
	HsPKOoj7WadspBMM9IUZCD6FMsiiPL1QOws2Eg5NFUU25InBKaWGV9Ok7dpcfbEmEdTariAybqTAe
	GWlLDs/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPc-000000042U6-1794;
	Wed, 04 Nov 2026 01:03:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPa-000000042Ra-3Koh
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 82ACC40598;
	Wed,  4 Nov 2026 01:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2741F000C1;
	Wed,  4 Nov 2026 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754214;
	bh=Ds/UOfmOvJuR4wrZT7xOsfABBaxA7lDS0xMWduVSe/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FGmiCuxIMEo4PfiK5wDWDqKO9ioOYOT10Q+/s4I9HzzzSEmfpY28pZ2yQ53yvRkCR
	 3eb+eTya1lHrl4zGKw3GKiK083UPvSW2fhMOYO0ATc2UAxg1ml7Xx8esy71OLR0Ejr
	 4Pds7FdyP/wefIADkTjysL6iMxqgywYhIbsKiPb7wKrqzRfbqzUD6qgzL3KPyc+gqT
	 RZRAyQDLQRb7bHd8kc7aavZKPSypVLnnn1ztT1kglRYz9Z8RwjqKxuAmQo9WjKTxpd
	 tBL6pVIPJGU9x1klIzD0DW/IrY41u3y2Yj7KRohhBUKtTTfNQ4OpKO2UyNI6thhKYU
	 E06vj7HHGWBQw==
Message-ID: <sashiko-outbox-196340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] mm/shmem_luo: Allow retrieving tmpfs files
 with O_RDONLY
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
In-Reply-To: <20261103010216.3447716-10-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:33 +0000
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

> Allow userspace to pass O_RDONLY in struct liveupdate_shmem_retrieve_arg
> to retrieve a tmpfs file read-only.
>=20
> open() requires write access for O_TMPFILE, so create the file writable
> like before, then reopen it read-only with dentry_open() using the flags
> of the writable file, which file_open_root() normalized, and drop the
> writable file. Like open(), which grants the requested access to a new
> file regardless of its mode, don't check permission for the read-only
> open.
>=20
> Retrieving a file read-only allows a restored binary to be executed
> before the session is finished. LUO keeps the retrieved file open until
> then, and executing a binary that is open for writing fails with
> -ETXTBSY. Being able to execute restored binaries right away matters
> when they are needed to finish restoring the system, e.g. to bring up
> the services that retrieve and finish the remaining sessions.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D9


