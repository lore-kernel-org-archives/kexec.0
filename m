Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE8606A326
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iXaOHMfs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEhYgGIv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=irXaiLNxNIRor6WB81c8MCLuB6vzrviLIeUiIXwvLkw=; b=iXaOHMfsMco/r04GRUbisNshec
	7uvi0jdQViE82A5tH1KUsayr62p1EpA0veYjhV1bbVU/H1OyBMWpEoAWzt2C4I8dLcSXVOQSvXlom
	2nKzg4ZxBOo9ntI1JLeEVf8wzoWBOs4iJUSpDfkVODk6l48Ey56LZuDj4ZOpuH5if/Au78mcGbNYe
	nY92t3c2pTDtSLhC5gGKTgCfbA/r3RjjYixxKIoCtwEW9FdTr+BeSABJDJ/63UKBSgiTfmASS9L7O
	1W/X+JRw5Qskah06joudYHewGOok9S9NZlimhayvhCZC22Hq6QElWLhFNKIDMtDmGACVI2cIzF1hk
	Yf+Dn2Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAmJ-0000000Dans-2Rbc;
	Thu, 19 Nov 2026 22:38:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAmH-0000000Daku-1hna
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D45E5623AD;
	Thu, 19 Nov 2026 22:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420571F000C4;
	Thu, 19 Nov 2026 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127928;
	bh=irXaiLNxNIRor6WB81c8MCLuB6vzrviLIeUiIXwvLkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEhYgGIvRTH185Wz3HIJSmjnBqXEoow0hpHIF39JYGfu8ZGY5CxlPUwC8hRqXcFap
	 SV1OPq0caLVxEAqJmgVNkkrCzUf95RBDqRqawkBF2kdsCsdLXuoQNVucpCoAiXMF+Q
	 lE6G0AI1uMtFAspf1bvjYj8a37VJCsEUfrx/HhqRw1GyUBajsoWTpMZEb9U8uMFnDp
	 vpDZRXz88/55BxuFNf2qJM2Ctwjkf5p9+gg5vzWq5De83h+EhWsGFGH07f1wjjzJag
	 E+vl7kkUMYj7D+X7h2d6S3kIjd5A7J8JwJwKjPDE3IIKSRCurJMT8B6wK+u8eXhZE4
	 dAuvtF+wVVxfQ==
Message-ID: <sashiko-outbox-224148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/13] Documentation: PCI: Add documentation for
 Live Update
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-14-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-14-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:46 +0000
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

> Add Documentation/PCI/liveupdate.rst, which pulls in the kernel-doc from
> drivers/pci/liveupdate.c and include/linux/kho/abi/pci.h, and link it
> from the PCI index and the Live Update Orchestrator documentation.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D13


