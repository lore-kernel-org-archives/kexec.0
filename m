Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FC606A326
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H5hbPFIz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBJbDakA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L3NrQuH0dgQoO2m39CIeXbV+CFfQJme6wMgjB57CNM0=; b=H5hbPFIzabLp9aVlR4nYogGvON
	lB0oRjpwYl06alPhALWyJD5dFlay7zS7Z1GWglkuuk8nJtGa/nsw8+Ay9DNPzofCpQnlTofSI0cce
	GgLsK5+Ydnxk3rNsPYefI/rcM44DeAifevvoq4ytXqu2K5J68P/N8KNuvoQ2bBb9mUVJ9FvxbjWDo
	xXpCCMhOW6HEhsCUICwl4sqicczL0u6GVfIW5YH56Xr5MlAjdD31CO1j60gdMd7IMbX8qUvvfmMgI
	ZCqtZAjm27+/IbQ4ZviKFNkEvxjeY/BWiiFKf++3vB9SqxkECWInu40mm/YClA5+U0tRt07zsb4MB
	EjbPBZMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIii-00000008F9O-1Sh5;
	Thu, 12 Nov 2026 00:31:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIif-00000008F5a-2Ds2
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F316660052;
	Thu, 12 Nov 2026 00:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE31F00A05;
	Thu, 12 Nov 2026 00:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443472;
	bh=L3NrQuH0dgQoO2m39CIeXbV+CFfQJme6wMgjB57CNM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBJbDakAi6PXdDxqXKrJToUVArtLXA+QFiznCa0Xk9OumH1jOP2Br4ldzvflXLLUA
	 Xw1D5ughERh5Due2ENsrbzNUCVATrXY3J4ScWaGMAz+rVyQzUe5RHGylINqs0+8WP8
	 F1w7pV7VtGfFBNdaGd2Tivc/nx8s1LRu7Vv8ai0G5wnDIXW+sQj3e1UEwzBNEasTBa
	 fOhAWZY1apZPoVyxkXL4/W5tty+wX5luCB4f7U/kvQTqblDdJiRGrqu9htE0CBX/Sn
	 LRiLd3t+xSEHsqGmV5FNZykqfIit3/O69AOFzGsqI+NMINnwpvVgsyIhZFTgB0H+9d
	 A3pqDjbjgGI0A==
Message-ID: <sashiko-outbox-209938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/19] liveupdate: Don't WARN if tracking a retrieved
 file fails
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
In-Reply-To: <20261111002358.1842967-7-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:11 +0000
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

> Handle a failure to add a retrieved file to luo_preserved_files instead
> of triggering a WARN_ON(). Make the failure permanent, and keep the file
> until the file set is finished, like any other retrieved file. Only warn
> if the file is already tracked (-EBUSY), which would be a kernel bug,
> since a retrieved file is always a new file.
>=20
> xa_insert() can fail with -ENOMEM, and userspace can trigger that with
> LIVEUPDATE_SESSION_RETRIEVE_FD, so warning about it lets userspace crash
> systems with panic_on_warn.
>=20
> The handler has already consumed the preserved state when this happens,
> so the retrieve can't be retried. Keeping the file ensures that its
> resources are not released before the file set is finished. Finishing
> the file set then erases the file from luo_preserved_files, which does
> nothing for a file that was never added.
>=20
> Fixes: 00d0b372374f ("liveupdate: prevent double management of files")
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D6


