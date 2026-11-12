Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A34606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kHuk66is;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaSo0gm1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qMPAKcfOiDx77Aw4OnsNyGUu0CKw5fyN/4q2Bj4VySY=; b=kHuk66isit+QEyPdM1qVPqnQCa
	aQxaq8a0NougTjn5HFsauCTzxJji/gXGiSCJPJXN2BLVG3BqQUkQuujKU7MTMLM3sIcgQezyw4/oi
	r02gXxDnxvQIu3csCA1FueTYz4bBJxTDtU+7ahd3u4dFgDCaEny8xF0MekvVUvVSHAI3kEuZxIkkO
	9DbNipRmhUuNOm+sJRSMnwStOUk1h8yqD+C2NvsuxFYKvaLfq56Ct83nr0tSBMY4vrp5hM/J4gGrW
	K8dhqtjWa6yhH86LOPHXrRnsiSJzmnYJwJwf8AsmmZUdOs/BK1fhBurpBFIako2heSYTUo3Cwgd4B
	GxvR+IUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXtV-0000000AesP-2vKi;
	Thu, 12 Nov 2026 16:43:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXtG-0000000Aepp-41Wl
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 16:43:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 72EF561D3E;
	Thu, 12 Nov 2026 16:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B731F000C4;
	Thu, 12 Nov 2026 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501789;
	bh=qMPAKcfOiDx77Aw4OnsNyGUu0CKw5fyN/4q2Bj4VySY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TaSo0gm1mYVTOTO0UFE67te3sagvpRZaWy9QUQxWkPpogSV0tBpYEYQpFe+4Cf95+
	 L4586K7G3YxuNkc2tiv3voC9dIfCYPA2nCziKbAXq21rN5KlS0D+hMrvDmfUwAVXSb
	 PaFD5lcNTA54geZkwjUExJHnr5FXfSkbhoKJ206zJlVuHvM6QAOxNJsPSyxGF76mMb
	 rvZijIj3vflDycmHpcR0ZxdNqx9twGEGE6LGF8kKyL/Y6WEMrQTuIPVcux9dn49b7G
	 1gzcBsSBY/iXB9Fd2X60+YDqCW2RXuvhRQ8Hh4afmdQaTKzOZ4zntwtgbd8MSoAtoz
	 ZYNianvMddO8A==
Message-ID: <sashiko-outbox-211529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/4] crash_dump: use copy_oldmem_to_iter()
 everywhere
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Breno Leitao" <leitao@debian.org>, "Chris
 Mason" <mason@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, "David
 Hildenbrand" <david@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
 <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:43:08 +0000
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

> Make the remaining copy_oldmem_page() implementations copy the page of
> the crashed kernel with copy_oldmem_to_iter() like x86_64 and powerpc
> do. None of these architectures has a machine check safe copy today, so
> for them this is copy_to_iter() under another name. But the copy of a
> page of the old kernel is in one place now, and an architecture that
> gains ARCH_HAS_COPY_MC later gets the recovery without touching its
> crash dump code.
>=20
> s390 stays as it is. It copies the old kernel's memory through its real
> address mode window in memcpy_real_iter(), and an uncorrected storage
> error is fatal on s390 anyway (cf. s390_handle_damage()).
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-work-procf=
s-oldmem-v1-0-ecdcafd99265@kernel.org?part=3D4


