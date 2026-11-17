Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41036606A32F
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QdyaUs56;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebfJanYI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ijIbSOHiE7jM7Yo16iY+NAX4exxM+xde0xRCrd7R8Q0=; b=QdyaUs56fWKSPv3lAKkRorzuEB
	e6aCywM7GmD/s9eLZoMuME1tbR05dIjGuRqsU0INsf9JhFMZ+OaVG03hS7d2qqQD2KWb2n5WCVNLp
	0HJPsahyV/0FiTBPfRCHoGMAJG4CKSibfELK2041FdpwDeXxMeRtt8LugfikxJSCcmKioXSNdIl4U
	5UdwO35qU6AU7/kIkcTajGN2Le4Hu7LTB8CrBA0Gksb6ywfPlYqimBaykubOhFGWSC8HUXKI3LvE3
	X4QBdPTstzyU1NrFIA84ywyzxBaXUxcuGwt3LQoOavqVnSm4eUNEmrcTfHBDJ288+4WmGmoDFszyV
	XQXBj5kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFiJ-000000058c5-3a4p;
	Tue, 17 Nov 2026 09:42:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFiI-000000058br-3y2X
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 09:42:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6C7D14693B;
	Tue, 17 Nov 2026 09:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96021F000C4;
	Tue, 17 Nov 2026 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908574;
	bh=ijIbSOHiE7jM7Yo16iY+NAX4exxM+xde0xRCrd7R8Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ebfJanYIRMYG4qv2lrxxxEEUvDC/KWmvyWDIeTwNxvyXXwNmU0PnWaEDB1VFtbVDL
	 bO6tKOcauNaT9I4s/XDjjSkrp2RNIGA8aZ4+xTca9jg7SkJM11+w1aD3GMQnXGPDUL
	 p0QTxO+o23pF382YbEgleIF7uOLx+IleeFWLy9NanlTacEnt+PX0QN5KE266+Z5M5r
	 DMMhEaelgcGIArNk+ruh3QzbXHGBg1Rnrz8+OQUmYS/Sv+9PBdVDAQ++rwu/55+8f1
	 pE5FA2+daxI/lE4bp24cb+tIUc9fRFpdbx4qkilYJmb3hWIvbGK9hOpT1p/Eaed4vG
	 e4Fz4NGpYYyug==
Message-ID: <sashiko-outbox-218514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] docs: kho: describe the in/blobs debugfs file
To: "Long Wei" <longwei27@huawei.com>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, akpm@linux-foundation.org
Cc: graf@amazon.com, leitao@debian.org, corbet@lwn.net, rdunlap@infradead.org, kexec@lists.infradead.org, hewenliang4@huawei.com
In-Reply-To: <20261117092951.4017931-3-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261117092951.4017931-3-longwei27@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:42:53 +0000
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

> The incoming sub-blob raw nodes under kho/in/sub_fdts no longer exist:
> the sub-blob pages are owned by their consumers and may already be freed
> by the time the debugfs view is created, so exposing them was unsafe.
> Document the in/blobs metadata file that replaces them.
>=20
> Signed-off-by: Long Wei <longwei27@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117092951.4017=
931-1-longwei27@huawei.com?part=3D2


