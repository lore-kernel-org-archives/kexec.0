Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503AEC982DD
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cyl7vQEW3LfLjMkgXBXkK29B6dIUdPn+EyE/qOnRRR0=; b=V1fI0d+c4TPrb3HLlqw8pmrBju
	9iV0wm+Hy7U/yAQzlyis6xBHAHjCkjA+rmq8YBYBr3etCIrvWnR8oOcOWpu/ufbPz1q34mYMX5jGS
	rATE85hznUEw8i2edhgqsTohZOilaIpyvy9OqBeF06+Ahr9kudxOIriFrQbzJM1Vm4TlUHeKSpTz8
	42XVr8GVDg0coOg9fUcepei6kpkSDPFU92tN1jTx/voKqF22yeIxiuz0ShDVAtx6cs8r7w6BDO8M7
	tZrRZDnqOwpYk/hApBhoY8o1b6VfePiyOJNOx9hxy9PULG5+plzQeL+5C++Xb7RubBmU3mO3h4B59
	f32nfvQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f44-0000000FVJ4-29hr;
	Fri, 18 Sep 2026 20:20:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f42-0000000FVIe-15ua
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:20:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AE1CD602CC;
	Fri, 18 Sep 2026 20:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AE51F000FF;
	Fri, 18 Sep 2026 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762805;
	bh=Cyl7vQEW3LfLjMkgXBXkK29B6dIUdPn+EyE/qOnRRR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjUAFoYZxPnQsQpOb1L4wDNqgVs+S5TR7L4F5G2tKrnkscbfk4QcfcKxREph+VKZo
	 HU3vZ2CgZGzNL0KHEe0HjGVd/CzNrQI8pyVAy0FTcj2mqPOkLNYCPtrf3ckcj7DhE8
	 +tqrhYnJcft2QiuKOnJYw3zmVc4Hfu4Bv8z2uZRXufolpGJHLAOMy7wLeOoCyIaywN
	 0YFL2w4urvGcCgv50l6U6RJbbLEgs44TDrHqe2wuj+SIUebumCXE7QON4KoF2V65y2
	 ogVEOzaDp5uXgGhOWTsvegM1Tsg/bEtnr51NmkSqpNGRH+UMEc75JUA3+0XnXd3u8h
	 VBiGcEdnQ9wiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, "David
 Matlack" <dmatlack@google.com>
Cc: "Mike Rapoport" <rppt@kernel.org>, "Leon Romanovsky" <leonro@nvidia.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "William Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Josh Hilke" <jrhilke@google.com>, "Pranjal
 Shrivastava" <praan@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Alex
 Williamson" <alex@shazbot.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Chris Li" <chrisl@kernel.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, linux-pci@vger.kernel.org, "Alexander Graf" <graf@amazon.com>, "David
 Rientjes" <rientjes@google.com>, "Parav Pandit" <parav@nvidia.com>, kexec@lists.infradead.org, "Lukas
 Wunner" <lukas@wunner.de>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
In-Reply-To: <20260918200640.887030-4-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:20:03 +0000
Message-Id: <20260918202003.E7AE51F000FF@smtp.kernel.org>
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

> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.
>=20
> Add pci_liveupdate_setup_device() which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() will run
> and convert the array of pci_dev_ser structs into an xarray so that it
> can be looked up efficiently.
>=20
> If a device is found in the xarray, the PCI core stores a pointer to its
> state in dev->liveupdate_incoming until pci_liveupdate_finish() is
> called by the driver. This pointer allows the PCI core and drivers to
> apply Live Update-specific logic to incoming devices in subsequent
> [ ... ]
> as the xarray key.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D3


