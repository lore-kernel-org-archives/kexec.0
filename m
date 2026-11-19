Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BD606A32A
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uxVMZFdM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NuwjnRJ7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cj8MKy2tc3Sx1JwUpxECQgdXmsrh1YRqOP4Sl+8Dj74=; b=uxVMZFdMgSM8wWt5EGSsBnehBw
	Woy2WGoytLmRzmVttwhy6FD++KWjvoPGg1Te+nRZJXu7R3TGVvyoSGL59zY8wC6r5Ila4/p0r5DIv
	rjKgUWx2s6XqWJ7D/7nI9myg9igng550iE2NZSnuqNmPYEFofzJHx5gba985CpIly6Z4laseyWsJv
	AGe4bHxh3GjNfUshH/FpK61uehpkMXqt2pPW9ZdgpditkNWxENjZErEp7/OOeupmaQmHKnH/3FU71
	tfTBRZPvsC0acDVy9/a4zNOQXbm141Z1IuucPsFNlZRhCcSSbu+ZwtJJv0a+pt9AWC8WrjM61A8LM
	EtBoRH1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAmA-0000000Dado-0BXg;
	Thu, 19 Nov 2026 22:38:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm8-0000000DacF-3nLv
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 59D3961F65;
	Thu, 19 Nov 2026 22:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EBA1F000CF;
	Thu, 19 Nov 2026 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127920;
	bh=cj8MKy2tc3Sx1JwUpxECQgdXmsrh1YRqOP4Sl+8Dj74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NuwjnRJ77VaBWoVlfrRYMOPJitsXnO0CmQ0ewhyBdvVQIUMa/2Lla85Nd6sVLcqSO
	 rBSZstLLajgdg7CE+ZtMUiIPEv7PaFl58FO+wjyZERXsQJXc1P+8EZBEsc/pc0Li1r
	 dSkKtAQNhJuxTDl75YrxBtqZBBY5rTx9XQlDa6MrD3Mm2Dx+CX2hcFoQ7EkEK4jzX2
	 ix5bmcrCXaw7nWXSZsh23FNASS8JJ6jpmZa+nRvl4KCo6luiLjhnX2QZ86aYoWNNTT
	 gsxJFCM+Haoqlx6Fd3JAZz1snnrO7gz1yCU4oh1Hz3OR/4LMVYS79qCG5O55gft1aC
	 rAn9WVkFg2HcA==
Message-ID: <sashiko-outbox-224145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
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
In-Reply-To: <20261118223704.3286085-11-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:38 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI: liveupdate: stale ARI state in pci_configure_ari() with
  pci=3Dnoari
--

commit ee2b5e1cebde3231a1c9acaaf68c272dbf3c6e8e
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges

This commit adopts the ARI Forwarding Enable bit from hardware on
incoming-preserved bridges during a Live Update, even when pci=3Dnoari is
passed on the kernel command line.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ebc565b4780a1..b5b578355a1b6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3748,7 +3748,7 @@ void pci_configure_ari(struct pci_dev *dev)
>  	u32 cap;
>  	struct pci_dev *bridge;
> =20
> -	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
> +	if (!pci_is_pcie(dev) || dev->devfn)
>  		return;
> =20
>  	bridge =3D dev->bus->self;
> @@ -3759,6 +3759,12 @@ void pci_configure_ari(struct pci_dev *dev)
>  	if (!(cap & PCI_EXP_DEVCAP2_ARI))
>  		return;
> =20
> +	if (!pci_liveupdate_adopt_ari(bridge))
> +		return;
> +
> +	if (pcie_ari_disabled)
> +		return;
> +
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
>  		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_ARI);

[Severity: Medium]
Does returning early on pcie_ari_disabled leave PCI_EXP_DEVCTL2_ARI and
bridge->ari_enabled set to 1 if a new device is hot-plugged after the
preserved devices below the bridge have finished Live Update?

When booting with pci=3Dnoari, pci_liveupdate_adopt_ari() sets
bridge->ari_enabled =3D 1 while bridge->liveupdate.incoming is set.  Once
the preserved devices finish Live Update and bridge->liveupdate.incoming
is cleared, hot-plugging or rescanning a non-ARI multi-function device
below the bridge causes pci_liveupdate_adopt_ari() to return -EINVAL and
pci_configure_ari() to return at pcie_ari_disabled without reaching the
else branch that clears PCI_EXP_DEVCTL2_ARI and bridge->ari_enabled.
Because bridge->ari_enabled stays 1, next_fn() calls next_ari_fn(), which
returns -ENODEV and skips enumerating functions 1..7 on the new device.

Checking !pcie_ari_disabled alongside pci_find_ext_capability(dev,
PCI_EXT_CAP_ID_ARI) instead of returning early would allow the else branch
to clear PCI_EXP_DEVCTL2_ARI and bridge->ari_enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D10

