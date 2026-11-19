Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266A606A326
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R5ZCTPY8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq3rUd03
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1+RNy9oxoDsxpp6WXRjzlfZE3yU9o9x54If3QAxT2VI=; b=R5ZCTPY8me+Dyuv4xtQArDV1Ue
	tNHMjY+ciqvqcPj1aPZE6+eBVBMIdCX+Up5pJIvMNRxSCnLTa8b6m45HvYkn+gLTo3bhQ15fm/zOy
	kv0g317QuTMvYxoNpgq5PxxabFbIdl0qT64zlqimwN9hz9meLPc6J/fhENvUDW54ggKMtdXcgt4AD
	8NARl6eTjOLWo2RrjK5v45Y6xosP32R8tN5sqDXwsEa5L1xQlgG0R/woWvICH26SEjhr84fTqFSB9
	DNFjzKtAruQnaErLdjeYX43xb7AynGLXKNMDEbU7M61GaJG94Aon9EnZ6DBGIvtV1BnKVyyFZ+NSZ
	XaXLWpQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAlu-0000000DaK4-0Coe;
	Thu, 19 Nov 2026 22:38:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAls-0000000DaJ1-4BAo
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 086F162206;
	Thu, 19 Nov 2026 22:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363CB1F000D1;
	Thu, 19 Nov 2026 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127903;
	bh=1+RNy9oxoDsxpp6WXRjzlfZE3yU9o9x54If3QAxT2VI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq3rUd03WXo5+Sc1+LxYuw14FftGuhT2AYRIxmIuvn21cysfkuX4yo2/308fLikBJ
	 wYQmaKAAQ96FcJcjkwUYXuSSKcjjAT9YJ+fSW2V2HbS8nWvhIcLLacvVCUgH5J8WnQ
	 nh1UNrCLW4BpZVH2dvUV0XTSQ18NfttT5FRkgILBvbmOxrEVB5acDGDYNREoCnBBB1
	 jshDQejYCneh7jlpaguxFgpBjZTwewaLb21YHygZ2fcegIF3bAxrS1C+5FJSmXiufH
	 jTZEmphQ7cd7/vI+VZebqt/w2vr7gtbSsKewoSJtnVOdWJaDzAmeLf5pftxHrjLOry
	 JbL9XG3BdwK8A==
Message-ID: <sashiko-outbox-224137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/13] PCI: liveupdate: Track outgoing preserved PCI
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
In-Reply-To: <20261118223704.3286085-3-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:19 +0000
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

> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
>=20
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
>=20
> Later patches use this to leave preserved devices running during
> shutdown and kexec, and the list of preserved devices is handed off to
> the next kernel.
>=20
> Warn if a device is released while it is still preserved.
>=20
> Panic if any device is still preserved when the outgoing FLB is freed,
> i.e. some driver failed to call pci_liveupdate_unpreserve(). Freeing the
> outgoing state would otherwise leave dangling dev->liveupdate.outgoing
> pointers behind.
>=20
> For now, the API only supports preserving non-VF devices on a root bus
> (not behind a PCI-to-PCI bridge).
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D2


