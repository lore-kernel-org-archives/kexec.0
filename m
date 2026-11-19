Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95887606A337
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n796toV3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaBBy+Pe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Coph6eFhW2l3OLj95aOAwsUun97wVKoM1gQqRkRPxkM=; b=n796toV38Ze63ahoRMgkO69SId
	O+V/ShazZDu+mvEvsMZc9gXgy6WVyy7aRfPV3wfFbt82X6TQei15TnYzpN8KiFk2cfGGLMILmOO4x
	L/2RQY6E6aPQbEdpzineQELBPm52T/BSogPKZGG+s9dSSGb0AwI7z6VNwv5ZjN0v0/tJApfa6Vb//
	ys3X2rBB7b2m7ByjfFnNHVjdqG3sFprEuLeXP5LpxzkUJNjJnOIcGHa4JrVw+6SwvvSiyQrpGpw0V
	j15KWdJYZ2jHPkgM16/afMVWqYp3uGZgKUuu42RuO2saT2pkEni1MsdNCsDbxpJIS5cF2Cw/nFBtQ
	hIhhFT3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm0-0000000DaR2-1FGS;
	Thu, 19 Nov 2026 22:38:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAly-0000000DaOx-17HZ
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ED5C64133D;
	Thu, 19 Nov 2026 22:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E701F000D1;
	Thu, 19 Nov 2026 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127909;
	bh=Coph6eFhW2l3OLj95aOAwsUun97wVKoM1gQqRkRPxkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VaBBy+PeRlIBgewixRGlvlwxRM80bTUxG+q34R8xZ7Gs/rsAXu4ocXwTvN6fBfvFX
	 YaAnwwGGLqbuuXY68R7z2IQXMr/HYKs4snMCfvsxrMJ4mC8vdfTNOXs7TW7AxoDsXD
	 8iUHnv9L/2tY2wWVOsfNHoo6yZ/MnC2UaX+2ZIyXJR0vbvyKFSnd2kfrcvfmadLxca
	 bkmJ2egtYlerHoh+lY+S/2vNhJmzcRWEPLTquj19Vq0Q0Taqu3+A/fhKInNByiPO5/
	 sZgFsMx5KkT8rAgBsVuvOEMVl57CBmooUfJCZS8YSnSafenX3g3TJPFd02cks2pkDF
	 HbmkzMMGD6YIQ==
Message-ID: <sashiko-outbox-224140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
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
In-Reply-To: <20261118223704.3286085-6-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:27 +0000
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

> Automatically preserve every bridge between a preserved device and its
> root port when the device is preserved.
>=20
> Subsequent commits use this to ensure that preserved devices can
> continue performing memory transactions without a disruption or change
> in routing.
>=20
> Track the number of preserved devices at or below each bridge with a
> reference count in struct pci_dev_ser. A bridge stays preserved until
> all of its downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
>=20
> struct pci_ser::nr_devices counts the struct pci_dev_ser entries that are
> in use, so it only changes when a device's entry is allocated or
> released, i.e. when its reference count goes from 0 to 1 or from 1 to 0,
> not on every preserve and unpreserve.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D5


