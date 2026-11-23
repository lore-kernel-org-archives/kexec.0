Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C8606A32A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rQqcFSlv;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEBmzn5x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8yNQkmQ9W7+6H0nowxTvFVztBcdqeEWifqsvT5sSXQc=; b=rQqcFSlvCKPVmpwLw+jQ0W8HAm
	uE/WUlRe3BL4il/MX/so9Jhg+ECzAdvg08UfiPWhs0lBdOx9OU/cP//FB/7iQ86SIyc7JRA2jbdCv
	zP5lrmoWauxe1u9mOrVs8rZJannNoUg0NJx+zLlWGWaUfE3pjyFUTzsBTEEIs6CbKQ/TdVnUFqHTT
	gnRwE9lhTT68eT81J3y6CVfeqsz5QtCs/+YW87F3jo3JIEuPILI89d0ZkAnBxw/KI6fYl7/XEVpiF
	ww4AiP8lJXkMf4M4UhUOd1e44jeXzSRiD1s5HHDxFmyFrZaT6yhi/5Zid7VWxhtZg7+tx7fIZdlRA
	IcICtblQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZLZ-00000004by0-3dRW;
	Mon, 23 Nov 2026 19:05:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZLY-00000004bwc-0EwH
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 19:05:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1188B61285;
	Mon, 23 Nov 2026 19:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2454B1F000C4;
	Mon, 23 Nov 2026 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460698;
	bh=8yNQkmQ9W7+6H0nowxTvFVztBcdqeEWifqsvT5sSXQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HEBmzn5xQMmzwun5/DxZ22UzPCD2jKX/bQDvPKrMHsor7HNC4pIf5nh6EIejmJps0
	 EI2vp6qgoHMZ4hZEtkPgxLq3ft2hdDonJO8HZdqORS2g1vPPK87FtWympSEAo+g3Lb
	 rpdD6x5ru0d1hQBx8gQF8vE1FhrggKCfDwRQ982AtOgQrS2/f7aMid4P9yXgsgObHG
	 /V754oOG0zXkcahTENS6GSRwHWDxatJwfT0q1SZ8qN8lJkrHPgn6fMHBUa53pBYrgT
	 T7UlDfoWvLnB3S2ks8W1Ni5G9kmN3SDvQF0ebU5ztSGijo/510L4jvdc/tr/K47vGx
	 OpjMHp0f7KW2w==
Message-ID: <sashiko-outbox-229908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] amend! PCI: liveupdate: Freeze preservation status
 during shutdown
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
In-Reply-To: <20261123190045.2166865-4-dmatlack@google.com>
References: <20261118223704.3286085-12-dmatlack@google.com>
 <20261123190045.2166865-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:04:56 +0000
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

> PCI: liveupdate: Freeze preservation status during shutdown
>=20
> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown for kexec. This enables the PCI core and
> drivers to safely make decisions based on the device's preservation
> status during shutdown.
>=20
> The PCI core freezes every device in pci_device_shutdown(), not just
> preserved ones, so that no device can be preserved or unpreserved after
> its shutdown starts.
>=20
> Only freeze devices during kexec. Other shutdowns do not depend on the
> preservation status, and they do not serialize Live Update sessions
> first, so a session can still be torn down after its devices are shut
> down. Refusing to unpreserve those devices would make pci_flb_unpreserve()
> panic because they were never released.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20261118223704.3286085-12-dmatlack@google.=
com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123190045.2166=
865-4-dmatlack@google.com?part=3D1

