Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EAB606A320
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T3rCQxn5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4R0qDbZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h+V3LMWnhSAOQbYaMO5Wnwd+d6TugLH8Q5qaI2Zp0Zc=; b=T3rCQxn5KuXWOvTRgR4pnR+S4g
	MYl7qrWtJLGDeZ9ppv1UWrPa/7AHHyzZ6e3g8fA/ZJp2ie3t00hC46y+M62zvLeQanEpRICRte3FQ
	sN4AVCKL65Vu9Nb8AaXAV1hpyc4NhNjXzO/jo3n8x0nqMYCSyyP2yrrzKuwH5l1Dc3OPbpR0TPJX9
	SthtDxvJmVvrHqd+0hfl6GoXATBcYvNP6yvWEN6WjQpYqK5K1a5quXt0XKQ9PGIOGVUBgm+tZI9Bc
	czyvKYO8qaANLF4VkWJJ0YfPPsD70jQrcNHT53veFQA4f/SK+D91voYoh+5+ZtwXavLU+xk1AMlj3
	sz5VVSRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm9-0000000DadW-3hFD;
	Thu, 19 Nov 2026 22:38:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm7-0000000DaZB-0aQz
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 828BE62206;
	Thu, 19 Nov 2026 22:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED571F000CF;
	Thu, 19 Nov 2026 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127918;
	bh=h+V3LMWnhSAOQbYaMO5Wnwd+d6TugLH8Q5qaI2Zp0Zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4R0qDbZSHu/Bmiz9yDL1jUK7cnWi5HVS7JQmBp/FTROlSLxBHpMZhr+jWgsdUfcx
	 fc+D0JrdAqsOr0UkN2KjGmNEB83n40WvaDWetXs/40uxmy3AQP/9jvkrdnP1P7ZFpy
	 z/jyTkQPXgRETT9J5is+sZ1SVgNR6bzWPZNHJV0uGBhv8LiMPmKh8DGHPmKvLPV16c
	 aPfygyoFMgJ0F1+XNcu9N5IfmKMkZjM5/LLw45PJq8TOvHeTErxzttbLwBpFFjDRVt
	 mrCiTbP4JpOcwaGwpFY2EsUGnuDq3ntWLqPmE+YoevyKHLA6CsD5huvh+YZCL5xdVd
	 NJDQc379lintg==
Message-ID: <sashiko-outbox-224144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
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
In-Reply-To: <20261118223704.3286085-10-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:36 +0000
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

> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>=20
> Adopting ACS controls avoids changing routing rules while memory
> transactions are in flight from preserved devices. It also keeps IOMMU
> groups from changing during or after Live Update.
>=20
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> reapplied by pci_restore_state() if the device is reset. Allocate the
> ACS save buffer for incoming preserved devices even if they match a
> device-specific ACS quirk, since their adopted controls live in the ACS
> capability, and panic if it could not be allocated.
>=20
> To simplify ACS adoption, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account. If such a quirk matches an incoming preserved device
> anyway, e.g. because it was added in the new kernel, log a warning and
> adopt the device's ACS controls regardless, rather than reprogram a
> device in the path of a preserved device's memory transactions.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D9


