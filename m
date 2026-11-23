Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50749606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1q64eMaj;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAp5tdW/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=srd7A8Px0pWz2BTVMFMBIEagss8SSqXkeJsLFnOz6vw=; b=1q64eMajDa6W1aiaxYtXMbD+FI
	OR/8o9XTU5+IIAVTvZB4x44UEMVYNj9jvFBMP6a3uCsNAZxDQQVKy1p7YZ5FUhEkTmXjinUJamZqr
	siFRC4j7GyoAjbnqPqF4fGmFa6hqMZ/PQ6inZ2pOdRQSdt11M57vRVR57hdnQbWjpx8VxIlVdgk7w
	oM113l/bqR/HCEXpl8nC28oLMuW3lYR3WbfgH2RWylv0c1fAcM/G1wxm+Ij/8PC2ojHkUZs579RoZ
	cAF2+NF6WXIGAFpNiPOptMWkcV8AQTlUbZceY/3oW3AHbZ1tDwvfhVlHZKi+wzH5r2bOfaNFoQZ4u
	7pD+wGOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZKI-00000004bgd-00hf;
	Mon, 23 Nov 2026 19:03:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZKH-00000004bgR-0VcB
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 19:03:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ADF7645633;
	Mon, 23 Nov 2026 19:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1EF1F000C0;
	Mon, 23 Nov 2026 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460620;
	bh=srd7A8Px0pWz2BTVMFMBIEagss8SSqXkeJsLFnOz6vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAp5tdW/6wfEljyNOjA7Ou6pReQqwzpzgwgH9ftvki/W/a8xyPBEGwIE48GycmcUv
	 AyjHCIffHrPNhSL+4TXV25JIhvZtzIJcLChmTZDxNyES7yHcfA8M3/LJJ29gah+0Zh
	 EUsqRiN8BbFT98OJHscCGPNXrFkh1TFDM9GjWUimo7rYouTVDscz0CFZYi5vEdJZJ2
	 q1NFJUysPDwjjF6IaWWKDqe9CREqV4KG8DvsdWvhXDIXn9w+agO+dgf3SEzVPaIcaM
	 QnD+7jZSp88oDtcMpzN5JxfFw+I6YG1WwsHtRxWgRFNhwTbQg2VxgI7TBzIU90w1DY
	 QjnJvNtpO+wkA==
Message-ID: <sashiko-outbox-229905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fixup! PCI: liveupdate: Track incoming preserved PCI
 devices
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alex Williamson" <alex.williamson@nvidia.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alexander Graf" <graf@amazon.com>, "Bjorn
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
In-Reply-To: <20261123190045.2166865-1-dmatlack@google.com>
References: <20261118223704.3286085-4-dmatlack@google.com>
 <20261123190045.2166865-1-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:03:38 +0000
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

> pci_flb_finish() logged args->data, but LUO does not pass args->data to
> the FLB .finish() callback, so it always logged 0x0. Log the physical
> address of the incoming struct pci_ser instead.
>=20
> Reported by Sashiko.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123190045.2166=
865-1-dmatlack@google.com?part=3D1

