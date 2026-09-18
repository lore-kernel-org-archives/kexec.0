Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DF8C982E0
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InHfte711M8GWjBqV1si8bv5IIZHkN2SnYlxIl1Cx7o=; b=uQhiXB0Sh8DA7QkKfSjDlkTW8e
	JvslSZnFdAnjH8Ezo1vkZwYS7UMa0S9kT2Yh9cklpSIQiLWph2muVyQmE+D4akZjZ+BCPVLcmp93T
	NdixWz+HeP0wZWOxNj8on03hLcjONe4QCCT1MeYfNNfgVZK9KDxl9f/xxAkDBIKoqgV0dexD1J8V5
	/stj26FEqYKxDFjJPaTRZ0HnvIN0kdHEdqfte0lbhkvEy2NMcbhkMd+fL4tmS7JXnLP2yCv24DSLz
	+NOwEJQvw8UnEVvHvUDUZW3aS9ahTwdOe9TwHjYeqjPnRaFhsCBi8XkbjHHgPigk1tBjHoK2wz/8l
	TZi4YhBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ezb-0000000FUqg-2W0N;
	Fri, 18 Sep 2026 20:15:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7eza-0000000FUqN-1gaB
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:15:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D1C4D602CC;
	Fri, 18 Sep 2026 20:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AEA1F000FF;
	Fri, 18 Sep 2026 20:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762529;
	bh=InHfte711M8GWjBqV1si8bv5IIZHkN2SnYlxIl1Cx7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGWq4Z8JIom2PSUBkh/EdMZIVDCCXYBM5UAkjo5ZctKxb/oTXclDf7lE4G5qGvanR
	 /seeSAzwKF+/GbobcB7qjEPxRcBPDNZUtdo7qo2Ujl5LYFG5HLUE32ss3ITpM5L9a1
	 1jons1f2KLhHlieiUlBapS9kly4rU3gDNWzYLRyAfZ2LAeKxxqjET+fV8mY/4bx4Tm
	 6q/3KM6sJlbE3qec2mMfH68MXMY4rVEmA/OWGmc5QOynTmO0FKYYzUyb8KjkRjgCYc
	 wTI2W4XlokzHkgzzhpQb6m4+BN2cSIRaQI6Czxh694MwqEBCUB+okYa9sdkCFDxnzk
	 l7eE5QrTxx1bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/13] PCI: liveupdate: Set up FLB handler for the
 PCI core
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, "David
 Matlack" <dmatlack@google.com>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, "Josh Hilke" <jrhilke@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Parav
 Pandit" <parav@nvidia.com>, "Vipin Sharma" <vipinsh@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Chris Li" <chrisl@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, "William Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>, kexec@lists.infradead.org, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Alex
 Williamson" <alex@shazbot.org>, "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org, "David
 Rientjes" <rientjes@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Saeed
 Mahameed" <saeedm@nvidia.com>
In-Reply-To: <20260918200640.887030-2-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:15:27 +0000
Message-Id: <20260918201528.29AEA1F000FF@smtp.kernel.org>
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

> Set up a File-Lifecycle-Bound (FLB) handler so that the PCI core can
> preserve its own state across a Live Update kexec.
>=20
> Preserving a PCI device across kexec requires preserving two independent
> sets of state:
>=20
>  - Driver state, e.g. everything vfio-pci needs so that userspace can
>    keep using the device in the new kernel. The driver preserves this
>    itself and the PCI core is not involved.
>=20
>  - PCI core state, e.g. which devices are preserved, so that the new
>    kernel knows not to disturb them while they are still running and
>    doing DMA. That is what this commit adds, serialized into struct
>    pci_ser.
>=20
> [ ... ]
> not be enabled and these routines would never run.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D1


