Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC263606A32D
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XkydlM6u;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBKfv2W/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=d0+2tNhiFJflov+MWXi2AvsUab0DMDTfOzzEpvXOaCo=; b=XkydlM6uXmovh+Pxs1/4Z1VrB3
	eE4bf3pyoU7C9hfwijHW9b11VrgYQ/amWbTUIIfPr/oI+luJfBhd56FIHhcm/t3OPT+nyKBUqEiya
	MOIdCqCIZYI2zMkEf2uYH2AO+/hk7XyfkI5ne4vVKKtDQR9h3voiB2HLvkshM5DdqHnQloZ/ZbU4N
	BAwW3erXnekkI3A4hNg0t57iPDy94AcfI9IjWwptRseYq7x7mDvUbu/mTs20ixb6G16qW2yizlu4q
	zz0XNrtKq52CrerRdo5QWzB3qOwbtOopVKAuUp4ny58PQ+cFhmtOIcE7bG1QtAKmFXorYr3iBfkRz
	bSZmXg1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZL4-00000004box-2J45;
	Mon, 23 Nov 2026 19:04:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZL1-00000004boB-3Jgb
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 19:04:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BAAB261285;
	Mon, 23 Nov 2026 19:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213491F000C4;
	Mon, 23 Nov 2026 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460666;
	bh=d0+2tNhiFJflov+MWXi2AvsUab0DMDTfOzzEpvXOaCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBKfv2W/WihCUWBZCD/WeN8/kea/RHHGPfzxz97KZLlJGvjc0xkZydEace0hfP2JP
	 pWaGgajMts6nc5VZYACrCzx6wCMavBIxtBX/6VVQzNabEl0d4MRCXX8qaDB/WDR+fi
	 Bb//hH80RG7wTQ9kspMVExrL5oy7SXDACL5YmOYvxtvLmdsaYy+wkcVEd1s7LBXTGW
	 lvU+s6fosVoNgMzc/9ZpESP1QXgmMXaAhRjVn+RNuMTjIq4dgeg6YIyVkoyHCIGOYD
	 luvUGRUJatHQpnQZ7NZH0uxnTTti6ckBlFsDKSnhDQwcbTRJvU14Ct2M9Hc6DGI5lM
	 CGw/xmE4kn2Fg==
Message-ID: <sashiko-outbox-229906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fixup! PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
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
In-Reply-To: <20261123190045.2166865-3-dmatlack@google.com>
References: <20261118223704.3286085-11-dmatlack@google.com>
 <20261123190045.2166865-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:04:23 +0000
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

> Fix the comment in pci_liveupdate_adopt_ari(), which claimed that ARI
> Forwarding Enable is always recomputed after the preserved devices below
> the bridge finish. That is not true with pci=3Dnoari, where
> pci_configure_ari() leaves the bridge alone, so document that the adopted
> setting persists in that case.
>=20
> Reported by Sashiko.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123190045.2166=
865-3-dmatlack@google.com?part=3D1

