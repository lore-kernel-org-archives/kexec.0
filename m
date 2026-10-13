Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A45CCC6B1A
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PN+r4VLMhssQCrNV6XPUOMNympjbdTpFLc59Vq+ieEo=; b=rnPURkLrBYS24qgaYBjQHYChaT
	xitCl12kJU3iexDlS80wO1bCfsYYTu13I/TL6/AI5yBWmx8lrXvva/cWckPnIHpqaOCPrjjUhXM/7
	eqiVmT1R+M1XWF80CKld2NpOo9my9tao1tEQxTOPbn1RCWWaWTM3ABnxqfoAiI3ChjoU0rf7pIo2Z
	T5ixMu6C1Lyau+fcl6yD7EWw/7WEklfz3IGMqbeuAkgqUYe1JXRXJr7JZbw7pT57SwMPjXLcrTiop
	BwRjCZAgFUL5WHMrYOFL2sVOPbn3AqDKFRF7qrFI/jkydaSMIBOzyyKarwofKjxl+iN0Ffx0IukIF
	ARZsgorw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfT5-0000000DXii-2VdC;
	Tue, 13 Oct 2026 16:35:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfT2-0000000DXdL-170j
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:35:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C9484602C3;
	Tue, 13 Oct 2026 16:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DE31F000FF;
	Tue, 13 Oct 2026 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909306;
	bh=PN+r4VLMhssQCrNV6XPUOMNympjbdTpFLc59Vq+ieEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=igwWydtP9/RJQDJe8CvfELwrsPK91rw9lgxOoWUSEDo2uGjP5nFxSTefsCkr+437D
	 ThvtAfJOs1wlCkUB7uWlJ95QrPNO+JMEmvT8fP7kn8LoGAetn2I9vUaDWBwn1dldC/
	 Q2PUIECgt4yJP2sGQUPHHwqeV3kCi0NMe10Kka4lNvrp9lbNyeBgl03Xzfig8+mWVU
	 s4IJB18EH1hmTJYoKftGr1cchTn0zcDJJf3BJVYl4AVsqeS2s0BZcqO6gbHRQsB5gB
	 lKpCEpib0iMxGkholpfyROWwC/GFufO37z54hFaoAQNrIYSxkcgvX304iyXdIeqPlK
	 iTkLzhw68nwYw==
Message-ID: <sashiko-outbox-170122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/13] PCI: Save and restore the ACS Control
 register and Egress Control Vector
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261013162529.1928093-9-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:35:04 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> Save the ACS Control register and the ACS Egress Control Vector in
> pci_save_state() and write them back in pci_restore_state(), instead of
> recomputing the ACS controls from scratch with pci_enable_acs().
>=20
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
>=20
> Notably, this prepares the kernel to be able to adopt the ACS controls
> established by a previous kernel across a Live Update rather than
> assigning new ones through pci_enable_acs().
>=20
> [ ... ]
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D8


