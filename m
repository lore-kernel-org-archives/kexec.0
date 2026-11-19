Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770DC606A334
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=giEl82T/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mq4n5c21
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mXEmIYwQs6olh4tGCdDknJUtcZFRu5o00knNY6/pK70=; b=giEl82T/qvXGc77JiQGFOqH6wo
	sqHSaFaG26rkV8GOqHAC+Siq1UHd3VxUy+8hQUybIqBq6/bwr+qnVCfoJqq18dYd//WXx9r5aJNLd
	5B4rDIyllieARc6l1TWkdsu/YXnSrjhbPiGNu/rd7zoYhwgqkC3nyE5SglnkoW0zQZG3782IO5xjF
	6+sBxsumFsui25UngM5XVPXadPYRpFR3nDR5NQ3DXKU09D6XZRw4ayiM9PoALIbzsa7fAy9BZDsYv
	D/fXRtD+Ta/rO2+zx9qufwMf5H4E1l8atPSsXFGpLoCpW6HhjSbymNZ2TUJk/5mQSmKtk37hMnfb+
	E4DXiyGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAlv-0000000DaL0-0Z3j;
	Thu, 19 Nov 2026 22:38:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAlu-0000000DaJl-0vlA
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 96F9F441AB;
	Thu, 19 Nov 2026 22:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363EA1F000C0;
	Thu, 19 Nov 2026 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127905;
	bh=mXEmIYwQs6olh4tGCdDknJUtcZFRu5o00knNY6/pK70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mq4n5c21rli6DqzcKFFDpWmbSABKkfRl5BaVQLXBMl52LVsDDio8ocK+SLg+fI9Fo
	 RXe070yO7nuuU3XiYab9Ezmgm7HZrx3h8vjcBjzPl2tlEj8ebEgMM/KC1oKLwpGtkF
	 PGPDDvSY6YFkDbDNO34fodqNvTulVJhlcRQhZonIIMmGYxR+sRS7dSvs7XIzv2B+2w
	 wusV14Tc301To1yumlhsARFChzaLZvDyjuF15wK16QAbtPteFKAENbWN9EPta8HxFx
	 tW88pT/sBS1AHjym+1So2VIVAG2tH30NZZ/bzRWE33L2jWQOQvrdURRNOyI9aFI//Y
	 clc+YWN0OrvgQ==
Message-ID: <sashiko-outbox-224138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
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
In-Reply-To: <20261118223704.3286085-4-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:23 +0000
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

> Identify devices that the previous kernel preserved across Live Update
> ("incoming" devices) when they are enumerated, and add
> pci_liveupdate_finish() and pci_liveupdate_is_incoming() for drivers.
>=20
> The previous kernel passes state about the devices it preserved across
> kexec, and the PCI core needs this state to know which devices require
> special handling.
>=20
> Add pci_liveupdate_setup_device(), which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() runs and
> loads the struct pci_dev_ser entries into an xarray so that they can be
> looked up efficiently.
>=20
> If a device is found in the xarray, the PCI core stores a pointer to its
> [ ... ]
>=20
> pci_flb_finish() panics if any preserved device was never finished,
> since that means a driver failed to call pci_liveupdate_finish().
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D3


