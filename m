Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4072C982D7
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rj26d3aL2UpD/OsbufCpnz9ZaAuE0EUthnpJ0sXROVk=; b=WMWrrXxO+GgI6RkU4YhGgKG2zR
	3mUDcaEot3haW8IRIHME+EHoo5cfEtQVoq9HG0SlsKIqEFaszuxFy9KEbVoBVCmkjH7B8zu/gRqEh
	os6jAzfqZXWr0bAaQEx+NmW17YO8hlh5IU1MMEDb9Lvjd0QOgIAP5SrwPGUT59jGTBK5IvuP0KJlG
	B6Ah3l0wgV3DYU7iOn6qr8Fs4zKNA/xLyt3UanehEpi0AKgTAEYpFdGKETqiY9iU8FqSF00Llw4RP
	3R6obbNSmoCt34BNw1NLXvLDe5x0GIx8yh0vTeZvreyW87cGK9v+FddNuNP/nQi0RdB+osQq6EhEJ
	oJVIGTSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f21-0000000FV7A-03ng;
	Fri, 18 Sep 2026 20:18:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f20-0000000FV6m-0eMH
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:18:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8AA26602CC;
	Fri, 18 Sep 2026 20:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3871F000FF;
	Fri, 18 Sep 2026 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762679;
	bh=Rj26d3aL2UpD/OsbufCpnz9ZaAuE0EUthnpJ0sXROVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ic40wAoFb5QI4S4AZtHCuYo7DpiDWYXy+Vg66oKsiZCf0vKs7mFaybs+eEkI2Ca0p
	 LsvOzLbUd20yb6EfzbjtdXMW6+daSuF3ys9c3jtzvaWzy1+r+5mGc1fW74XF/5xHyW
	 b8HuWqEy60y7RoYviDGVFDKJPsAyD0qU/Ws/i7DJ/dd3yXFha6vfyubXF5yueTE+jX
	 ziihUo2gPcptS36xC6q1uUCmQUnVk+m3aIeKFzuZWUeN22ifPM8TEtaL7Iv1Dkxwc7
	 Isj2sKpT1v3z952iVZ8xaJorgYZQ0GT0fOo9V0X8cIwBEDMIzs0NEPjHoY3bSChifJ
	 /+vGQ/ZG08ZDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/13] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-mm@kvack.org
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Mike
 Rapoport" <rppt@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Chris Li" <chrisl@kernel.org>, "Josh Hilke" <jrhilke@google.com>, linux-pci@vger.kernel.org, kexec@lists.infradead.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Jason Gunthorpe" <jgg@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Pranjal Shrivastava" <praan@google.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Alex
 Williamson" <alex@shazbot.org>, "Parav Pandit" <parav@nvidia.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20260918200640.887030-13-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:17:57 +0000
Message-Id: <20260918201757.CA3871F000FF@smtp.kernel.org>
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

> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
>=20
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
>=20
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D12


